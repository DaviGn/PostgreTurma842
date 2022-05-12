create table Agencias (
	Id int generated always as identity,
	Codigo varchar(10) not null,
	Nome varchar (50) not null,
	primary key(id)
);

create table Contas (
	Id int not null,
	AgenciaId int not null,
	Nome varchar (50) not null,
	Email varchar (50) not null,
	CPF varchar (14) not null,
	DtNascimento date not null,
	Saldo decimal(10, 2) not null default 0,
	primary key(Id, AgenciaId)
);

create index IX_Contas_AgenciaId on Contas (AgenciaId);

create table Transacoes (
	Id int generated always as identity,
	ContaOrigemId int not null,
	AgenciaOrigemId int not null,
	ContaDestinoId int not null,
	AgenciaDestinoId int not null,
	Valor decimal (10, 2) not null,
	DtTransacao date not null default now(),
	primary key(Id),
	constraint FK_Transacoes_ContaOrigem foreign key(ContaOrigemId, AgenciaOrigemId) references Contas(Id, AgenciaId),
	constraint FK_Transacoes_AgenciaOrigem foreign key(AgenciaOrigemId) references Agencias(Id),
	constraint FK_Transacoes_ContaDestino foreign key(ContaDestinoId, AgenciaDestinoId) references Contas(Id, AgenciaId),
	constraint FK_Transacoes_AgenciaDestino foreign key(AgenciaDestinoId) references Agencias(Id)
);

create index IX_Transacoes_ContaOrigem on Transacoes (ContaOrigemId, AgenciaOrigemId);
create index IX_Transacoes_ContaDestino on Transacoes (ContaDestinoId, AgenciaDestinoId);

insert into Agencias (codigo, nome)
values ('001-1', 'Default'), ('002-1', 'Especial'), ('003-1', 'Van Gogh'), ('004-1', 'Select');

insert into Contas values (100103, 1, 'Fulano da Silva', 'fulano@hotmail.com', '123.123.123-12', '2000-01-10'),
(120512, 2, 'Armando Brltrano', 'a.beltrano@hotmail.com', '123.123.123-43', '1997-05-03'),
(148619, 2, 'João José', 'jj@gmail.com', '143.223.544-41', '1992-10-19'),
(122353, 1, 'João da Silva', 'j.silva@gmail.com', '243.443.619-53', '1999-11-12');

update Contas set Saldo = 100 where Id = 100103;
update Contas set Saldo = 30 where Id = 120512;
update Contas set Saldo = 500 where Id = 148619;

-- 3
create procedure sp_enviarValor (contaOrigemId integer, agenciaOrigemId integer,
				  contaDestinoId integer, agenciaDestinoId integer, valor decimal (10, 2))
language sql
as $$
	update Contas set Saldo = Saldo - valor where Id = contaOrigemId and AgenciaId = agenciaOrigemId;
	update Contas set Saldo = Saldo + valor where Id = contaDestinoId and AgenciaId = agenciaDestinoId;
	
	insert into Transacoes (ContaOrigemId, AgenciaOrigemId,	ContaDestinoId,	AgenciaDestinoId, Valor)
	values (contaOrigemId, agenciaOrigemId, contaDestinoId, agenciaDestinoId, valor);
$$;

-- call sp_enviarValor(148619, 2, 122353, 1, 30)

select * from Contas
select * from Transacoes

-- 1
create or replace view vw_SaldoAgencias as
SELECT a.*, COALESCE(sum(c.Saldo), 0) as Saldo -- semelhante ao isnull do SQL Server,
from Agencias a
left join Contas c on a.Id = c.AgenciaId
group by a.Id, a.Codigo, a.Nome

select * from vw_SaldoAgencias

-- 2
create or replace view vw_Transferencias as
SELECT t.Id, to_char(t.DtTransacao, 'DD/MM/YYYY') as data,
t.contaOrigemId, ao.Codigo agenciaOrigem, co.Nome as Debitor,
t.contaDestinoId, ad.Codigo agenciaDestino, cd.Nome as Creditor,
t.Valor
from Transacoes t
inner join Contas co on t.ContaOrigemId = co.Id and t.AgenciaOrigemId = co.AgenciaId
inner join Agencias ao on co.AgenciaId = ao.Id
inner join Contas cd on t.ContaDestinoId = cd.Id and t.AgenciaDestinoId = cd.AgenciaId
inner join Agencias ad on cd.AgenciaId = ad.Id
order by t.DtTransacao

select * from vw_Transferencias

-- 4
create or replace view vw_contas as
select c.Id, a.Codigo as Agencia, count(tr.ContaOrigemid) Transacoes, 
case 
	when sum(tr.Valor) is null
	then 0
	else sum(tr.Valor)
end as Enviado,
--sum(
--	case 
--		when td.Valor is null then 0
--		else td.Valor
--	end
--),
case 
	when sum(td.Valor) is null
	then 0
	else sum(td.Valor)
end as Recebido
from Contas c
inner join Agencias a on c.AgenciaId = a.Id
left join Transacoes tr on c.Id = tr.ContaOrigemid and c.AgenciaId = tr.AgenciaOrigemid
left join Transacoes td on c.Id = td.ContaDestinoid and c.AgenciaId = td.AgenciaDestinoid
group by c.Id, a.Codigo

select * from vw_contas