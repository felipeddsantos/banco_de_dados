--Banco de Dados - Manipulação de Banco de Dados
--Felipe Daniel Dias dos Santos - 11711ECP004
--Graduação em Engenharia de Computação - Faculdade de Engenharia Elétrica - Universidade Federal de Uberlândia

--Utilização de apelidos 1
select p.dt_compra, p.id_cliente, p.valor from vendas.tb_pedido p
where p.id_cliente = (select c.id_cliente from vendas.tb_cliente c where c.nome = 'Felipe')

--Utilização de apelidos 2
select c.id_cliente, c.nome from vendas.tb_cliente c,
(select id_cliente from vendas.tb_pedido)p where c.id_cliente = p.id_cliente

--Verificação de existência
select 1 from vendas.tb_cliente where id = 7

--Seleção de tabelas com verificação de existência
select id_cliente, nome, sobrenome from vendas.tb_cliente c
where exists (select 1 from vendas.tb_pedido p where p.id_cliente = c.id_cliente order by id_cliente)

--Obter o valor da venda 
select ip.id_item, i.ds_item, ip.quantidade, i.preco_venda, ip.quantidade * i.preco_venda as "Valor de Venda"
from vendas.tb_produto i, vendas.tb_pedido ip
where ip.id_item = i.id_item

--Obter o total do pedido 
select ip.id_pedido, sum (ip.quantidade * i.preco_venda) as "Pedido total"
from vendas.tb_pedido ip, tabela i
where ip.id_item = i.id_item group by ip.id_pedido order by ip.id_pedido

--Obter o total do pedido e o nome do cliente 
select p.id_pedido, p.id_cliente, 
(select c.nome from vendas.tb_cliente c where c.id_cliente = p.id_cliente),
(select sum (ip.quantidade * i.preco_venda) as "Total pedido"
from vendas.tb_item_pedido ip, vendas.item i
where ip.id_item = i.id_item and p.id_pedido = ip.id_pedido group by ip.id_pedido order by ip.id_pedido)
from vendas.tb_pedido p, vendas.tb_cliente c where p.id_cliente = c.id_cliente

--Obter a quantidade de pedidos, nome, ID e sobrenome por cliente
select distinct (p.id_cliente),
(select c.nome from vendas.tb_cliente c where c.id_cliente = p.id_cliente),
(select c.sobrenome from vendas.tb_cliente c where c.id_cliente = p.id_cliente),
(select count (i.id_cliente) as "Total de pedidos do cliente"
from vendas.tb_pedido i where p.id_cliente = i.id_cliente)
from vendas.tb_pedido p, vendas.tb_cliente c where p.id_cliente = c.id_cliente
