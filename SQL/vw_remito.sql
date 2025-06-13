create or alter view vw_detalle_remitos_legible as
select
  r.id as id_remito,
  r.fecha_emision,
  c.nombre as cliente,
  p.nombre as producto,
  co.nombre as color,
  dr.descripcion,
  dr.cantidad,
  dr.precio_unitario,
  dr.precio_total
from detalle_remitos dr
inner join remitos r on dr.id_remito = r.id
inner join clientes c on r.id_cliente = c.id
inner join productos p on dr.id_producto = p.id
inner join colores co on dr.id_color = co.id
where r.activo = 1 and dr.activo = 1 and c.activo = 1 and p.activo = 1 and co.activo = 1;

select * from vw_detalle_remitos_legible
order by fecha_emision desc, id_remito;

