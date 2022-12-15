---------------------------------------------------------------------------------------------------------
------------------------------------- Creacion de stored procedures ------------------------------------
---------------------------------------------------------------------------------------------------------
--Stored procedure que crea el esquema 

create schema BI_Es_Quiu_El;
go 

-- FUNCION QUE DEVUELVE RANGO ETARIO 
CREATE FUNCTION BI_ES_Quiu_El.RANGO_EDAD(@edad int) 
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

--Stored procedure que crea las tablas de nuestro modelo

create procedure BI_Es_Quiu_El.Crear_Tablas
as
begin 

create table  BI_Es_Quiu_El.Hechos_Ventas(
	Producto_Codigo  nvarchar(50),
	Canal_id nvarchar(255),
	ID_Tiempo int,
	ID_Envio int,
	ID_Producto_Categoria int,
	ID_Provincia int,
	ID_Medio_de_Pago int,
	Rango_Etario nvarchar(255),
	unidades decimal(18,2),
	precio decimal(18,2)
);

create  table  BI_Es_Quiu_El.Hechos_Compras(
	Producto_Codigo  nvarchar(50),
	ID_Tiempo int,
	ID_Producto_Categoria int,
	ID_Provincia int,
	ID_Medio_de_Pago int,
	proveedor_cuit nvarchar(50),
	unidades decimal(18,2),
	precio decimal(18,2)
);

CREATE TABLE BI_Es_Quiu_El.Hechos_descuentos (
	id_tiempo int,
	id_medio_de_pago int,
	id_canal_de_venta nvarchar(255),
	id_tipo_de_descuento int,
	descuento decimal(18,2)
);

create table BI_Es_Quiu_El.Dimension_Tipo_Descuento(
	Descuento_id int identity(1,1) not null,
	Descuento_Concepto nvarchar(255)
);

create table BI_Es_Quiu_El.Dimension_Edad(
	Rango_Etario nvarchar(255) not null,
	Cantidad decimal(18,0)
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

alter table BI_Es_Quiu_El.Dimension_Tipo_Descuento 
add primary key(descuento_id)

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

alter table BI_Es_Quiu_El.Dimension_Tipo_De_Envio
add primary key (ID_ENVIO)

alter table BI_Es_Quiu_El.Dimension_Edad
add primary key(Rango_Etario)

alter table BI_ES_Quiu_El.Dimension_Proveedor
add primary key (proveedor_cuit)


--FOREING KEYS PARA TABLA DE HECHOS VENTAS

alter table BI_Es_Quiu_El.Hechos_Ventas
add constraint FK_HECHOS_VENTAS_PRODUCTO foreign key(Producto_Codigo) references BI_ES_Quiu_El.Dimension_Producto(PRODUCTO_CODIGO)

alter table BI_Es_Quiu_El.Hechos_Ventas
add constraint FK_HECHOS_VENTAS_CANAL foreign key(Canal_id) references BI_ES_Quiu_El.Dimension_Canal_De_Ventas(ID_CANAL)

alter table BI_Es_Quiu_El.Hechos_Ventas
add constraint FK_HECHOS_VENTAS_PROVINCIA foreign key(ID_Provincia) references BI_ES_Quiu_El.Dimension_Provincia(ID_Provincia)

alter table BI_Es_Quiu_El.Hechos_Ventas
add constraint FK_HECHOS_VENTAS_TIEMPO foreign key(ID_Tiempo) references BI_Es_Quiu_El.Dimension_Tiempo(ID_Tiempo)

alter table BI_Es_Quiu_El.Hechos_Ventas
add constraint FK_HECHOS_VENTAS_ENVIO foreign key(ID_Envio) references BI_Es_Quiu_El.Dimension_Tipo_De_Envio(ID_Envio)

alter table BI_Es_Quiu_El.Hechos_Ventas
add constraint FK_HECHOS_VENTAS_PRODUCTO_CATEGORIA foreign key(ID_Producto_Categoria) references BI_ES_Quiu_El.Dimension_Categoria_Producto(ID_Producto_Categoria)

alter table BI_Es_Quiu_El.Hechos_Ventas
add constraint FK_HECHOS_VENTAS_MEDIO_DE_PAGO foreign key(ID_Medio_de_Pago) references BI_Es_Quiu_El.Dimension_Medio_de_Pago(ID_Medio_de_pago)

alter table BI_Es_Quiu_El.Hechos_Ventas
add constraint FK_HECHOS_VENTAS_EDAD foreign key(Rango_Etario) references BI_Es_Quiu_El.Dimension_Edad(Rango_Etario)

--FOREING KEYS PARA TABLA DE HECHOS COMPRAS

alter table BI_Es_Quiu_El.Hechos_Compras
add constraint FK_HECHOS_COMPRAS_PRODUCTO foreign key(Producto_Codigo) references BI_ES_Quiu_El.Dimension_Producto(PRODUCTO_CODIGO)

alter table BI_Es_Quiu_El.Hechos_Compras
add constraint FK_HECHOS_COMPRAS_PROVINCIA foreign key(ID_Provincia) references BI_ES_Quiu_El.Dimension_Provincia(ID_Provincia)

alter table BI_Es_Quiu_El.Hechos_Compras
add constraint FK_HECHOS_COMPRAS_TIEMPO foreign key(ID_Tiempo) references BI_Es_Quiu_El.Dimension_Tiempo(ID_Tiempo)

alter table BI_Es_Quiu_El.Hechos_Compras
add constraint FK_HECHOS_COMPRAS_PRODUCTO_CATEGORIA foreign key(ID_Producto_Categoria) references BI_ES_Quiu_El.Dimension_Categoria_Producto(ID_Producto_Categoria)

alter table BI_Es_Quiu_El.Hechos_Compras
add constraint FK_HECHOS_COMPRAS_MEDIO_DE_PAGO foreign key(ID_Medio_de_Pago) references BI_Es_Quiu_El.Dimension_Medio_de_Pago(ID_Medio_de_pago)

alter table BI_Es_Quiu_El.Hechos_Compras
add constraint FK_HECHOS_COMPRAS_Proveedor foreign key(proveedor_cuit) references BI_Es_Quiu_El.Dimension_Proveedor(proveedor_cuit)


--FOREING KEYS PARA TABLA DE HECHOS DESCUENTOS
alter table BI_Es_Quiu_El.Hechos_Descuentos
add constraint FK_HECHOS_DESCUENTOS_TIEMPO foreign key(ID_Tiempo) references BI_Es_Quiu_El.Dimension_Tiempo(ID_Tiempo)

alter table BI_Es_Quiu_El.Hechos_Descuentos
add constraint FK_HECHOS_DESCUENTOS_MEDIO_DE_PAGO foreign key(ID_Medio_de_Pago) references BI_Es_Quiu_El.Dimension_Medio_de_Pago(ID_Medio_de_pago)
	
alter table BI_Es_Quiu_El.Hechos_Descuentos
add constraint FK_HECHOS_DESCUNETOS_CANAL foreign key(id_canal_de_venta) references BI_ES_Quiu_El.Dimension_Canal_De_Ventas(ID_CANAL)

alter table BI_Es_Quiu_El.Hechos_Descuentos
add constraint FK_HECHOS_DESCUNETOS_TIPO_DESCUNETO foreign key(id_tipo_de_descuento) references BI_ES_Quiu_El.Dimension_Tipo_Descuento(descuento_id)

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

--Stored procedure para migrar producto
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

	insert into BI_ES_Quiu_El.Dimension_tipo_descuento( Descuento_Concepto)
	select distinct venta_descuento_concepto from ES_Quiu_El.venta_descuento

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

--Stored procedure para migrar hechos_ventas
create procedure BI_Es_Quiu_El.Migrar_hechos_ventas
as
begin
declare @Existingdate date
	Set @Existingdate=GETDATE()
	insert into  BI_ES_Quiu_El.Hechos_Ventas
	select  dp.producto_codigo, v.venta_canal, t.ID_Tiempo,e.ID_Envio, cp.id_producto_categoria, dpp.id_provincia, mp.ID_Medio_De_Pago,
	BI_ES_Quiu_El.RANGO_EDAD(datediff(YEAR,c.CLIENTE_FECHA_NAC,@Existingdate)) as 'rango etario', SUM(a.venta_producto_cantidad) as 'unidades',  SUM(a.venta_producto_cantidad * a.venta_producto_precio) / SUM(a.venta_producto_cantidad) as 'precio'
	 from ES_Quiu_El.venta_producto a
	JOIN ES_Quiu_El.venta v ON  a.venta_codigo = v.venta_codigo
	JOIN BI_Es_Quiu_El.Dimension_Medio_de_Pago mp ON v.venta_medio_pago = mp.ID_Medio_De_Pago
	JOIN ES_Quiu_El.producto_por_variante vp ON a.producto_variante_codigo = vp.producto_variante_codigo
	JOIN ES_Quiu_El.producto p ON vp.producto_codigo = p.producto_codigo
	JOIN BI_ES_Quiu_El.Dimension_producto dp ON p.producto_codigo = dp.producto_codigo
	JOIN BI_Es_Quiu_El.Dimension_Categoria_producto cp ON  cp.id_producto_categoria = p.producto_categoria
	JOIN ES_Quiu_El.cliente c ON v.VENTA_CLIENTE_CODIGO = c.cliente_codigo
	JOIN BI_ES_Quiu_El.Dimension_Provincia dpp ON dpp.codigo_postal = c.CLIENTE_CP and dpp.localidad = C.cliente_localidad
	JOIN BI_Es_Quiu_El.Dimension_Tiempo t ON t.fecha = v.venta_fecha
	JOIN BI_Es_Quiu_El.Dimension_Tipo_De_envio e ON V.venta_envio_codigo = e.id_envio
	group by dp.producto_codigo, t.ID_Tiempo, cp.id_producto_categoria, mp.ID_Medio_De_Pago,
	v.venta_canal, dpp.id_provincia, BI_ES_Quiu_El.RANGO_EDAD(datediff(YEAR,c.CLIENTE_FECHA_NAC,@Existingdate)), 
	e.id_envio
end
go

--Stored procedure para migrar hechos_compras
create procedure BI_Es_Quiu_El.Migrar_hechos_compras
as
begin

	insert into  BI_ES_Quiu_El.Hechos_Compras
	select  dp.producto_codigo, t.ID_Tiempo, cp.id_producto_categoria, dpp.id_provincia, mp.ID_Medio_De_Pago,
	pro.proveedor_cuit, SUM(a.compra_producto_cantidad) as 'unidades',  SUM(a.compra_producto_cantidad * a.compra_producto_precio) / SUM(a.compra_producto_cantidad) as 'precio'
	 from ES_Quiu_El.compra_producto a
	JOIN ES_Quiu_El.compra c ON  a.compra_numero = c.compra_numero
	JOIN BI_Es_Quiu_El.Dimension_Medio_de_Pago mp ON c.compra_medio_pago = mp.ID_Medio_De_Pago
	JOIN ES_Quiu_El.producto_por_variante vp ON a.producto_variante_codigo = vp.producto_variante_codigo
	JOIN ES_Quiu_El.producto p ON vp.producto_codigo = p.producto_codigo
	JOIN BI_ES_Quiu_El.Dimension_producto dp ON p.producto_codigo = dp.producto_codigo
	JOIN BI_Es_Quiu_El.Dimension_Categoria_producto cp ON  cp.id_producto_categoria = p.producto_categoria
	JOIN BI_ES_Quiu_El.Dimension_proveedor pro ON c.COMPRA_PROVEEDOR = pro.proveedor_cuit
	JOIN BI_ES_Quiu_El.Dimension_Provincia dpp ON dpp.codigo_postal = pro.proveedor_CP and dpp.localidad = pro.proveedor_localidad
	JOIN BI_Es_Quiu_El.Dimension_Tiempo t ON t.fecha = C.Compra_fecha
	group by  dp.producto_codigo, t.ID_Tiempo, cp.id_producto_categoria, dpp.id_provincia, mp.ID_Medio_De_Pago,
	pro.proveedor_cuit
end
go

--Stored procedure para migrar hechos_descuentos
create procedure BI_Es_Quiu_El.Migrar_hechos_descuentos
as
begin
	insert into  BI_ES_Quiu_El.Hechos_Descuentos
	select  t.id_tiempo,p.id_medio_de_pago, cv.id_canal, td.descuento_id, d.venta_descuento_importe from ES_Quiu_El.venta_descuento d
	join ES_Quiu_El.venta v ON  d.venta_codigo = v.venta_codigo
	join BI_ES_Quiu_El.Dimension_Canal_de_ventas cv ON v.venta_canal = cv.id_canal
	join BI_Es_Quiu_El.Dimension_Tiempo t ON V.venta_fecha = t.fecha
	join BI_Es_Quiu_El.Dimension_Medio_de_Pago p ON  v.venta_medio_pago = p.ID_Medio_de_pago
	join BI_Es_Quiu_El.Dimension_Tipo_Descuento td ON d.venta_descuento_concepto = td.descuento_concepto
	
end 
go

--Stored procedure para migrar Dimension_Edad
create procedure BI_ES_Quiu_El.Migrar_Dimension_edad
as
begin
	declare @Existingdate date
	Set @Existingdate=GETDATE()
	insert into BI_ES_Quiu_El.Dimension_edad
	select BI_ES_Quiu_El.RANGO_EDAD(datediff(YEAR,c.Cliente_fecha_nac,@Existingdate)), count(c.Cliente_fecha_nac) from Es_Quiu_El.Cliente c
	group by BI_ES_Quiu_El.RANGO_EDAD(datediff(YEAR,c.Cliente_fecha_nac,@Existingdate))
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
exec BI_ES_Quiu_El.Migrar_Dimension_edad
--Migrar los Proveedores 
exec BI_ES_Quiu_El.Migrar_Dimension_Proveedor 
--Migrar hechos_ventas
exec BI_Es_Quiu_El.Migrar_hechos_ventas
--Migrar hechos_ventas
exec BI_Es_Quiu_El.Migrar_hechos_compras
--Migrar hechos_ventas
exec BI_Es_Quiu_El.Migrar_hechos_descuentos
end
go 

-- Crear vista de las ganancias mensuales de cada canal de venta 
CREATE  VIEW   BI_ES_Quiu_El.ganancias_mensuales_X_Canales
AS  
	SELECT v.Canal_id, dt.mes, dt.anio , sum(v.precio)-(select sum(c.precio) 
	from BI_ES_Quiu_El.Hechos_Compras  c
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on c.ID_TIEMPO = dt1.ID_TIEMPO
	where dt1.mes = dt.mes and dt1.anio = dt.anio
	group by dt1.mes, dt1.anio) - sum(cv.canal_costo_decimal ) ganancia
	from BI_ES_Quiu_El.Hechos_Ventas  v
	join BI_ES_Quiu_El.dimension_Canal_de_ventas cv on v.canal_id = cv.id_canal
	join BI_ES_Quiu_El.dimension_Tiempo dt on v.ID_TIEMPO = dt.ID_TIEMPO
	group by v.canal_id, dt.mes, dt.anio

go

-- Crear vista de Los 5 productos con mayor rentabilidad anual
CREATE  VIEW   BI_ES_Quiu_El.top5_productos_mas_rentables_anual
AS 


   select top 5 p.Producto_Codigo,p.Producto_Nombre, dt.anio,(sum(v.precio)-(select  sum(c.precio) 
   from BI_ES_Quiu_El.Hechos_Compras  c join BI_ES_Quiu_El.dimension_Tiempo dt1 on c.ID_TIEMPO = dt1.ID_TIEMPO
   where p.Producto_Codigo = c.producto_codigo and dt1.anio = dt.anio
   group by dt1.anio)) /(select sum(v1.precio) from BI_ES_Quiu_El.Hechos_Ventas v1
	 join BI_ES_Quiu_El.dimension_Tiempo dt2 on v1.ID_TIEMPO = dt2.ID_TIEMPO and dt2.anio = 2022) rentabilidad_anual
	from BI_ES_Quiu_El.Hechos_Ventas v
	join BI_ES_Quiu_El.dimension_Tiempo dt on v.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Producto p on v.Producto_Codigo = p.Producto_Codigo
	where dt.anio = 2022
	group by p.Producto_Codigo,p.Producto_Nombre, dt.anio
	union
	 select top 5 p.Producto_Codigo,p.Producto_Nombre, dt.anio,(sum(v.precio)-(select  sum(c.precio) 
   from BI_ES_Quiu_El.Hechos_Compras  c join BI_ES_Quiu_El.dimension_Tiempo dt1 on c.ID_TIEMPO = dt1.ID_TIEMPO
   where p.Producto_Codigo = c.producto_codigo and dt1.anio = dt.anio
   group by dt1.anio)) /(select sum(v1.precio) from BI_ES_Quiu_El.Hechos_Ventas v1
	 join BI_ES_Quiu_El.dimension_Tiempo dt2 on v1.ID_TIEMPO = dt2.ID_TIEMPO and dt2.anio = 2023) rentabilidad_anual
	from BI_ES_Quiu_El.Hechos_Ventas v
	join BI_ES_Quiu_El.dimension_Tiempo dt on v.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Producto p on v.Producto_Codigo = p.Producto_Codigo
	where dt.anio = 2023
	group by p.Producto_Codigo,p.Producto_Nombre, dt.anio
	order by 3,4 desc

go

-- crear vista para Las 5 categorías de productos más vendidos por rango etario de clientes por mes.

CREATE   VIEW   BI_ES_Quiu_El.top_5_Categorias_mensuales_mas_vendidas_por_rango_etario
AS 
	select  dt.anio,dt.mes,v.Rango_Etario,cp.producto_categoria, 
	sum(v.precio) cantidad from BI_ES_Quiu_El.Hechos_Ventas v 
	join BI_ES_Quiu_El.dimension_Tiempo dt on v.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Categoria_Producto cp on v.Id_Producto_Categoria = cp.ID_Producto_Categoria
	WHERE v.id_producto_categoria IN (SELECT TOP 5 v1.id_producto_categoria
											 FROM BI_ES_Quiu_El.Hechos_Ventas v1
											 WHERE v1.Rango_Etario = v.Rango_Etario and v.id_tiempo = v1.id_tiempo
											 GROUP BY v1.id_producto_categoria
											 ORDER BY SUM(v1.unidades) DESC)
	group by dt.anio,dt.mes,v.Rango_Etario, cp.Producto_categoria
go


--crear Vista para Total de Ingresos por cada medio de pago por mes 
CREATE VIEW   BI_ES_Quiu_El.ingresos_mensual_por_pago
AS 

	select  v.id_medio_de_pago, dt.mes, dt.anio,SUM((v.precio*v.unidades)-isnull(mp.ID_Medio_de_pago,0))-
	(select SUM(D.descuento) from Bi_Es_Quiu_El.Hechos_Descuentos D 
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on D.ID_TIEMPO = dt1.ID_TIEMPO
	where dt.mes = dt1.mes and dt.anio = dt.anio and v.id_medio_de_pago = D.id_medio_de_pago) 
	ingresos from BI_ES_Quiu_El.Hechos_Ventas v
	join BI_ES_Quiu_El.dimension_Tiempo dt on v.ID_TIEMPO = dt.ID_TIEMPO
	left join BI_ES_Quiu_El.dimension_Medio_De_Pago mp on v.id_medio_de_pago = mp.id_MEDIO_de_PAGO
	group by v.id_medio_de_pago,dt.mes, dt.anio

go
--crear Vista Importe total en descuentos aplicados según su tipo de descuento, por canal de venta, por mes. 
CREATE   VIEW   BI_ES_Quiu_El.ingreso_tipo_desc_mensual_X_canal
AS 
	select  td.Descuento_concepto, d.id_canal_de_venta, dt.mes,dt.anio, sum(d.Descuento) importe_total from BI_ES_Quiu_El.hechos_descuentos  d
	join BI_ES_Quiu_El.dimension_Tiempo dt on d.ID_TIEMPO = dt.ID_TIEMPO
	join BI_Es_Quiu_El.Dimension_Tipo_Descuento td on td.Descuento_id = d.id_tipo_de_descuento
	group by  td.Descuento_concepto, d.id_canal_de_venta, dt.mes,dt.anio 

go

--crear Vista Porcentaje de envíos realizados a cada Provincia por mes. 
CREATE  VIEW   BI_ES_Quiu_El.porcentaje_envios_mensuales_cada_prov
AS 


	select  p.provincia, dt.mes, dt.anio,(count(v.id_envio)+0.00)/(select  count(v1.id_envio) from  BI_ES_Quiu_El.Hechos_Ventas v1
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on v1.ID_TIEMPO = dt1.ID_TIEMPO
	where dt1.mes = dt.mes  and  dt1.anio= dt.anio
	) porcentaje from BI_Es_Quiu_El.Hechos_Ventas v
	join BI_ES_Quiu_El.Dimension_Provincia  p on v.Id_Provincia = p.Id_Provincia
	join BI_ES_Quiu_El.dimension_Tiempo dt on v.ID_TIEMPO = dt.ID_TIEMPO
	group by  dt.mes,dt.anio,p.provincia

go

--crear vista Valor promedio de envío por Provincia por Medio De Envío anual.        
CREATE    VIEW  BI_ES_Quiu_El.Valor_promedio_envio_anual_X_Provincia
AS 
	select p.provincia, dt.anio ,te.envio_medio, avg(te.envio_precio) promedio
	from BI_ES_Quiu_El.Hechos_Ventas v
	join BI_ES_Quiu_El.Dimension_Provincia  p on v.Id_Provincia = p.Id_Provincia
	join BI_ES_Quiu_El.dimension_Tiempo dt on v.ID_TIEMPO = dt.ID_TIEMPO
	join BI_ES_Quiu_El.dimension_Tipo_de_envio te on v.ID_Envio = te.ID_Envio
	group by p.provincia,dt.anio,te.envio_medio
go


--crear vista Aumento promedio de precios de cada proveedor anual. 
CREATE VIEW   BI_ES_Quiu_El.Aumento_Promedio_anual_de_precios_proveedores
AS 
	select   c.proveedor_cuit, dt.anio, ((select top 1  c1.precio from BI_ES_Quiu_El.Hechos_Compras c1
	join BI_ES_Quiu_El.dimension_Tiempo dt1 on c1.ID_TIEMPO = dt1.ID_TIEMPO
	where c1.proveedor_cuit is not null and dt1.anio = dt.anio and c1.proveedor_cuit = c.proveedor_cuit
	group by c1.producto_codigo,c1.precio
	order by 1 desc)-(select top 1  c2.precio from BI_ES_Quiu_El.Hechos_Compras c2
	join BI_ES_Quiu_El.dimension_Tiempo dt2 on c2.ID_TIEMPO = dt2.ID_TIEMPO
	where c2.proveedor_cuit is not null and dt2.anio = dt.anio and c2.proveedor_cuit = c.proveedor_cuit
	group by c2.proveedor_cuit, dt2.anio,c2.precio
	order by 1 ))/(select top 1  c3.precio from BI_ES_Quiu_El.Hechos_Compras c3
	join BI_ES_Quiu_El.dimension_Tiempo dt3 on c3.ID_TIEMPO = dt3.ID_TIEMPO
	where c3.proveedor_cuit is not null and dt3.anio = dt.anio and c3.proveedor_cuit = c.proveedor_cuit
	group by c3.proveedor_cuit, dt3.anio,c3.precio
	order by 1 ) Aumento_promedio from BI_ES_Quiu_El.Hechos_Compras c
	join BI_ES_Quiu_El.dimension_Tiempo dt on c.ID_TIEMPO = dt.ID_TIEMPO
	group by c.proveedor_cuit, dt.anio
go


-- crear vista de Los 3 productos con mayor cantidad de reposición(compra) por mes. %Contultar %si son solo 3 funciona
CREATE   VIEW   BI_ES_Quiu_El.top_3_productos_mayor_reposicion_mes
AS 
	select  c.producto_codigo, dt.mes, dt.anio,sum(unidades) cantidad_reposicion from BI_ES_Quiu_El.Hechos_Compras c
	join BI_ES_Quiu_El.dimension_Tiempo dt on c.ID_TIEMPO = dt.ID_TIEMPO
	where c.producto_codigo in (select top 3 c1.producto_codigo from BI_ES_Quiu_El.Hechos_Compras c1
	where c1.id_tiempo=c.id_tiempo
	group by c1.producto_codigo, c1.id_tiempo
	order by sum(c1.unidades)desc)
	group by c.producto_codigo, dt.mes,dt.anio

go

