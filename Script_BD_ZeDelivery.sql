CREATE TABLE [USUARIO]
(
    [COD_USUARIO] INTEGER PRIMARY KEY AUTOINCREMENT,
    [LOGIN] NVARCHAR(160)  NOT NULL,
    [SENHA] NVARCHAR(160)  NOT NULL,
    [NOME] NVARCHAR(160)  NOT NULL,
    [CPF] NVARCHAR(160)  NOT NULL,
    [TELEFONE] NVARCHAR(160)  NOT NULL,
    [EMAIL] NVARCHAR(160)  NOT NULL,
    [ENDERECO] NVARCHAR(160)  NOT NULL,
    [ADMIN] BOOLEAN NOT NULL
);

CREATE UNIQUE INDEX [IPK_USUARIO] ON [USUARIO]([COD_USUARIO]);



CREATE TABLE [CLIENTE]
(
    [COD_CLIENTE] INTEGER PRIMARY KEY AUTOINCREMENT,
    [COD_USUARIO] INTEGER NOT NULL,
    CONSTRAINT [FK_USUARIO] FOREIGN KEY ([COD_USUARIO]) REFERENCES USUARIO(COD_USUARIO)
);

CREATE UNIQUE INDEX [IPK_CLIENTE] ON [CLIENTE]([COD_CLIENTE]);


CREATE TABLE [LOJA_FISICA]
(
    [COD_LOJA] INTEGER PRIMARY KEY AUTOINCREMENT,
    [NOME_LOJA] NVARCHAR(160)  NOT NULL,
    [TELEFONE] NVARCHAR(160)  NOT NULL,
    [EMAIL] NVARCHAR(160)  NOT NULL,
    [ENDERECO] NVARCHAR(160)  NOT NULL
);
CREATE UNIQUE INDEX [IPK_LOJA] ON [LOJA_FISICA]([COD_LOJA]);



CREATE TABLE [VENDEDOR]
(
    [COD_VENDEDOR] INTEGER PRIMARY KEY AUTOINCREMENT,
    [COD_USUARIO] INTEGER NOT NULL,
    [COD_LOJA] INTEGER NOT NULL,
    CONSTRAINT [FK_USUARIO] FOREIGN KEY ([COD_USUARIO]) REFERENCES USUARIO(COD_USUARIO),
    CONSTRAINT [FK_LOJA] FOREIGN KEY ([COD_LOJA]) REFERENCES LOJA_FISICA(COD_LOJA)
);
CREATE UNIQUE INDEX [IPK_VENDEDOR] ON [VENDEDOR]([COD_VENDEDOR]);



CREATE TABLE [PRODUTO]
(
    [COD_PRODUTO] INTEGER PRIMARY KEY AUTOINCREMENT,
    [NOME] NVARCHAR(160)  NOT NULL,
    [VALOR_PRODUTO] FLOAT(15,2)  NOT NULL
);
CREATE UNIQUE INDEX [IPK_PRODUTO] ON [PRODUTO]([COD_PRODUTO]);


CREATE TABLE [ESTOQUE]
(
    [COD_ESTOQUE] INTEGER PRIMARY KEY AUTOINCREMENT,
    [QUANTIDADE_PRODUTO] INTEGER NOT NULL,
    [COD_PRODUTO] INTEGER  NOT NULL,
    [COD_LOJA] INTEGER  NOT NULL,
    CONSTRAINT [FK_PRODUTO] FOREIGN KEY ([COD_PRODUTO]) REFERENCES PRODUTO(COD_PRODUTO), 
    CONSTRAINT [FK_LOJA] FOREIGN KEY ([COD_LOJA]) REFERENCES LOJA_FISICA(COD_LOJA)
);
CREATE UNIQUE INDEX [IPK_ESTOQUE] ON [ESTOQUE]([COD_ESTOQUE]);



CREATE TABLE [FORNECEDOR]
(
    [COD_FORNECEDOR] INTEGER PRIMARY KEY AUTOINCREMENT,
    [NOME] NVARCHAR(160)  NOT NULL,
    [CPF_CNPJ] NVARCHAR(160)  NOT NULL,
    [TELEFONE] NVARCHAR(160)  NOT NULL,
    [EMAIL] NVARCHAR(160)  NOT NULL,
    [ENDERECO] NVARCHAR(160)  NOT NULL
);
CREATE UNIQUE INDEX [IPK_FORNECEDOR] ON [FORNECEDOR]([COD_FORNECEDOR]);


CREATE TABLE [FORNECEDOR_PRODUTO]
(
    [COD_FORNECEDOR_PRODUTO] INTEGER PRIMARY KEY AUTOINCREMENT,
    [COD_PRODUTO] INTEGER  NOT NULL,
    [COD_FORNECEDOR] INTEGER  NOT NULL,
    CONSTRAINT [FK_PRODUTO] FOREIGN KEY ([COD_PRODUTO]) REFERENCES PRODUTO(COD_PRODUTO),
    CONSTRAINT [FK_FORNECEDOR] FOREIGN KEY ([COD_FORNECEDOR]) REFERENCES FORNECEDOR(COD_FORNECEDOR)
);
CREATE UNIQUE INDEX [IPK_FORNECEDOR_PRODUTO] ON [FORNECEDOR_PRODUTO]([COD_FORNECEDOR_PRODUTO]);



CREATE TABLE [STATUS_PEDIDO]
(
    [COD_STATUS_PEDIDO] INTEGER PRIMARY KEY AUTOINCREMENT,
    [DESCRICAO_STATUS] NVARCHAR(160)  NOT NULL
);
CREATE UNIQUE INDEX [IPK_STATUS_PEDIDO] ON [STATUS_PEDIDO]([COD_STATUS_PEDIDO]);


CREATE TABLE [PEDIDO]
(
    [COD_PEDIDO] INTEGER PRIMARY KEY AUTOINCREMENT,
    [DATA_PEDIDO] DATETIME NOT NULL,
    [TEMPO_ESPERA] TIME NOT NULL,
    [VALOR_TOTAL_PEDIDO] FLOAT(15,2)  NOT NULL,
    [COD_CLIENTE] INTEGER  NOT NULL,
    [COD_VENDEDOR] INTEGER  NOT NULL,
    [COD_STATUS_PEDIDO] INTEGER  NOT NULL,
    [COD_LOJA] INTEGER NOT NULL,   
    CONSTRAINT [FK_CLIENTE] FOREIGN KEY ([COD_CLIENTE]) REFERENCES CLIENTE(COD_CLIENTE),
    CONSTRAINT [FK_VENDEDOR] FOREIGN KEY ([COD_VENDEDOR]) REFERENCES VENDEDOR(COD_VENDEDOR),
    CONSTRAINT [FK_STATUS_PEDIDO] FOREIGN KEY ([COD_STATUS_PEDIDO]) REFERENCES STATUS_PEDIDO(COD_STATUS_PEDIDO),
    CONSTRAINT [FK_LOJA] FOREIGN KEY ([COD_LOJA]) REFERENCES LOJA_FISICA(COD_LOJA)
);
CREATE UNIQUE INDEX [IPK_PEDIDO] ON [PEDIDO]([COD_PEDIDO]);




CREATE TABLE [ITEM_PEDIDO]
(
    [COD_ITEM_PEDIDO] INTEGER PRIMARY KEY AUTOINCREMENT,
    [QUANTIDADE] INTEGER NOT NULL,
    [COD_PEDIDO] INTEGER  NOT NULL,
    [COD_PRODUTO] INTEGER  NOT NULL,
    CONSTRAINT [FK_COD_PEDIDO] FOREIGN KEY ([COD_PEDIDO]) REFERENCES PEDIDO(COD_PEDIDO),
    CONSTRAINT [FK_PRODUTO] FOREIGN KEY ([COD_PRODUTO]) REFERENCES PRODUTO(COD_PRODUTO)
  
);
CREATE UNIQUE INDEX [IPK_ITEM_PEDIDO] ON [ITEM_PEDIDO]([COD_ITEM_PEDIDO]);



CREATE TABLE [RELATORIO_VENDAS]
(
    [COD_RELATORIO] INTEGER PRIMARY KEY AUTOINCREMENT,
    [VALOR_TOTAL_VENDAS] FLOAT(15,2)  NOT NULL,
    [DATA_INCIO] DATETIME NOT NULL,
    [DATA_FINAL] DATETIME NOT NULL,
    [COD_LOJA] INTEGER  NOT NULL,
    CONSTRAINT [FK_LOJA] FOREIGN KEY ([COD_LOJA]) REFERENCES LOJA_FISICA(COD_LOJA)  
);
CREATE UNIQUE INDEX [IPK_RELATORIO] ON [RELATORIO_VENDAS]([COD_RELATORIO]);




-- Inserindo registro na tabela LOJA_FISICA
INSERT INTO LOJA_FISICA (NOME_LOJA, TELEFONE, EMAIL, ENDERECO)
VALUES ('LOJA1', '31999999999', 'LOJA1@GMAIL.COM', 'R. LOJA 1');

-- Inserindo registro na tabela LOJA_FISICA
INSERT INTO LOJA_FISICA  (NOME_LOJA, TELEFONE, EMAIL, ENDERECO)
VALUES ('LOJA2', '31999999999', 'LOJA2@GMAIL.COM', 'R. LOJA 2');

-- Inserindo registro na tabela LOJA_FISICA
INSERT INTO LOJA_FISICA  (NOME_LOJA, TELEFONE, EMAIL, ENDERECO)
VALUES ('LOJA3', '31999999999', 'LOJA3@GMAIL.COM', 'R. LOJA 3');

-- Inserindo registro na tabela LOJA_FISICA
INSERT INTO LOJA_FISICA  (NOME_LOJA, TELEFONE, EMAIL, ENDERECO)
VALUES ('LOJA4', '31999999999', 'LOJA4@GMAIL.COM', 'R. LOJA 4');


-- Inserindo registro na tabela USUARIO
INSERT INTO USUARIO(LOGIN, SENHA, NOME, CPF, TELEFONE, EMAIL, ENDERECO, ADMIN)
VALUES ('JENNI', '1234', 'JENNIFER', '136', '31994533390', 'JEN@GMAIL.COM', 'R. LK 161', FALSE);  

-- Inserindo registro na tabela USUARIO
INSERT INTO USUARIO(LOGIN, SENHA, NOME, CPF, TELEFONE, EMAIL, ENDERECO, ADMIN)
VALUES ('JOAOV', '1234', 'JOAO VITOR', '108', '31999999999', 'JOAO@GMAIL.COM', 'R. LK 161', FALSE);  


-- Inserindo registro na tabela USUARIO
INSERT INTO USUARIO(LOGIN, SENHA, NOME, CPF, TELEFONE, EMAIL, ENDERECO, ADMIN)
VALUES ('JOY', '1234', 'JOYCE', '107', '31999999999', 'JOYCE@GMAIL.COM', 'R. MC 139', FALSE); 
 
-- Inserindo registro na tabela USUARIO
INSERT INTO USUARIO(LOGIN, SENHA, NOME, CPF, TELEFONE, EMAIL, ENDERECO, ADMIN)
VALUES ('DAVI', '1234', 'DAVI', '105', '31999999999', 'DAVI@GMAIL.COM', 'R. GAP 331', FALSE);  

-- Inserindo registro na tabela USUARIO
INSERT INTO USUARIO(LOGIN, SENHA, NOME, CPF, TELEFONE, EMAIL, ENDERECO, ADMIN)
VALUES ('ANA', '1234', 'ANA PAULA', '100', '31999999999', 'ANA@GMAIL.COM', 'R. GAP 331', TRUE);

-- Inserindo registro na tabela USUARIO
INSERT INTO USUARIO(LOGIN, SENHA, NOME, CPF, TELEFONE, EMAIL, ENDERECO, ADMIN)
VALUES ('LEO', '1234', 'LEONARDO', '101', '31999999999', 'LEO@GMAIL.COM', 'R. GAP 331', TRUE);

-- Inserindo registro na tabela USUARIO
INSERT INTO USUARIO(LOGIN, SENHA, NOME, CPF, TELEFONE, EMAIL, ENDERECO, ADMIN)
VALUES ('ELIZA', '1234', 'ELIZABETH', '102', '31999999999', 'ELIZA@GMAIL.COM', 'R. MC 139', TRUE);

-- Inserindo registro na tabela USUARIO
INSERT INTO USUARIO(LOGIN, SENHA, NOME, CPF, TELEFONE, EMAIL, ENDERECO, ADMIN)
VALUES ('ILMAF', '1234', 'ILMA', '103', '31999999999', 'ILMA@GMAIL.COM', 'R. GAP 331', TRUE);



-- Inserindo registro na tabela CLIENTE
INSERT INTO CLIENTE (COD_USUARIO)
VALUES (1);

-- Inserindo registro na tabela CLIENTE
INSERT INTO CLIENTE (COD_USUARIO)
VALUES (4);

-- Inserindo registro na tabela CLIENTE
INSERT INTO CLIENTE (COD_USUARIO)
VALUES (2);

-- Inserindo registro na tabela CLIENTE
INSERT INTO CLIENTE (COD_USUARIO)
VALUES (3);


-- Inserindo registro na tabela VENDEDOR
INSERT INTO VENDEDOR(COD_USUARIO, COD_LOJA)
VALUES (7, 4);

-- Inserindo registro na tabela VENDEDOR
INSERT INTO VENDEDOR(COD_USUARIO, COD_LOJA)
VALUES (5, 1);

-- Inserindo registro na tabela VENDEDOR
INSERT INTO VENDEDOR(COD_USUARIO, COD_LOJA)
VALUES (8, 2);

-- Inserindo registro na tabela VENDEDOR
INSERT INTO VENDEDOR(COD_USUARIO, COD_LOJA)
VALUES (6, 3);



-- Inserindo registro na tabela PRODUTO
INSERT INTO PRODUTO (NOME, VALOR_PRODUTO)
VALUES ('COCA-COLA 1,5L', 10.00);

-- Inserindo registro na tabela PRODUTO
INSERT INTO PRODUTO (NOME, VALOR_PRODUTO)
VALUES ('SUCO LATA', 7.00);

-- Inserindo registro na tabela PRODUTO
INSERT INTO PRODUTO (NOME, VALOR_PRODUTO)
VALUES ('CERVEJA', 8.00);

-- Inserindo registro na tabela PRODUTO
INSERT INTO PRODUTO (NOME, VALOR_PRODUTO)
VALUES ('COCA-COLA 2L', 12.00);

-- Inserindo registro na tabela ESTOQUE
INSERT INTO ESTOQUE(QUANTIDADE_PRODUTO, COD_PRODUTO, COD_LOJA)
VALUES (10, 1, 4);

-- Inserindo registro na tabela ESTOQUE
INSERT INTO ESTOQUE(QUANTIDADE_PRODUTO, COD_PRODUTO, COD_LOJA)
VALUES (5, 2, 3);

-- Inserindo registro na tabela ESTOQUE
INSERT INTO ESTOQUE(QUANTIDADE_PRODUTO, COD_PRODUTO, COD_LOJA)
VALUES (18, 3, 2);

-- Inserindo registro na tabela ESTOQUE
INSERT INTO ESTOQUE(QUANTIDADE_PRODUTO, COD_PRODUTO, COD_LOJA)
VALUES (15, 4, 1);



-- Inserindo registro na tabela FORNECEDOR
INSERT INTO FORNECEDOR(NOME, CPF_CNPJ, TELEFONE, EMAIL, ENDERECO)
VALUES ('JANE', '110', '31999999999', 'JANE@GMAIL.COM', 'R. VL 1929'); 

-- Inserindo registro na tabela FORNECEDOR
INSERT INTO FORNECEDOR(NOME, CPF_CNPJ, TELEFONE, EMAIL, ENDERECO)
VALUES ('VANDERLEI', '111', '31999999999', 'VANDERLEI@GMAIL.COM', 'R. VL 1929'); 

-- Inserindo registro na tabela FORNECEDOR
INSERT INTO FORNECEDOR(NOME, CPF_CNPJ, TELEFONE, EMAIL, ENDERECO)
VALUES ('ROGÉRIO', '115', '31999999999', 'ROGERIO@GMAIL.COM', 'R. GAP 331'); 

-- Inserindo registro na tabela FORNECEDOR
INSERT INTO FORNECEDOR(NOME, CPF_CNPJ, TELEFONE, EMAIL, ENDERECO)
VALUES ('JOSÉ ANTÔNIO', '119', '31999999999', 'JOSE@GMAIL.COM', 'R. MC 139'); 


-- Inserindo registro na tabela FORNECEDOR_PRODUTO
INSERT INTO FORNECEDOR_PRODUTO(COD_PRODUTO, COD_FORNECEDOR)
VALUES (4, 3); 

-- Inserindo registro na tabela FORNECEDOR_PRODUTO
INSERT INTO FORNECEDOR_PRODUTO(COD_PRODUTO, COD_FORNECEDOR)
VALUES (1, 4); 

-- Inserindo registro na tabela FORNECEDOR_PRODUTO
INSERT INTO FORNECEDOR_PRODUTO(COD_PRODUTO, COD_FORNECEDOR)
VALUES (2, 3); 

-- Inserindo registro na tabela FORNECEDOR_PRODUTO
INSERT INTO FORNECEDOR_PRODUTO(COD_PRODUTO, COD_FORNECEDOR)
VALUES (3, 2); 



-- Inserindo registro na tabela STATUS_PEDIDO
INSERT INTO STATUS_PEDIDO (DESCRICAO_STATUS)
VALUES ('PREPARANDO');

-- Inserindo registro na tabela STATUS_PEDIDO
INSERT INTO STATUS_PEDIDO (DESCRICAO_STATUS)
VALUES ('AGUARDANDO ENTREGADOR');

-- Inserindo registro na tabela STATUS_PEDIDO
INSERT INTO STATUS_PEDIDO (DESCRICAO_STATUS)
VALUES ('CANCELADO');

-- Inserindo registro na tabela STATUS_PEDIDO
INSERT INTO STATUS_PEDIDO (DESCRICAO_STATUS)
VALUES ('ENTREGUE');

-- Inserindo registro na tabela PEDIDO
INSERT INTO PEDIDO(DATA_PEDIDO, TEMPO_ESPERA, VALOR_TOTAL_PEDIDO, COD_CLIENTE, COD_VENDEDOR, COD_STATUS_PEDIDO, COD_LOJA)
VALUES ('2023-27-10 07:00:00', '00:30:00', 150.65, 1, 4, 2, 4);

-- Inserindo registro na tabela PEDIDO
INSERT INTO PEDIDO(DATA_PEDIDO, TEMPO_ESPERA, VALOR_TOTAL_PEDIDO, COD_CLIENTE, COD_VENDEDOR, COD_STATUS_PEDIDO, COD_LOJA)
VALUES ('2023-04-11 08:00:00', '00:20:00', 180.65, 4, 2, 3, 1);

-- Inserindo registro na tabela PEDIDO
INSERT INTO PEDIDO(DATA_PEDIDO, TEMPO_ESPERA, VALOR_TOTAL_PEDIDO, COD_CLIENTE, COD_VENDEDOR, COD_STATUS_PEDIDO, COD_LOJA)
VALUES ('2023-22-11 10:00:00', '00:25:00', 170.65, 3, 1, 4, 2);

-- Inserindo registro na tabela PEDIDO
INSERT INTO PEDIDO(DATA_PEDIDO, TEMPO_ESPERA, VALOR_TOTAL_PEDIDO, COD_CLIENTE, COD_VENDEDOR, COD_STATUS_PEDIDO, COD_LOJA)
VALUES ('2023-21-11 04:00:00', '00:40:00', 140.65, 2, 3, 1, 3);


-- Inserindo registro na tabela ITEM_PEDIDO
INSERT INTO ITEM_PEDIDO(QUANTIDADE, COD_PEDIDO, COD_PRODUTO)
VALUES (10, 4, 3);

-- Inserindo registro na tabela ITEM_PEDIDO
INSERT INTO ITEM_PEDIDO(QUANTIDADE, COD_PEDIDO, COD_PRODUTO)
VALUES (15, 3, 2);

-- Inserindo registro na tabela ITEM_PEDIDO
INSERT INTO ITEM_PEDIDO(QUANTIDADE, COD_PEDIDO, COD_PRODUTO)
VALUES (20, 2, 1);

-- Inserindo registro na tabela ITEM_PEDIDO
INSERT INTO ITEM_PEDIDO(QUANTIDADE, COD_PEDIDO, COD_PRODUTO)
VALUES (25, 1, 4);

-- Inserindo registro na tabela RELATORIO_VENDAS
INSERT INTO RELATORIO_VENDAS(VALOR_TOTAL_VENDAS, DATA_INCIO, DATA_FINAL, COD_LOJA)
VALUES (3.595, '2023-21-11 04:00:00', '2023-25-11 03:00:00',  1);

-- Inserindo registro na tabela RELATORIO_VENDAS
INSERT INTO RELATORIO_VENDAS(VALOR_TOTAL_VENDAS, DATA_INCIO, DATA_FINAL, COD_LOJA)
VALUES (4.595, '2023-25-11 07:00:00', '2023-30-11 10:00:00',  2);

-- Inserindo registro na tabela RELATORIO_VENDAS
INSERT INTO RELATORIO_VENDAS(VALOR_TOTAL_VENDAS, DATA_INCIO, DATA_FINAL, COD_LOJA)
VALUES (5.595, '2023-10-11 12:00:00', '2023-15-11 01:00:00',  3);

-- Inserindo registro na tabela RELATORIO_VENDAS
INSERT INTO RELATORIO_VENDAS(VALOR_TOTAL_VENDAS, DATA_INCIO, DATA_FINAL, COD_LOJA)
VALUES (10.595, '2023-02-11 22:00:00', '2023-05-11 02:00:00',  4);


-- SELECT DE UMA INFORMAÇÃO DE CADA TABELA
SELECT * FROM USUARIO WHERE NOME LIKE 'JEN%';
SELECT * FROM CLIENTE WHERE COD_USUARIO LIKE '3';
SELECT * FROM LOJA_FISICA WHERE NOME_LOJA LIKE '%3';
SELECT * FROM VENDEDOR WHERE COD_USUARIO LIKE '8';
SELECT * FROM PRODUTO WHERE VALOR_PRODUTO LIKE '10%';
SELECT * FROM ESTOQUE WHERE QUANTIDADE_PRODUTO LIKE '1%';
SELECT * FROM FORNECEDOR WHERE NOME LIKE 'JOSÉ%';
SELECT * FROM FORNECEDOR_PRODUTO WHERE COD_PRODUTO LIKE '2';
SELECT * FROM STATUS_PEDIDO WHERE DESCRICAO_STATUS LIKE 'CANC%';
SELECT * FROM PEDIDO WHERE COD_LOJA LIKE '4';
SELECT * FROM ITEM_PEDIDO WHERE QUANTIDADE LIKE '1%';
SELECT * FROM RELATORIO_VENDAS WHERE VALOR_TOTAL_VENDAS LIKE '%3.%';


-- UPDATE DE UMA INFORMAÇÃO DE CADA TABELA

UPDATE USUARIO SET NOME = 'JENNIFER GOMES' WHERE COD_USUARIO  = 1;
UPDATE CLIENTE SET COD_USUARIO= '10' WHERE COD_CLIENTE = 2;
UPDATE LOJA_FISICA SET ENDERECO= 'R. LOJA 22' WHERE COD_LOJA = 2;
UPDATE VENDEDOR SET COD_USUARIO= '10' WHERE COD_VENDEDOR = 4;
UPDATE PRODUTO SET NOME = 'CERVEJA LATÃO' WHERE COD_PRODUTO = 3;
UPDATE ESTOQUE SET QUANTIDADE_PRODUTO = '41' WHERE COD_PRODUTO = 2;
UPDATE FORNECEDOR SET NOME = 'JANE ANGÉLICA' WHERE COD_FORNECEDOR  = 1;
UPDATE FORNECEDOR_PRODUTO SET COD_PRODUTO= '2' WHERE COD_FORNECEDOR  = 3;
UPDATE STATUS_PEDIDO SET DESCRICAO_STATUS= 'CANCELADO SEM PAGAMENTO' WHERE COD_STATUS_PEDIDO = 3;
UPDATE PEDIDO SET VALOR_TOTAL_PEDIDO= 300.20 WHERE COD_PEDIDO = 1;
UPDATE ITEM_PEDIDO SET QUANTIDADE= 5 WHERE COD_ITEM_PEDIDO = 1;
UPDATE RELATORIO_VENDAS SET DATA_FINAL= '2024-15-11 01:00:00' WHERE COD_RELATORIO = 1;


-- DELETE DE UMA INFORMAÇÃO DE CADA TABELA


DELETE FROM USUARIO WHERE LOGIN LIKE '%ELIZA';
DELETE FROM CLIENTE WHERE COD_CLIENTE  = 4;
DELETE FROM LOJA_FISICA WHERE COD_LOJA  = 4;
DELETE FROM VENDEDOR WHERE COD_VENDEDOR = 2;
DELETE FROM PRODUTO WHERE VALOR_PRODUTO  LIKE '%8';
DELETE FROM ESTOQUE WHERE QUANTIDADE = 10;
DELETE FROM FORNECEDOR WHERE NOME LIKE 'A';
DELETE FROM FORNECEDOR_PRODUTO WHERE COD_PRODUTO LIKE '1%';
DELETE FROM STATUS_PEDIDO WHERE DESCRICAO_STATUS LIKE 'CANC%';
DELETE FROM PEDIDO WHERE COD_LOJA LIKE '4';
DELETE FROM ITEM_PEDIDO WHERE QUANTIDADE LIKE '%1%';
DELETE FROM RELATORIO_VENDAS WHERE VALOR_TOTAL_VENDAS LIKE '%3.%';



-- SELECT COM JOIN

SELECT * FROM PRODUTO p
INNER JOIN ESTOQUE e 
WHERE p.COD_PRODUTO = e.COD_PRODUTO 
AND p.COD_PRODUTO = 1 ;

-- SELECT COM JOIN

SELECT * FROM PEDIDO p 
INNER JOIN CLIENTE c 
WHERE p.COD_CLIENTE  = c.COD_CLIENTE
AND p.COD_CLIENTE = 2;

-- SELECT COM JOIN

SELECT * FROM VENDEDOR v 
INNER JOIN USUARIO u 
WHERE v.COD_USUARIO = u.COD_USUARIO
AND v.COD_USUARIO = 7;

-- SELECT COM JOIN

SELECT * FROM FORNECEDOR_PRODUTO fp 
INNER JOIN FORNECEDOR f 
WHERE fp.COD_FORNECEDOR = f.COD_FORNECEDOR 
AND fp.COD_FORNECEDOR = 2;

-- SELECT COM JOIN

SELECT COUNT(*) AS QUANTIDADE_DE_PEDIDOS FROM PEDIDO p 
INNER JOIN CLIENTE c 
WHERE p.COD_CLIENTE  = c.COD_CLIENTE
AND p.COD_CLIENTE = 2;











