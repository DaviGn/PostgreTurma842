alter table Produto add column Valor decimal(10,2) not null;

create table Marca (
	id int generated always as identity,
	nome varchar(50) not null,
	primary key(id)
);

alter table Produto add column MarcaId int not null;
alter table Produto add constraint FK_Produto_Marca foreign key(marcaId) references marca(id);

insert into marca (nome) values ('Nike'), ('Adidas'), ('Puma'), ('Vans');

insert into Produto (nome, valor, marcaId)
values ('Puma Suede', 400, (select Id from Marca where Nome = 'Puma')),
('Adidas Breaknet', 300, (select Id from Marca where Nome = 'Adidas')),
('Adidas Grant Court', 279, (select Id from Marca where Nome = 'Adidas')),
('Nike AirForce One', 800, (select Id from Marca where Nome = 'Nike')),
('Vans Old School', 300, (select Id from Marca where Nome = 'Vans')),
('Vans Ultrarange', 500, (select Id from Marca where Nome = 'Vans'));