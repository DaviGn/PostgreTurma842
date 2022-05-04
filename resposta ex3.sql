-- Ex 1
select * from Cliente
order by Nome

-- Ex 2
select * from Produto
where Nome like '%Vans%'

-- Ex 3
select marcaId, count(*) from Produto
group by marcaId

-- Ex 4
select marcaId, count(*) from Produto
group by marcaId
having count(*) > 1

-- Ex 5
select marcaId, count(*) from Produto
where Valor > (select avg(Valor) from Produto)
group by marcaId

-- Ex 6
select marcaId, max(Valor) from Produto
group by marcaId

-- Resposta correta! ALIAS/Apelido
select p.* from Produto p
where p.Valor = (select max(Valor) from Produto where MarcaId = p.MarcaId)

