CREATE DATABASE ElectriCars

USE ElectriCars
go

-- CREATE TABLE Cliente(
-- 	ID int primary key identity,
-- 	nombre varchar(50),
-- 	apellido varchar(50),
-- 	direccion varchar(300),
-- 	telefono varchar(10),
-- 	correo varchar(100),
-- 	contrasenia varchar(100),
-- 	activo bit
-- );

-- CREATE TABLE TipoVehiculo(
-- 	ID int primary key identity,
-- 	tipoVehiculo varchar(50)
-- );

-- CREATE TABLE Vehiculo(
-- 	ID int primary key identity,
-- 	TipoVehiculoID int,
-- 	modelo varchar(50),
-- 	marca varchar(50),
-- 	anio varchar(10),
-- 	precio decimal(18,2),
-- 	imagen varchar(300),
-- 	stock int,
-- 	activo bit,
-- 	constraint fk_TipoVehiculoID foreign key (TipoVehiculoID) references TipoVehiculo(ID)
-- );

-- CREATE TABLE VehiculoPersonalizado(
-- 	ID INT PRIMARY KEY IDENTITY,
-- 	VehiculoID int,
-- 	caracteristicas varchar(max),
-- 	constraint fk_VehiculoID foreign key (VehiculoID) references Vehiculo(ID)
-- );

CREATE TABLE CategoriaPieza(
	ID int primary key identity,
	nombreCategoria varchar(50),
);

CREATE TABLE Proveedor(
	ID int primary key identity,
	nombreEmpresa varchar(50),
	direccion varchar(300),
	telefono varchar(10),
	correo varchar(100),
	activo bit
);

CREATE TABLE Pieza(
	ID int primary key identity,
	CategoriaPiezaID int,
	nombre varchar(50),
	descripcion varchar(300),
	precio decimal(18,2),
	stock int,
	activo bit,
	constraint fk_CategoriaPieza foreign key (CategoriaPiezaID) references CategoriaPieza(ID)
);

CREATE TABLE InventarioPieza(
	ID int primary key identity,
	PiezaID int,
	ProveedorID int,
	cantidaCompra int,
	precioCompra decimal(18,2),
	fechaCompra date,
	constraint fk_PiezaID foreign key (PiezaID) references Pieza(ID),
	constraint fk_ProveedorID foreign key (ProveedorID) references Proveedor(ID)
);

CREATE TABLE Region(
	ID INT PRIMARY KEY IDENTITY,
	nombre varchar(50)
);

CREATE TABLE Sucursal(
	ID INT PRIMARY KEY IDENTITY,
	RegionID int,
	nombre varchar(50),
	direccion varchar(50),
	telefono varchar(10),
	constraint fk_RegionID foreign key (RegionID) references Region(ID),
);

CREATE TABLE Empleado(
	ID int primary key identity,
	SucursalID int,
	nombre varchar(50),
	apellido varchar(50),
	puesto varchar(100),
	departamento varchar(100),
	salario decimal(18,2),
	fechaContratacion date,
	activo bit,
	constraint fk_SucursalID foreign key (SucursalID) references Sucursal(ID)
);

CREATE TABLE PiezasEnsamblaje(
	ID int primary key identity,
	EnsamblajeVehiculoID int,
	PiezaID int,
	cantidad int,
);

CREATE TABLE EnsamblajeVehiculo(
	ID int primary key identity,
	EmpleadoID int,
	fechaEnsamblaje date,
	estado varchar(50),
	constraint fk_EmpleadoID foreign key (EmpleadoID) references Empleado(ID)
);

CREATE TABLE VehiculoPersonalizado_Ensamblaje(
	ID INT PRIMARY KEY IDENTITY,
	EnsamblajeVehiculoID INT,
	VehiculoPersonalizado INT,
	constraint fk_EnsamblajeVehiculoID foreign key (EnsamblajeVehiculoID) references EnsamblajeVehiculo(ID),
	constraint fk_VehiculoPersonalizado foreign key (VehiculoPersonalizado) references VehiculoPersonalizado(ID)
);

CREATE TABLE Venta(
	ID int primary key identity,
	ClienteID int,
	SucursalID int,
	fechaVenta date,
	montoTotal decimal(18,2),
	metodoPago varchar(50),
	constraint fk_Venta_ClienteID_Venta foreign key (ClienteID) references Cliente(ID),
	constraint fk_Venta_SucursalID foreign key (SucursalID) references Sucursal(ID)
);

CREATE TABLE Venta_VehiculoPersonalizado(
	ID INT PRIMARY KEY IDENTITY,
	VentaID int,
	VehiculoPersonalizadoID int,
	EmpleadoID int,
	estado varchar(50),
	constraint fk_VentaID foreign key (VentaID) references Venta(ID),
	constraint fk_VehiculoPersonalizadoID foreign key (VehiculoPersonalizadoID) references VehiculoPersonalizado(ID),
	constraint fk_Venta_EmpleadoID foreign key (EmpleadoID) references Empleado(ID)
);