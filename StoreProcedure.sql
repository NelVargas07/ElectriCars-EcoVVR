USE ElectriCars
GO;

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


--CREATE VIEW vw_listar_clientes
--as
--select ID, nombre,apellido,direccion,telefono,correo,contrasenia from Cliente
--where activo = 1

--CREATE PROCEDURE sp_inicio_sesion_cliente
--	@correo varchar(100),
--	@contrasenia varchar(100)
--AS
--BEGIN
--	IF EXISTS(SELECT 1 FROM Cliente WHERE correo = @correo AND contrasenia = @contrasenia)
--		BEGIN
		
--			RETURN 1
--		END
--	RETURN 0
--END

CREATE VIEW vw_listar_vehiculos
as
select
V.ID, TV.tipoVehiculo,
V.modelo, V.marca, V.anio, 
V.precio, V.stock, V.imagen
from Vehiculo V
inner join TipoVehiculo TV on TV.ID = V.TipoVehiculoID
where activo = 1

CREATE PROCEDURE sp_insertar_Cliente
	@nombre varchar(50),
	@apellido varchar(50),
	@direccion varchar(100),
	@telefono varchar(10),
	@correo varchar(100),
	@contrasenia varchar(100)
as
begin
	IF NOT EXISTS( SELECT 1 FROM Cliente WHERE @correo = correo)
		BEGIN
			INSERT INTO Cliente (nombre, apellido, direccion, telefono, correo, contrasenia,activo)
			VALUES (@nombre, @apellido, @direccion, @telefono, @correo, @contrasenia,1)
			RETURN 1
		END
	RETURN 0
end