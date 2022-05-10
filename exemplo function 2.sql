CREATE OR REPLACE FUNCTION totalProducts(marca int) RETURNS integer
LANGUAGE plpgsql
AS $$
  DECLARE total int;
BEGIN
  SELECT count(*) INTO total
  FROM produto
  where marcaId = marca;
  
  RETURN total;
END;
$$;

select * from Produto
select totalProducts(2)