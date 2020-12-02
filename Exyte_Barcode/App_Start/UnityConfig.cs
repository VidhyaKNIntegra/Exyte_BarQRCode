using Exyte.BAL.Account;
using Exyte.BAL.MSSQL;
using System.Web.Mvc;
using Unity;
using Unity.Mvc5;

namespace Exyte_Barcode
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
			var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();
            container.RegisterType<IAccountRepository, AccountRepository>();
            container.RegisterType<IMSSQLRepository, MSSQLRepository>();
            container.RegisterType<IAuditTrack, AuditTrack>();
            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}