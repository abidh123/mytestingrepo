using System;
using System.Text.Json.Serialization;

namespace Kerry.SSP.Orders.API.Contracts
{
    public class MyOrders
    {
        [JsonPropertyName("PoNumber")]
        public int poNumber { get; set; }
        [JsonPropertyName("SoNumber")]
        public int soNumber { get; set; }
        [JsonPropertyName("DateOfOrder")]
        public DateTime dateOfOrder { get; set; }
        [JsonPropertyName("DeliveryDate")]
        public DateTime deliveryDate { get; set; }
        [JsonPropertyName("ShipTo")]
        public string shipTo { get; set; }
        [JsonPropertyName("Status")]
        public int status { get; set; }
    }
}
