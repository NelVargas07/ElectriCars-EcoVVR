using APIProyectoBases.Constantes;
using APIProyectoBases.Domain;
using Microsoft.Data.SqlClient;
using System.Data;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace APIProyectoBases.Data
{
    public class ClienteData
    {


        public bool registrarCliente(Cliente cliente)
        {
            using (SqlConnection connection = new SqlConnection(URLConexionSQL.conexionSQL))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("sp_insertar_Cliente", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Agrega los parámetros al procedimiento almacenado
                    command.Parameters.AddWithValue("@nombre", cliente.nombre);
                    command.Parameters.AddWithValue("@apellido", cliente.apellido);
                    command.Parameters.AddWithValue("@direccion", cliente.direccion);
                    command.Parameters.AddWithValue("@telefono", cliente.telefono);
                    command.Parameters.AddWithValue("@correo", cliente.correo);
                    command.Parameters.AddWithValue("@contrasenia", cliente.contrasenia);

                    // Agrega un parámetro de retorno para capturar el valor devuelto por el procedimiento almacenado
                    SqlParameter returnValue = command.Parameters.Add("@ReturnVal", SqlDbType.Int);
                    returnValue.Direction = ParameterDirection.ReturnValue;

                    // Ejecuta el procedimiento almacenado
                    command.ExecuteNonQuery();

                    // Obtiene el valor devuelto por el procedimiento almacenado
                    int resultado = (int)returnValue.Value;

                    if (resultado == 1)
                    {
                        return true;
                    }
                    
                     return false;
                    
                }
            }
        }

        //public void Editar(Cliente cE)
        //{
        //    try
        //    {
        //        using (MySqlConnection mySqlConnection = new MySqlConnection(CadenaConexion))
        //        {
        //            mySqlConnection.Open();

        //            string query = "CALL EditarCliente(@id, @nombre, @apellido, @foto)";

        //            using (MySqlCommand mySqlCommand = new MySqlCommand(query, mySqlConnection))
        //            {

        //                mySqlCommand.Parameters.AddWithValue("@id", cE.ID);
        //                mySqlCommand.Parameters.AddWithValue("@nombre", cE.Nombre);
        //                mySqlCommand.Parameters.AddWithValue("@apellido", cE.Apellido);
        //                mySqlCommand.Parameters.AddWithValue("@foto", MySql.Data.MySqlClient.MySqlHelper.EscapeString(cE.Foto));


        //                mySqlCommand.ExecuteNonQuery();
        //            }
        //        }
        //        MessageBox.Show("Registro Actualizado");
        //    }
        //    catch (Exception ex)
        //    {
        //        MessageBox.Show("Error al actualizar el registro: " + ex.Message);
        //    }
        //}
        //public void Eliminar(Cliente cE)
        //{
        //    try
        //    {
        //        using (MySqlConnection mySqlConnection = new MySqlConnection(CadenaConexion))
        //        {
        //            mySqlConnection.Open();

        //            string query = "CALL EliminarCliente(@id)";

        //            using (MySqlCommand mySqlCommand = new MySqlCommand(query, mySqlConnection))
        //            {

        //                mySqlCommand.Parameters.AddWithValue("@id", cE.ID);


        //                mySqlCommand.ExecuteNonQuery();
        //            }
        //        }
        //        MessageBox.Show("Registro Eliminado");
        //    }
        //    catch (Exception ex)
        //    {
        //        MessageBox.Show("Error al eliminar el registro: " + ex.Message);
        //    }
        //}

        public bool inicioSesion(string correo, string contrasenia) 
        {
            using (SqlConnection connection = new SqlConnection(URLConexionSQL.conexionSQL))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("sp_inicio_sesion_cliente", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@correo", correo);
                    command.Parameters.AddWithValue("@contrasenia", contrasenia);

                    SqlParameter returnValue = command.Parameters.Add("@ReturnVal", SqlDbType.Int);
                    returnValue.Direction = ParameterDirection.ReturnValue;

                    command.ExecuteNonQuery();
                    int resultado = (int)returnValue.Value;

                    if (resultado == 1)
                    {
                        return true;
                    }
                    return false;
                }
            }
        }

        public List<Cliente> ListarCliente()
        {
          
            List<Cliente> clientes = new List<Cliente>();

            using (SqlConnection connection = new SqlConnection(URLConexionSQL.conexionSQL))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("SELECT * FROM vw_listar_clientes", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Cliente cliente = new Cliente
                            {
                                id = reader.GetInt32(0),
                                nombre = reader.GetString(1),
                                apellido = reader.GetString(2),
                                direccion = reader.GetString(3),
                                telefono = reader.GetString(4),
                                correo = reader.GetString(5),
                                contrasenia= reader.GetString(6)
                            };

                            clientes.Add(cliente);
                        }
                    }
                }
            }
            return clientes;

        }
    }
}
