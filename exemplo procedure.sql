CREATE PROCEDURE changebrandproductvalue(marca integer, incrementValue integer)
LANGUAGE SQL
BEGIN ATOMIC
	UPDATE produto set valor = valor + incrementValue
	where marcaId = marca;
END;

call changebrandproductvalue(2, 10)
select * from produto