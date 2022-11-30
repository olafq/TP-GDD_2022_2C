---------------------------------------------------------------------------------------------------------
------------------------------------- Creacion de stored procedures ------------------------------------
---------------------------------------------------------------------------------------------------------
--Stored procedure que crea el esquema 

create schema BI_Es_Quiu_El;
go 


--Stored procedure que crea las tablas de nuestro modelo

create procedure BI_Es_Quiu_El.Crear_Tablas
as
begin 
create table BI_Es_Quiu_El.Hechos_Ventas_y_Compras(
	Producto_Codigo  nvarchar(50),
	Canal_id nvarchar(255),
	ID_Tiempo int,
	ID_Envio int,
	ID_Producto_Categoria int,
	ID_Provincia int,
	ID_Medio_de_Pago int,
	ID_Descuento int,
	Cliente_Codigo int,
	proveedor_cuit nvarchar(50),
	unidades decimal(18,2),
	precio decimal(18,2)
);

create table BI_Es_Quiu_El.Dimension_Cliente(
	CLINETE_CODIGO int not null,
	CLIENTE_DNI decimal(18,0),
	CLIENTE_NOMBRE nvarchar(255),
	CLIENTE_APELLIDO nvarchar(255),
	CLIENTE_TELEFONO decimal(18,0),
	ClIENTE_MAIL nvarchar(255),
	CLIENTE_FECHA_NAC date,
	CLIENTE_EDAD int,
	CLIENTE_DIRECCION nvarchar(255),
	CLIENTE_CP decimal (18,0),
	CLIENTE_LOCALIDAD nvarchar(255),
);

create table BI_ES_Quiu_El.Dimension_Proveedor(
	proveedor_cuit nvarchar(50) not null,
	proveedor_cp decimal(18,0),
	proveedor_localidad nvarchar(255),
	proveedor_razon_social nvarchar(50),
	proveedor_mail nvarchar(50),
	proveedor_domicilio nvarchar(50)
);

create table BI_Es_Quiu_El.Dimension_Tipo_De_Envio(
	ID_ENVIO int not null,
	Envio_Medio nvarchar(255),
	Envio_Precio decimal(18,2),
	Tiempo_Envio decimal(18,2)
);

create table BI_Es_Quiu_El.Dimension_Tipo_Descuento(
	Descuento_id int identity(1,1)not null,
	Descuento_Codigo int not null,
	Descuento_Importe decimal(18,2),
	Descuento_Concepto nvarchar(255)
);

create table BI_Es_Quiu_El.Dimension_Medio_de_Pago(
	ID_Medio_de_pago int  not null,
	medio_de_pago nvarchar(255),
	medio_de_pago_costo decimal(18,2)
);

create table BI_Es_Quiu_El.Dimension_Tiempo(
	ID_Tiempo int identity(1,1) not null,
	fecha date,
	anio  int,
	mes  int,
	diaSemana nvarchar(10)
);

create table BI_ES_Quiu_El.Dimension_Categoria_Producto(
	ID_Producto_Categoria int not null,
	producto_categoria nvarchar(255)
);

create table BI_ES_Quiu_El.Dimension_Provincia(
	ID_Provincia int identity(1,1) not null,
	provincia nvarchar(255),
	codigo_postal decimal(18,0),
	localidad nvarchar(255)
);

Create table BI_ES_Quiu_El.Dimension_Canal_De_Ventas(
	ID_Canal nvarchar(255) not null,
	Canal_Costo_Decimal decimal(18,2)
);

Create table BI_ES_Quiu_El.Dimension_Producto(
	PRODUCTO_CODIGO nvarchar(50) not null,
	PRODUCTO_NOMBRE nvarchar(50),
	PRODUCTO_VARIANTE_CODIGO nvarchar(50),
	PRODUCTO_PRECIO decimal(18,2)
);

--PRIMARY KEYS

alter table BI_ES_Quiu_El.Dimension_Canal_De_Ventas
add primary key (ID_Canal)

alter table BI_ES_Quiu_El.Dimension_Producto
add primary key (PRODUCTO_CODIGO)

alter table BI_ES_Quiu_El.Dimension_Provincia
add primary key (ID_Provincia)

alter table BI_ES_Quiu_El.Dimension_Categoria_Producto
add primary key (ID_Producto_Categoria)

alter table BI_ES_Quiu_El.Dimension_Tiempo
add primary key (ID_Tiempo)

alter table BI_ES_Quiu_El.Dimension_Medio_de_Pago
add primary key (ID_Medio_de_pago)

alter table BI_Es_Quiu_El.Dimension_Tipo_Descuento
add primary key (Descuento_id)

alter table BI_Es_Quiu_El.Dimension_Tipo_De_Envio
add primary key (ID_ENVIO)

alter table BI_Es_Quiu_El.Dimension_Cliente
add primary key (CLINETE_CODIGO)

alter table BI_ES_Quiu_El.Dimension_Proveedor
add primary key (proveedor_cuit)


--FOREING KEYS

alter table BI_Es_Quiu_El.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_PRODUCTO foreign key(Producto_Codigo) references BI_ES_Quiu_El.Dimension_Producto(PRODUCTO_CODIGO)

alter table BI_Es_Quiu_El.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_CANAL foreign key(Canal_id) references BI_ES_Quiu_El.Dimension_Canal_De_Ventas(ID_CANAL)

alter table BI_Es_Quiu_El.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_PROVINCIA foreign key(ID_Provincia) references BI_ES_Quiu_El.Dimension_Provincia(ID_Provincia)

alter table BI_Es_Quiu_El.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_TIEMPO foreign key(ID_Tiempo) references BI_Es_Quiu_El.Dimension_Tiempo(ID_Tiempo)

alter table BI_Es_Quiu_El.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_ENVIO foreign key(ID_Envio) references BI_Es_Quiu_El.Dimension_Tipo_De_Envio(ID_Envio)

alter table BI_Es_Quiu_El.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_PRODUCTO_CATEGORIA foreign key(ID_Producto_Categoria) references BI_ES_Quiu_El.Dimension_Categoria_Producto(ID_Producto_Categoria)

alter table BI_Es_Quiu_El.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_MEDIO_DE_PAGO foreign key(ID_Medio_de_Pago) references BI_Es_Quiu_El.Dimension_Medio_de_Pago(ID_Medio_de_pago)

alter table BI_Es_Quiu_El.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_CLIENTE_CODIGO foreign key(Cliente_Codigo) references BI_Es_Quiu_El.Dimension_Cliente(CLINETE_CODIGO)

alter table BI_Es_quiu_el.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_PROVEEDOR foreign key(proveedor_cuit) references BI_Es_Quiu_El.Dimension_Proveedor(proveedor_cuit)

alter table BI_Es_quiu_el.Hechos_Ventas_y_Compras
add constraint FK_HECHOS_VENTAS_Y_COMPRAS_DESCUENTOS foreign key(id_descuento) references BI_Es_Quiu_El.Dimension_Tipo_Descuento(descuento_id)

end
go

--Stored procedure para migrar Cliente
create procedure BI_Es_Quiu_El.Migrar_Dimension_Cliente
as 
begin
	declare @Existingdate date
	Set @Existingdate=GETDATE()

	insert into BI_Es_Quiu_El.Dimension_Cliente
	select  CLIENTE_CODIGO,CLIENTE_DNI,CLIENTE_NOMBRE,CLIENTE_APELLIDO,CLIENTE_TELEFONO,
	CLIENTE_MAIL, CLIENTE_FECHA_NAC,datediff(YEAR,CLIENTE_FECHA_NAC,@Existingdate) AS 'EDAD', CLIENTE_DIRECCION , CLIENTE_CP, CLIENTE_LOCALIDAD
	from Es_Quiu_El.Cliente

end
go


--Stored procedure para migrar canal de ventas
create procedure BI_Es_Quiu_El.Migrar_Dimension_Canal_De_Ventas
as 
begin

	insert into BI_ES_Quiu_El.Dimension_Canal_De_Ventas
	select  CANAL_ID,CANAL_COSTO from Es_Quiu_El.Canal_De_Venta

end
go

--Stored procedure para migrar categoria_producto 
create procedure BI_Es_Quiu_El.Migrar_Dimension_Categoria_Producto
as 
begin

	insert into BI_ES_Quiu_El.Dimension_Categoria_Producto 
	select  PRODUCTO_CATEGORIA_ID,producto_categoria from ES_Quiu_El.Producto_Categoria

end
go

--Stored procedure para migrar medio_de_pago 
create procedure BI_Es_Quiu_El.Migrar_Dimension_Medio_De_Pago
as 
begin

	insert into BI_ES_Quiu_El.Dimension_Medio_de_pago
	select VENTA_MEDIO_PAGO_ID,VENTA_MEDIO_PAGO, VENTA_MEDIO_PAGO_COSTO from ES_Quiu_El.Medio_de_pago_venta

end
go

--Stored procedure para migrar tiempo
create procedure BI_ES_Quiu_El.Migrar_Dimension_Tiempo
as
begin

	insert into BI_ES_Quiu_El.Dimension_Tiempo(fecha,anio,mes,diaSemana)
	select distinct compra_Fecha, year(compra_Fecha),month(compra_Fecha), (SELECT (CASE DATENAME(dw,compra_Fecha)
     when 'Monday' then 'LUNES'
     when 'Tuesday' then 'MARTES'
     when 'Wednesday' then 'MIERCOLES'
     when 'Thursday' then 'JUEVES'
     when 'Friday' then 'VIERNES'
     when 'Saturday' then 'SABADO'
     when 'Sunday' then 'DOMINGO'
END)) from ES_Quiu_El.Compra
	union 
	select distinct venta_fecha,year(venta_fecha),month(venta_fecha), (SELECT (CASE DATENAME(dw,venta_fecha)
     when 'Monday' then 'LUNES'
     when 'Tuesday' then 'MARTES'
     when 'Wednesday' then 'MIERCOLES'
     when 'Thursday' then 'JUEVES'
     when 'Friday' then 'VIERNES'
     when 'Saturday' then 'SABADO'
     when 'Sunday' then 'DOMINGO'
END)) from ES_Quiu_El.venta

end 
go


create procedure BI_Es_Quiu_El.Migrar_Producto
as
begin

	insert into BI_ES_Quiu_El.Dimension_Producto
	select  p.producto_codigo,p.producto_nombre,pv.Producto_Variante_Codigo,pv.precio_unitario_venta from ES_Quiu_El.Producto p
	join ES_Quiu_El.Producto_por_variante pv on p.producto_codigo = pv.producto_codigo

end
go


--Stored procedure para migrar Provincia
create procedure BI_Es_Quiu_El.Migrar_Provincia
as
begin

	insert into BI_ES_Quiu_El.Dimension_provincia
	select  PROVINCIA, CODIGO_POSTAL, LOCALIDAD from ES_Quiu_El.Zona

end
go
--Stored procedure para migrar tipo_de_envio
create procedure BI_Es_Quiu_El.Migrar_tipo_de_envio
as
begin

	insert into BI_ES_Quiu_El.Dimension_tipo_de_envio
	select   ES_Quiu_El.Envio.ENVIO_ID, ENVIO_MEDIO,ES_Quiu_El.Envio.ENVIO_PRECIO,ENVIO_TIEMPO from ES_Quiu_El.Envio 

end
go
--Stored procedure para migrar tipo_descuento
create procedure BI_Es_Quiu_El.Migrar_tipo_descuento
as
begin

	insert into BI_ES_Quiu_El.Dimension_tipo_descuento(Descuento_Codigo, Descuento_Importe, Descuento_Concepto)
	select venta_codigo,venta_descuento_importe, venta_descuento_concepto from ES_Quiu_El.venta_descuento
	union
	select Descuento_compra_codigo,descuento_compra_valor, null from ES_Quiu_El.Compra_descuento

end
go

-- stored procedure para migrar Proveedor
create procedure BI_ES_Quiu_El.Migrar_Dimension_Proveedor
as
begin 
	insert into  BI_ES_Quiu_El.Dimension_Proveedor
	select proveedor_cuit,proveedor_cp,proveedor_localidad,proveedor_razon_social,proveedor_mail,proveedor_domicilio from ES_Quiu_El.Proveedor
end
go

--Stored procedure para migrar hechos_ventas_y_compras
create procedure BI_Es_Quiu_El.Migrar_hechos_ventas_y_compras
as
begin

	insert into  BI_ES_Quiu_El.Hechos_Ventas_y_Compras
	select distinct dp.Producto_Codigo,ID_canal,ID_TIEMPO,ID_ENVIO,cp.ID_Producto_Categoria,
	ID_Provincia,ID_Medio_de_pago,td.descuento_id,Clinete_Codigo,null, pv.Venta_Producto_Cantidad,venta_producto_precio from ES_quiu_El.Venta v
	join ES_Quiu_El.Venta_Producto pv on v.Venta_Codigo = pv.Venta_codigo
	join BI_ES_Quiu_El.Dimension_Medio_de_Pago on v.VENTA_MEDIO_PAGO = ID_Medio_de_pago
	join BI_ES_Quiu_El.Dimension_Producto dp on pv.Venta_Producto_Codigo = dp.Producto_Codigo
	join ES_Quiu_El.Producto p on dp.Producto_Codigo = p.Producto_codigo 
	join BI_ES_Quiu_El.Dimension_Tipo_De_Envio ON v.VENTA_ENVIO_CODIGO = ID_ENVIO
	join BI_ES_quiu_El.Dimension_Canal_De_Ventas ON v.VENTA_CANAL = ID_Canal
	join BI_ES_Quiu_El.Dimension_Tiempo on v.VENTA_FECHA = fecha
	join BI_ES_Quiu_El.Dimension_Categoria_Producto cp on p.Producto_categoria  = cp.ID_producto_categoria 
	join BI_ES_Quiu_El.Dimension_Cliente ON v.VENTA_CLIENTE_CODIGO =  Clinete_Codigo
	join BI_ES_Quiu_El.Dimension_Provincia on Cliente_Localidad = localidad and Cliente_CP = codigo_postal 
	left join Es_Quiu_El.Venta_Descuento vd on v.Venta_codigo = vd.venta_Codigo and id_medio_de_pago = vd.venta_descuento_medio_de_pago_id
	left join BI_Es_Quiu_El.Dimension_Tipo_Descuento td on td.Descuento_Codigo = vd.Venta_Codigo
	union 
	select distinct dp.Producto_Codigo,null,ID_TIEMPO,null,cp.ID_Producto_Categoria,ID_Provincia,
    ID_Medio_de_pago,td.descuento_id,NULL, Proveedor_cuit, pc.Compra_Producto_Cantidad, pc.Compra_Producto_Precio from ES_quiu_El.Compra c
	join ES_Quiu_El.compra_Producto pc on c.compra_Numero = pc.compra_numero
	join BI_ES_Quiu_El.Dimension_Producto dp on pc.Compra_Producto_Codigo = dp.Producto_Codigo
	join ES_Quiu_El.Producto p on dp.Producto_Codigo = p.Producto_codigo 
	join BI_ES_Quiu_El.Dimension_Tiempo on c.COMPRA_FECHA = fecha
	join BI_ES_Quiu_El.Dimension_Categoria_Producto cp on p.Producto_categoria  = cp.ID_producto_categoria
	join BI_ES_Quiu_El.Dimension_Proveedor ON C.COMPRA_PROVEEDOR =  proveedor_cuit
	join BI_ES_Quiu_El.Dimension_Provincia on proveedor_Localidad = localidad and proveedor_CP = codigo_postal
	join BI_ES_Quiu_El.Dimension_Medio_de_Pago on c.COMPRA_MEDIO_PAGO = ID_Medio_de_pago 
	left join Es_Quiu_El.Compra_Descuento cd on c.Compra_descuento_codigo = cd.Descuento_Compra_Codigo 
	left join BI_Es_Quiu_El.Dimension_Tipo_Descuento td on td.Descuento_Codigo = cd.descuento_compra_Codigo

	
end
go

--Crea las tablas 

begin
exec BI_Es_Quiu_El.Crear_Tablas
--Migra los Canales de ventas
exec BI_Es_Quiu_El.Migrar_Dimension_Canal_De_Ventas
--Migrar los productos
exec BI_Es_Quiu_El.Migrar_Producto
--Migra las categorias producto
exec BI_Es_Quiu_El.Migrar_dimension_categoria_producto
--Migra los Medios de Pago
exec BI_Es_Quiu_El.Migrar_Dimension_Medio_De_Pago
--Migra los tiempos
exec BI_Es_Quiu_El.Migrar_Dimension_Tiempo
--Migra las provincias
exec BI_Es_Quiu_El.Migrar_Provincia
--Migra los tipos de envios 
exec BI_Es_Quiu_El.Migrar_tipo_de_envio
--Migra los tipos descuentos
exec BI_Es_Quiu_El.Migrar_tipo_descuento
--Migrar los clientes 
exec BI_ES_Quiu_El.Migrar_Dimension_Cliente
--Migrar los Proveedores 
exec BI_ES_Quiu_El.Migrar_Dimension_Proveedor 
--Migrar hechos_ventas_y_compras
exec BI_Es_Quiu_El.Migrar_hechos_ventas_y_compras
end
go 

-- Crear vista de las ganancias mensuales de cada canal de venta
CREATE  VIEW   BI_ES_Quiu_El.ganancias_mensuales_X_Canales
AS  
	SELECT vc.Canal_id, dt.mes, dt.anio , sum(vc.precio)-(select sum(vc1.precio) 
	from BI_ES_Quiu_El.Hechos_Ventas_y_Compras  vc1
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on vc1.ID_TIEMPO = dt1.ID_TIEMPO
	where cliente_codigo is null and dt1.mes = dt.mes and dt1.anio = dt.anio
	group by dt1.mes, dt1.anio) ganancia
	from BI_ES_Quiu_El.Hechos_Ventas_y_Compras  vc
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	where proveedor_cuit is null
	group by canal_id, mes, anio

go

-- Crear vista de Los 5 productos con mayor rentabilidad anual, con sus respectivos % 
CREATE  VIEW   BI_ES_Quiu_El.top5_productos_mas_rentables_anual
AS 

   select top 5 p.Producto_Codigo,p.Producto_Nombre, dt.anio,sum(vc.precio)-(select top 5 sum(vc1.precio) 
	from BI_ES_Quiu_El.Hechos_Ventas_y_Compras  vc1
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on vc1.ID_TIEMPO = dt1.ID_TIEMPO
	where cliente_codigo is null and  dt1.anio = dt.anio
	group by  dt1.anio)/(select sum(vc2.precio) from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc2
	 join BI_ES_Quiu_El.dimension_Tiempo dt2 on vc2.ID_TIEMPO = dt2.ID_TIEMPO 
	 where cliente_codigo is null and  dt2.anio = dt.anio) rentabilidad_Anual
	from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Producto p on vc.Producto_Codigo = p.Producto_Codigo
	where proveedor_cuit is null and dt.anio = 2022
	group by p.Producto_Codigo,p.Producto_Nombre, dt.anio
	union
	select top 5 p.Producto_Codigo,p.Producto_Nombre, dt.anio,sum(vc.precio)-(select top 5 sum(vc1.precio) 
	from BI_ES_Quiu_El.Hechos_Ventas_y_Compras  vc1
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on vc1.ID_TIEMPO = dt1.ID_TIEMPO
	where cliente_codigo is null and  dt1.anio = dt.anio
	group by  dt1.anio)/(select sum(vc2.precio) from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc2
	 join BI_ES_Quiu_El.dimension_Tiempo dt2 on vc2.ID_TIEMPO = dt2.ID_TIEMPO 
	 where cliente_codigo is null and  dt2.anio = dt.anio) rentabilidad_Anual
	from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Producto p on vc.Producto_Codigo = p.Producto_Codigo
	where proveedor_cuit is null and dt.anio = 2023
	group by p.Producto_Codigo,p.Producto_Nombre, dt.anio
	order by 4 desc

go

--crear Vista para Total de Ingresos por cada medio de pago por mes
CREATE VIEW   BI_ES_Quiu_El.ingresos_mensual_por_pago
AS 
	select  vc.id_medio_de_pago, dt.mes, dt.anio, sum(vc.precio-isnull(mp.ID_Medio_de_pago,0)+isnull(td.Descuento_Importe,0)) ingresos from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	left join BI_ES_Quiu_El.dimension_Medio_De_Pago mp on vc.id_medio_de_pago = mp.id_MEDIO_de_PAGO
	left join BI_ES_Quiu_El.dimension_Tipo_Descuento td on vc.id_descuento = td.descuento_id and mp.medio_de_pago = td.Descuento_Concepto
	group by vc.id_medio_de_pago,dt.mes, dt.anio

go
--crear Vista Importe total en descuentos aplicados según su tipo de descuento, por canal de venta, por mes.
CREATE   VIEW   BI_ES_Quiu_El.ingreso_tipo_desc_mensual_X_canal
AS 
	select  td.Descuento_concepto, vc.Canal_id, dt.mes,dt.anio, sum(Descuento_Importe) importe from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Tipo_Descuento td on vc.id_descuento = td.descuento_id 
	where td.Descuento_Concepto is not null
	group by  td.Descuento_concepto, vc.Canal_id, dt.mes,dt.anio 

go
--crear Vista Porcentaje de envíos realizados a cada Provincia por mes.
CREATE  VIEW   BI_ES_Quiu_El.porcentaje_envios_mensuales_cada_prov
AS 
	select p.provincia, dt.mes, dt.anio ,count(vc.id_envio)/(select  count(vc1.id_envio) from  BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc1
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on vc1.ID_TIEMPO = dt1.ID_TIEMPO
	where dt1.mes = dt.mes  and  dt1.anio= dt.anio
	) porcentaje
	from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc
	join BI_ES_Quiu_El.Dimension_Provincia  p on vc.Id_Provincia = p.Id_Provincia
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	group by provincia, dt.mes,dt.anio

go
--crear vista Valor promedio de envío por Provincia por Medio De Envío anual. 
CREATE    VIEW   BI_ES_Quiu_El.Valor_promedio_envio_anual_X_Provincia
AS 
	select p.provincia, dt.anio ,avg(te.envio_precio) promedio
	from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc
	join BI_ES_Quiu_El.Dimension_Provincia  p on vc.Id_Provincia = p.Id_Provincia
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Tipo_de_envio te on vc.ID_Envio = te.ID_Envio
	group by provincia,dt.anio
go
--crear vista Aumento promedio de precios de cada proveedor anual.
CREATE VIEW   BI_ES_Quiu_El.Aumento_Promedio_anual_de_precios_proveedores
AS 
	select   vc.proveedor_cuit, dt.anio,((select top 1  vc1.precio from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc1
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on vc1.ID_TIEMPO = dt1.ID_TIEMPO
	where vc1.proveedor_cuit is not null and dt1.anio = dt.anio and vc1.proveedor_cuit = vc.proveedor_cuit
	group by vc1.producto_codigo,vc1.precio
	order by 1 desc)-(select top 1  vc2.precio from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc2
	join BI_ES_Quiu_El.dimension_Tiempo dt2 on vc2.ID_TIEMPO = dt2.ID_TIEMPO
	where vc2.proveedor_cuit is not null and dt2.anio = dt.anio and vc2.proveedor_cuit = vc.proveedor_cuit
	group by vc2.proveedor_cuit, dt2.anio,vc2.precio
	order by 1 ))/(select top 1  vc2.precio from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc2
	join BI_ES_Quiu_El.dimension_Tiempo dt2 on vc2.ID_TIEMPO = dt2.ID_TIEMPO
	where vc2.proveedor_cuit is not null and dt2.anio = dt.anio and vc2.proveedor_cuit = vc.proveedor_cuit
	group by vc2.proveedor_cuit, dt2.anio,vc2.precio
	order by 1 ) aumento_promedio from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	where proveedor_cuit is not null
	group by proveedor_cuit, dt.anio

go


-- crear vista de Los 3 productos con mayor cantidad de reposición(compra) por mes.
CREATE   VIEW   BI_ES_Quiu_El.top_3_productos_mayor_reposicion
AS 
	select  producto_codigo, dt.mes, dt.anio, sum(unidades) cantidad_repuesta from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	where proveedor_cuit is not null
	group by producto_codigo, dt.mes,dt.anio
	
	
go

-- FUNCION QUE DEVUELVE RANGO ETARIO 
CREATE FUNCTION ES_Quiu_El.RANGO_EDAD(@edad int) 
RETURNS nvarchar(255)
AS
BEGIN
	DECLARE @rango nvarchar(255);
	DECLARE @hoy DATE;
	SET @hoy = GETDATE();

	IF @edad < 25
		SET @rango = '< 25 años'
	ELSE IF @edad BETWEEN 25 AND 35
		SET @rango = '25 - 35 años'
	ELSE IF @edad BETWEEN 36 AND 55
		SET @rango  = '35 - 55 años'
	ELSE
		SET @rango = '> 55 años'


	RETURN @rango;

END
GO

-- crear vista para Las 5 categorías de productos más vendidos por rango etario de clientes por mes.
--(Correguir como hacer para ordenar de mayor a menor segun los precios)

CREATE   VIEW   BI_ES_Quiu_El.top_5_Categorias_mensuales_mas_vendidas_por_rango_etario
AS 
	select vc.ID_Producto_categoria,cp.producto_categoria, dt.mes,dt.anio,ES_Quiu_El.RANGO_EDAD(c.cliente_edad) rango_etario, 
	sum(vc.precio) precio from BI_ES_Quiu_El.Hechos_Ventas_y_Compras vc 
	join BI_ES_Quiu_El.dimension_Tiempo dt on vc.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Cliente c on vc.Cliente_Codigo = c.CLINETE_CODIGO
	join BI_ES_Quiu_El.dimension_Categoria_Producto cp on vc.Id_Producto_Categoria = cp.ID_Producto_Categoria
	where proveedor_cuit is null
	group by vc.ID_Producto_categoria, dt.mes,ES_Quiu_El.RANGO_EDAD(c.cliente_edad),producto_categoria,dt.anio
	
go

/*
select * from BI_ES_Quiu_El.ganancias_mensuales_X_Canales
select * from BI_ES_Quiu_El.top5_productos_mas_rentables_anual 
select * from BI_ES_Quiu_El.ingresos_mensual_por_pago
select * from BI_ES_Quiu_El.ingreso_tipo_desc_mensual_X_canal
select * from BI_ES_Quiu_El.porcentaje_envios_mensuales_cada_prov /*correguir division*/
select * from  BI_ES_Quiu_El.Valor_promedio_envio_anual_X_Provincia
select * from BI_ES_Quiu_El.Aumento_Promedio_anual_de_precios_proveedores
select * from BI_ES_Quiu_El.top_3_productos_mayor_reposicion /* correguir*/
select * from BI_ES_Quiu_El.top_5_Categorias_mensuales_mas_vendidas_por_rango_etario
*/
