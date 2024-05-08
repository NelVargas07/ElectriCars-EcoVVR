
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

CREATE VIEW vw_listar_vehiculos
as
select
[ID], 
[modelo], [marca], [anio], 
[precio], [stock], [activo], [imagen]
from Vehiculo
where activo = 1