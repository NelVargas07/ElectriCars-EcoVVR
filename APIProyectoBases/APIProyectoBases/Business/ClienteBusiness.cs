using APIProyectoBases.Data;
using APIProyectoBases.Domain;

namespace APIProyectoBases.Business
{
    public class ClienteBusiness
    {
        private readonly ClienteData clienteData;

        public ClienteBusiness()
        {
            this.clienteData = new ClienteData();
        }

        public List<Cliente> ListarCliente()
        {
            return this.clienteData.ListarCliente();
        }

        public bool inicioSesion(string correo, string contrasenia)
        {
            return this.clienteData.inicioSesion(correo, contrasenia);
        }

        public bool registrarCliente(Cliente cliente)
        {
            return this.clienteData.registrarCliente(cliente);
        }
    }
}
