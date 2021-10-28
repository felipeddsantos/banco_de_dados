--Banco de Dados - Segurança de Banco de Dados
--Felipe Daniel Dias dos Santos - 11711ECP004
--Graduação em Engenharia de Computação - Faculdade de Engenharia Elétrica - Universidade Federal de Uberlândia

CREATE ROLE gerente;
CREATE ROLE analista;
CREATE ROLE estagiario;

REVOKE ALL ON FUNCTION vendas.fn_ret_nome_cliente(integer), 
                       vendas.fn_ret_cliente_tupla(integer), 
                       vendas.fn_ret_cliente_record(vendas.tb_cliente.id_cliente%TYPE), 
                       vendas.fn_log(pNome varchar) FROM PUBLIC;

REVOKE ALL ON vendas.tb_cliente, 
              vendas.tb_pedido, vendas.tb_item, 
              vendas.tb_codigo_barras, 
              vendas.tb_estoque, 
              vendas.tb_item_pedido, 
              vendas.tb_log FROM PUBLIC; 

GRANT ALL ON vendas.tb_cliente, 
             vendas.tb_pedido, 
             vendas.tb_item, 
             vendas.tb_codigo_barras, 
             vendas.tb_estoque, 
             vendas.tb_item_pedido, 
             vendas.tb_log TO gerente WITH GRANT OPTION;

GRANT EXECUTE ON FUNCTION vendas.fn_ret_nome_cliente(integer), 
                          vendas.fn_ret_cliente_tupla(integer), 
                          vendas.fn_ret_cliente_record(vendas.tb_cliente.id_cliente%TYPE), 
                          vendas.fn_log(pNome varchar)TO gerente;

GRANT ALL ON vendas.tb_cliente, 
             vendas.tb_pedido, 
             vendas.tb_item, 
             vendas.tb_codigo_barras, 
             vendas.tb_estoque, 
             vendas.tb_item_pedido, 
             vendas.tb_log TO analista;

GRANT SELECT ON vendas.tb_cliente, 
                vendas.tb_pedido, 
                vendas.tb_item, 
                vendas.tb_codigo_barras, 
                vendas.tb_estoque, 
                vendas.tb_item_pedido, 
                vendas.tb_log TO estagiario;

GRANT ALL ON SCHEMA vendas TO postgres
