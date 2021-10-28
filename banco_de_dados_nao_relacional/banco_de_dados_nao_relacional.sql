--Banco de Dados - Banco de Dados Não Relacional
--Felipe Daniel Dias dos Santos - 11711ECP004
--Graduação em Engenharia de Computação - Faculdade de Engenharia Elétrica - Universidade Federal de Uberlândia

--Executar MongoDB
mongo

--Criar base de dados
use vendas

--Criar coleções
db.createCollection('cliente')
db.createCollection('pedido')
db.createCollection('item')
db.createCollection('codigo_barras')
db.createCollection('estoque')
db.createCollection('item_pedido')

show collections

--Inserir dados
db.cliente.insertMany([{"cliente" : 1, "titulo" : "Sr","nome" : "Otávio","sobrenome" : "Santos","endereco" : "Rua A","numero" : "10","complemento" : "Casa","cep" : "1001","cidade" : "Uberlândia","estado" : "MG","fone_fixo" : "321","fone_movel" : "123","fg_ativo" : 1},{"cliente" : 2, "titulo" : "Sr","nome" : "Márcio","sobrenome" : "Santos","endereco" : "Rua B","numero" : "11","complemento" : "Casa","cep" : "1002","cidade" : "Uberlândia","estado" : "MG","fone_fixo" : "321","fone_movel" : "123","fg_ativo" : 1},{"cliente" : 3, "titulo" : "Sra","nome" : "Danielle","sobrenome" : "Santos","endereco" : "Rua C","numero" : "12","complemento" : "Casa","cep" : "1003","cidade" : "Uberlândia","estado" : "MG","fone_fixo" : "321","fone_movel" : "123","fg_ativo" : 1}])

db.pedido.insertMany([{"pedido" : 1, "cliente" : 1,"dt_compra" : "2019-8-2","dt_entrega" : "2019-8-3","valor" : 18.90,"fg_ativo" : 1},{"pedido" : 2, "cliente" : 3,"dt_compra" : "2019-8-2","dt_entrega" : "2019-8-3","valor" : 299.95,"fg_ativo" : 1},{"pedido" : 3, "cliente" : 2,"dt_compra" : "2019-8-2","dt_entrega" : "2019-8-3","valor" : 56.70,"fg_ativo" : 1}])

db.item.insertMany([{"item" : 1, "ds_item" : "Mouse","preco_custo" : 10.95,"preco_venda" : 18.90,"fg_ativo" : 1},{"item" : 2, "ds_item" : "Monitor","preco_custo" : 100.95,"preco_venda" : 200.90,"fg_ativo" : 1},{"item" : 3, "ds_item" : "HD","preco_custo" : 210.00,"preco_venda" : 350.00,"fg_ativo" : 1}])

db.codigo_barras.insertMany([{"codigo_barras" : 00000, "item" : 1},{"codigo_barras" : 00001, "item" : 2},{"codigo_barras" : 00010, "item" : 3}])

db.estoque.insertMany([{"item" : 1, "estoque" : 5},{"item" : 2, "estoque" : 3},{"item" : 3, "estoque" : 14}])

db.item_pedido.insertMany([{"item" : 1, "pedido" : 1,"quantidade" : 1},{"item" : 3, "pedido" : 2,"quantidade" : 5},{"item" : 1, "pedido" : 3,"quantidade" : 3}])

--Visualizar registros
db.cliente.find().pretty()
db.pedido.find().pretty()
db.item.find().pretty()
db.codigo_barras.find().pretty()
db.estoque.find().pretty()
db.item_pedido.find().pretty()

--Visualizar registro específico
db.cliente.find({"cliente" : 2}).pretty()

--Alterar registro
db.estoque.update({"item" : 1}, {$set : {"estoque" : 1000}})
db.estoque.find({"item" : 1}).pretty()

--Excluir registro
db.cliente.deleteOne({"cliente" : 1})
db.cliente.deleteOne({"cliente" : 2})
db.cliente.find().pretty()
