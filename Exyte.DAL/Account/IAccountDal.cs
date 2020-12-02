using Exyte.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.DAL.Account
{
    public interface IAccountDal
    {
        string Login(string email, string password);
        string Register(SignUpModel sign);
        List<SignUpModel> GetRoleTypes();

        string UpdatePassword(SignUpModel pass,int userId);

        List<SignUpModel> GetAllUsers();
        List<SignUpModel> GetParticularUser(long id);

        List<SignUpModel> GetRoleDetails();

        string UpdateUserDetails(SignUpModel sign);
        string DeleteUser(long userId);
        List<SignUpModel> GetRoles();
        string AddNewRole(SignUpModel sign);
        string DeleteRole(int id);
        string UpdateRole(RoleDetails sign);
        List<SignUpModel> GetParticularRole(int id);
        List<MenuItems> GetMenuList();

        List<MenuItems> MenuList(int roleId);
        DashBoard AdminDashboardDetails();

        DashBoard EngineerDashboardDetails();

        DashBoard CommercialDashboardDetails();
    }
}
