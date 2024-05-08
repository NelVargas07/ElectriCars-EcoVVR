using System.Globalization;

namespace APIProyectoBases.Domain
{
    public class Cliente
    {
        public int id { get; set; }
        public string nombre { get; set; }
        public string apellido { get; set; }
        public string direccion { get; set; }
        public String telefono { get; set; }
        public string correo { get; set; }
        public string contrasenia { get; set; }

    }
}
