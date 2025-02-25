PGDMP  +    7                }            TSMX    17.2    17.2 9    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16388    TSMX    DATABASE     }   CREATE DATABASE "TSMX" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "TSMX";
                     postgres    false            �            1255    16732     formatcpfcnpj(character varying)    FUNCTION     z  CREATE FUNCTION public.formatcpfcnpj(alphatext character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
  FormattedText VARCHAR(50) = '';
  NumChar INTEGER;
  NumericChar CHAR;
BEGIN
  AlphaText := regexp_replace(AlphaText, '[^0-9]', '', 'g');
  NumChar := LENGTH( AlphaText );
  if (NumChar > 14) OR (NumChar < 11) THEN
    RETURN NULL;
  elsif NumChar = 11 THEN
    FormattedText := regexp_replace( AlphaText, '(\\d)(\\d)(\\d)(\\d)', '\\1.\\2.\\3-\\4');
  else
    FormattedText := regexp_replace( AlphaText, '(\\d)(\\d)(\\d)(\\d)(\\d)', '\\1.\\2.\\3/\\4');
  end if;
   
  RETURN FormattedText;
END;
$$;
 A   DROP FUNCTION public.formatcpfcnpj(alphatext character varying);
       public               postgres    false            �            1259    16389    tbl_cliente_contatos    TABLE     �   CREATE TABLE public.tbl_cliente_contatos (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    tipo_contato_id integer NOT NULL,
    contato character varying(255) NOT NULL
);
 (   DROP TABLE public.tbl_cliente_contatos;
       public         heap r       postgres    false            �            1259    16392    tbl_cliente_contatos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tbl_cliente_contatos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.tbl_cliente_contatos_id_seq;
       public               postgres    false    217                        0    0    tbl_cliente_contatos_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.tbl_cliente_contatos_id_seq OWNED BY public.tbl_cliente_contatos.id;
          public               postgres    false    218            �            1259    16393    tbl_cliente_contratos    TABLE     S  CREATE TABLE public.tbl_cliente_contratos (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    plano_id integer NOT NULL,
    dia_vencimento integer NOT NULL,
    isento boolean DEFAULT false NOT NULL,
    endereco_logradouro character varying(255) NOT NULL,
    endereco_numero character varying(15),
    endereco_bairro character varying(255) NOT NULL,
    endereco_cidade character varying(255) NOT NULL,
    endereco_complemento character varying(500),
    endereco_cep character varying(9) NOT NULL,
    endereco_uf character varying(2) NOT NULL,
    status_id integer NOT NULL
);
 )   DROP TABLE public.tbl_cliente_contratos;
       public         heap r       postgres    false            �            1259    16399    tbl_cliente_contratos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tbl_cliente_contratos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.tbl_cliente_contratos_id_seq;
       public               postgres    false    219                       0    0    tbl_cliente_contratos_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.tbl_cliente_contratos_id_seq OWNED BY public.tbl_cliente_contratos.id;
          public               postgres    false    220            �            1259    16400    tbl_clientes    TABLE       CREATE TABLE public.tbl_clientes (
    id bigint NOT NULL,
    nome_razao_social character varying(255) NOT NULL,
    nome_fantasia character varying(255),
    cpf_cnpj character varying(18) NOT NULL,
    data_nascimento date,
    data_cadastro timestamp without time zone
);
     DROP TABLE public.tbl_clientes;
       public         heap r       postgres    false            �            1259    16405    tbl_clientes_id_seq    SEQUENCE     |   CREATE SEQUENCE public.tbl_clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tbl_clientes_id_seq;
       public               postgres    false    221                       0    0    tbl_clientes_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tbl_clientes_id_seq OWNED BY public.tbl_clientes.id;
          public               postgres    false    222            �            1259    16406 
   tbl_planos    TABLE     �   CREATE TABLE public.tbl_planos (
    id integer NOT NULL,
    descricao character varying(255) NOT NULL,
    valor numeric(15,2) NOT NULL
);
    DROP TABLE public.tbl_planos;
       public         heap r       postgres    false            �            1259    16409    tbl_planos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tbl_planos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.tbl_planos_id_seq;
       public               postgres    false    223                       0    0    tbl_planos_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.tbl_planos_id_seq OWNED BY public.tbl_planos.id;
          public               postgres    false    224            �            1259    16410    tbl_status_contrato    TABLE     p   CREATE TABLE public.tbl_status_contrato (
    id integer NOT NULL,
    status character varying(50) NOT NULL
);
 '   DROP TABLE public.tbl_status_contrato;
       public         heap r       postgres    false            �            1259    16413    tbl_status_contrato_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tbl_status_contrato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.tbl_status_contrato_id_seq;
       public               postgres    false    225                       0    0    tbl_status_contrato_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.tbl_status_contrato_id_seq OWNED BY public.tbl_status_contrato.id;
          public               postgres    false    226            �            1259    16414    tbl_tipos_contato    TABLE     t   CREATE TABLE public.tbl_tipos_contato (
    id integer NOT NULL,
    tipo_contato character varying(50) NOT NULL
);
 %   DROP TABLE public.tbl_tipos_contato;
       public         heap r       postgres    false            �            1259    16417    tbl_tipos_contato_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tbl_tipos_contato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.tbl_tipos_contato_id_seq;
       public               postgres    false    227                       0    0    tbl_tipos_contato_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.tbl_tipos_contato_id_seq OWNED BY public.tbl_tipos_contato.id;
          public               postgres    false    228            ;           2604    16424    tbl_cliente_contatos id    DEFAULT     �   ALTER TABLE ONLY public.tbl_cliente_contatos ALTER COLUMN id SET DEFAULT nextval('public.tbl_cliente_contatos_id_seq'::regclass);
 F   ALTER TABLE public.tbl_cliente_contatos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217            <           2604    16425    tbl_cliente_contratos id    DEFAULT     �   ALTER TABLE ONLY public.tbl_cliente_contratos ALTER COLUMN id SET DEFAULT nextval('public.tbl_cliente_contratos_id_seq'::regclass);
 G   ALTER TABLE public.tbl_cliente_contratos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219            >           2604    16426    tbl_clientes id    DEFAULT     r   ALTER TABLE ONLY public.tbl_clientes ALTER COLUMN id SET DEFAULT nextval('public.tbl_clientes_id_seq'::regclass);
 >   ALTER TABLE public.tbl_clientes ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            ?           2604    16427    tbl_planos id    DEFAULT     n   ALTER TABLE ONLY public.tbl_planos ALTER COLUMN id SET DEFAULT nextval('public.tbl_planos_id_seq'::regclass);
 <   ALTER TABLE public.tbl_planos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223            @           2604    16428    tbl_status_contrato id    DEFAULT     �   ALTER TABLE ONLY public.tbl_status_contrato ALTER COLUMN id SET DEFAULT nextval('public.tbl_status_contrato_id_seq'::regclass);
 E   ALTER TABLE public.tbl_status_contrato ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225            A           2604    16429    tbl_tipos_contato id    DEFAULT     |   ALTER TABLE ONLY public.tbl_tipos_contato ALTER COLUMN id SET DEFAULT nextval('public.tbl_tipos_contato_id_seq'::regclass);
 C   ALTER TABLE public.tbl_tipos_contato ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    227            �          0    16389    tbl_cliente_contatos 
   TABLE DATA           X   COPY public.tbl_cliente_contatos (id, cliente_id, tipo_contato_id, contato) FROM stdin;
    public               postgres    false    217   �L       �          0    16393    tbl_cliente_contratos 
   TABLE DATA           �   COPY public.tbl_cliente_contratos (id, cliente_id, plano_id, dia_vencimento, isento, endereco_logradouro, endereco_numero, endereco_bairro, endereco_cidade, endereco_complemento, endereco_cep, endereco_uf, status_id) FROM stdin;
    public               postgres    false    219   �L       �          0    16400    tbl_clientes 
   TABLE DATA           v   COPY public.tbl_clientes (id, nome_razao_social, nome_fantasia, cpf_cnpj, data_nascimento, data_cadastro) FROM stdin;
    public               postgres    false    221   �L       �          0    16406 
   tbl_planos 
   TABLE DATA           :   COPY public.tbl_planos (id, descricao, valor) FROM stdin;
    public               postgres    false    223   �L       �          0    16410    tbl_status_contrato 
   TABLE DATA           9   COPY public.tbl_status_contrato (id, status) FROM stdin;
    public               postgres    false    225   N       �          0    16414    tbl_tipos_contato 
   TABLE DATA           =   COPY public.tbl_tipos_contato (id, tipo_contato) FROM stdin;
    public               postgres    false    227   ]N                  0    0    tbl_cliente_contatos_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.tbl_cliente_contatos_id_seq', 1, false);
          public               postgres    false    218                       0    0    tbl_cliente_contratos_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tbl_cliente_contratos_id_seq', 1, false);
          public               postgres    false    220                       0    0    tbl_clientes_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tbl_clientes_id_seq', 1, false);
          public               postgres    false    222            	           0    0    tbl_planos_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.tbl_planos_id_seq', 960, true);
          public               postgres    false    224            
           0    0    tbl_status_contrato_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.tbl_status_contrato_id_seq', 4, true);
          public               postgres    false    226                       0    0    tbl_tipos_contato_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.tbl_tipos_contato_id_seq', 3, true);
          public               postgres    false    228            C           2606    16431 P   tbl_cliente_contatos tbl_cliente_contatos_cliente_id_tipo_contato_id_contato_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.tbl_cliente_contatos
    ADD CONSTRAINT tbl_cliente_contatos_cliente_id_tipo_contato_id_contato_key UNIQUE (cliente_id, tipo_contato_id, contato);
 z   ALTER TABLE ONLY public.tbl_cliente_contatos DROP CONSTRAINT tbl_cliente_contatos_cliente_id_tipo_contato_id_contato_key;
       public                 postgres    false    217    217    217            E           2606    16433 .   tbl_cliente_contatos tbl_cliente_contatos_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.tbl_cliente_contatos
    ADD CONSTRAINT tbl_cliente_contatos_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.tbl_cliente_contatos DROP CONSTRAINT tbl_cliente_contatos_pkey;
       public                 postgres    false    217            G           2606    16435 0   tbl_cliente_contratos tbl_cliente_contratos_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tbl_cliente_contratos
    ADD CONSTRAINT tbl_cliente_contratos_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.tbl_cliente_contratos DROP CONSTRAINT tbl_cliente_contratos_pkey;
       public                 postgres    false    219            I           2606    16437 &   tbl_clientes tbl_clientes_cpf_cnpj_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.tbl_clientes
    ADD CONSTRAINT tbl_clientes_cpf_cnpj_key UNIQUE (cpf_cnpj);
 P   ALTER TABLE ONLY public.tbl_clientes DROP CONSTRAINT tbl_clientes_cpf_cnpj_key;
       public                 postgres    false    221            K           2606    16439    tbl_clientes tbl_clientes_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.tbl_clientes
    ADD CONSTRAINT tbl_clientes_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.tbl_clientes DROP CONSTRAINT tbl_clientes_pkey;
       public                 postgres    false    221            M           2606    16441 #   tbl_planos tbl_planos_descricao_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.tbl_planos
    ADD CONSTRAINT tbl_planos_descricao_key UNIQUE (descricao);
 M   ALTER TABLE ONLY public.tbl_planos DROP CONSTRAINT tbl_planos_descricao_key;
       public                 postgres    false    223            O           2606    16443    tbl_planos tbl_planos_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.tbl_planos
    ADD CONSTRAINT tbl_planos_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.tbl_planos DROP CONSTRAINT tbl_planos_pkey;
       public                 postgres    false    223            Q           2606    16445 ,   tbl_status_contrato tbl_status_contrato_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.tbl_status_contrato
    ADD CONSTRAINT tbl_status_contrato_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.tbl_status_contrato DROP CONSTRAINT tbl_status_contrato_pkey;
       public                 postgres    false    225            S           2606    16447 2   tbl_status_contrato tbl_status_contrato_status_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.tbl_status_contrato
    ADD CONSTRAINT tbl_status_contrato_status_key UNIQUE (status);
 \   ALTER TABLE ONLY public.tbl_status_contrato DROP CONSTRAINT tbl_status_contrato_status_key;
       public                 postgres    false    225            U           2606    16449 (   tbl_tipos_contato tbl_tipos_contato_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.tbl_tipos_contato
    ADD CONSTRAINT tbl_tipos_contato_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.tbl_tipos_contato DROP CONSTRAINT tbl_tipos_contato_pkey;
       public                 postgres    false    227            W           2606    16451 4   tbl_tipos_contato tbl_tipos_contato_tipo_contato_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.tbl_tipos_contato
    ADD CONSTRAINT tbl_tipos_contato_tipo_contato_key UNIQUE (tipo_contato);
 ^   ALTER TABLE ONLY public.tbl_tipos_contato DROP CONSTRAINT tbl_tipos_contato_tipo_contato_key;
       public                 postgres    false    227            X           2606    16452 9   tbl_cliente_contatos tbl_cliente_contatos_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_cliente_contatos
    ADD CONSTRAINT tbl_cliente_contatos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.tbl_clientes(id) ON UPDATE CASCADE ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.tbl_cliente_contatos DROP CONSTRAINT tbl_cliente_contatos_cliente_id_fkey;
       public               postgres    false    221    4683    217            Y           2606    16457 >   tbl_cliente_contatos tbl_cliente_contatos_tipo_contato_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_cliente_contatos
    ADD CONSTRAINT tbl_cliente_contatos_tipo_contato_id_fkey FOREIGN KEY (tipo_contato_id) REFERENCES public.tbl_tipos_contato(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 h   ALTER TABLE ONLY public.tbl_cliente_contatos DROP CONSTRAINT tbl_cliente_contatos_tipo_contato_id_fkey;
       public               postgres    false    4693    217    227            Z           2606    16462 ;   tbl_cliente_contratos tbl_cliente_contratos_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_cliente_contratos
    ADD CONSTRAINT tbl_cliente_contratos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.tbl_clientes(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 e   ALTER TABLE ONLY public.tbl_cliente_contratos DROP CONSTRAINT tbl_cliente_contratos_cliente_id_fkey;
       public               postgres    false    219    221    4683            [           2606    16467 9   tbl_cliente_contratos tbl_cliente_contratos_plano_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_cliente_contratos
    ADD CONSTRAINT tbl_cliente_contratos_plano_id_fkey FOREIGN KEY (plano_id) REFERENCES public.tbl_planos(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 c   ALTER TABLE ONLY public.tbl_cliente_contratos DROP CONSTRAINT tbl_cliente_contratos_plano_id_fkey;
       public               postgres    false    219    223    4687            \           2606    16472 :   tbl_cliente_contratos tbl_cliente_contratos_status_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tbl_cliente_contratos
    ADD CONSTRAINT tbl_cliente_contratos_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.tbl_status_contrato(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 d   ALTER TABLE ONLY public.tbl_cliente_contratos DROP CONSTRAINT tbl_cliente_contratos_status_id_fkey;
       public               postgres    false    4689    219    225            �      x������ � �      �      x������ � �      �      x������ � �      �     x�]��j�0E��W�������L��mȪ08PJ $��t��Mӝ�>��be
�{����k��8�&C�$X�4Njc��#�`"���ބ�Z0X2��q�p�Z54Y�ikT͔@�}��[���v�������U`*HA��䞊��r�+V��g�/�ȥ����@i|�����V�8^����õ���`���^�lU�Pe�X�?���{����X��Y���r�M]��j1�G��D�a�rʑG�<D?�$I~;�|      �   @   x�3�t,�,��2�K��O�LILIUJM)�2��9�K�R��L8��SsS�b���� #N�      �   +   x�3�I�IM��K�2�tN�)�I,�2�t��M������� �c	g     