import psycopg2
import pandas as pd
import numpy as np



db_conexao = "dbname='TSMX' user='postgres' password='123456'"

successful_imports = 0
duplicate_cpf_cnpj = 0
failed_imports = 0
errors_log = []
registros_nao_importados = []

ESTADOS = {
    'acre': 'AC',
    'alagoas': 'AL',
    'amapá': 'AP',
    'amazonas': 'AM',
    'bahia': 'BA',
    'ceará': 'CE',
    'distrito federal': 'DF',
    'espírito santo': 'ES',
    'goiás': 'GO',
    'maranhão': 'MA',
    'mato grosso': 'MT',
    'mato grosso do sul': 'MS',
    'minas gerais': 'MG',
    'pará': 'PA',
    'paraíba': 'PB',
    'paraná': 'PR',
    'pernambuco': 'PE',
    'piauí': 'PI',
    'rio de janeiro': 'RJ',
    'rio grande do norte': 'RN',
    'rio grande do sul': 'RS',
    'rondônia': 'RO',
    'roraima': 'RR',
    'santa catarina': 'SC',
    'são paulo': 'SP',
    'sergipe': 'SE',
    'tocantins': 'TO'
}

df = pd.read_excel('D:/Projeto/dados_importacao.xlsx')


BATCH_SIZE = 500

def tratar_data(data):
    if pd.isna(data) or data == 'NaT' or data == '':
        return None
    try:
        return pd.to_datetime(data).strftime('%Y-%m-%d')
    except:
        return None

def tratar_booleano(valor):
    if pd.isna(valor) or valor == '':
        return None
    try:
        if isinstance(valor, bool):
            return valor
        if isinstance(valor, (int, float)):
            return bool(valor)
        if isinstance(valor, str):
            return valor.lower() in ('true', 't', 'yes', 'y', '1', 'sim', 's')
        return None
    except:
        return None

def tratar_valor(valor):
    if pd.isna(valor) or valor == '' or valor == 'NaN' or valor == 'nan':
        return None
    return valor

def converter_uf(uf):
    if pd.isna(uf) or uf == '':
        return None
        
    uf = str(uf).strip().lower()
    

    if uf in ESTADOS:
        return ESTADOS[uf]
    

try:
    conn = psycopg2.connect(db_conexao)
    
    
    planos_unicos = df.drop_duplicates(subset=['Plano'])
    
    with conn.cursor() as cursor:
        
        for _, plano_row in planos_unicos.iterrows():
            try:
                valor_plano = tratar_valor(plano_row['Plano Valor'])
                cursor.execute(
                    "INSERT INTO tbl_planos (descricao, valor) VALUES (%s, %s) ON CONFLICT (descricao) DO NOTHING",
                    (tratar_valor(plano_row['Plano']), valor_plano)
                )
                conn.commit()
            except Exception as e:
                conn.rollback()
                print(f"Erro ao inserir plano {plano_row['Plano']}: {e}")

        
        for batch_start in range(0, len(df), BATCH_SIZE):
            batch_end = min(batch_start + BATCH_SIZE, len(df))
            batch = df.iloc[batch_start:batch_end]
            
            print(f"Processando lote de {batch_start} até {batch_end}")
            
            for index, row in batch.iterrows():
                try:
                   
                    data_nascimento = tratar_data(row['Data Nasc.'])
                    data_cadastro = tratar_data(row['Data Cadastro cliente'])
                    nome_razao_social = tratar_valor(row['Nome/Razão Social'])
                    nome_fantasia = tratar_valor(row['Nome Fantasia'])
                    cpf_cnpj = tratar_valor(row['CPF/CNPJ'])
                    
                    
                    cursor.execute("SELECT 1 FROM tbl_clientes WHERE cpf_cnpj = %s::text", (cpf_cnpj,))
                    existing_record = cursor.fetchone()
                    
                    
                    if nome_razao_social is None:
                        registros_nao_importados.append((index, "Nome/Razão Social não pode ser nulo"))
                        continue
                    
                    cursor.execute(
                        """
                        INSERT INTO tbl_clientes 
                        (nome_razao_social, nome_fantasia, cpf_cnpj, data_nascimento, data_cadastro) 
                        VALUES (%s, %s, %s, %s, %s)
                        ON CONFLICT (cpf_cnpj) DO UPDATE 
                        SET nome_razao_social = EXCLUDED.nome_razao_social,
                            nome_fantasia = EXCLUDED.nome_fantasia,
                            data_nascimento = EXCLUDED.data_nascimento,
                            data_cadastro = EXCLUDED.data_cadastro
                        RETURNING id
                        """,
                        (nome_razao_social, nome_fantasia, cpf_cnpj, data_nascimento, data_cadastro)
                    )
                    
                    id_gerado = cursor.fetchone()[0]
                    
                   
                    celulares = tratar_valor(row['Celulares'])
                    if celulares is not None:
                        
                        if isinstance(celulares, (float, np.float64)):
                            celulares = str(int(celulares))
                        cursor.execute(
                            "INSERT INTO tbl_cliente_contatos (cliente_id, tipo_contato_id, contato) VALUES (%s, %s, %s)",
                            (id_gerado, 2, str(celulares))
                        )
                    
                    telefones = tratar_valor(row['Telefones'])
                    if telefones is not None:
                        
                        if isinstance(telefones, (float, np.float64)):
                            telefones = str(int(telefones))
                        cursor.execute(
                            "INSERT INTO tbl_cliente_contatos (cliente_id, tipo_contato_id, contato) VALUES (%s, %s, %s)",
                            (id_gerado, 1, str(telefones))
                        )
                    
                    email = tratar_valor(row.get('Email'))
                    if email is not None:
                        cursor.execute(
                            "INSERT INTO tbl_cliente_contatos (cliente_id, tipo_contato_id, contato) VALUES (%s, %s, %s)",
                            (id_gerado, 3, str(email))
                        )
                    
                    plano = tratar_valor(row['Plano'])
                    if plano is not None:
                        cursor.execute("SELECT id FROM tbl_planos WHERE descricao = %s", (plano,))
                        plano_result = cursor.fetchone()
                        

                        
                        if plano_result:
                            id_plano = plano_result[0]
                            
                    
                    status = tratar_valor(row['Status'])
                    if status is not None:
                        cursor.execute("SELECT id FROM tbl_status_contrato WHERE status = %s", (status,))
                        status_result = cursor.fetchone()
                        

                        
                        if status_result:
                            id_status = status_result[0]        
                                                       
                            
                            isento = True if tratar_booleano(row.get('Isento')) == "Sim" else False
                            vencimento = tratar_valor(row['Vencimento'])
                            endereco = tratar_valor(row['Endereço']) or "Endereço não informado"
                            numero = tratar_valor(row['Número'])
                            bairro = tratar_valor(row['Bairro'])
                            cidade = tratar_valor(row['Cidade'])
                            complemento = tratar_valor(row.get('Complemento'))
                            cep = tratar_valor(row['CEP']) or '00000-000'
                            uf = converter_uf(row['UF'])  
                                               
                          
                            
                            cursor.execute("""
                                INSERT INTO tbl_cliente_contratos 
                                (cliente_id, plano_id, dia_vencimento, isento, 
                                 endereco_logradouro, endereco_numero, endereco_bairro, 
                                 endereco_cidade, endereco_complemento, endereco_cep, 
                                 endereco_uf, status_id)
                                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                                """,
                                (id_gerado, id_plano, vencimento, isento,
                                 endereco, numero, bairro, cidade, complemento, cep, uf, id_status)
                            )
                    
   
                    conn.commit()
                    successful_imports += 1
                    
                except Exception as e:
                    conn.rollback()
                    failed_imports += 1
                    errors_log.append({
                        'linha': index,
                        'erro': str(e),
                        'cpf_cnpj': row.get('CPF/CNPJ', 'N/A')
                    })
                    continue

except Exception as e:
    registros_nao_importados.append((index, str(e)))
    failed_imports += 1
    if 'conn' in locals():
        conn.rollback()

finally:
    if 'conn' in locals():
        conn.close()
    

    total_registros = len(df) if 'df' in locals() else 0
    

print("\n=== RESUMO DA IMPORTAÇÃO ===")
print(f"Total de registros processados: {len(df)}")
print(f"Importações bem-sucedidas: {successful_imports}")
print(f"Registros com CPF/CNPJ duplicados (atualizados): {duplicate_cpf_cnpj}")
print(f"Importações falhas por outros motivos: {failed_imports}")


if registros_nao_importados:
    print("\n=== REGISTROS NÃO IMPORTADOS ===")
    for registro in registros_nao_importados:
        print(f"Índice: {registro[0]} - Motivo: {registro[1]}")

    if len(errors_log) > 0:
        print("\n=== DETALHES DOS ERROS ===")
        for error in errors_log:
            print(f"Linha {error['linha']} (CPF/CNPJ: {error['cpf_cnpj']}): {error['erro']}")
            
    comando_sql_CPF_CNPJ = """
    UPDATE tbl_clientes
    SET cpf_cnpj = FormatCPFCNPJ(cpf_cnpj)
    """
    cursor.execute(comando_sql_CPF_CNPJ)
    
    comando_sql_CEP = """
    UPDATE tbl_cliente_contratos
    SET endereco_cep = REGEXP_REPLACE(endereco_cep, '(\d{5})(\d{3})', '\1-\2') 
    """
    cursor.execute(comando_sql_CEP)
    
    
print("\n=== PROCESSO FINALIZADO! ===")

