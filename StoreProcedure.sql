USE ElectriCars
GO

CREATE PROCEDURE sp_listar_clientes(
	@ID int = NULL,
	@nombre NVARCHAR(50) = NULL,
   @apellido NVARCHAR(50) = NULL,
   @direccion NVARCHAR(300) = NULL,
   @telefono NVARCHAR(100) = NULL,
   @correo NVARCHAR(100) = NULL,
   @contrasenia NVARCHAR(100) = NULL)
AS
BEGIN
	SELECT 
	[ID], [nombre], [apellido], 
	[direccion], [telefono], [correo], 
	[contrasenia], [activo]
   FROM Cliente
   WHERE 
		activo = 1
       AND (@ID IS NULL OR ID = @ID)
       AND (@nombre IS NULL OR nombre = @nombre)
       AND (@apellido IS NULL OR apellido = @apellido)
       AND (@direccion IS NULL OR direccion = @direccion)
       AND (@telefono IS NULL OR telefono = @telefono)
       AND (@correo IS NULL OR correo = @correo)
       AND (@contrasenia IS NULL OR contrasenia = @contrasenia)
END;


CREATE VIEW vw_listar_clientes
as
select ID, nombre,apellido,direccion,telefono,correo,contrasenia from Cliente
where activo = 1

CREATE PROCEDURE sp_inicio_sesion_cliente
	@correo varchar(100),
	@contrasenia varchar(100)
AS
BEGIN
	
	IF EXISTS(SELECT 1 FROM Cliente WHERE correo = @correo AND contrasenia = @contrasenia)
		BEGIN
		
			RETURN 1
		END
	RETURN 0
END

alter VIEW vw_listar_vehiculos
as
select
V.ID, TV.tipoVehiculo,
V.modelo, V.marca, V.anio, 
V.precio, V.stock, V.imagen
from Vehiculo V
inner join TipoVehiculo TV on TV.ID = V.TipoVehiculoID
where activo = 1 and v.stock >= 1

CREATE PROCEDURE sp_insertar_Cliente
	@nombre varchar(50),
	@apellido varchar(50),
	@direccion varchar(100),
	@telefono varchar(10),
	@correo varchar(100),
	@contrasenia varchar(100)
as
begin
	BEGIN TRANSACTION 
	IF EXISTS( SELECT 1 FROM Cliente WHERE @correo = correo)
	BEGIN
		ROLLBACK TRANSACTION;
		RETURN 0;
	END
	
	INSERT INTO Cliente (nombre, apellido, direccion, telefono, correo, contrasenia,activo)
	VALUES (@nombre, @apellido, @direccion, @telefono, @correo, @contrasenia,1)
	
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK;
		RETURN 0;
	END
	COMMIT TRANSACTION;
	RETURN 1;

end


CREATE PROCEDURE sp_insertar_venta
	@ClienteID int,
	@VehiculoID int,
	@montoTotal decimal(18,2),
	@metodoPago varchar(50)
AS
BEGIN
	BEGIN TRANSACTION
		
		IF NOT EXISTS( SELECT 1 FROM Cliente WHERE ID = @ClienteID)
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN 0;
		END

		IF EXISTS( SELECT 1 FROM Vehiculo WHERE ID = @VehiculoID AND stock >=1)
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN 0;	
		END
		INSERT INTO Venta
		VALUES(@ClienteID,@VehiculoID,GETDATE(),@montoTotal,@metodoPago)

		UPDATE Vehiculo
		SET stock = stock - 1
		WHERE ID = @VehiculoID

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK;
			RETURN 0;
		END
		COMMIT TRANSACTION;
		RETURN 1;
END

CREATE VIEW vw_listar_piezas
as
select P.ID, CP.nombreCategoria, P.nombre, P.descripcion, P.precio, P.stock from Pieza P
		join categoriaPieza CP ON CP.ID = P.CategoriaPiezaID
where P.activo = 1