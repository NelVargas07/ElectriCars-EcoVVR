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
