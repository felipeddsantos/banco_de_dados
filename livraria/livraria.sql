--Banco de Dados - Banco de Dados Livraria
--Felipe Daniel Dias dos Santos - 11711ECP004
--Graduação em Engenharia de Computação - Faculdade de Engenharia Elétrica - Universidade Federal de Uberlândia

--Criação da base de dados
CREATE DATABASE livraria

--Criação de esquemas
CREATE SCHEMA locais
CREATE SCHEMA produtos
CREATE SCHEMA negocios
CREATE SCHEMA funcionarios
CREATE SCHEMA auditoria

--Criação das tabelas
CREATE TABLE locais.tb_unidades(

  id_unidade    INTEGER,
  endereco      VARCHAR(30) CONSTRAINT nn_endereco NOT NULL,
  cidade        VARCHAR(30) CONSTRAINT nn_cidade   NOT NULL,
  estado        VARCHAR(30) CONSTRAINT nn_estado   NOT NULL,
  pais	        VARCHAR(30) CONSTRAINT nn_pais 	   NOT NULL,
  criacao	DATE, 
  CONSTRAINT pk_id_unidade PRIMARY KEY(id_unidade)
);

CREATE TABLE locais.tb_depart_vendas(

  id_depart_venda INTEGER,
  id_unidade      INTEGER     CONSTRAINT nn_id_unidade  NOT NULL,
  localizacao     VARCHAR(30) CONSTRAINT nn_localizacao NOT NULL,
  descricao	  VARCHAR(60), 
  CONSTRAINT pk_id_depart_venda PRIMARY KEY(id_depart_venda),
  CONSTRAINT fk_id_unidade FOREIGN KEY(id_unidade) 
  REFERENCES locais.tb_unidades(id_unidade)
);

CREATE TABLE locais.tb_depart_emprestimos(

  id_depart_emprestimo INTEGER,
  id_unidade           INTEGER     CONSTRAINT nn_id_unidade  NOT NULL,
  localizacao 	       VARCHAR(30) CONSTRAINT nn_localizacao NOT NULL,
  descricao	       VARCHAR(60), 
  CONSTRAINT pk_id_depart_emprestimo PRIMARY KEY(id_depart_emprestimo),
  CONSTRAINT fk_id_unidade FOREIGN KEY(id_unidade) 
  REFERENCES locais.tb_unidades(id_unidade)
);

CREATE TABLE funcionarios.tb_gerentes(

  id_gerente INTEGER,
  id_unidade INTEGER      CONSTRAINT nn_id_unidade NOT NULL,
  cpf 	     VARCHAR(20)  CONSTRAINT nn_cpf        NOT NULL,
  nome 	     VARCHAR(30)  CONSTRAINT nn_nome       NOT NULL,
  sobrenome  VARCHAR(30)  CONSTRAINT nn_sobrenome  NOT NULL,
  nascimento DATE         CONSTRAINT nn_nascimento NOT NULL,
  endereco   VARCHAR(30)  CONSTRAINT nn_endereco   NOT NULL,
  cidade     VARCHAR(30)  CONSTRAINT nn_cidade 	   NOT NULL,
  estado     VARCHAR(30)  CONSTRAINT nn_estado 	   NOT NULL,
  pais	     VARCHAR(30)  CONSTRAINT nn_pais 	   NOT NULL,
  telefone   VARCHAR(20)  CONSTRAINT nn_telefone   NOT NULL,
  salario    NUMERIC(7,2) CONSTRAINT nn_salario    NOT NULL, 
  CONSTRAINT pk_id_gerente PRIMARY KEY(id_gerente),
  CONSTRAINT fk_id_unidade FOREIGN KEY(id_unidade) 
  REFERENCES locais.tb_unidades(id_unidade)
);

CREATE TABLE funcionarios.tb_vendedores(

  id_vendedor	INTEGER,
  id_unidade    INTEGER      CONSTRAINT nn_id_unidade NOT NULL,
  cpf 	        VARCHAR(20)  CONSTRAINT nn_cpf        NOT NULL,
  nome 	        VARCHAR(30)  CONSTRAINT nn_nome       NOT NULL,
  sobrenome 	VARCHAR(30)  CONSTRAINT nn_sobrenome  NOT NULL,
  nascimento 	DATE         CONSTRAINT nn_nascimento NOT NULL,
  endereco 	VARCHAR(30)  CONSTRAINT nn_endereco   NOT NULL,
  cidade 	VARCHAR(30)  CONSTRAINT nn_cidade     NOT NULL,
  estado 	VARCHAR(30)  CONSTRAINT nn_estado     NOT NULL,
  pais	        VARCHAR(30)  CONSTRAINT nn_pais       NOT NULL,
  telefone 	VARCHAR(20)  CONSTRAINT nn_telefone   NOT NULL,
  salario	NUMERIC(7,2) CONSTRAINT nn_salario    NOT NULL, 
  ultima_venda  TIMESTAMP,
  CONSTRAINT pk_id_vendedor PRIMARY KEY(id_vendedor),
  CONSTRAINT fk_id_unidade FOREIGN KEY(id_unidade) 
  REFERENCES locais.tb_unidades(id_unidade)
);

CREATE TABLE funcionarios.tb_bibliotecarios(

  id_bibliotecario     INTEGER,
  id_depart_emprestimo INTEGER      CONSTRAINT nn_id_depart_emprestimo NOT NULL,
  cpf 	               VARCHAR(20)  CONSTRAINT nn_cpf                  NOT NULL,
  nome 	               VARCHAR(30)  CONSTRAINT nn_nome                 NOT NULL,
  sobrenome 	       VARCHAR(30)  CONSTRAINT nn_sobrenome            NOT NULL,
  nascimento 	       DATE         CONSTRAINT nn_nascimento           NOT NULL,
  endereco 	       VARCHAR(30)  CONSTRAINT nn_endereco             NOT NULL,
  cidade 	       VARCHAR(30)  CONSTRAINT nn_cidade 	       NOT NULL,
  estado 	       VARCHAR(30)  CONSTRAINT nn_estado 	       NOT NULL,
  pais	               VARCHAR(30)  CONSTRAINT nn_pais 	               NOT NULL,
  telefone 	       VARCHAR(20)  CONSTRAINT nn_telefone             NOT NULL,
  salario	       NUMERIC(7,2) CONSTRAINT nn_salario              NOT NULL, 
  CONSTRAINT pk_id_bibliotecario PRIMARY KEY(id_bibliotecario),
  CONSTRAINT fk_id_depart_emprestimo FOREIGN KEY(id_depart_emprestimo) 
  REFERENCES locais.tb_depart_emprestimos(id_depart_emprestimo)
);

CREATE TABLE produtos.tb_editoras(

  id_editora INTEGER,
  cnpj 	     VARCHAR(20) CONSTRAINT nn_cnpj     NOT NULL,
  endereco   VARCHAR(30) CONSTRAINT nn_endereco NOT NULL,
  cidade     VARCHAR(30) CONSTRAINT nn_cidade 	NOT NULL,
  estado     VARCHAR(30) CONSTRAINT nn_estado 	NOT NULL,
  pais	     VARCHAR(30) CONSTRAINT nn_pais 	NOT NULL,
  CONSTRAINT pk_id_editora PRIMARY KEY(id_editora)
);

CREATE TABLE produtos.tb_autores(
  id_autor    INTEGER,
  nome 	      VARCHAR(30) CONSTRAINT nn_nome        NOT NULL,
  sobrenome   VARCHAR(30) CONSTRAINT nn_sobrenome   NOT NULL,
  nascimento  DATE,
  preferencia INTEGER     CONSTRAINT nn_preferencia NOT NULL,
  CONSTRAINT pk_id_autor PRIMARY KEY(id_autor)
);

CREATE TABLE produtos.tb_generos(

  id_genero   INTEGER,
  descricao   VARCHAR(60) CONSTRAINT nn_descricao   NOT NULL,
  preferencia INTEGER     CONSTRAINT nn_preferencia NOT NULL,
  CONSTRAINT pk_id_genero PRIMARY KEY(id_genero)
);

CREATE TABLE produtos.tb_obras(

  id_obra    INTEGER,
  id_editora INTEGER     CONSTRAINT nn_id_editora NOT NULL,
  id_genero  INTEGER     CONSTRAINT nn_id_genero  NOT NULL,
  id_autor   INTEGER     CONSTRAINT nn_id_autor   NOT NULL,
  nome 	     VARCHAR(30) CONSTRAINT nn_nome       NOT NULL,
  publicacao DATE        CONSTRAINT nn_publicacao NOT NULL,
  descricao  VARCHAR(60),
  preferencia INTEGER CONSTRAINT nn_preferencia   NOT NULL,
  CONSTRAINT pk_id_obra PRIMARY KEY(id_obra),
  CONSTRAINT fk_id_genero FOREIGN KEY(id_genero) 
  REFERENCES produtos.tb_generos(id_genero),
  CONSTRAINT fk_id_autor FOREIGN KEY(id_autor) 
  REFERENCES produtos.tb_autores(id_autor),
  CONSTRAINT fk_id_editora FOREIGN KEY(id_editora) 
  REFERENCES produtos.tb_editoras(id_editora)
);

CREATE TABLE negocios.tb_tipo_clientes(

  id_tipo_cliente	 INTEGER,
  descricao 	         VARCHAR(60),
  desconto_vendas 	 NUMERIC(7,2) CONSTRAINT nn_desconto_vendas        NOT NULL,
  desconto_emprestimos 	 NUMERIC(7,2) CONSTRAINT nn_desconto_emprestimos   NOT NULL,
  desconto_multas 	 NUMERIC(7,2) CONSTRAINT nn_desconto_multas        NOT NULL,
  tempo_extra_emprestimo INTEGER      CONSTRAINT nn_tempo_extra_emprestimo NOT NULL,
  emprestimo_simultaneo  INTEGER      CONSTRAINT nn_emprestimo_simultaneo  NOT NULL,
  multa_maxima	         NUMERIC(7,2) CONSTRAINT nn_multa_maximo           NOT NULL, 
  CONSTRAINT pk_id_tipo_cliente PRIMARY KEY(id_tipo_cliente)
);

CREATE TABLE negocios.tb_clientes(

  id_cliente	         INTEGER,
  id_genero              INTEGER,
  id_autor               INTEGER,
  id_obra                INTEGER,
  id_tipo_cliente        INTEGER     CONSTRAINT nn_id_tipo_cliente         NOT NULL,
  nome 	                 VARCHAR(30) CONSTRAINT nn_nome                    NOT NULL,
  sobrenome 	         VARCHAR(30) CONSTRAINT nn_sobrenome               NOT NULL,
  cpf 	                 VARCHAR(20),
  endereco 	         VARCHAR(30) CONSTRAINT nn_endereco                NOT NULL,
  cidade 	         VARCHAR(30) CONSTRAINT nn_cidade 	           NOT NULL,
  estado 	         VARCHAR(30) CONSTRAINT nn_estado 	           NOT NULL,
  pais	                 VARCHAR(30) CONSTRAINT nn_pais 	           NOT NULL,
  telefone 	         VARCHAR(20) CONSTRAINT nn_telefone                NOT NULL,
  multa_total	         NUMERIC(7,2),
  emprestimos_simultaneos INTEGER     CONSTRAINT nn_emprestimos_simultaneos NOT NULL, 
  CONSTRAINT pk_id_cliente PRIMARY KEY(id_cliente),
  CONSTRAINT fk_id_genero FOREIGN KEY(id_genero) 
  REFERENCES produtos.tb_generos(id_genero),
  CONSTRAINT fk_id_autor FOREIGN KEY(id_autor) 
  REFERENCES produtos.tb_autores(id_autor),
  CONSTRAINT fk_id_obra FOREIGN KEY(id_obra) 
  REFERENCES produtos.tb_obras(id_obra),
  CONSTRAINT fk_id_tipo_cliente FOREIGN KEY(id_tipo_cliente) 
  REFERENCES negocios.tb_tipo_clientes(id_tipo_cliente)
);

CREATE TABLE produtos.tb_produtos_venda(

  id_produto_venda INTEGER,
  id_obra          INTEGER      CONSTRAINT nn_obra          NOT NULL,
  id_depart_venda  INTEGER      CONSTRAINT nn_depart_venda  NOT NULL,
  codigo_barras    VARCHAR(30)  CONSTRAINT nn_codigo_barras NOT NULL,
  preco_venda	   NUMERIC(7,2) CONSTRAINT nn_preco_venda   NOT NULL,
  preco_custo 	   NUMERIC(7,2) CONSTRAINT nn_preco_custo   NOT NULL,
  desconto 	   NUMERIC(7,2) CONSTRAINT nn_desconto      NOT NULL,
  estoque 	   INTEGER      CONSTRAINT nn_estoque 	    NOT NULL,
  CONSTRAINT pk_id_produto_venda PRIMARY KEY(id_produto_venda),
  CONSTRAINT fk_id_obra FOREIGN KEY(id_obra) 
  REFERENCES produtos.tb_obras (id_obra),
  CONSTRAINT fk_id_depart_venda FOREIGN KEY(id_depart_venda) 
  REFERENCES locais.tb_depart_vendas(id_depart_venda)
);

CREATE TABLE produtos.tb_produtos_emprestimo(

  id_produto_emprestimo	INTEGER,
  id_obra               INTEGER      CONSTRAINT nn_obra              NOT NULL,
  id_depart_emprestimo  INTEGER      CONSTRAINT nn_depart_emprestimo NOT NULL,
  codigo_barras 	VARCHAR(30)  CONSTRAINT nn_codigo_barras     NOT NULL,
  preco_emprestimo	NUMERIC(7,2) CONSTRAINT nn_preco_emprestimo  NOT NULL,
  preco_custo 	        NUMERIC(7,2) CONSTRAINT nn_preco_custo       NOT NULL,
  desconto 	        NUMERIC(7,2) CONSTRAINT nn_desconto 	     NOT NULL,
  estoque 	        INTEGER      CONSTRAINT nn_estoque 	     NOT NULL,
  multa 	        NUMERIC(7,2) CONSTRAINT nn_multa 	     NOT NULL,
  CONSTRAINT pk_id_produto_emprestimo PRIMARY KEY(id_produto_emprestimo),
  CONSTRAINT fk_id_depart_emprestimo FOREIGN KEY(id_depart_emprestimo) 
  REFERENCES locais.tb_depart_emprestimos(id_depart_emprestimo),
  CONSTRAINT fk_id_obra FOREIGN KEY(id_obra) 
  REFERENCES produtos.tb_obras(id_obra)
);

CREATE TABLE negocios.tb_emprestimos(

  id_emprestimo	        INTEGER,
  id_cliente            INTEGER      CONSTRAINT nn_id_cliente            NOT NULL,
  id_bibliotecario      INTEGER      CONSTRAINT nn_id_bibliotecario      NOT NULL,
  id_produto_emprestimo INTEGER      CONSTRAINT nn_id_produto_emprestimo NOT NULL,
  data_emprestimo 	TIMESTAMP    CONSTRAINT nn_data_emprestimo       NOT NULL,
  data_devolucao	TIMESTAMP    CONSTRAINT nn_data_devolucao        NOT NULL,
  quantidade 	        INTEGER      CONSTRAINT nn_quantidade 	         NOT NULL,
  valor 	        NUMERIC(7,2) CONSTRAINT nn_valor 	         NOT NULL,
  CONSTRAINT pk_id_emprestimo PRIMARY KEY(id_emprestimo),
  CONSTRAINT fk_id_cliente FOREIGN KEY(id_cliente) 
  REFERENCES negocios.tb_clientes(id_cliente),
  CONSTRAINT fk_id_bibliotecario FOREIGN KEY(id_bibliotecario) 
  REFERENCES funcionarios.tb_bibliotecarios(id_bibliotecario),
  CONSTRAINT fk_id_produto_emprestimo FOREIGN KEY(id_produto_emprestimo) 
  REFERENCES produtos.tb_produtos_emprestimo(id_produto_emprestimo)
);

CREATE TABLE negocios.tb_vendas(

  id_venda	   INTEGER,
  id_cliente       INTEGER      CONSTRAINT nn_id_cliente       NOT NULL,
  id_vendedor      INTEGER      CONSTRAINT nn_id_vendedor      NOT NULL,
  id_produto_venda INTEGER      CONSTRAINT nn_id_produto_venda NOT NULL,
  data_venda 	   TIMESTAMP    CONSTRAINT nn_data_venda       NOT NULL,
  quantidade 	   INTEGER      CONSTRAINT nn_quantidade       NOT NULL,
  valor 	   NUMERIC(7,2) CONSTRAINT nn_valor 	       NOT NULL,
  CONSTRAINT pk_id_venda PRIMARY KEY(id_venda),
  CONSTRAINT fk_id_cliente FOREIGN KEY(id_cliente) 
  REFERENCES funcionarios.tb_clientes(id_cliente),
  CONSTRAINT fk_id_vendedor FOREIGN KEY(id_vendedor) 
  REFERENCES funcionarios.tb_vendedores(id_vendedor),
  CONSTRAINT fk_id_produto_venda FOREIGN KEY(id_produto_venda) 
  REFERENCES produtos.tb_produtos_venda(id_produto_venda)
);

CREATE TABLE negocios.tb_devolucoes(

  id_devolucao	 INTEGER,
  id_emprestimo  INTEGER      CONSTRAINT nn_id_emprestimo  NOT NULL,
  data_devolucao TIMESTAMP    CONSTRAINT nn_data_devolucao NOT NULL,
  multa 	 NUMERIC(7,2) CONSTRAINT nn_multa 	   NOT NULL,
  CONSTRAINT pk_id_devolucao PRIMARY KEY(id_devolucao),
  CONSTRAINT fk_id_emprestimo FOREIGN KEY(id_emprestimo) 
  REFERENCES negocios.tb_emprestimos(id_emprestimo)
);

CREATE TABLE negocios.tb_pagamentos(

  id_pagamento INTEGER,
  id_devolucao INTEGER      CONSTRAINT nn_id_devolucao  NOT NULL,
  valor        NUMERIC(7,2) CONSTRAINT nn_valor 	NOT NULL,
  CONSTRAINT pk_id_pagamento PRIMARY KEY(id_pagamento),
  CONSTRAINT fk_id_devolucao FOREIGN KEY(id_devolucao) 
  REFERENCES negocios.tb_devolucoes(id_devolucao)
);

CREATE TABLE auditoria.tb_vendas_auditoria(

  operacao         CHAR         NOT NULL,
  usuario          VARCHAR      NOT NULL,
  dt_hr            TIMESTAMP    NOT NULL,
  id_venda	   INTEGER,
  id_cliente       INTEGER      CONSTRAINT nn_id_cliente       NOT NULL,
  id_vendedor      INTEGER      CONSTRAINT nn_id_vendedor      NOT NULL,
  id_produto_venda INTEGER      CONSTRAINT nn_id_produto_venda NOT NULL,
  data_venda 	   TIMESTAMP    CONSTRAINT nn_data_venda       NOT NULL,
  quantidade 	   INTEGER      CONSTRAINT nn_quantidade       NOT NULL,
  valor 	   NUMERIC(7,2) CONSTRAINT nn_valor 	       NOT NULL
);

CREATE TABLE auditoria.tb_emprestimos_auditoria(

  operacao         CHAR         NOT NULL,
  usuario          VARCHAR      NOT NULL,
  dt_hr            TIMESTAMP    NOT NULL,
  id_emprestimo	        INTEGER,
  id_cliente            INTEGER      CONSTRAINT nn_id_cliente            NOT NULL,
  id_bibliotecario      INTEGER      CONSTRAINT nn_id_bibliotecario      NOT NULL,
  id_produto_emprestimo INTEGER      CONSTRAINT nn_id_produto_emprestimo NOT NULL,
  data_emprestimo 	TIMESTAMP    CONSTRAINT nn_data_emprestimo       NOT NULL,
  data_devolucao	TIMESTAMP    CONSTRAINT nn_data_devolucao        NOT NULL,
  quantidade 	        INTEGER      CONSTRAINT nn_quantidade 	         NOT NULL,
  valor 	        NUMERIC(7,2) CONSTRAINT nn_valor 	         NOT NULL
);

CREATE TABLE auditoria.tb_devolucoes_auditoria(

  operacao              CHAR         NOT NULL,
  usuario               VARCHAR      NOT NULL,
  dt_hr                 TIMESTAMP    NOT NULL,
  id_devolucao	 INTEGER,
  id_emprestimo  INTEGER      CONSTRAINT nn_id_emprestimo  NOT NULL,
  data_devolucao TIMESTAMP    CONSTRAINT nn_data_devolucao NOT NULL,
  multa 	 NUMERIC(7,2) CONSTRAINT nn_multa 	   NOT NULL
);

CREATE TABLE auditoria.tb_pagamentos_auditoria(

  operacao         CHAR         NOT NULL,
  usuario          VARCHAR      NOT NULL,
  dt_hr            TIMESTAMP    NOT NULL,
  id_pagamento INTEGER,
  id_devolucao INTEGER      CONSTRAINT nn_id_devolucao  NOT NULL,
  valor        NUMERIC(7,2) CONSTRAINT nn_valor 	NOT NULL
);

--Criação de sequências
CREATE SEQUENCE locais.sq_unidades START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE locais.sq_depart_vendas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE locais.sq_depart_emprestimos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE funcionarios.sq_gerentes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE funcionarios.sq_vendedores START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE funcionarios.sq_bibliotecarios START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE produtos.sq_editoras START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE produtos.sq_autores START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE produtos.sq_generos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE produtos.sq_obras START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE negocios.sq_tipo_clientes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE negocios.sq_clientes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE produtos.sq_produtos_venda START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE produtos.sq_produtos_emprestimo START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE negocios.sq_emprestimos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE negocios.sq_vendas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE negocios.sq_devolucoes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE negocios.sq_pagamentos START WITH 1 INCREMENT BY 1;

--Criação de funções
CREATE OR REPLACE FUNCTION locais.controle_unidades(id_unidade integer, endereco varchar, cidade varchar, estado varchar, pais varchar, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_unidade INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('locais.sq_unidades') INTO codigo_unidade;
			INSERT INTO locais.tb_unidades(id_unidade, endereco, cidade, estado, pais, criacao) VALUES(codigo_unidade, endereco, cidade, estado, pais, now());
			RETURN 'Unidade cadastrada com sucesso. Código da nova unidade: ' || codigo_unidade;
		ELSIF opcao = 'U' THEN
			UPDATE locais.tb_unidades SET endereco = endereco, cidade = cidade, estado = estado, pais = pais WHERE id_unidade = id_unidade;
			RETURN 'Unidade atualizada com sucesso. Código da unidade alterada: ' || id_unidade;
		ELSIF opcao = 'D' THEN
			DELETE FROM locais.tb_unidades WHERE id_unidade = id_unidade;
			RETURN 'Unidade excluida com sucesso. Código da unidade excluida: ' || id_unidade;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION locais.controle_depart_vendas(id_depart_venda integer, id_unidade integer, localizacao varchar, descricao varchar, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_depart INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('locais.sq_depart_vendas') INTO codigo_depart;
			INSERT INTO locais.tb_depart_vendas(id_depart_venda, id_unidade, localizacao, descricao) VALUES(codigo_depart, id_unidade, localizacao, descricao);
			RETURN 'Departamento cadastrado com sucesso. Código do novo departamento de vendas: ' || codigo_depart;
		ELSIF opcao = 'U' THEN
			UPDATE locais.tb_depart_vendas SET id_unidade = id_unidade, localizacao = localizacao, descricao = descricao WHERE id_depart_venda = id_depart_venda;
			RETURN 'Departamento atualizado com sucesso. Código do departamento alterado: ' || id_depart_venda;
		ELSIF opcao = 'D' THEN
			DELETE FROM locais.tb_depart_vendas WHERE id_depart_venda = id_depart_venda;
			RETURN 'Departamento excluído com sucesso. Código do departamento excluído: ' || id_depart_venda;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION locais.controle_depart_emprestimos(id_depart_emprestimo integer, id_unidade integer, localizacao varchar, descricao varchar, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_depart INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('locais.sq_depart_emprestimos') INTO codigo_depart;
			INSERT INTO locais.tb_depart_emprestimos(id_depart_emprestimo, id_unidade, localizacao, descricao) VALUES(codigo_depart, id_unidade, localizacao, descricao);
			RETURN 'Departamento cadastrado com sucesso. Código do novo departamento de empréstimos: ' || codigo_depart;
		ELSIF opcao = 'U' THEN
			UPDATE locais.tb_depart_emprestimos SET id_unidade = id_unidade, localizacao = localizacao, descricao = descricao WHERE id_depart_emprestimo = id_depart_emprestimo;
			RETURN 'Departamento atualizado com sucesso. Código do departamento alterado: ' || id_depart_emprestimo;
		ELSIF opcao = 'D' THEN
			DELETE FROM locais.tb_depart_emprestimos WHERE id_depart_emprestimo = id_depart_emprestimo;
			RETURN 'Departamento excluido com sucesso. Código do departamento excluído: ' || id_depart_emprestimo;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION funcionarios.controle_gerentes(id_gerente integer, id_unidade integer, cpf varchar, nome varchar, sobrenome varchar, nascimento date, endereco varchar, cidade varchar, estado varchar, pais varchar, telefone varchar, salario real, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_gerente INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('funcionarios.sq_gerentes') INTO codigo_gerente;
			INSERT INTO funcionarios.tb_gerentes(id_gerente, id_unidade, cpf, nome, sobrenome, nascimento, endereco, cidade, estado, pais, telefone, salario) VALUES(codigo_gerente, id_unidade, cpf, nome, sobrenome, nascimento, endereco, cidade, estado, pais, telefone, salario);
			RETURN 'Gerente cadastrado com sucesso. Código do novo gerente: ' || codigo_gerente;
		ELSIF opcao = 'U' THEN
			UPDATE funcionarios.tb_gerentes SET id_unidade = id_unidade, cpf = cpf, nome = nome, sobrenome = sobrenome, nascimento = nascimento, endereco = endereco, cidade = cidade, estado = estado, pais = pais, telefone = telefone, salario = salario WHERE id_gerente = id_gerente;
			RETURN 'Gerente atualizado com sucesso. Código do gerente alterado: ' || id_gerente;
		ELSIF opcao = 'D' THEN
			DELETE FROM funcionarios.tb_gerentes WHERE id_gerente = id_gerente;
			RETURN 'Gerente excluido com sucesso. Código do gerente excluído: ' || id_gerente;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION funcionarios.controle_vendedores(id_vendedor integer, id_unidade integer, cpf varchar, nome varchar, sobrenome varchar, nascimento date, endereco varchar, cidade varchar, estado varchar, pais varchar, telefone varchar, salario real, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_vendedor INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('funcionarios.sq_vendedores') INTO codigo_vendedor;
			INSERT INTO funcionarios.tb_vendedores(id_vendedor, id_unidade, cpf, nome, sobrenome, nascimento, endereco, cidade, estado, pais, telefone, salario) VALUES(codigo_vendedor, id_unidade, cpf, nome, sobrenome, nascimento, endereco, cidade, estado, pais, telefone, salario);
			RETURN 'Vendedor cadastrado com sucesso. Código do novo vendedor: ' || codigo_vendedor;
		ELSIF opcao = 'U' THEN
			UPDATE funcionarios.tb_vendedores SET id_unidade = id_unidade, cpf = cpf, nome = nome, sobrenome = sobrenome, nascimento = nascimento, endereco = endereco, cidade = cidade, estado = estado, pais = pais, telefone = telefone, salario = salario WHERE id_vendedor = id_vendedor;
			RETURN 'Vendedor atualizado com sucesso. Código do vendedor alterado: ' || id_vendedor;
		ELSIF opcao = 'D' THEN
			DELETE FROM funcionarios.tb_vendedores WHERE id_vendedor = id_vendedor;
			RETURN 'Vendedor excluido com sucesso. Código do vendedor excluído: ' || id_vendedor;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION funcionarios.controle_bibliotecarios(id_bibliotecario integer, id_depart_emprestimo integer, cpf varchar, nome varchar, sobrenome varchar, nascimento date, endereco varchar, cidade varchar, estado varchar, pais varchar, telefone varchar, salario real, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_bibliotecario INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('funcionarios.sq_bibliotecarios') INTO codigo_bibliotecario;
			INSERT INTO funcionarios.tb_bibliotecarios(id_bibliotecario, id_depart_emprestimo, cpf, nome, sobrenome, nascimento, endereco, cidade, estado, pais, telefone, salario) VALUES(codigo_bibliotecario, id_depart_emprestimo, cpf, nome, sobrenome, nascimento, endereco, cidade, estado, pais, telefone, salario);
			RETURN 'Bibliotecario cadastrado com sucesso. Código do novo bibliotecario: ' || codigo_bibliotecario;
		ELSIF opcao = 'U' THEN
			UPDATE funcionarios.tb_bibliotecarios SET id_depart_emprestimo = id_depart_emprestimo, cpf = cpf, nome = nome, sobrenome = sobrenome, nascimento = nascimento, endereco = endereco, cidade = cidade, estado = estado, pais = pais, telefone = telefone, salario = salario WHERE id_bibliotecario = id_bibliotecario;
			RETURN 'Bibliotecario atualizado com sucesso. Código do bibliotecario alterado: ' || id_bibliotecario;
		ELSIF opcao = 'D' THEN
			DELETE FROM funcionarios.tb_bibliotecarios WHERE id_bibliotecario = id_bibliotecario;
			RETURN 'Bibliotecario excluido com sucesso. Código do bibliotecario excluído: ' || id_bibliotecario;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION produtos.controle_editoras(id_editora integer, cnpj varchar, endereco varchar, cidade varchar, estado varchar, pais varchar, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_editora INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('produtos.sq_editoras') INTO codigo_editora;
			INSERT INTO produtos.tb_editoras(id_editora, cnpj, endereco, cidade, estado, pais) VALUES(codigo_editora, cnpj, endereco, cidade, estado, pais);
			RETURN 'Editora cadastrada com sucesso. Código da nova editora: ' || codigo_editora;
		ELSIF opcao = 'U' THEN
			UPDATE produtos.tb_editoras SET cnpj = cnpj, endereco = endereco, cidade = cidade, estado = estado, pais = pais WHERE id_editora = id_editora;
			RETURN 'Editora atualizada com sucesso. Código da editora alterada: ' || id_editora;
		ELSIF opcao = 'D' THEN
			DELETE FROM produtos.tb_editoras WHERE id_editora = id_editora;
			RETURN 'Editora excluida com sucesso. Código da editora excluída: ' || id_editora;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION produtos.controle_autores(id_autor integer, nome varchar, sobrenome varchar, nascimento date, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_autor INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('produtos.sq_autores') INTO codigo_autor;
			INSERT INTO produtos.tb_autores(id_autor, nome, sobrenome, nascimento, preferencia) VALUES(codigo_autor, nome, sobrenome, nascimento, 0);
			RETURN 'Autor cadastrado com sucesso. Código do novo autor: ' || codigo_autor;
		ELSIF opcao = 'U' THEN
			UPDATE produtos.tb_autores SET nome = nome, sobrenome = sobrenome, nascimento = nascimento WHERE id_autor = id_autor;
			RETURN 'Autor atualizado com sucesso. Código do autor alterado: ' || id_autor;
		ELSIF opcao = 'D' THEN
			DELETE FROM produtos.tb_autores WHERE id_autor = id_autor;
			RETURN 'Autor excluido com sucesso. Código do autor excluído: ' || id_autor;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION produtos.controle_generos(id_genero integer, descricao varchar, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_genero INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('produtos.sq_generos') INTO codigo_genero;
			INSERT INTO produtos.tb_generos(id_genero, descricao, preferencia) VALUES(codigo_genero, descricao, 0);
			RETURN 'Genero cadastrado com sucesso. Código do novo genero: ' || codigo_genero;
		ELSIF opcao = 'U' THEN
			UPDATE produtos.tb_generos SET descricao = descricao WHERE id_genero = id_genero;
			RETURN 'Genero atualizado com sucesso. Código do genero alterado: ' || id_genero;
		ELSIF opcao = 'D' THEN
			DELETE FROM produtos.tb_generos WHERE id_genero = id_genero;
			RETURN 'Genero excluido com sucesso. Código do genero excluído: ' || id_genero;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION produtos.controle_obras(id_obra integer, id_editora integer, id_genero integer, id_autor integer, nome varchar, publicacao date, descricao varchar, preferencia integer, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_obra INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('produtos.sq_obras') INTO codigo_obra;
			INSERT INTO produtos.tb_obras(id_obra, id_editora, id_genero, id_autor, nome, publicacao, descricao, preferencia) VALUES(codigo_obra, id_editora, id_genero, id_autor, nome, publicacao, descricao, 0);
			RETURN 'Obra cadastrada com sucesso. Código da nova obra: ' || codigo_obra;
		ELSIF opcao = 'U' THEN
			UPDATE produtos.tb_obras SET id_editora = id_editora, id_genero = id_genero, id_autor = id_autor, nome = nome, publicacao = publicacao, descricao = descricao WHERE id_obra = id_obra;
			RETURN 'Obra atualizada com sucesso. Código da obra alterada: ' || id_obra;
		ELSIF opcao = 'D' THEN
			DELETE FROM produtos.tb_obras WHERE id_obra = id_obra;
			RETURN 'Obra excluida com sucesso. Código da obra excluída: ' || id_obra;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION negocios.controle_tipo_clientes(id_tipo_cliente integer, descricao varchar, desconto_vendas real, desconto_emprestimos real, desconto_multas real, tempo_extra_emprestimo integer, emprestimo_simultaneo integer, multa_maxima real, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_tipo INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('negocios.sq_tipo_clientes') INTO codigo_tipo;
			INSERT INTO negocios.tb_tipo_clientes(id_tipo_cliente, descricao, desconto_vendas, desconto_emprestimos, desconto_multas, tempo_extra_emprestimo, emprestimo_simultaneo, multa_maxima) VALUES(codigo_tipo, descricao, desconto_vendas, desconto_emprestimos, desconto_multas, tempo_extra_emprestimo, emprestimo_simultaneo, multa_maxima);
			RETURN 'Tipo de cliente cadastrado com sucesso. Código do novo tipo de cliente: ' || codigo_tipo;
		ELSIF opcao = 'U' THEN
			UPDATE negocios.tb_tipo_clientes SET descricao = descricao, desconto_vendas = desconto_vendas, desconto_emprestimos = desconto_emprestimos, desconto_multas = desconto_multas, tempo_extra_emprestimo = tempo_extra_emprestimo, emprestimo_simultaneo = emprestimo_simultaneo, multa_maxima = multa_maxima WHERE id_tipo_cliente = id_tipo_cliente;
			RETURN 'Tipo de cliente atualizado com sucesso. Código do tipo de cliente alterado: ' || id_tipo_cliente;
		ELSIF opcao = 'D' THEN
			DELETE FROM negocios.tb_tipo_clientes WHERE id_tipo_cliente = id_tipo_cliente;
			RETURN 'Tipo de cliente excluido com sucesso. Código do tipo de cliente excluído: ' || id_tipo_cliente;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION negocios.controle_clientes(id_cliente integer, f_id_genero integer, f_id_autor integer, f_id_obra integer, id_tipo_cliente integer, nome varchar, sobrenome varchar, cpf varchar, endereco varchar, cidade varchar, estado varchar, pais varchar, telefone varchar, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_cliente INTEGER;
                preferencia_autor INTEGER;
                preferencia_obra INTEGER;
                preferencia_genero INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('negocios.sq_clientes') INTO codigo_cliente;
                        INSERT INTO negocios.tb_clientes(id_cliente, id_genero, id_autor, id_obra, id_tipo_cliente, nome, sobrenome, cpf, endereco, cidade, estado, pais, telefone, multa_total, emprestimos_simultaneos) VALUES(codigo_cliente, f_id_genero, f_id_autor, f_id_obra, id_tipo_cliente, nome, sobrenome, cpf, endereco, cidade, estado, pais, telefone, 0, 0);
                        SELECT preferencia INTO preferencia_autor FROM produtos.tb_autores WHERE id_autor = f_id_autor;
                        preferencia_autor = preferencia_autor + 1;
                        UPDATE produtos.tb_autores SET preferencia = preferencia_autor WHERE id_autor = f_id_autor;
                        SELECT preferencia INTO preferencia_obra FROM produtos.tb_obras WHERE id_obra = f_id_obra;
                        preferencia_obra = preferencia_obra + 1;
                        UPDATE produtos.tb_obras SET preferencia = preferencia_obra WHERE id_obra = f_id_obra;
                        SELECT preferencia INTO preferencia_genero FROM produtos.tb_generos WHERE id_genero = f_id_genero;
                        preferencia_genero = preferencia_genero + 1;
                        UPDATE produtos.tb_generos SET preferencia = preferencia_genero WHERE id_genero = f_id_genero;
			RETURN 'Cliente cadastrado com sucesso. Código do novo cliente: ' || codigo_cliente;
		ELSIF opcao = 'U' THEN
			UPDATE negocios.tb_clientes SET id_tipo_cliente = id_tipo_cliente, nome = nome, sobrenome = sobrenome, cpf = cpf, endereco = endereco, cidade = cidade, estado = estado, pais = pais, telefone = telefone WHERE id_obra = codigo_obra;
			RETURN 'Cliente atualizado com sucesso. Código do cliente alterado: ' || id_cliente;
		ELSIF opcao = 'D' THEN
			DELETE FROM negocios.tb_clientes WHERE id_cliente = id_cliente;
			RETURN 'Cliente excluido com sucesso. Código do cliente excluído: ' || id_cliente;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION produtos.controle_produtos_venda(id_produto_venda integer, id_obra integer, id_depart_venda integer, codigo_barras varchar, preco_venda real, preco_custo real, desconto real, estoque integer, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_produto INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('produtos.sq_produtos_venda') INTO codigo_produto;
			INSERT INTO produtos.tb_produtos_venda(id_produto_venda, id_obra, id_depart_venda, codigo_barras, preco_venda, preco_custo, desconto, estoque) VALUES(codigo_produto, id_obra, id_depart_venda, codigo_barras, preco_venda, preco_custo, desconto, estoque);
			RETURN 'Produto cadastrado com sucesso. Código do novo produto: ' || codigo_produto;
		ELSIF opcao = 'U' THEN
			UPDATE produtos.tb_produtos_venda SET id_obra = id_obra, id_depart_venda = id_depart_venda, codigo_barras = codigo_barras, preco_venda = preco_venda, preco_custo = preco_custo, desconto = desconto, estoque = estoque WHERE id_produto_venda = id_produto_venda;
			RETURN 'Produto atualizado com sucesso. Código do produto alterado: ' || id_produto_venda;
		ELSIF opcao = 'D' THEN
			DELETE FROM produtos.tb_produtos_venda WHERE id_produtos_venda = id_produtos_venda;
			RETURN 'Produto excluido com sucesso. Código do produto excluído: ' || id_produto_venda;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION produtos.controle_produtos_emprestimo(id_produto_emprestimo integer, id_obra integer, id_depart_emprestimo integer, codigo_barras varchar, preco_emprestimo real, preco_custo real, desconto real, estoque integer, multa real, opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_produto INTEGER;
	BEGIN
		IF opcao = 'I' THEN
			SELECT nextval('produtos.sq_produtos_emprestimo') INTO codigo_produto;
			INSERT INTO produtos.tb_produtos_emprestimo(id_produto_emprestimo, id_obra, id_depart_emprestimo, codigo_barras, preco_emprestimo, preco_custo, desconto, estoque, multa) VALUES(codigo_produto, id_obra, id_depart_emprestimo, codigo_barras, preco_emprestimo, preco_custo, desconto, estoque, multa);
			RETURN 'Produto cadastrado com sucesso. Código do novo produto: ' || codigo_produto;
		ELSIF opcao = 'U' THEN
			UPDATE produtos.tb_produtos_emprestimo SET id_obra = id_obra, id_depart_emprestimo = id_depart_emprestimo, codigo_barras = codigo_barras, preco_emprestimo = preco_emprestimo, preco_custo = preco_custo, desconto = desconto, estoque = estoque, multa = multa WHERE id_produto_emprestimo = id_produto_emprestimo;
			RETURN 'Produto atualizado com sucesso. Código do produto alterado: ' || id_produto_emprestimo;
		ELSIF opcao = 'D' THEN
			DELETE FROM produtos.tb_produtos_emprestimo WHERE id_produtos_emprestimo = id_produtos_emprestimo;
			RETURN 'Produto excluido com sucesso. Código do produto excluído: ' || id_produto_emprestimo;
		ELSE
			RETURN 'Opção inválida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION negocios.emprestimo(cliente integer, bibliotecario integer, produto integer, quantidade integer)
RETURNS varchar AS
$$
	DECLARE
		emprestimo INTEGER;
                valor REAL;
                desconto_produto REAL;
                desconto_cliente REAL;
                f_multa_total REAL;
                multa_permitida REAL;
                f_estoque INTEGER;
                f_emprestimos_simultaneos INTEGER;
                emprestimos_permitidos INTEGER;
                tempo_extra INTEGER;
                tempo_total DATE;
	BEGIN
                SELECT estoque INTO f_estoque AS estoque FROM produtos.tb_produtos_emprestimo WHERE id_produto_emprestimo = produto;
                SELECT emprestimos_simultaneos INTO f_emprestimos_simultaneos AS emprestimos_simultaneos FROM negocios.tb_clientes WHERE id_cliente = cliente;
                SELECT emprestimo_simultaneo INTO emprestimos_permitidos AS emprestimos_permitidos FROM negocios.tb_tipo_clientes WHERE id_tipo_cliente = (SELECT id_tipo_cliente FROM negocios.tb_clientes WHERE id_cliente = cliente);
                SELECT multa_total INTO f_multa_total AS multa_total FROM negocios.tb_clientes WHERE id_cliente = cliente;
                SELECT multa_maxima INTO multa_permitida AS multa_permitida FROM negocios.tb_tipo_clientes WHERE id_tipo_cliente = (SELECT id_tipo_cliente FROM negocios.tb_clientes WHERE id_cliente = cliente);
                SELECT tempo_extra_emprestimo INTO tempo_extra AS tempo_extra FROM negocios.tb_tipo_clientes WHERE id_tipo_cliente = (SELECT id_tipo_cliente FROM negocios.tb_clientes WHERE id_cliente = cliente);
                IF (f_estoque > 0 AND f_multa_total <= multa_permitida AND f_emprestimos_simultaneos <= emprestimos_permitidos) THEN
			SELECT nextval('negocios.sq_emprestimos') INTO emprestimo;
                	SELECT preco_emprestimo INTO valor AS valor FROM produtos.tb_produtos_emprestimo WHERE id_produto_emprestimo = produto; 
                	SELECT desconto INTO desconto_produto AS desconto_produto FROM produtos.tb_produtos_emprestimo WHERE id_produto_emprestimo = produto; 
                	SELECT desconto_emprestimos INTO desconto_cliente AS desconto_cliente FROM negocios.tb_tipo_clientes WHERE id_tipo_cliente = (SELECT id_tipo_cliente FROM negocios.tb_clientes WHERE id_cliente = cliente);
			valor = valor - desconto_cliente - desconto_produto;
                        f_estoque = f_estoque - quantidade;
                        f_emprestimos_simultaneos = f_emprestimos_simultaneos + quantidade;
                        tempo_total = CURRENT_DATE + tempo_extra + 7;
                	INSERT INTO negocios.tb_emprestimos(id_emprestimo, id_cliente, id_bibliotecario, id_produto_emprestimo, data_emprestimo, data_devolucao, quantidade, valor) VALUES(emprestimo, cliente, bibliotecario, produto, now(), tempo_total, quantidade, valor);
			UPDATE produtos.tb_produtos_emprestimo SET estoque = f_estoque WHERE id_produto_emprestimo = produto;
                        UPDATE negocios.tb_clientes SET emprestimos_simultaneos = f_emprestimos_simultaneos WHERE id_cliente = cliente;
			RETURN 'Empréstimo realizado com sucesso. Valor a pagar: ' || valor;
                END IF;
                IF (f_emprestimos_simultaneos > emprestimos_permitidos) THEN
                      RETURN 'Empréstimos simultâneos excedidos.';
                END IF;
                IF (f_multa_total > multa_permitida) THEN
                     RETURN 'Multa máxima excedida.';
                END IF;
                IF (f_estoque <= 0) THEN
                	RETURN 'Produto Indisponível.';
                END IF;
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION negocios.venda(cliente integer, vendedor integer, produto integer, quantidade integer)
RETURNS varchar AS
$$
	DECLARE
		venda INTEGER;
                valor REAL;
                desconto_produto REAL;
                desconto_cliente REAL;
                f_estoque INTEGER;
	BEGIN
                SELECT estoque INTO f_estoque AS estoque FROM produtos.tb_produtos_venda WHERE id_produto_venda = produto;
                IF (f_estoque > 0) THEN
			SELECT nextval('negocios.sq_vendas') INTO venda;
                	SELECT preco_venda INTO valor AS valor FROM produtos.tb_produtos_venda WHERE id_produto_venda = produto; 
                	SELECT desconto INTO desconto_produto AS desconto_produto FROM produtos.tb_produtos_venda WHERE id_produto_venda = produto; 
                	SELECT desconto_vendas INTO desconto_cliente AS desconto_cliente FROM negocios.tb_tipo_clientes WHERE id_tipo_cliente = (SELECT id_tipo_cliente FROM negocios.tb_clientes WHERE id_cliente = cliente);
			valor = valor - desconto_cliente - desconto_produto;
                        f_estoque = f_estoque - quantidade;
                	INSERT INTO negocios.tb_vendas(id_venda, id_cliente, id_vendedor, id_produto_venda, data_venda, quantidade, valor) VALUES(venda, cliente, vendedor, produto, now(), quantidade, valor);
			UPDATE funcionarios.tb_vendedores SET ultima_venda = now() WHERE id_vendedor = vendedor;
                        UPDATE produtos.tb_produtos_venda SET estoque = f_estoque WHERE id_produto_venda = produto;
			RETURN 'Venda realizada com sucesso. Valor a pagar: ' || valor;
                ELSE
                	RETURN 'Produto Indisponível.';
                END IF;
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION negocios.devolucao(emprestimo integer)
RETURNS varchar AS
$$
	DECLARE
                cliente INTEGER;
                f_data_devolucao TIMESTAMP;
		tempo_atual INTERVAL;
                devolucao INTEGER;
                f_desconto_multa REAL;
                f_multa REAL;
                multa_atual REAL;
                f_emprestimos_simultaneos INTEGER;
                f_quantidade INTEGER;
                f_estoque INTEGER;
                produto INTEGER;
	BEGIN
                SELECT id_cliente INTO cliente as cliente FROM negocios.tb_emprestimos WHERE id_emprestimo = emprestimo;
                SELECT data_devolucao INTO f_data_devolucao as data_devolucao FROM negocios.tb_emprestimos WHERE id_emprestimo = emprestimo;
                SELECT id_produto_emprestimo INTO produto as produto FROM negocios.tb_emprestimos WHERE id_emprestimo = emprestimo;
                tempo_atual = f_data_devolucao - now();
                IF (date_part('second', tempo_atual) < 0) THEN
                    SELECT desconto_multa INTO f_desconto_multa AS desconto_multa FROM negocios.tb_tipos_cliente WHERE id_tipo_cliente = cliente;
                    SELECT multa INTO f_multa as multa FROM produtos.tb_produtos_emprestimo WHERE id_produto = produto;
                    f_multa = f_multa - f_desconto_multa;
                    SELECT multa_total INTO multa_atual as multa_atual FROM negocios.tb_clientes WHERE id_cliente = cliente;
                    multa_atual = multa_atual + f_multa;
                    UPDATE negocios.tb_clientes SET multa_total = multa_atual WHERE id_cliente = cliente;
				ELSE
				   f_multa = 0;
                END IF;
                SELECT nextval('negocios.sq_devolucoes') INTO devolucao;
                INSERT INTO negocios.tb_devolucoes(id_devolucao, id_emprestimo, data_devolucao, multa) VALUES(devolucao, emprestimo, now(), f_multa);
                SELECT emprestimos_simultaneos INTO f_emprestimos_simultaneos as emprestimos_simultaneos FROM negocios.tb_clientes WHERE id_cliente = cliente;
                SELECT quantidade INTO f_quantidade as quantidade FROM negocios.tb_emprestimos WHERE id_emprestimo = emprestimo;
                f_emprestimos_simultaneos = f_emprestimos_simultaneos - f_quantidade;
                UPDATE negocios.tb_clientes SET emprestimos_simultaneos = f_emprestimos_simultaneos WHERE id_cliente = cliente;
                SELECT estoque INTO f_estoque FROM produtos.tb_produtos_emprestimo WHERE id_produto_emprestimo = produto;
                f_estoque = f_estoque + f_quantidade;
                UPDATE produtos.tb_produtos_emprestimo SET estoque = f_estoque WHERE id_produto_emprestimo = produto;
                RETURN 'Devolução realizada com sucesso. Código da devolução: ' || devolucao;
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION negocios.pagamento(devolucao integer)
RETURNS varchar AS
$$
	DECLARE
                f_multa REAL;
                cliente INTEGER;
                emprestimo INTEGER;
                multa_atual REAL;
                pagamento INTEGER;
	BEGIN
                SELECT nextval('negocios.sq_pagamentos') INTO pagamento;
                SELECT multa INTO f_multa as multa FROM negocios.tb_devolucoes WHERE id_devolucao = devolucao;
                SELECT id_emprestimo INTO emprestimo as emprestimo FROM negocios.tb_devolucoes WHERE id_devolucoes = devolucao;
                SELECT id_cliente INTO cliente as cliente FROM negocios.tb_emprestimos WHERE id_emprestimo = emprestimo;
                SELECT multa_total INTO multa_atual as multa_atual FROM negocios.tb_clientes WHERE id_cliente = cliente;
                INSERT INTO negocios.tb_pagamentos(id_pagamento, id_devolucao, valor) VALUES(pagamento, devolucao, multa);
                f_multa = multa_atual - f_multa;
                UPDATE negocios.tb_clientes SET multa_total = f_multa WHERE id_cliente = cliente;
                RETURN 'Pagamento realizado com sucesso. Código do pagamento: ' || pagamento;
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION negocios.relatorio_financeiro(integer) RETURNS varchar AS
$$
       DECLARE
       custo_gerentes REAL;
       custo_vendedores REAL;
       custo_bibliotecarios REAL;
       custo_vendas REAL; 
       custo_emprestimos REAL;  
       receita_vendas REAL;
       receita_emprestimos REAL;
       receita_multas REAL;
    BEGIN
       SELECT SUM(salario) INTO custo_gerentes AS custo_gerentes FROM funcionarios.tb_gerentes WHERE id_unidade = $1;
       SELECT SUM(salario) INTO custo_vendedores AS custo_vendedores FROM funcionarios.tb_vendedores WHERE id_unidade = $1;
       SELECT SUM(salario) INTO custo_bibliotecarios AS custo_bibliotecarios FROM funcionarios.tb_bibliotecarios WHERE id_unidade = $1; 
       SELECT SUM(preco_custo) INTO custo_vendas AS custo_vendas FROM produtos.tb_produtos_venda WHERE id_unidade = $1; 
       SELECT SUM(preco_custo) INTO custo_emprestimos AS custo_emprestimos FROM produtos.tb_produtos_emprestimo WHERE id_unidade = $1; 
       SELECT SUM(valor) INTO receita_emprestimos AS receita_emprestimos FROM negocios.tb_emprestimos WHERE id_unidade = $1; 
       SELECT SUM(valor) INTO receita_vendas AS receita_vendas FROM negocios.tb_vendas WHERE id_unidade = $1; 
       SELECT SUM(valor) INTO receita_multas AS receita_multas FROM negocios.tb_pagamentos WHERE id_unidade = $1; 
       RETURN 'Relatório Financeiro - Custo Total: ' || custo_vendedores + custo_gerentes + custo_bibliotecarios + custo_vendas + custo_emprestimos || ' Receita Total: ' || receita_emprestimos + receita_vendas || ' Lucro Total: ' || receita_vendas + receita_emprestimos - custo_vendedores - custo_gerentes - custo_bibliotecarios - custo_vendas - custo_emprestimos;
    END
$$
LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION negocios.relatorio_quantidades(integer) RETURNS varchar AS
$$
       DECLARE
       quantidade_gerentes integer;
       quantidade_vendedores integer;
       quantidade_bibliotecarios integer;
       quantidade_vendas integer; 
       quantidade_emprestimos integer;  
    BEGIN
       SELECT COUNT(*) INTO quantidade_gerentes AS quantidade_gerentes FROM funcionarios.tb_gerentes WHERE id_unidade = $1;
       SELECT COUNT(*) INTO quantidade_vendedores AS quantidade_vendedores FROM funcionarios.tb_vendedores WHERE id_unidade = $1;
       SELECT COUNT(*) INTO quantidade_bibliotecarios AS quantidade_bibliotecarios FROM funcionarios.tb_bibliotecarios WHERE id_unidade = $1; 
       SELECT COUNT(*) INTO quantidade_vendas AS quantidade_vendas FROM negocios.tb_vendas WHERE id_unidade = $1; 
       SELECT COUNT(*) INTO quantidade_emprestimos AS quantidade_emprestimos FROM negocios.tb_emprestimos WHERE id_unidade = $1;   
       RETURN 'Relatório Quantidades - Quantidade de Funcionários: ' || quantidade_vendedores + quantidade_gerentes + quantidade_bibliotecarios || ' Quantidade de Vendas: ' || quantidade_vendas || ' Quantidade de Empréstimos: ' || quantidade_emprestimos;
    END
$$
LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION negocios.relatorio_estoque(integer) RETURNS varchar AS
$$
       DECLARE
       estoque_emprestimos integer;
       estoque_vendas integer;
    BEGIN
       SELECT SUM(estoque) INTO estoque_emprestimos AS estoque_emprestimos FROM produtos.tb_produtos_emprestimo WHERE id_unidade = $1; 
       SELECT SUM(estoque) INTO estoque_vendas AS estoque_vendas FROM produtos.tb_produtos_venda WHERE id_unidade = $1; 
       RETURN 'Relatório Estoque - Quantidade de Produtos Disponíveis para Venda: ' || estoque_vendas || ' Quantidade de Produtos Disponíveis para Empréstimo: ' || estoque_emprestimos;
    END
$$
LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION auditoria.vendas_auditoria()
RETURNS trigger AS
$$
	BEGIN
		IF(tg_op = 'DELETE') THEN
			INSERT INTO auditoria.tb_vendas_auditoria
			SELECT 'D', user, now(), OLD.*;
			RETURN OLD;
		ELSIF(tg_op = 'UPDATE') THEN
			INSERT INTO auditoria.tb_vendas_auditoria
			SELECT 'U', user, now(), NEW.*;
			RETURN NEW;
		ELSIF(tg_op = 'INSERT') THEN
			INSERT INTO auditoria.tb_vendas_auditoria
			SELECT 'I', user, now(), NEW.*;
			RETURN NEW;
		END IF;
		RETURN NULL;                   
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION auditoria.emprestimos_auditoria()
RETURNS trigger AS
$$
	BEGIN
		IF(tg_op = 'DELETE') THEN
			INSERT INTO auditoria.tb_emprestimos_auditoria
			SELECT 'D', user, now(), OLD.*;
			RETURN OLD;
		ELSIF(tg_op = 'UPDATE') THEN
			INSERT INTO auditoria.tb_emprestimos_auditoria
			SELECT 'U', user, now(), NEW.*;
			RETURN NEW;
		ELSIF(tg_op = 'INSERT') THEN
			INSERT INTO auditoria.tb_emprestimos_auditoria
			SELECT 'I', user, now(), NEW.*;
			RETURN NEW;
		END IF;
		RETURN NULL;                   
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION auditoria.devolucoes_auditoria()
RETURNS trigger AS
$$
	BEGIN
		IF(tg_op = 'DELETE') THEN
			INSERT INTO auditoria.tb_devolucoes_auditoria
			SELECT 'D', user, now(), OLD.*;
			RETURN OLD;
		ELSIF(tg_op = 'UPDATE') THEN
			INSERT INTO auditoria.tb_devolucoes_auditoria
			SELECT 'U', user, now(), NEW.*;
			RETURN NEW;
		ELSIF(tg_op = 'INSERT') THEN
			INSERT INTO auditoria.tb_devolucoes_auditoria
			SELECT 'I', user, now(), NEW.*;
			RETURN NEW;
		END IF;
		RETURN NULL;                   
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION auditoria.pagamentos_auditoria()
RETURNS trigger AS
$$
	BEGIN
		IF(tg_op = 'DELETE') THEN
			INSERT INTO auditoria.tb_pagamentos_auditoria
			SELECT 'D', user, now(), OLD.*;
			RETURN OLD;
		ELSIF(tg_op = 'UPDATE') THEN
			INSERT INTO auditoria.tb_pagamentos_auditoria
			SELECT 'U', user, now(), NEW.*;
			RETURN NEW;
		ELSIF(tg_op = 'INSERT') THEN
			INSERT INTO auditoria.tb_pagamentos_auditoria
			SELECT 'I', user, now(), NEW.*;
			RETURN NEW;
		END IF;
		RETURN NULL;                   
	END
$$
LANGUAGE plpgsql;

--Criação de triggers
CREATE TRIGGER tg_vendas_auditoria
AFTER INSERT OR UPDATE OR DELETE ON negocios.tb_vendas
FOR EACH ROW EXECUTE PROCEDURE auditoria.vendas_auditoria();

CREATE TRIGGER tg_emprestimos_auditoria
AFTER INSERT OR UPDATE OR DELETE ON negocios.tb_emprestimos
FOR EACH ROW EXECUTE PROCEDURE auditoria.emprestimos_auditoria();

CREATE TRIGGER tg_devolucoes_auditoria
AFTER INSERT OR UPDATE OR DELETE ON negocios.tb_devolucoes
FOR EACH ROW EXECUTE PROCEDURE auditoria.devolucoes_auditoria();

CREATE TRIGGER tg_pagamentos_auditoria
AFTER INSERT OR UPDATE OR DELETE ON negocios.tb_pagamentos
FOR EACH ROW EXECUTE PROCEDURE auditoria.pagamentos_auditoria();

--Exemplos de inserção de dados
SELECT locais.controle_unidades(null, 'Rua A', 'Cidade A', 'estado A', 'pais A', 'I')
SELECT locais.controle_unidades(null, 'Rua B', 'Cidade B', 'estado B', 'pais B', 'I')

SELECT locais.controle_depart_vendas(null, 1, 'Piso 1', 'Ok', 'I')

SELECT locais.controle_depart_emprestimos(null, 1, 'Piso 1', 'Ok', 'I')
SELECT locais.controle_depart_emprestimos(null, 1, 'Piso 2', 'Ok2', 'I')

SELECT funcionarios.controle_gerentes(null, 1, '', 'Roberto', 'Silva', '09-09-09', '', '', '', '', '', 580, 'I')

SELECT funcionarios.controle_vendedores(null, 1, '', 'Amanda', '1', '09-01-04', '', '', '', '', '', 230, 'I')
SELECT funcionarios.controle_vendedores(null, 1, '', 'Amanda', '2', '09-01-04', '', '', '', '', '', 130, 'I')

SELECT funcionarios.controle_bibliotecarios(null, 1, '', 'Antonio', '1', '09-09-09', '', '', '', '', '', 120.90, 'I')
SELECT funcionarios.controle_bibliotecarios(null, 2, '', 'Antonio', '2', '09-09-09', '', '', '', '', '', 180.98, 'I')

SELECT produtos.controle_editoras(null, 'editora 1', '', '', '', '', 'I')

SELECT produtos.controle_autores(null, 'W', 'S', '07-07-99', 'I')
SELECT produtos.controle_autores(null, 'Machado', 'Assis', '07-07-99', 'I')

SELECT produtos.controle_generos(null, 'Ficção', 'I')
SELECT produtos.controle_generos(null, 'Romance', 'I')

SELECT produtos.controle_obras(null, 1, 1, 1, 'IT', '09-09-99', 'descrição', null, 'I')
SELECT produtos.controle_obras(null, 1, 2, 2, 'Cemitério Maldito', '09-09-99', 'descrição', null, 'I')

SELECT negocios.controle_tipo_clientes(null, 'cliente normal', 0, 0, 0, 0, 3, 50, 'I')
SELECT negocios.controle_tipo_clientes(null, 'cliente vip', 20, 10, 5, 3, 5, 100, 'I')

SELECT negocios.controle_clientes(null, 1, 2, 1, 2, 'Cliente', 'Normal', '', 'endereco 1', 'cidade 1', 'estado 1', 'pais 1', '', 'I')
SELECT negocios.controle_clientes(null, 2, 2, 1, 3, 'Cliente', 'Vip', '', 'endereco 2', 'cidade 2', 'estado 2', 'pais 2', '', 'I')

SELECT produtos.controle_produtos_venda(null, 1, 1, '', 90, 10, 0, 5, 'I')

SELECT produtos.controle_produtos_emprestimo(null, 1, 1, '', 40, 10, 0, 10, 5, 'I')
SELECT produtos.controle_produtos_emprestimo(null, 2, 2, '', 70, 20, 0, 15, 1, 'I')

SELECT negocios.emprestimo(1, 1, 2, 2)
SELECT negocios.emprestimo(1, 1, 1, 1)

SELECT negocios.venda(1, 1, 2, 2)

SELECT negocios.devolucao(1)

SELECT negocios.pagamento(1)

--Exemplo de utilização de funções auxiliares
SELECT negocios.relatorio_financeiro(1)
SELECT negocios.relatorio_quantidades(1)
SELECT negocios.relatorio_estoque(1)
