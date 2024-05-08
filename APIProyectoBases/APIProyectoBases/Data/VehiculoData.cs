using APIProyectoBases.Constantes;
using APIProyectoBases.Domain;
using Microsoft.Data.SqlClient;

namespace APIProyectoBases.Data
{
    public class VehiculoData
    {

        public List<Vehiculo> ListarVehiculo()
        {
            List<Vehiculo> vehiculos = new List<Vehiculo>();


            using (SqlConnection connection = new SqlConnection(URLConexionSQL.conexionSQL))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("SELECT * FROM vw_listar_vehiculos", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Vehiculo vehiculo1 = new Vehiculo() 
                            { 
                                id = reader.GetInt32(0),
                                tipo = reader.GetString(1),
                                modelo =reader.GetString(2),
                                marca = reader.GetString(3),
                                anio=reader.GetString(4),
                                precio= Convert.ToDouble(reader.GetDecimal(5)),
                                stock=reader.GetInt32(6),
                                imagen=reader.GetString(7)
                                
                            };

                            vehiculos.Add(vehiculo1);
                        }
                    }
                }
            }
            
            return vehiculos;

        }
    }
}
