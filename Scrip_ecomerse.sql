-- Criação do banco de dados para o cenario de E-commmerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique(CPF)
);



-- criar tabela Produto
create table Product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kid bool default false,
    catogory enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis') not null,
    avaliação float default 0,
    size varchar(10)
);

-- criar tablea pagamento

create table payments(
	idClient int,
    id_payment int,
    cash float,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key(idClient, id_payment)
);


-- criar tabela Pedido
create table orders( 
	idOrders int auto_increment primary key,
    idOrderClient int,
    ordersStatus enum('cancelado','Confirmado','Em processamento') default 'Em processamento',
    ordersDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
	constraint fk_ordes_client foreign key (idOrderClient) references clients(idClient)

);

-- criar tabela estoque 
create table productStorage( 
	idProdStorage int auto_increment primary key,
    category int,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor 
create table supplier( 
	idsupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
-- criar tabela vendedor
create table Seller( 
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);


-- Criar tabela Produto vendedor

create table productSeller(
	idPseller int,
	idProduct int,
    prodQuantity int default 1,
	primary key(idPseller , idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
	constraint fk_product_product foreign key (idProduct) references product(idProduct)

);
-- criar tabela Produto pedido 
create table productOrder(
	idPOproduct int,
	idPOrder int,
    poQuantity int default 1,
    poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
	primary key(idPOproduct , idPOrder),
    constraint fk_productOrder_seller foreign key (idPOproduct) references product(idProduct),
	constraint fk_producOrder_product foreign key (idPOrder) references orders(idOrders)
);


-- criar tabela produto em estoque
create table StorageLocation(
	idLproduct int,
	idLstorage int,
    location varchar(255) not null,
	primary key(idLproduct , idLstorage),
    constraint fk_StorageLocation_product foreign key (idLproduct) references product(idProduct),
	constraint fk_StorageLocation_Storage foreign key (idLstorage) references productStorage(idProdStorage)
);


create table productSupplier(
	idPsSupplier int,
	idPsProduct int,
    Quantity int not null,
	primary key(idPsSupplier , idPsProduct),
    constraint fk_productSupplier_seller foreign key (idPsSupplier) references supplier(idsupplier),
	constraint fk_productSupplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables
