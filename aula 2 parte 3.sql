create table Produto (
	Id int generated always as identity,
	nome varchar (100) not null,
	primary key(Id)
);

create table Cliente (
	Id int generated always as identity,
	nome varchar (100) not null,
	primary key(Id)
);

create table MotivoDevolucao (
	Id int generated always as identity,
	nome varchar (100) not null,
	primary key(Id)
);

create table Compra (
	Id int generated always as identity,
	ClienteId int not null,
	MotivoDevolucaoId int,
	primary key(Id),
	constraint FK_Compra_Cliente foreign key(ClienteId) references Cliente(Id),
	constraint FK_Compra_MotivoDevolucao foreign key(MotivoDevolucaoId) references MotivoDevolucao(Id)
);

-- Chave primária composta
CREATE TABLE ItensCompra (
	-- Chave primária
	CompraId int not null,
	ProdutoId int not null,
	------------
	Qtd decimal(10, 2) not null,
	primary key (CompraId, ProdutoId),
	constraint FK_ItensCompra_Compra foreign key(CompraId) references Compra(Id),
	constraint FK_ItensCompra_Produto foreign key(ProdutoId) references Produto(Id)
)


CREATE TABLE NFE (
	Id int generated always as identity,
	primary key (Id)
)

CREATE TABLE ItensNFE (
	NFEId int not null,
	CompraId int not null,
	ProdutoId int not null,
	primary key (NFEId, CompraId, ProdutoId),
	constraint FK_ItensNFE_NFE foreign key (NFEId) references NFE(Id),
	constraint FK_ItensNFE_ItensCompra foreign key (CompraId, ProdutoId) 
		references ItensCompra(CompraId, ProdutoId)
)