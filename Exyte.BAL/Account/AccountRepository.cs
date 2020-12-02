using Exyte.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Exyte.DAL.Account;

namespace Exyte.BAL.Account
{
    public class AccountRepository: IAccountRepository
    {
        private readonly IAccountDal _service;
        //private readonly IAuditTrackDal _audit;
        public AccountRepository()
        {
            this._service = new AccountDal();
           
        }
        public string Login(string email, string password)
        {
            var res = _service.Login(email, password);            
            return res;
        }

        public string Register(SignUpModel sign)
        {
            var res = _service.Register(sign);
            return res;
        }

        public List<SignUpModel> GetRoleTypes()
        {
            var res = _service.GetRoleTypes();
            return res;
        }

        public string UpdatePassword(SignUpModel pass,int userId)
        {
            var res = _service.UpdatePassword(pass, userId);
            return res;
        }
        public List<SignUpModel> GetAllUsers()
        {
            var res = _service.GetAllUsers();
            return res;
        }

        public List<SignUpModel> GetParticularUser(long id)
        {
            var res = _service.GetParticularUser(id);
            return res;
        }

        public List<SignUpModel> GetRoleDetails()
        {
            var res = _service.GetRoleDetails();
            return res;
        }

        public string UpdateUserDetails(SignUpModel sign)
        {
            var res = _service.UpdateUserDetails(sign);
            return res;
        }
        public string DeleteUser(long userId)
        {
            var res = _service.DeleteUser(userId);
            return res;
        }

        public List<SignUpModel> GetRoles()
        {
            var res = _service.GetRoles();
            return res;
        }

        public string AddNewRole(SignUpModel sign)
        {
            var res = _service.AddNewRole(sign);
            return res;
        }
        public string DeleteRole(int id)
        {
            var res = _service.DeleteRole(id);
            return res;
        }

        public string UpdateRole(RoleDetails sign)
        {
            var res = _service.UpdateRole(sign);
            return res;
        }

        public List<SignUpModel> GetParticularRole(int id)
        {
            var res = _service.GetParticularRole(id);
            return res;
        }

        public List<MenuItems> GetMenuList()
        {
            var res = _service.GetMenuList();
            return res;
        }
        public List<MenuItems> MenuList(int roleId)
        {
            var res = _service.MenuList(roleId);
            return res;
        }
        public DashBoard AdminDashboardDetails()
        {
            var res = _service.AdminDashboardDetails();
            return res;
        }

        public DashBoard EngineerDashboardDetails()
        {
            var res = _service.EngineerDashboardDetails();
            return res;
        }

        public DashBoard CommercialDashboardDetails()
        {
            var res = _service.CommercialDashboardDetails();
            return res;
        }
    }
}
