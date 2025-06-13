-- Insert clientes
insert into clientes (nombre, fecha_creacion) values
('Miguel', getdate());

-- Insert productos
insert into productos (nombre, precio, categoria, fecha_creacion) values
('Silla', 1000, 'Muebles', getdate()),
('Tubo 110X25', 500, 'Materiales', getdate()),
('Tubo 75X25', 350, 'Materiales', getdate()),
('Sillon 3 cuerpos', 5000, 'Muebles', getdate());

-- Insert colores
insert into colores (nombre, multiplicador, fecha_creacion) values
('Negro Onix', 1.00, getdate()),
('Oliva sinteplast', 1.15, getdate());

-- Para insertar un remito con detalle primero obtengo ids (ejemplo para cliente y productos)
-- Suponemos que Miguel es id=1, colores 1 y 2, productos 1-4 según inserción anterior

-- Insert remito
insert into remitos (id_cliente, fecha_emision, total, fecha_creacion) values
(1, getdate(), 0, getdate());

-- Obtener el último id de remito insertado
declare @id_remito bigint = scope_identity();

-- Insert detalle remito (ejemplo: 2 Sillas color Negro Onix y 3 Tubo 110X25 color Oliva sinteplast)
-- Calculamos precio_unitario y precio_total según multiplicador del color

insert into detalle_remitos
(id_remito, id_producto, id_color, descripcion, cantidad, precio_unitario, precio_total, fecha_creacion)
values
(@id_remito, 1, 1, 'Silla color Negro Onix', 2, 1000 * 1.00, 2 * 1000 * 1.00, getdate()),
(@id_remito, 2, 2, 'Tubo 110X25 color Oliva sinteplast', 3, 500 * 1.15, 3 * 500 * 1.15, getdate());

-- Actualizar total del remito sumando los precios totales del detalle
update remitos
set total = (select sum(precio_total) from detalle_remitos where id_remito = @id_remito)
where id = @id_remito;
