using APIProyectoBases.Business;
using APIProyectoBases.Domain;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace APIProyectoBases.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VehiculoController : ControllerBase
    {
        private readonly VehiculoBusiness vehiculoBusiness;

        public VehiculoController()
        {
            this.vehiculoBusiness = new VehiculoBusiness();
        }

        [HttpGet]
        public ActionResult<List<Vehiculo>> listarVehiculos()
        {
            return Ok(this.vehiculoBusiness.ListarVehiculo());
        }

    }
}
