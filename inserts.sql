--Insert para Cliente
INSERT INTO Cliente (nombre, apellido, direccion, telefono, correo, contrasenia, activo) VALUES 
('Juan', 'Perez', 'Calle 123, Ciudad', '1234567890', 'juan@example.com', 'contraseña123', 1),
('María', 'López', 'Avenida Principal, Pueblo', '0987654321', 'maria@example.com', 'clave123', 1),
('Carlos', 'González', 'Carrera 456, Villa', '5555555555', 'carlos@example.com', 'password123', 1),
('Ana', 'Martínez', 'Avenida Central, Ciudad', '7777777777', 'ana@example.com', 'clave456', 1),
('Pedro', 'Sánchez', 'Calle Principal, Pueblo', '9999999999', 'pedro@example.com', 'contraseña456', 1),
('Laura', 'García', 'Carrera 789, Villa', '3333333333', 'laura@example.com', 'password456', 1),
('Luis', 'Rodríguez', 'Calle 456, Ciudad', '6666666666', 'luis@example.com', 'clave789', 1),
('Sofía', 'Díaz', 'Avenida 2, Pueblo', '2222222222', 'sofia@example.com', 'contraseña789', 1),
('Daniel', 'Hernández', 'Carrera 1011, Villa', '4444444444', 'daniel@example.com', 'password789', 1),
('Lucía', 'Torres', 'Calle 789, Ciudad', '8888888888', 'lucia@example.com', 'clave1011', 1);

-- Inserts para TipoVehiculo
INSERT INTO TipoVehiculo (tipoVehiculo) VALUES ('carros');
INSERT INTO TipoVehiculo (tipoVehiculo) VALUES ('motos');

-- Inserts para Vehiculo
INSERT INTO Vehiculo (TipoVehiculoID, modelo, marca, anio, precio, imagen, stock, activo) 
VALUES 
(1, 'Modelo1', 'Marca1', '2022', 25000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 5, 1),
(1, 'Modelo2', 'Marca2', '2023', 30000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 3, 1),
(2, 'Modelo3', 'Marca3', '2021', 18000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 8, 1),
(2, 'Modelo4', 'Marca4', '2024', 35000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 2, 1),
(1, 'Modelo5', 'Marca5', '2020', 20000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 4, 1),
(2, 'Modelo6', 'Marca6', '2019', 15000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 6, 1),
(1, 'Modelo7', 'Marca7', '2022', 28000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 7, 1),
(2, 'Modelo8', 'Marca8', '2023', 32000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 9, 1),
(1, 'Modelo9', 'Marca9', '2021', 26000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 10, 1),
(2, 'Modelo10', 'Marca10', '2020', 19000.00, 'https://imageio.forbes.com/specials-images/imageserve/6552427075f8cabe3a24d6f1/The-Ferrari-SF90-Stradale---/960x0.jpg?format=jpg&width=1440', 1, 1);

INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Motor');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Transmisión');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Suspensión');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Frenos');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Eléctrico');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Carrocería');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Escape');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Refrigeración');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Interior');
INSERT INTO CategoriaPieza (nombreCategoria) VALUES ('Accesorios');

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (1, 'Filtro de Aceite', 'Filtro de aceite para motor', 12.99, 50, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (2, 'Embrague', 'Kit de embrague completo', 249.99, 20, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (3, 'Amortiguador', 'Amortiguador delantero', 89.99, 35, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (4, 'Disco de Freno', 'Disco de freno ventilado', 55.99, 40, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (5, 'Batería', 'Batería de 12V 60Ah', 120.99, 25, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (6, 'Parachoques', 'Parachoques delantero', 150.00, 10, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (7, 'Silenciador', 'Silenciador de escape deportivo', 200.00, 15, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (8, 'Radiador', 'Radiador de alta eficiencia', 99.99, 20, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (9, 'Asiento', 'Asiento de cuero', 300.00, 5, 1);

INSERT INTO Pieza (CategoriaPiezaID, nombre, descripcion, precio, stock, activo) 
VALUES (10, 'Alfombra', 'Alfombra para coche', 30.00, 50, 1);

INSERT INTO Region (nombre) VALUES ('Costa Rica');

INSERT INTO Sucursal (RegionID, nombre, direccion, telefono) VALUES (1, 'San José', 'Dirección San José', '11111111');
INSERT INTO Sucursal (RegionID, nombre, direccion, telefono) VALUES (1, 'Alajuela', 'Dirección Alajuela', '22222222');
INSERT INTO Sucursal (RegionID, nombre, direccion, telefono) VALUES (1, 'Cartago', 'Dirección Cartago', '33333333');
INSERT INTO Sucursal (RegionID, nombre, direccion, telefono) VALUES (1, 'Heredia', 'Dirección Heredia', '44444444');
INSERT INTO Sucursal (RegionID, nombre, direccion, telefono) VALUES (1, 'Guanacaste', 'Dirección Guanacaste', '55555555');
INSERT INTO Sucursal (RegionID, nombre, direccion, telefono) VALUES (1, 'Puntarenas', 'Dirección Puntarenas', '66666666');
INSERT INTO Sucursal (RegionID, nombre, direccion, telefono) VALUES (1, 'Limón', 'Dirección Limón', '77777777');
