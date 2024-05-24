USE ElectriCars
go

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
go

CREATE VIEW vw_listar_clientes
as
select ID, nombre,apellido,direccion,telefono,correo,contrasenia from Cliente
where activo = 1
go

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
go

CREATE VIEW vw_listar_vehiculos
as
select
V.ID, TV.tipoVehiculo,
V.modelo, V.marca, V.anio, 
V.precio, V.stock, V.imagen
from Vehiculo V
inner join TipoVehiculo TV on TV.ID = V.TipoVehiculoID
where activo = 1 and v.stock >= 1
go

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
go

CREATE VIEW vw_listar_piezas
as
select P.ID, CP.nombreCategoria, P.nombre, P.descripcion, P.precio, P.stock from Pieza P
		join categoriaPieza CP ON CP.ID = P.CategoriaPiezaID
where P.activo = 1
go

CREATE PROCEDURE sp_Delete_Pieza
   @ID INT
AS
BEGIN
	BEGIN TRANSACTION 
	IF NOT EXISTS ( SELECT 1 FROM Pieza WHERE ID = @ID)
	BEGIN
		ROLLBACK TRANSACTION;
		RETURN 0;
	END
    UPDATE Pieza 
	 SET activo = 0
	 WHERE ID = @ID;

	 IF @@ERROR <> 0
	BEGIN
		ROLLBACK;
		RETURN 0;
	END

   COMMIT TRANSACTION;
	RETURN 1;

END;
go

CREATE PROCEDURE sp_actualizar_pieza
   @ID INT,
   @Nombre VARCHAR(50) = NULL,
   @Descripcion VARCHAR(300) = NULL,
   @Precio DECIMAL(18,2) = NULL,
   @Stock INT = NULL
AS
BEGIN
	BEGIN TRANSACTION 
	IF NOT EXISTS ( SELECT 1 FROM Pieza WHERE ID = @ID)
	BEGIN
		ROLLBACK TRANSACTION;
		RETURN 0;
	END
    UPDATE Pieza
   SET nombre = ISNULL(@Nombre, nombre),
       descripcion = ISNULL(@Descripcion, descripcion),
       precio = ISNULL(@Precio, precio),
       stock = ISNULL(@Stock, stock)
   WHERE ID = @ID;

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK;
		RETURN 0;
	END

   COMMIT TRANSACTION;
	RETURN 1;

END;
go

CREATE PROCEDURE sp_insertar_venta
    @correo VARCHAR(100),
    @sucursalID INT,
    @montoTotal DECIMAL(18,2),
    @metodoPago VARCHAR(50),
    @vehiculoJSON NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        
        IF NOT EXISTS (SELECT 1 FROM Cliente WHERE correo = @correo)
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN 0;
        END

        DECLARE @ClienteID INT;
        SELECT @ClienteID = ID FROM Cliente WHERE correo = @correo;

        IF NOT EXISTS (SELECT 1 FROM Sucursal WHERE ID = @sucursalID)
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN 0;
        END
        
        INSERT INTO Venta (ClienteID, SucursalID, fechaVenta, montoTotal, metodoPago)
        VALUES (@ClienteID, @sucursalID, GETDATE(), @montoTotal, @metodoPago);

        DECLARE @VentaID INT = SCOPE_IDENTITY();

        DECLARE @i INT = 0;
        DECLARE @total_records INT;
        SET @total_records = (SELECT COUNT(*) FROM OPENJSON(@vehiculoJSON));

        DECLARE @VehiculoID INT;
        DECLARE @Caracteristica NVARCHAR(MAX);
        
        WHILE @i < @total_records
        BEGIN
            SET @VehiculoID = JSON_VALUE(@vehiculoJSON, CONCAT('$[', @i, '].id'));
            SET @Caracteristica = JSON_VALUE(@vehiculoJSON, CONCAT('$[', @i, '].descripcion'));

            IF NOT EXISTS (SELECT 1 FROM Vehiculo WHERE ID = @VehiculoID AND stock >= 1)
            BEGIN
                ROLLBACK TRANSACTION;
                RETURN 0;
            END

            IF @Caracteristica IS NULL
            BEGIN
                INSERT INTO VehiculoPersonalizado (VehiculoID, caracteristicas)
                VALUES (@VehiculoID, NULL);
            END
            ELSE
            BEGIN
                INSERT INTO VehiculoPersonalizado (VehiculoID, caracteristicas)
                VALUES (@VehiculoID, @Caracteristica);
            END

            DECLARE @VehiculoPersonalizadoID INT = SCOPE_IDENTITY();

            INSERT INTO Venta_VehiculoPersonalizado (ventaID, VehiculoPersonalizadoID,estado)
            VALUES (@VentaID, @VehiculoPersonalizadoID,'pendiente');

            UPDATE Vehiculo
            SET stock = stock - 1
            WHERE ID = @VehiculoID;

            SET @i = @i + 1;
        END

        COMMIT TRANSACTION;
        RETURN 1;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RETURN 0;
    END CATCH
END;
go

CREATE VIEW vw_listar_categorias
as
select P.ID, P.nombreCategoria from CategoriaPieza P
go

CREATE VIEW vw_listar_sucursal
AS
SELECT ID,nombre FROM Sucursal
go