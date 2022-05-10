--Exemplo de trigger
create table historicoProduto (
	id int generated always as identity,
	produtoId int,
	valor decimal(10, 2),
	primary key (id),
	constraint fk_historicoProduto_produto foreign key(produtoId) references produto(id)
)

CREATE OR REPLACE FUNCTION func_order_items() RETURNS trigger AS 
$$
BEGIN
  INSERT INTO historicoProduto (produtoId, valor) values (OLD.id, OLD.valor);
  RETURN NULL;
END
$$
LANGUAGE PLPGSQL;

create or replace trigger trg_historico after update on Produto
FOR EACH ROW EXECUTE PROCEDURE func_order_items();



select * from Produto
select * from historicoProduto
update Produto set valor = 310 where Id = 2





CREATE TEMP TABLE temp_cities
(
 	name VARCHAR(80)
)

select * from temp_cities
