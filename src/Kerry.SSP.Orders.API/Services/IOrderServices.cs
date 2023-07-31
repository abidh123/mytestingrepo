using Kerry.SSP.Orders.API.Contracts;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Kerry.SSP.Orders.API.Services
{
    public interface IOrderServices
    {
        Task<List<MyOrders>> GetOrderDetailsWithHttpClientFactory();
        Task<string> GetSecret(string secretName);
    }
}
