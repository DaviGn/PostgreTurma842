-- Tabela para armazenar alunos
create table if not exists Alunos (
	Cpf varchar(14), -- para ignorar .
	Nome varchar,
	Email varchar,
	primary key(Cpf)
);

insert into Alunos values ('123.123.123-12', 'Davi');
insert into Alunos values ('123.123.123-13', 'Fulano', 'teste@teste.com');
insert into Alunos values ('123.123.123-15', null, 'teste@teste.com');

update Alunos set Nome = '' where Nome is null;
update Alunos set Email = '' where Email is null;

alter table Alunos alter column Nome type varchar(60);
alter table Alunos alter column Nome set not null;
alter table Alunos alter column Email type varchar(60);
alter table Alunos alter column Email set not null;