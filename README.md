# 📊 Prática - Analista de Dados  

Este projeto foi desenvolvido como parte de um teste para a posição de Analista de Dados. Ele consiste em uma aplicação Python que realiza o upload de uma planilha **.xlsx** para um banco de dados **PostgreSQL**.  

## 🚀 Tecnologias Utilizadas  
- **Python**  
- **PostgreSQL**  
- **Pandas** (para leitura do arquivo **.xlsx**)  
- **NumPy** (para conversões de dados)  
- **psycopg2** (para conexão com o banco de dados)  

## ⚙️ Configuração do Ambiente  

### 1️⃣ Pré-requisitos  
- **VSCode** (ou outro editor de sua preferência)  
- **PostgreSQL 17.2** instalado e configurado  

### 2️⃣ Instalação das Dependências  
No VSCode, abra o projeto e instale as seguintes extensões via **pip**:  
```bash
pip install psycopg2 pandas numpy
```  

### 3️⃣ Configuração do Banco de Dados  
1. Instale o **PostgreSQL 17.2** e crie um banco de dados chamado **TSMX**.  
2. Restaure o backup incluído no projeto (**TSMX.sql**).  
3. No código, atualize as credenciais de conexão com o banco de dados na linha onde está **"db_conexao"**.  

---

💡 **Observação:** Certifique-se de ajustar o usuário e senha do banco de dados antes de rodar a aplicação.  
