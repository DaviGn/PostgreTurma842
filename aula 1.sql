create table Cidade (
	id int primary key,
	nome varchar
)

insert into Cidade (id, nome)
values (3, null)

insert into Cidade (id)
values (5)

insert into Cidade 
values (7, 'S�o Paulo')

insert into Cidade 
values (8, 'S�o Caetano'),
(9, 'S�o Bernardo')

alter table cidade alter column nome type varchar(20)

update cidade set nome = ''
where nome is null

alter table cidade alter column nome set not null

delete from cidade
where nome = ''

select * from Cidade