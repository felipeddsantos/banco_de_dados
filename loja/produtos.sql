--Banco de Dados - Banco de Dados Loja (Produtos)
--Felipe Daniel Dias dos Santos - 11711ECP004
--Graduação em Engenharia de Computação - Faculdade de Engenharia Elétrica - Universidade Federal de Uberlândia

create table vendas.tb_cliente(

id_cliente  integer,
titulo      char(4),
nome        varchar(32) constraint nn_nome      not null,
sobrenome   varchar(32) constraint nn_sobrenome not null,
endereco    varchar(62) constraint nn_endereco  not null,
numero      varchar(5)  constraint nn_numero    not null,
complemento varchar(62),
cep         varchar(10),
cidade      varchar(62) constraint nn_nome      not null,
estado      varchar(2)  constraint nn_nome      not null,
fone_fixo   varchar(15) constraint nn_nome      not null,
fone_movel  varchar(15) constraint nn_nome      not null,
fg_ativo    integer,

constraint pk_id_cliente primary key (id_cliente)
);

create table vendas.tb_pedido(

id_pedido   integer,
id_cliente  integer constraint nn_id_cliente not null,
dt_compra   timestamp,
dt_entrega  timestamp,
valor       numeric(7,2),
fg_ativo    integer,
	
constraint pk_id_pedido  primary key (id_pedido),	
constraint fk_id_cliente foreign key (id_cliente) references vendas.tb_cliente (id_cliente)	
);

create table vendas.tb_item(

id_item           integer,
ds_item           varchar(64),
preco_custo       numeric(7,2),
preco_venda       numeric(7,2),
fg_ativo          integer,
	
constraint pk_id_item primary key (id_item)	
);

create table vendas.tb_codigo_barras(

codigo_barras   integer,
id_item         integer constraint nn_id_item not null,
	
constraint fk_id_item foreign key (id_item) references vendas.tb_item (id_item)	
);

create table vendas.tb_estoque(

id_item      integer constraint nn_id_item not null,
quantidade   integer,

constraint fk_id_item   foreign key (id_item) references vendas.tb_item (id_item),
constraint pk_id_item_1 primary key (id_item)
);

create table vendas.tb_item_pedido(

id_item     integer constraint nn_id_item   not null,
id_pedido   integer constraint nn_id_pedido not null,
quantidade  integer,
	
constraint fk_id_item     foreign key (id_item)   references vendas.tb_item (id_item),
constraint fk_id_pedido   foreign key (id_pedido) references vendas.tb_pedido (id_pedido),
constraint pk_item_pedido primary key (id_item, id_pedido)
);

insert into vendas.tb_cliente 
							   
values (1,  'Sr',  'Felipe',   'Santos',   'Rua A', '10', 'Casa', '1001', 'Uberlândia',     'MG', '321', '123', 1),
       (2,  'Sr',  'Márcio',   'Santos',   'Rua B', '11', 'Casa', '1002', 'Uberlândia',     'MG', '321', '123', 1),
       (3,  'Sr',  'Otávio',   'Santos',   'Rua C', '12', 'Casa', '1003', 'Uberlândia',     'MG', '321', '123', 1),
       (4,  'Sra', 'Danielle', 'Santos',   'Rua D', '13', 'Casa', '1004', 'Uberlândia',     'MG', '321', '123', 1),
       (5,  'Sr',  'Edson',    'Santos',   'Rua E', '14', 'Casa', '1005', 'Araguari',       'MG', '321', '123', 1),
       (6,  'Sra', 'Júlia',    'Dias',     'Rua F', '15', 'AP',   '1006', 'Araguari',       'MG', '321', '123', 0),
       (7,  'Sra', 'Kátia',    'Dias',     'Rua G', '16', 'Casa', '1007', 'Araguari',       'MG', '321', '123', 1),
       (8,  'Sr',  'Leonardo', 'Dias',     'Rua H', '17', 'Casa', '1008', 'Araguari',       'MG', '321', '123', 1),
       (9,  'Sra', 'Ana',      'Dias',     'Rua I', '18', 'Casa', '1009', 'São Paulo',      'SP', '321', '123', 1),
       (10, 'Sra', 'Alice',    'Dias',     'Rua J', '19', 'Casa', '1010', 'São Paulo',      'SP', '321', '123', 1),
       (11, 'Sr',  'Leandro',  'Silva',    'Rua K', '20', 'Casa', '1011', 'São Paulo',      'SP', '321', '123', 1),
       (12, 'Sr',  'Cristian', 'Silva',    'Rua L', '21', 'AP',   '1012', 'São Paulo',      'SP', '321', '123', 0),
       (13, 'Sra', 'Fernanda', 'Silva',    'Rua M', '22', 'Casa', '1013', 'Rio de Janeiro', 'RJ', '321', '123', 1),
       (14, 'Sr',  'Antônio',  'Silva',    'Rua N', '23', 'Casa', '1014', 'Rio de Janeiro', 'RJ', '321', '123', 1),
       (15, 'Sr',  'Samuel',   'Silva',    'Rua O', '24', 'Casa', '1015', 'Rio de Janeiro', 'RJ', '321', '123', 1),
       (16, 'Sr',  'Igor',     'Ferreira', 'Rua P', '25', 'Casa', '1016', 'Rio de Janeiro', 'RJ', '321', '123', 1),
       (17, 'Sr',  'Marcelo',  'Ferreira', 'Rua Q', '26', 'Casa', '1017', 'Vitória',        'ES', '321', '123', 1),
       (18, 'Sr',  'Marcos',   'Ferreira', 'Rua R', '27', 'AP',   '1018', 'Vitória',        'ES', '321', '123', 0),
       (19, 'Sr',  'Gabriel',  'Ferreira', 'Rua S', '28', 'AP',   '1019', 'Vitória',        'ES', '321', '123', 1),
       (20, 'Sra', 'Isabela',  'Ferreira', 'Rua T', '29', 'AP',   '1020', 'Manaus',         'AM', '321', '123', 1)

select * from vendas.tb_cliente

insert into vendas.tb_pedido 

values (1,  1,  '2019-8-2',  '2019-8-3',  18.90,   1),
       (2,  5,  '2019-8-2',  '2019-8-3',  299.95,  1),
       (3,  9,  '2019-8-2',  '2019-8-3',  56.70,   1),
       (4,  20, '2019-8-2',  '2019-8-3',  700.00,  1),
       (5,  5,  '2019-7-2',  '2019-8-2',  2450.00, 1),
       (6,  13, '2019-7-2',  '2019-8-2',  35.10,   1),
       (7,  17, '2019-7-2',  '2019-8-2',  3601.80, 1),
       (8,  18, '2019-7-2',  '2019-8-2',  0.80,    1),
       (9,  1,  '2019-8-25', '2019-8-27', 1.20,    1),
       (10, 11, '2019-8-25', '2019-8-27', 32.00,   1),
       (11, 10, '2019-8-25', '2019-8-27', 32.00,   1),
       (12, 10, '2019-8-25', '2019-8-27', 35.80,   1),
       (13, 10, '2019-2-13', '2019-2-16', 15.90,   1),
       (14, 8,  '2019-2-13', '2019-2-16', 604.50,  1),
       (15, 4,  '2019-2-13', '2019-2-16', 18.90,   1),
       (16, 20, '2019-2-13', '2019-2-16', 18.90,   1),
       (17, 1,  '2018-8-2',  '2018-8-4',  1750.00, 1),
       (18, 20, '2018-8-2',  '2018-8-4',  53.40,   1),
       (19, 13, '2018-8-2',  '2018-8-4',  7.80,    1),
       (20, 1,  '2018-8-2',  '2018-8-4',  1.00,    1)
	   
select * from vendas.tb_pedido

insert into vendas.tb_item 

values (1,  'Mouse',               10.95,  18.90,   1),
       (2,  'Monitor',             100.95, 200.90,  1),
       (3,  'HD',                  210.00, 350.00,  1),
       (4,  'Memória',             95.80,  178.00,  1),
       (5,  'DVD',                 0.95,   8.90,    1),
       (6,  'Pen Drive',           10.95,  18.90,   1),
       (7,  'Cabo de Alimentação', 20.95,  59.99,   1),
       (8,  'Cabo USB',            1.95,   3.90,    1),
       (9,  'Cabo OTG',            1.95,   3.90,    1),
       (10, 'Console',             500.95, 1800.90, 1),
       (11, 'Diodo',               0.05,   0.10,    1),
       (12, 'Resistor',            0.05,   0.50,    1),
       (13, 'Transistor',          1.95,   4.90,    1),
       (14, 'CI LM555',            2.95,   10.90,   1),
       (15, 'Servo Motor',         10.00,  32.00,   1),
       (16, 'Garra Robótica',      18.00,  35.80,   1),
       (17, 'Motor DC',            10.95,  18.90,   1),
       (18, 'Bateria',             70.95,  120.90,  1),
       (19, 'Transformador',       70.00,  120.00,  1),
       (20, 'Teclado',             30.95,  68.90,   1)
	   
select * from vendas.tb_item

insert into vendas.tb_codigo_barras 

values (00000, 1),
       (00001, 2),
       (00010, 3),
       (00011, 4),
       (00100, 5),
       (00101, 6),
       (00110, 7),
       (00111, 8),
       (01000, 9),
       (01001, 10),
       (01010, 11),
       (01011, 12),
       (01100, 13),
       (01101, 14),
       (01110, 15),
       (01111, 16),
       (10000, 17),
       (10001, 18),
       (10010, 19),
       (10011, 20)
                    
select * from vendas.tb_codigo_barras

insert into vendas.tb_estoque 

values (1,  5),
       (2,  3),
       (3,  14),
       (4,  7),
       (5,  19),
       (6,  13),
       (7,  17),
       (8,  19),
       (9,  23),
       (10, 29),
       (11, 31),
       (12, 37),
       (13, 41),
       (14, 43),
       (15, 47),
       (16, 53),
       (17, 59),
       (18, 61),
       (19, 1),
       (20, 0)
	   
select * from vendas.tb_estoque

insert into vendas.tb_item_pedido 

values (6,  1,  1),
       (7,  2,  5),
       (1,  3,  3),
       (3,  4,  2),
       (3,  5,  7),
       (9,  6,  9),
       (10, 7,  2),
       (11, 8,  8),
       (11, 9,  12),
       (15, 10, 1),
       (15, 11, 1),
       (16, 12, 1),
       (18, 13, 5),
       (19, 14, 3),
       (1,  15, 1),
       (1,  16, 1),
       (3,  17, 5),
       (5,  18, 6),
       (9,  19, 2),
       (12, 20, 2)
                 
select * from vendas.tb_item_pedido
