-- LEFT JOIN
select * from Produto p    -- Esquerda
inner join Marca m on p.MarcaId = m.Id  -- Direita

-- Colocando condição a mais no join
select * from Departamentos d
left join Usuarios u on d.Id = u.DepartamentoId and u.Excluido = false

-- RIGHT JOIN
select * from Marca     -- Esquerda
junte com a tabela 
Produto -- Direita

-- Colocando condição a mais no join
select d.*, u.* from Usuarios u
right join Departamentos d on d.Id = u.DepartamentoId and u.Excluido = false

-- Exemplo de junção mais complexa para criar um report de compra com quantidade de itens
select cp.Id, cl.nome, m.nome motivoDevolucao, count(*) as QtdItens, sum(i.Qtd) QtdTotalItensComprados
from Compra cp
inner join Cliente cl on cp.ClienteId = cl.Id
left join MotivoDevolucao m on cp.MotivoDevolucaoId = m.Id
inner join ItensCompra i on cp.id = i.CompraId
group by cp.Id, cl.nome, m.nome
order by sum(i.Qtd) desc