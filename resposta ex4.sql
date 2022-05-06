-- Ex 1
select p.id, p.nome, m.nome as marca, valor from Produto p
inner join Marca m on p.marcaId = m.id
order by m.nome

-- Descoberto join preguiçoso pelo Giu
SELECT p.id, p.nome, m.nome, p.valor
FROM Produto p, Marca m
WHERE p.marcaId = m.id
ORDER BY m.nome;

-- Ex 2
select p.id, p.nome, m.nome as marca, valor from Produto p
inner join Marca m on p.marcaId = m.id
where p.nome like '%Nike%'
order by m.nome

-- ou (mais eficiente)
select p.id, p.nome, m.nome as marca, valor from Produto p
inner join Marca m on p.marcaId = m.id
where p.marcaId = (select Id from marca where nome = 'Nike')
order by m.nome

-- Ex 3
select m.Nome, count(*) as Qtd, sum(p.Valor) as ValorTotal from Marca m
left join Produto p on m.Id = p.MarcaId
group by p.marcaId, m.Nome
order by count(*) -- ou pelo alias Qtd

-- Ex 4
select m.Nome, count(*) as Qtd, sum(p.Valor) as ValorTotal from Marca m
left join Produto p on m.Id = p.MarcaId
group by p.marcaId, m.Nome
having count(*) > 1
order by count(*) -- ou pelo alias Qtd

-- Ex 5
select m.nome as marca from produto p 
right join marca m on p.marcaid = m.id
where p.marcaid is null
order by marca desc