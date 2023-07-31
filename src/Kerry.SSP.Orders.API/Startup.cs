using Kerry.SSP.Orders.API.Services;
using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

[assembly: FunctionsStartup(typeof(Kerry.SSP.Orders.API.Startup))]

namespace Kerry.SSP.Orders.API
{
//    public class Startup
//    {
//        public Startup(IConfiguration configuration)
//        {
//            Configuration = configuration;
//        }
//        public IConfiguration Configuration { get; }
//        public void ConfigureServices(IServiceCollection services)
//        {
//            services.AddHttpClient();
//            services.AddSingleton<IOrderServices, OrderServices>();
//        }
//    }
//}
//using Microsoft.Azure.Functions.Extensions.DependencyInjection; 
//using Microsoft.Extensions.DependencyInjection; 
//[assembly: FunctionsStartup(typeof(MyNamespace.Startup))] 
//namespace MyNamespace 

    public class Startup : FunctionsStartup 
    { 
        public override void Configure(IFunctionsHostBuilder builder) 
        { 
            builder.Services.AddHttpClient();
            builder.Services.AddSingleton<IOrderServices, OrderServices>();
        } 
    } 
}