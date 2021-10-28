--Banco de Dados - Banco de Dados Correios
--Felipe Daniel Dias dos Santos - 11711ECP004
--Gradua��o em Engenharia de Computa��o - Faculdade de Engenharia El�trica - Universidade Federal de Uberl�ndia

--Inicializar base de dados
CREATE DATABASE correios

SELECT * FROM localidades
SELECT * FROM logradouros
SELECT * FROM bairros

--Fun��o para quantidade de cidades no Brasil
CREATE OR REPLACE FUNCTION qntd_cidades_br() 
RETURNS varchar AS
$$
	DECLARE 
		quantidade INTEGER;
	BEGIN
		SELECT COUNT (*) INTO quantidade FROM localidades;
		RETURN 'Quantidade de cidades no Brasil: ' || quantidade;
	END
$$
LANGUAGE plpgsql;

--Retornar quantidade de cidades no Brasil
SELECT qntd_cidades_br();

--Fun��o para quantidade de cidades em Minas Gerais
CREATE OR REPLACE FUNCTION qntd_cidades_mg() 
RETURNS varchar AS
$$
	DECLARE 
		quantidade INTEGER;
	BEGIN
		SELECT COUNT (*) INTO quantidade FROM localidades WHERE estado = 'MG';
		RETURN 'Quantidade de cidades em Minas Gerais: ' || quantidade;
	END
$$
LANGUAGE plpgsql;

--Retornar quantidade de cidades em Minas Gerais
SELECT qntd_cidades_mg();

--Fun��o para listar cidades de Minas Gerais
CREATE OR REPLACE FUNCTION cidades_mg() 
RETURNS SETOF localidades AS
'
SELECT * FROM localidades WHERE estado = ''MG'';
'
LANGUAGE sql;

--Retornar lista de cidades de Minas Gerais
SELECT cidades_mg();

--Fun��o para listar ruas de Uberl�ndia
SELECT * FROM localidades WHERE localidade = 'Uberl�ndia'

CREATE OR REPLACE FUNCTION ruas_udia() 
RETURNS SETOF logradouros AS
'
SELECT * FROM logradouros WHERE localidade = 4048 AND tipo = ''Rua'';
'
LANGUAGE sql;

--Retornar lista de ruas de Uberl�ndia
SELECT ruas_udia();

--Fun��o para controle da tabela localidades
CREATE SEQUENCE sq_localidades START WITH 9980 INCREMENT BY 1;

CREATE OR REPLACE FUNCTION controle_localidades(f_codigo integer, f_localidade varchar, f_estado char, f_opcao char)
RETURNS varchar AS
$$
	DECLARE
		codigo_localidade localidades.codigo%TYPE;
	BEGIN
		IF f_opcao = 'I' THEN
			SELECT nextval('sq_localidades') INTO codigo_localidade;
			INSERT INTO localidades (codigo, localidade, estado) VALUES(codigo_localidade, f_localidade, f_estado);
			RETURN 'Inser��o realizada com sucesso. C�digo da nova localidade: ' || codigo_localidade;
		ELSIF f_opcao = 'U' THEN
			UPDATE localidades SET localidade = f_localidade, estado = f_estado WHERE codigo = f_codigo;
			RETURN 'Atualiza��o realizada com sucesso. C�digo da localidade alterada: ' || f_codigo;
		ELSIF f_opcao = 'D' THEN
			DELETE FROM localidades WHERE codigo = f_codigo;
			RETURN 'Exclus�o realizada com sucesso. C�digo da localidade excluida: ' || f_codigo;
		ELSE
			RETURN 'Op��o inv�lida. Tente novamente';
		END IF;
		EXCEPTION WHEN OTHERS THEN RETURN 'Erro inesperado. Tente novamente';
	END
$$
LANGUAGE plpgsql;

--Teste de inser��o na tabela localidades
SELECT controle_localidades(null, 'Localidade de teste', 'ZZ', 'I');
SELECT * FROM localidades WHERE codigo = 9980

--Teste de altera��o na tabela localidades
SELECT controle_localidades(9980, 'Localidade alterada', 'WY', 'U');
SELECT * FROM localidades WHERE codigo = 9980

--Teste de exclus�o na tabela localidades
SELECT controle_localidades(9980, null, null, 'D');
SELECT * FROM localidades WHERE codigo = 9980

--Teste de op��o inv�lida da fun��o controle de localidades
SELECT controle_localidades(9980, null, null, 'F');

--Cria��o da tabela de auditoria de localidades
CREATE TABLE localidades_auditoria (
operacao    CHAR 	NOT NULL,
usuario	    VARCHAR     NOT NULL,
dt_hr	    TIMESTAMP	NOT NULL,
codigo	    INTEGER	NOT NULL,
localidade  VARCHAR     NOT NULL,
estado      VARCHAR     NOT NULL
);

--Fun��o de auditoria de localidades
CREATE OR REPLACE FUNCTION controle_localidades_auditoria()
RETURNS trigger AS
$$
	BEGIN
		IF(tg_op = 'DELETE') THEN
			INSERT INTO localidades_auditoria
			SELECT 'D', user, now(), OLD.*;
			RETURN OLD;
		ELSIF(tg_op = 'UPDATE') THEN
			INSERT INTO localidades_auditoria
			SELECT 'U', user, now(), NEW.*;
			RETURN NEW;
		ELSIF(tg_op = 'INSERT') THEN
			INSERT INTO localidades_auditoria
			SELECT 'I', user, now(), NEW.*;
			RETURN NEW;
		END IF;
		RETURN NULL;                   
	END
$$
LANGUAGE plpgsql;

--Trigger auditoria de localidades
CREATE TRIGGER tg_localidades_auditoria
AFTER INSERT OR UPDATE OR DELETE ON localidades
FOR EACH ROW EXECUTE PROCEDURE controle_localidades_auditoria();

--Inser��o em auditoria de localidades
SELECT controle_localidades(null, 'Localidade de teste - auditoria', 'YY', 'I');
SELECT * FROM localidades_auditoria;

--Atualiza��o em auditoria de localidades
SELECT controle_localidades(9980, 'Localidade alterada - auditoria', 'VV', 'U');
SELECT * FROM localidades_auditoria;

--Exclus�o em auditoria de localidades
SELECT controle_localidades(9980, null, null, 'D');
SELECT * FROM localidades_auditoria;
