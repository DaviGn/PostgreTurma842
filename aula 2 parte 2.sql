
-- Formular do alter
ALTER TABLE NomeDaTabela [ADD, ALTER, DROP] [COLUMN, CONSTRAINT] 

-- Criar a coluna
ALTER TABLE Estado ADD COLUMN PaisId int not null default 1

--ou
ALTER TABLE Estado ADD COLUMN PaisId int --nullable

update Estado set PaisId = 1 where Paisid is null
ALTER TABLE Estado alter column PaisId set not null

-- Criar a constraint
ALTER TABLE Estado ADD CONSTRAINT FK_Estado_Pais foreign key(PaisId) references Pais(Id)