using APIProyectoBases.Data;
using APIProyectoBases.Domain;

namespace APIProyectoBases.Business
{
    public class VehiculoBusiness
    {
        private readonly VehiculoData vehiculoData;

        public VehiculoBusiness()
        {
            this.vehiculoData = new VehiculoData();
        }

        public List<Vehiculo> ListarVehiculo()
        {
            return this.vehiculoData.ListarVehiculo();
        }
    }
}
