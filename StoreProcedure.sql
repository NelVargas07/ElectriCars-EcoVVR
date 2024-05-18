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
	@correo varchar(100),
	@VehiculoID int,
	@montoTotal decimal(18,2),
	@metodoPago varchar(50)
AS
BEGIN
	BEGIN TRANSACTION
		
		IF NOT EXISTS( SELECT 1 FROM Cliente WHERE correo = @correo)
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN 0;
		END

		IF EXISTS( SELECT 1 FROM Vehiculo WHERE ID = @VehiculoID AND stock >=1)
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN 0;	
		END

		DECLARE @ClienteID int;

		SELECT @ClienteID = ID FROM Cliente WHERE @correo = correo

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

alter PROCEDURE sp_insertar_venta
    @correo VARCHAR(100),
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
            RETURN 1;
        END

        
        DECLARE @ClienteID INT;
        SELECT @ClienteID = ID FROM Cliente WHERE correo = @correo;

        
        INSERT INTO Venta (ClienteID, fechaVenta, montoTotal, metodoPago)
        VALUES (@ClienteID, GETDATE(), @montoTotal, @metodoPago);

        DECLARE @VentaID INT = SCOPE_IDENTITY();

     
        DECLARE @i INT = 0;
        DECLARE @total_records INT;
        SET @total_records = JSON_VALUE(@vehiculoJSON, 'ARRAY_LENGTH($)'); -- Change based on your method to count JSON array length

        DECLARE @VehiculoID INT;

        
        WHILE @i < @total_records
        BEGIN
            SET @VehiculoID = JSON_VALUE(@vehiculoJSON, CONCAT('$[', @i, '].ID'));

            
            IF NOT EXISTS (SELECT 1 FROM Vehiculo WHERE ID = @VehiculoID AND stock >= 1)
            BEGIN
                ROLLBACK TRANSACTION;
                RETURN 1;
            END

          
            INSERT INTO Venta_Vehiculo (ventaID, vehiculoID)
            VALUES (@VentaID, @VehiculoID);

          
            UPDATE Vehiculo
            SET stock = stock - 1
            WHERE ID = @VehiculoID;

            SET @i = @i + 1;
        END

        
        COMMIT TRANSACTION;
        RETURN 0;
    END TRY
    BEGIN CATCH
        
        ROLLBACK TRANSACTION;
        RETURN 1;
    END CATCH
END
