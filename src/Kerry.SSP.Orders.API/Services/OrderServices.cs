using Azure.Security.KeyVault.Secrets;
using Kerry.SSP.Orders.API.Contracts;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;

namespace Kerry.SSP.Orders.API.Services
{
    public class OrderServices: IOrderServices
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly JsonSerializerOptions _options;
        private readonly SecretClient _secretClient;

        public OrderServices(IHttpClientFactory httpClientFactory, SecretClient secretClient)
        {
            _httpClientFactory = httpClientFactory ?? throw new ArgumentNullException(nameof(httpClientFactory)); ;
            _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
            _secretClient = secretClient;
        }
        public async Task<List<MyOrders>> GetOrderDetailsWithHttpClientFactory()
        {
            var httpClient = _httpClientFactory.CreateClient();
            using (var response = await httpClient.GetAsync("", HttpCompletionOption.ResponseHeadersRead))
            {
                response.EnsureSuccessStatusCode();
                //var data = await response.Content.ReadAsStringAsync();
                var stream = await response.Content.ReadAsStreamAsync();
                var OrderDetails = await JsonSerializer.DeserializeAsync<List<MyOrders>>(stream, _options);
                return OrderDetails;
            }
        }
        public async Task<string> GetSecret(string secretName)
        {
            KeyVaultSecret keyValueSecret = await _secretClient.GetSecretAsync(secretName);
            return keyValueSecret.Value;
        }

        //private readonly HttpClient _httpClient;
        //private readonly JsonSerializerOptions _options;
        //public OrderServices(HttpClient httpClient)
        //{
        //    this._httpClient = httpClient;
        //    _options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
        //}
        //public async Task<List<MyOrders>> GetOrderDetailsWithHttpClientFactory()
        //{
        //    using (var response = await _httpClient.GetAsync("", HttpCompletionOption.ResponseHeadersRead))
        //    {
        //        response.EnsureSuccessStatusCode();
        //        var stream = await response.Content.ReadAsStreamAsync();
        //        var MyOrders = await JsonSerializer.DeserializeAsync<List<MyOrders>>(stream, _options);
        //        return MyOrders;
        //    }
        //}
    }
}
