using APIProyectoBases.Business;
using APIProyectoBases.Data;
using APIProyectoBases.Domain;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace APIProyectoBases.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClienteController : ControllerBase
    {
        private readonly ClienteBusiness clienteBusiness;

        public ClienteController()
        {
            this.clienteBusiness = new ClienteBusiness();
        }

        [HttpGet]

        public ActionResult<List<Vehiculo>> ListarCliente()
        {
            return Ok(this.clienteBusiness.ListarCliente());
        }

        [HttpGet("{correo},{contrasenia}")]

        public ActionResult<bool> inicioSesion(string correo, string contrasenia)
        {
            return this.clienteBusiness.inicioSesion(correo, contrasenia);
         }

        [HttpPut]
        public ActionResult<bool> registrarCliente(Cliente cliente)
        {
            return Ok(this.clienteBusiness.registrarCliente(cliente));  
        }
    }
}
