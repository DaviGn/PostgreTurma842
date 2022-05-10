create or replace view vw_Marcas as
select m.Nome, count(*) as Qtd, sum(p.Valor) as ValorTotal from Marca m
left join Produto p on m.Id = p.MarcaId
group by p.marcaId, m.Nome
having count(*) > 1
order by count(*)

select * from vw_Marcas