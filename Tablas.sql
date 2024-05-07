--CREATE DATABASE ElectriCars

USE ElectriCars
go

CREATE TABLE Cliente(
	ID int primary key identity,
	nombre varchar(50),
	apellido varchar(50),
	direccion varchar(300),
	telefono varchar(10),
	correo varchar(100),
	contrasenia varchar(100),
	activo bit
);

CREATE TABLE TipoVehiculo(
	ID int primary key identity,
	tipoVehiculo varchar(50)
);

CREATE TABLE Vehiculo(
	ID int primary key identity,
	TipoVehiculoID int,
	modelo varchar(50),
	marca varchar(50),
	anio varchar(10),
	precio decimal(18,2),
	imagen varchar(300),
	stock int,
	activo bit,
	constraint fk_TipoVehiculoID foreign key (TipoVehiculoID) references TipoVehiculo(ID)
);

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

CREATE TABLE Empleado(
	ID int primary key identity,
	nombre varchar(50),
	apellido varchar(50),
	puesto varchar(100),
	departamento varchar(100),
	salario decimal(18,2),
	fechaContratacion date,
	activo bit
);

CREATE TABLE PiezasEnsamblaje(
	ID int primary key identity,
	EnsamblajeVehiculoID int,
	PiezaID int,
	cantidad int,
);

CREATE TABLE EnsamblajeVehiculo(
	ID int primary key identity,
	VehiculoID int,
	EmpleadoID int,
	fechaEnsamblaje date,
	estado varchar(50),
	constraint fk_VehiculoID foreign key (VehiculoID) references Vehiculo(ID),
	constraint fk_EmpleadoID foreign key (EmpleadoID) references Empleado(ID)
);

CREATE TABLE Venta(
	ID int primary key identity,
	ClienteID int,
	EmpleadoID int,
	VehiculoID int,
	fechaVenta date,
	montoTotal decimal(18,2),
	metodoPago varchar(5)
);