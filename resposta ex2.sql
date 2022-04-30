create table Funcionalidades (
	id int generated always as identity,
	nome varchar(60) not null,	
	primary key(id)
);

create table Departamentos (
	id int generated always as identity,
	nome varchar(60) not null,
	primary key(id)
);

create table DepartamentosFuncionalidades (
	DepartamentoId int,
	FuncionalidadeId int,
	primary key(DepartamentoId, FuncionalidadeId),
	constraint FK_DepartamentosFuncionalidades_Departamentos foreign key(DepartamentoId) references Departamentos(id),
	constraint FK_DepartamentosFuncionalidades_Funcionalidades foreign key(FuncionalidadeId) references Funcionalidades(id)
);

create table Usuarios (
	cpf varchar(11) not null,
	nome varchar(60) not null,
	email varchar(60) not null,
	senha varchar(500) not null,
	dtnascimento date not null,
	departamentoId int not null,
	validado boolean not null default false,
	excluido boolean not null default false,
	primary key(cpf),
	constraint FK_Usuarios_Departamentos foreign key(departamentoId) references Departamentos(id)
);