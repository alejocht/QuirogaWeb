create database quiroga_db;
go
use quiroga_db;
go
create table clientes(
id int primary key not null identity(1,1),
nombre varchar(100) not null,
activo bit default 1 not null,
fecha_creacion datetime not null,
fecha_ult_modificacion datetime null
);
create table productos(
id int primary key not null identity(1,1),
nombre varchar(100) not null,
precio money not null default 0,
categoria varchar(50) null,
activo bit default 1 not null,
fecha_creacion datetime not null,
fecha_ult_modificacion datetime null
);
create table colores(
id int primary key not null identity(1,1),
nombre varchar(100) not null,
multiplicador decimal(5,2) not null default 1.00,
activo bit default 1 not null,
fecha_creacion datetime not null,
fecha_ult_modificacion datetime null
);
create table remitos(
id bigint primary key not null identity(1,1),
id_cliente int not null,
fecha_emision date not null,
total money not null default 0,
activo bit default 1 not null,
fecha_creacion datetime not null,
fecha_ult_modificacion datetime null,
constraint FK_remitos_clientes foreign key (id_cliente) references clientes(id)
);
create table pagos(
id bigint primary key not null identity(1,1),
id_cliente int not null,
fecha date not null,
monto money not null,
metodo_pago varchar(100) null,
observaciones varchar(200) null,
activo bit default 1 not null,
fecha_creacion datetime not null,
fecha_ult_modificacion datetime null,
constraint FK_pagos_clientes foreign key (id_cliente) references clientes(id)
);
create table detalle_remitos(
id bigint primary key not null identity(1,1),
id_remito bigint not null,
id_producto int not null,
id_color int not null,
descripcion varchar(100) null,
cantidad decimal not null,
precio_unitario money not null,
precio_total money not null,
activo bit default 1 not null,
fecha_creacion datetime not null,
fecha_ult_modificacion datetime null,
constraint FK_detalleremitos_remitos foreign key (id_remito) references remitos(id),
constraint FK_detalleremitos_productos foreign key (id_producto) references productos(id),
constraint FK_detalleremitos_colores foreign key (id_color) references colores(id)
)