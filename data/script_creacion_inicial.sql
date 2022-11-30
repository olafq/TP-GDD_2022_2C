
---------------------------------------------------------------------------------------------------------
------------------------------------- Creacion de stored procedures ------------------------------------
---------------------------------------------------------------------------------------------------------
--Stored procedure que crea el esquema 

create schema Es_Quiu_El;
go 


--Stored procedure que crea las tablas de nuestro modelo

create procedure Es_Quiu_El.Crear_Tablas
as
begin 
create table Es_Quiu_El.Compra(
	COMPRA_NUMERO decimal(19,0) not null,
	COMPRA_PROVEEDOR nvarchar(50),
	COMPRA_MEDIO_PAGO int,
	COMPRA_DESCUENTO_CODIGO decimal(19,0),
	COMPRA_FECHA date,
	COMPRA_TOTAL decimal(18,2)
);


create table Es_Quiu_El.Compra_Producto(
	COMPRA_PRODUCTO_CODIGO nvarchar(50),
	PRODUCTO_VARIANTE_CODIGO nvarchar(50),
	COMPRA_NUMERO decimal(19,0),
	COMPRA_PRODUCTO_CANTIDAD decimal(18,0),
	COMPRA_PRODUCTO_PRECIO decimal(18,2)
);



create table Es_Quiu_El.Compra_Descuento(
	DESCUENTO_COMPRA_CODIGO decimal(19,0) not null,
	DESCUENTO_COMPRA_VALOR decimal(18,2)
);


create table Es_Quiu_El.Medio_de_Pago_Compra( 
	COMPRA_MEDIO_PAGO_ID int identity (1,1) not null,
	COMPRA_MEDIO_PAGO nvarchar(255)
);



create table Es_Quiu_El.Medio_de_Pago_Venta( 
	VENTA_MEDIO_PAGO_ID int identity (1,1) not null,
	VENTA_MEDIO_PAGO nvarchar(255),
	VENTA_MEDIO_PAGO_COSTO decimal(18,2)
);



create table Es_Quiu_El.Producto_Tipo_Variante(
	PRODUCTO_VARIANTE_CODIGO nvarchar(50) not null,
	PRODUCTO_TIPO_VARIANTE nvarchar(50)
);


create table Es_Quiu_El.Variante(
	PRODUCTO_VARIANTE_CODIGO nvarchar(50)not null, /* explicar porque se puso como FK Y NO PK como estaba antes*/
	PRODUCTO_VARIANTE nvarchar(50)
);

create table Es_Quiu_El.Canal_de_Venta(
	CANAL_ID nvarchar(255) not null,
	CANAL_COSTO decimal(18,2)
);

create table Es_Quiu_El.Venta_Descuento(
	VENTA_CODIGO decimal(19,0),
	VENTA_DESCUENTO_MEDIO_DE_PAGO_ID int,
	VENTA_DESCUENTO_CONCEPTO nvarchar(255),
	VENTA_DESCUENTO_IMPORTE decimal (18,2)
);

create table Es_Quiu_El.Venta_Por_Cupon(
	VENTA_CODIGO decimal(19,0),
	VENTA_CUPON_CODIGO int,
	Venta_CUPON_Total decimal(18,2)
);

create table Es_Quiu_El.Cupon(
	VENTA_CUPON_CODIGO_ID int identity(1,1) not null,
	VENTA_CUPON_CODIGO nvarchar(255) not null,
	VENTA_CUPON_IMPORTE decimal(18,2),
	VENTA_CUPON_FECHA_DESDE date,
	VENTA_CUPON_FECHA_HASTA date,
	VENTA_CUPON_VALOR decimal(18,2),
	VENTA_CUPON_TIPO nvarchar(50)
);


create table Es_Quiu_El.Proveedor(
	PROVEEDOR_CUIT nvarchar(50) not null,
	PROVEEDOR_CP decimal(18,0),
	PROVEEDOR_LOCALIDAD nvarchar(255),
	PROVEEDOR_RAZON_SOCIAL nvarchar(50),
	PROVEEDOR_MAIL nvarchar(50),
	PROVEEDOR_DOMICILIO nvarchar(50)
);

create table Es_Quiu_El.Producto_Categoria(
	PRODUCTO_CATEGORIA_ID int identity(1,1) not null ,
	PRODUCTO_CATEGORIA nvarchar(255)
);


create table Es_Quiu_El.Producto_Por_Variante(
	PRODUCTO_CODIGO nvarchar(50) not null,
	PRODUCTO_VARIANTE_CODIGO nvarchar(50)  not null,
	PRECIO_UNITARIO_VENTA decimal(18,2) default null ,
	PRECIO_UNITARIO_COMPRA decimal(18,2) default null
);

create table Es_Quiu_El.Venta(
	VENTA_CODIGO decimal(19,0) not null,
	VENTA_CLIENTE_CODIGO int,
	VENTA_MEDIO_PAGO int,
	VENTA_MEDIO_PAGO_COSTO decimal(18,2),
	VENTA_CANAL nvarchar(255),
	VENTA_CANAL_COSTO decimal(18,2),
	VENTA_ENVIO_CODIGO int NOT NULL,
	VENTA_COSTO_ENVIO decimal(18,2),
	VENTA_FECHA date,
	VENTA_TOTAL decimal(18,2)
);

create table Es_Quiu_El.Venta_Producto(
	VENTA_PRODUCTO_CODIGO nvarchar(50),
	VENTA_CODIGO decimal(19,0),
	PRODUCTO_VARIANTE_CODIGO nvarchar(50),
	VENTA_PRODUCTO_CANTIDAD decimal(18,0),
	VENTA_PRODUCTO_PRECIO decimal(18,2)
);


create table Es_Quiu_El.Envio_CP(
	ENVIO_ID int,
	CODIGO_POSTAL decimal(18,0),
	LOCALIDAD nvarchar(255), ------------
	ENVIO_PRECIO decimal(18,2)
);


create table Es_Quiu_El.Envio(
	ENVIO_ID int identity(1,1) not null,
	ENVIO_MEDIO nvarchar(255),
	ENVIO_PRECIO decimal(18,2),
	ENVIO_TIEMPO decimal(18,2)
);


create table Es_Quiu_El.Producto(
	PRODUCTO_CODIGO nvarchar(50)not null,
	PRODUCTO_CATEGORIA int,
	PRODUCTO_NOMBRE nvarchar(50),
	PRODUCTO_DESCRIPCION nvarchar(50),
	PRODUCTO_MATERIAL nvarchar(50),
	PRODUCTO_MARCA nvarchar(50)
);

create table Es_Quiu_El.Cliente(
	CLIENTE_CODIGO int identity(1,1) not null,
	CLIENTE_DNI decimal(18,0),
	CLIENTE_NOMBRE nvarchar(255),
	CLIENTE_APELLIDO nvarchar(255),
	CLIENTE_TELEFONO decimal(18,0),
	ClIENTE_MAIL nvarchar(255),
	CLIENTE_FECHA_NAC date,
	CLIENTE_DIRECCION nvarchar(255),
	CLIENTE_CP decimal (18,0),
	CLIENTE_LOCALIDAD nvarchar(255),
);


create table Es_Quiu_El.Zona(
	CODIGO_POSTAL decimal(18,0) not null,
	LOCALIDAD nvarchar(255) not null,
	PROVINCIA nvarchar(50),
);

--PRIMARY KEYS

alter table Es_Quiu_El.Compra
add primary key (COMPRA_NUMERO)

alter table Es_Quiu_El.Medio_de_Pago_Compra 
add primary key(COMPRA_MEDIO_PAGO_ID)

alter table Es_Quiu_El.Medio_de_Pago_Venta 
add primary key(VENTA_MEDIO_PAGO_ID)

alter table Es_Quiu_El.Producto_Tipo_Variante 
add primary key(PRODUCTO_VARIANTE_CODIGO)

alter table Es_Quiu_El.Compra_Descuento 
add primary key(DESCUENTO_COMPRA_CODIGO)

alter table Es_Quiu_El.Canal_de_Venta
add primary key (CANAL_ID)

alter table Es_Quiu_El.Cupon 
add primary key (VENTA_CUPON_CODIGO_ID)

alter table Es_Quiu_El.Proveedor  
add primary key (PROVEEDOR_CUIT)

alter table Es_Quiu_El.Producto_Categoria  
add primary key (PRODUCTO_CATEGORIA_ID)

alter table Es_Quiu_El.Venta 
add constraint PK_VENTA_ENVIO_CODIGO primary key (VENTA_CODIGO)

alter table Es_Quiu_El.Producto_Por_Variante 
add constraint PK_Producto_por_variante_Codigo primary key (PRODUCTO_CODIGO,PRODUCTO_VARIANTE_CODIGO) 

alter table Es_Quiu_El.Envio 
add primary key (ENVIO_ID)

alter table Es_Quiu_El.Producto 
add primary key (PRODUCTO_CODIGO)

alter table Es_Quiu_El.Cliente
add primary key (CLIENTE_CODIGO)

alter table Es_Quiu_El.Zona
add constraint PK_Zona primary key(CODIGO_POSTAL,LOCALIDAD)


--FOREING KEYS

alter table Es_Quiu_El.Compra 
add constraint FK_COMPRA_PROVEEDOR foreign key(COMPRA_PROVEEDOR) references Es_Quiu_El.Proveedor(PROVEEDOR_CUIT)

alter table Es_Quiu_El.Compra
add constraint FK_COMPRA_MEDIO_PAGO foreign key(COMPRA_MEDIO_PAGO) references Es_Quiu_El.Medio_de_Pago_Compra(COMPRA_MEDIO_PAGO_ID)

alter table Es_Quiu_El.Compra
add constraint FK_COMPRA_DESCUENTO_CODIGO foreign key(COMPRA_DESCUENTO_CODIGO) references Es_Quiu_El.Compra_Descuento(DESCUENTO_COMPRA_CODIGO)

alter table Es_Quiu_El.Compra_Producto 
add constraint FK_Compra_Producto_Compra foreign key(COMPRA_NUMERO) references Es_Quiu_El.compra(COMPRA_NUMERO)

alter table Es_Quiu_El.Compra_Producto 
add constraint FK_Compra_Producto_Por_Variante foreign key(COMPRA_PRODUCTO_CODIGO,PRODUCTO_VARIANTE_CODIGO) references Es_Quiu_El.Producto_Por_Variante(PRODUCTO_CODIGO,PRODUCTO_VARIANTE_CODIGO)
 
alter table Es_Quiu_El.Variante 
add constraint FK_PRODUCTO_TIPO_X_VARIANTE foreign key(PRODUCTO_VARIANTE_CODIGO) references Es_Quiu_El.Producto_Tipo_Variante(PRODUCTO_VARIANTE_CODIGO)

alter table Es_Quiu_El.Venta_Descuento
add constraint FK_VENTA_DESCUENTO_VENTA foreign key(VENTA_CODIGO) references Es_Quiu_El.Venta(VENTA_CODIGO)

alter table Es_Quiu_El.Venta_Descuento
add constraint FK_VENTA_DESCUENTO_MEDIO_DE_PAGO foreign key(VENTA_DESCUENTO_MEDIO_DE_PAGO_ID) references Es_Quiu_El.Medio_De_Pago_Venta(VENTA_MEDIO_PAGO_ID)

alter table Es_Quiu_El.Venta_Por_Cupon
add constraint FK_Venta_Por_Cupon_X_Cupon foreign key(VENTA_CODIGO) references Es_Quiu_El.Venta(VENTA_CODIGO)

alter table Es_Quiu_El.Venta_Por_Cupon
add constraint FK_Venta_Por_Cupon foreign key(VENTA_CUPON_CODIGO) references Es_Quiu_El.Cupon(VENTA_CUPON_CODIGO_ID)

alter table Es_Quiu_El.Proveedor 
add constraint FK_Proveedor_ZONA foreign key(PROVEEDOR_CP,PROVEEDOR_LOCALIDAD) references Es_Quiu_El.ZONA(CODIGO_POSTAL,LOCALIDAD)

alter table Es_Quiu_El.Producto_Por_Variante 
add constraint FK_Producto_por_variante foreign key(PRODUCTO_CODIGO) references Es_Quiu_El.Producto(PRODUCTO_CODIGO)

alter table Es_Quiu_El.Producto_Por_Variante 
add constraint FK_Producto_por_variante_tipo_variante foreign key(PRODUCTO_VARIANTE_CODIGO) references Es_Quiu_El.Producto_Tipo_Variante(PRODUCTO_VARIANTE_CODIGO)

alter table Es_Quiu_El.Venta 
add constraint FK_VENTA_CLIENTE foreign key(VENTA_CLIENTE_CODIGO) references Es_Quiu_El.Cliente(CLIENTE_CODIGO)

alter table Es_Quiu_El.Venta 
add constraint FK_VENTA_CANAL foreign key(VENTA_CANAL) references Es_Quiu_El.Canal_de_Venta(CANAL_ID)

alter table Es_Quiu_El.Venta 
add constraint FK_VENTA_MEDIO_DE_PAGO foreign key(VENTA_MEDIO_PAGO) references Es_Quiu_El.Medio_De_Pago_Venta(VENTA_MEDIO_PAGO_ID)

alter table Es_Quiu_El.Venta 
add constraint FK_VENTA_ENVIO foreign key(VENTA_ENVIO_CODIGO) references Es_Quiu_El.Envio(ENVIO_ID)

alter table Es_Quiu_El.Venta_Producto
add constraint FK_Venta_Producto_Por_Variante foreign key(VENTA_PRODUCTO_CODIGO,PRODUCTO_VARIANTE_CODIGO) references Es_Quiu_El.Producto_Por_Variante(PRODUCTO_CODIGO,PRODUCTO_VARIANTE_CODIGO)

alter table Es_Quiu_El.Venta_Producto 
add constraint FK_Venta_Producto_Venta foreign key(VENTA_CODIGO) references Es_Quiu_El.Venta(VENTA_CODIGO)

alter table Es_Quiu_El.Envio_CP
add  constraint FK_ENVIO_CP_ENVIO foreign key(ENVIO_ID) references Es_Quiu_El.Envio(ENVIO_ID)

alter table Es_Quiu_El.Envio_CP
add  constraint FK_ENVIO_ZONA foreign key(CODIGO_POSTAL, LOCALIDAD) references Es_Quiu_El.Zona(CODIGO_POSTAL, LOCALIDAD)

alter table Es_Quiu_El.Producto 
add constraint FK_Producto_Por_Categoria foreign key(PRODUCTO_CATEGORIA) references Es_Quiu_El.Producto_Categoria(PRODUCTO_CATEGORIA_ID)

alter table Es_Quiu_El.Cliente 
add constraint FK_CLIENTE_ZONA foreign key(CLIENTE_CP,CLIENTE_LOCALIDAD) references Es_Quiu_El.Zona(CODIGO_POSTAL,LOCALIDAD)

end 
go


--Stored procedure para migrar Zonas
create procedure Es_Quiu_El.Migrar_Zonas
as 
begin

insert into Es_Quiu_El.Zona (CODIGO_POSTAL , LOCALIDAD , PROVINCIA)

select distinct Maestra.CLIENTE_CODIGO_POSTAL, Maestra.CLIENTE_LOCALIDAD, Maestra.CLIENTE_PROVINCIA from gd_esquema.Maestra
where CLIENTE_CODIGO_POSTAL is not null and CLIENTE_LOCALIDAD is not null 
union
select distinct Maestra.PROVEEDOR_CODIGO_POSTAL, Maestra.PROVEEDOR_LOCALIDAD, Maestra.PROVEEDOR_PROVINCIA from gd_esquema.Maestra
where CLIENTE_PROVINCIA is not null and PROVEEDOR_PROVINCIA is not null


end
go



--Stored procedure para migrar Proveedores

create procedure Es_Quiu_El.Migrar_Proveedores --Con left tira 21 resultados porque hay 3 con CP y localidad en NULL, tiene sentido no migrarlos? 
as 
begin
insert into Es_Quiu_El.Proveedor(PROVEEDOR_CUIT,PROVEEDOR_RAZON_SOCIAL,PROVEEDOR_MAIL,PROVEEDOR_CP,PROVEEDOR_LOCALIDAD,PROVEEDOR_DOMICILIO)

select  distinct Maestra.PROVEEDOR_CUIT, Maestra.PROVEEDOR_RAZON_SOCIAL,
 Maestra.PROVEEDOR_MAIL, Es_Quiu_El.zona.CODIGO_POSTAL,Es_Quiu_El.zona.LOCALIDAD, Maestra.PROVEEDOR_DOMICILIO
 from gd_esquema.Maestra left join Es_Quiu_El.Zona on  Es_Quiu_El.zona.Codigo_postal = maestra.proveedor_codigo_postal AND Es_Quiu_El.zona.Localidad = maestra.PROVEEDOR_localidad
 where PROVEEDOR_CUIT is not null

end
go



--Stored procedure para migrar Clientes

create procedure Es_Quiu_El.Migrar_Clientes
as 
begin
insert into Es_Quiu_El.Cliente(CLIENTE_DNI,CLIENTE_NOMBRE,CLIENTE_APELLIDO,CLIENTE_TELEFONO,CLIENTE_MAIL,CLIENTE_FECHA_NAC,CLIENTE_DIRECCION,CLIENTE_CP, CLIENTE_LOCALIDAD)

select  distinct Maestra.CLIENTE_DNI,Maestra.CLIENTE_NOMBRE, Maestra.CLIENTE_APELLIDO, Maestra.CLIENTE_TELEFONO,
Maestra.CLIENTE_MAIL, Maestra.CLIENTE_FECHA_NAC,Maestra.CLIENTE_DIRECCION,Es_Quiu_El.Zona.CODIGO_POSTAL, Es_Quiu_El.Zona.LOCALIDAD
from gd_esquema.Maestra   join Es_Quiu_El.Zona on  Es_Quiu_El.zona.Codigo_postal = maestra.CLIENTE_codigo_postal AND Es_Quiu_El.zona.Localidad = maestra.CLIENTE_localidad
where CLIENTE_DNI is not null
 
end
go



--Stored procedure para migrar Prodcucto_Categoria

create procedure Es_Quiu_El.Migrar_Producto_Categoria
as 
begin
insert into Es_Quiu_El.Producto_Categoria

select distinct PRODUCTO_CATEGORIA from gd_esquema.Maestra
where PRODUCTO_CATEGORIA is not null

end
go



--Stored procedure para migrar Productos

create procedure Es_Quiu_El.Migrar_Productos
as 
begin
insert into Es_Quiu_El.Producto

select distinct PRODUCTO_CODIGO, Es_Quiu_El.Producto_Categoria.PRODUCTO_CATEGORIA_ID, PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_MATERIAL, PRODUCTO_MARCA from gd_esquema.Maestra
join Es_Quiu_El.Producto_Categoria on Es_Quiu_El.Producto_Categoria.PRODUCTO_CATEGORIA = Maestra.PRODUCTO_CATEGORIA

end
go



--Stored procedure para migrar Productos tipo Variante

create procedure Es_Quiu_El.Migrar_Producto_Tipo_Variante
as 
begin
insert into Es_Quiu_El.Producto_Tipo_Variante

select distinct PRODUCTO_VARIANTE_CODIGO, PRODUCTO_TIPO_VARIANTE from gd_esquema.Maestra
where PRODUCTO_VARIANTE_CODIGO is not null and PRODUCTO_TIPO_VARIANTE is not null

end
go



--Stored procedure para migrar Variantes

create procedure Es_Quiu_El.Migrar_Variantes 
as 
begin
insert into Es_Quiu_El.Variante

select distinct Es_Quiu_El.Producto_Tipo_Variante.PRODUCTO_VARIANTE_CODIGO, maestra.PRODUCTO_VARIANTE from gd_esquema.Maestra
left join Es_Quiu_El.Producto_Tipo_Variante on Es_Quiu_El.Producto_Tipo_Variante.PRODUCTO_VARIANTE_CODIGO = maestra.PRODUCTO_VARIANTE_CODIGO
where Es_Quiu_El.Producto_Tipo_Variante.PRODUCTO_VARIANTE_CODIGO is not null

end
go



--Stored procedure para migrar Canales de Ventas

create procedure Es_Quiu_El.Migrar_Canal_de_Ventas
as 
begin
insert into Es_Quiu_El.Canal_de_Venta

select distinct cast (VENTA_CANAL as nvarchar(255)), VENTA_CANAL_COSTO from gd_esquema.Maestra
where VENTA_CANAL is not null and VENTA_CANAL_COSTO is not null

end
go



--Stored procedure para migrar Compra_Descuento

create procedure Es_Quiu_El.Migrar_Compra_Descuento
as 
begin
insert into Es_Quiu_El.Compra_Descuento

select DESCUENTO_COMPRA_CODIGO, DESCUENTO_COMPRA_VALOR from gd_esquema.Maestra
where DESCUENTO_COMPRA_CODIGO is not null and DESCUENTO_COMPRA_VALOR is not null

end
go



--Stored procedure para migrar Medio de Pago Compra

create procedure Es_Quiu_El.Migrar_Medio_De_Pago_Compra
as 
begin
insert into Es_Quiu_El.Medio_de_Pago_Compra

select distinct COMPRA_MEDIO_PAGO  from gd_esquema.Maestra
where COMPRA_MEDIO_PAGO is not null

end
go



--Stored procedure para migrar Medio de Pago Venta

create procedure Es_Quiu_El.Migrar_Medio_De_Pago_Venta
as 
begin
insert into Es_Quiu_El.Medio_de_Pago_Venta

select distinct VENTA_MEDIO_PAGO, VENTA_MEDIO_PAGO_COSTO from gd_esquema.Maestra
where VENTA_MEDIO_PAGO is not null

end
go



--Stored procedure para migrar Compras

create procedure Es_Quiu_El.Migrar_Compras
as 
begin
insert into Es_Quiu_El.Compra

select distinct COMPRA_NUMERO, Es_Quiu_El.Proveedor.PROVEEDOR_CUIT, Es_Quiu_El.Medio_de_Pago_Compra.COMPRA_MEDIO_PAGO_ID, Es_Quiu_El.Compra_Descuento.DESCUENTO_COMPRA_CODIGO, COMPRA_FECHA, COMPRA_TOTAL from gd_esquema.Maestra
left join Es_Quiu_El.Proveedor on Es_Quiu_El.Proveedor.PROVEEDOR_CUIT = maestra.PROVEEDOR_CUIT
join Es_Quiu_El.Medio_de_Pago_Compra on Es_Quiu_El.Medio_De_Pago_Compra.COMPRA_MEDIO_PAGO = maestra.COMPRA_MEDIO_PAGO
left join Es_Quiu_El.Compra_Descuento on Es_Quiu_El.Compra_Descuento.DESCUENTO_COMPRA_CODIGO = maestra.DESCUENTO_COMPRA_CODIGO
where COMPRA_NUMERO is not null and Es_Quiu_El.Compra_Descuento.DESCUENTO_COMPRA_CODIGO is not null

end
go



--Stored procedure para migrar Producto por Variante

create procedure Es_Quiu_El.Migrar_Producto_Por_Variante
as 
begin
insert into Es_Quiu_El.Producto_Por_Variante

select distinct Es_Quiu_El.Producto.PRODUCTO_CODIGO, Es_Quiu_El.Producto_Tipo_Variante.PRODUCTO_VARIANTE_CODIGO, null, null from gd_esquema.Maestra
join Es_Quiu_El.Producto on Es_Quiu_El.Producto.PRODUCTO_CODIGO = Maestra.PRODUCTO_CODIGO
join Es_Quiu_El.Producto_Tipo_Variante on Es_Quiu_El.Producto_Tipo_Variante.PRODUCTO_VARIANTE_CODIGO = Maestra.PRODUCTO_VARIANTE_CODIGO

end
go



--Stored procedure para Venta_Producto

create procedure Es_Quiu_El.Migrar_Compra_Producto 
as 
begin
insert into Es_Quiu_El.Compra_Producto

select distinct Es_Quiu_El.Producto_Por_Variante.PRODUCTO_CODIGO, Es_Quiu_El.Producto_Por_Variante.PRODUCTO_VARIANTE_CODIGO, Es_Quiu_El.Compra.COMPRA_NUMERO,
COMPRA_PRODUCTO_CANTIDAD, COMPRA_PRODUCTO_PRECIO from gd_esquema.Maestra 
join Es_Quiu_El.Producto_Por_Variante on Es_Quiu_El.Producto_Por_Variante.PRODUCTO_CODIGO = Maestra.PRODUCTO_CODIGO and Es_Quiu_El.Producto_Por_Variante.PRODUCTO_VARIANTE_CODIGO = Maestra.PRODUCTO_VARIANTE_CODIGO 
join Es_Quiu_El.Compra on Es_Quiu_El.Compra.COMPRA_NUMERO = Maestra.COMPRA_NUMERO
where Es_Quiu_El.Producto_Por_Variante.PRODUCTO_CODIGO is not null and Es_Quiu_El.Compra.COMPRA_NUMERO is not null


end
go



--Stored procedure para migrar cupones

create procedure Es_Quiu_El.Migrar_Cupones
as 
begin
insert into Es_Quiu_El.Cupon

select distinct VENTA_CUPON_CODIGO, VENTA_CUPON_IMPORTE, VENTA_CUPON_FECHA_DESDE, VENTA_CUPON_FECHA_HASTA, VENTA_CUPON_VALOR,
VENTA_CUPON_TIPO from gd_esquema.Maestra
where VENTA_CUPON_CODIGO is not null 

end
go



-- store procedure para migrar Envio
create procedure Es_Quiu_El.Migrar_Envios
as
begin 
insert into Es_Quiu_El.Envio 
select distinct VENTA_MEDIO_ENVIO, VENTA_ENVIO_PRECIO,NULL from gd_esquema.Maestra
where VENTA_MEDIO_ENVIO is not null
end
go



-- store procedure para migrar Envio_CP
create procedure Es_Quiu_El.Migrar_Envio_CP
as
begin

insert into Es_Quiu_El.Envio_CP
select distinct ENVIO_ID, CODIGO_POSTAL, LOCALIDAD, ENVIO_PRECIO from gd_esquema.Maestra 
join Es_Quiu_El.Envio on Maestra.VENTA_MEDIO_ENVIO=Es_Quiu_El.Envio.ENVIO_MEDIO and Maestra.VENTA_ENVIO_PRECIO=Es_Quiu_El.Envio.ENVIO_PRECIO
join Es_Quiu_El.Zona on Maestra.Cliente_Localidad = Es_Quiu_El.Zona.Localidad and Maestra.Cliente_Codigo_Postal = Es_Quiu_El.Zona.Codigo_Postal

end
go




--Stored procedure para migrar Ventas

create procedure Es_Quiu_El.Migrar_Ventas
as 
begin
insert into Es_Quiu_El.Venta

select distinct VENTA_CODIGO, Es_Quiu_El.cliente.CLIENTE_CODIGO, Es_Quiu_El.Medio_de_Pago_Venta.VENTA_MEDIO_PAGO_ID, Es_Quiu_El.Medio_de_Pago_Venta.VENTA_MEDIO_PAGO_COSTO,
Es_Quiu_El.Canal_de_Venta.CANAL_ID, Es_Quiu_El.Canal_de_Venta.CANAL_COSTO,Es_Quiu_El.Envio.ENVIO_ID, Es_Quiu_El.Envio.ENVIO_PRECIO, VENTA_FECHA, VENTA_TOTAL from gd_esquema.Maestra
join Es_Quiu_El.Cliente on Es_Quiu_El.cliente.CLIENTE_DNI = maestra.CLIENTE_DNI and Es_Quiu_El.cliente.CLIENTE_APELLIDO = Maestra.CLIENTE_APELLIDO and Es_Quiu_El.cliente.CLIENTE_NOMBRE = Maestra.CLIENTE_NOMBRE
join Es_Quiu_El.Medio_de_Pago_Venta on Es_Quiu_El.Medio_de_Pago_Venta.VENTA_MEDIO_PAGO = maestra.VENTA_MEDIO_PAGO
join Es_Quiu_El.Canal_de_Venta on Es_Quiu_El.Canal_de_Venta.CANAL_ID= Maestra.VENTA_CANAL
join Es_Quiu_El.Envio on Es_Quiu_El.Envio.ENVIO_MEDIO = Maestra.VENTA_MEDIO_ENVIO and Es_Quiu_El.Envio.ENVIO_PRECIO = Maestra.VENTA_ENVIO_PRECIO

end
go

--Stored procedure para migrar Venta Producto
create procedure Es_Quiu_El.Migrar_Venta_Producto
as 
begin
insert into Es_Quiu_El.Venta_Producto
select distinct  Es_Quiu_El.Producto_Por_Variante.PRODUCTO_CODIGO,Es_Quiu_El.Venta.VENTA_CODIGO, Es_Quiu_El.Producto_Por_Variante.PRODUCTO_VARIANTE_CODIGO, 
VENTA_PRODUCTO_CANTIDAD, VENTA_PRODUCTO_PRECIO from gd_esquema.Maestra 

join Es_Quiu_El.Producto_Por_Variante on Es_Quiu_El.Producto_Por_Variante.PRODUCTO_CODIGO = Maestra.PRODUCTO_CODIGO and Es_Quiu_El.Producto_Por_Variante.PRODUCTO_VARIANTE_CODIGO = Maestra.PRODUCTO_VARIANTE_CODIGO 
join Es_Quiu_El.Venta on Es_Quiu_El.Venta.VENTA_CODIGO = Maestra.VENTA_CODIGO
where Es_Quiu_El.Producto_Por_Variante.PRODUCTO_CODIGO is not null and Es_Quiu_El.Venta.VENTA_CODIGO is not null

end
go




--Stored procedure para migrar Venta Descuento

create procedure Es_Quiu_El.Migrar_Venta_Descuento
as 
begin
insert into Es_Quiu_El.Venta_Descuento
select distinct Es_Quiu_El.Venta.VENTA_CODIGO, Es_Quiu_El.Medio_de_Pago_Venta.VENTA_MEDIO_PAGO_ID, VENTA_DESCUENTO_CONCEPTO, VENTA_DESCUENTO_IMPORTE  from gd_esquema.Maestra
join Es_Quiu_El.Venta on Es_Quiu_El.Venta.VENTA_CODIGO = Maestra.VENTA_CODIGO
join Es_Quiu_El.Medio_de_Pago_Venta on Es_Quiu_El.Medio_de_Pago_Venta.VENTA_MEDIO_PAGO = maestra.VENTA_MEDIO_PAGO
where VENTA_DESCUENTO_CONCEPTO is not null

end
go


--Stored procedure para migrar Venta_Por_Cupon

create procedure Es_Quiu_El.Migrar_Venta_Por_Cupon
as 
begin
insert into Es_Quiu_El.Venta_Por_Cupon

select distinct  Es_Quiu_El.Venta.VENTA_CODIGO, count(Es_Quiu_El.Cupon.VENTA_CUPON_CODIGO_ID), sum(Es_Quiu_El.Cupon.VENTA_CUPON_VALOR) from gd_esquema.Maestra
join Es_Quiu_El.Venta on Es_Quiu_El.Venta.VENTA_CODIGO = Maestra.VENTA_CODIGO 
join Es_Quiu_El.Cupon on Es_Quiu_El.Cupon.VENTA_CUPON_CODIGO = maestra.VENTA_CUPON_CODIGO and Es_Quiu_El.Cupon.VENTA_CUPON_VALOR = maestra.VENTA_CUPON_VALOR 
group by Es_Quiu_El.Venta.VENTA_CODIGO


end
go


---------------------------------------------------------------------------------------------------------
------------------------------------- Ejecucion de stored procedures ------------------------------------
---------------------------------------------------------------------------------------------------------


--Crea las tablas 
exec Es_Quiu_El.Crear_Tablas

--Migra las Zona 
exec Es_Quiu_El.Migrar_Zonas

--Migra los proveedores 
exec Es_Quiu_El.Migrar_Proveedores 

--Migra los Clientes 
exec Es_Quiu_El.Migrar_Clientes

--Migra los Compra Descuento 
exec   Es_Quiu_El.Migrar_Compra_Descuento

--Migra los Medio de pago de compra 
exec Es_Quiu_El.Migrar_Medio_De_Pago_Compra

--Migra los Medio de pago de venta 
exec Es_Quiu_El.Migrar_Medio_De_Pago_Venta

--Migra los canales de venta 
exec Es_Quiu_El.Migrar_Canal_de_Ventas

--Migra los envios 
exec Es_Quiu_El.Migrar_Envios

--Migra los envios_CP 
exec Es_Quiu_El.Migrar_Envio_CP

--Migra los Cupones 
exec Es_Quiu_El.Migrar_Cupones

--Migra las Categorias 
exec Es_Quiu_El.Migrar_Producto_Categoria

--Migra los Productos 
exec Es_Quiu_El.Migrar_Productos

--Migra los Productos tipo Variante 
exec Es_Quiu_El.Migrar_Producto_Tipo_Variante

--Migra las Variante 
exec Es_Quiu_El.Migrar_Variantes

--Migra los Productos por Variante 
exec Es_Quiu_El.Migrar_Producto_Por_Variante

--Migra las compras 
exec Es_Quiu_El.Migrar_Compras

--Migra los compra producto 
exec Es_Quiu_El.Migrar_Compra_Producto

--Migra las ventas  
exec Es_Quiu_El.Migrar_Ventas

--Migra las ventas Descuetos
exec Es_Quiu_El.Migrar_Venta_Descuento

--Migra las ventas por cupon 
exec Es_Quiu_El.Migrar_Venta_Por_Cupon

--Migra las ventas Descuetos 
exec  Es_Quiu_El.Migrar_Venta_Producto

