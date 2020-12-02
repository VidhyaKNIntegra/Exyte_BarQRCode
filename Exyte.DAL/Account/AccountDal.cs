using Exyte.Models;
using Exyte.Provider;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.DAL.Account
{
    public class AccountDal : IAccountDal
    {
        private readonly ToolCostingEntities _db = new ToolCostingEntities();
        log4net.ILog logger = log4net.LogManager.GetLogger(typeof(AccountDal));
        public string Login(string email, string password)
        {
            try
            {
                var user = _db.Users.Where(x => x.Email == email).FirstOrDefault();
                if (user != null)
                {

                    //string pwd = Global.base64Decode(user.Password);
                    string pwd = Global.EncodePasswordSHA256(password);

                    //var query = (from s in _db.tbl_User_Master where (s.Email == email) && s.Password.Equals(pwd) select s).FirstOrDefault();
                    if (user.Password == pwd)
                    {
                        return "success" + "-" + user.RoleId + "-" + user.FirstName + " " + user.LastName + "-" + user.UserId;
                    }
                    else
                    {
                        return "Please Enter the valid Email and Password";
                    }
                }
                else
                {
                    return "Please Enter the valid Email and Password";
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
        }

        public string Register(SignUpModel sign)
        {
            try
            {
                var user = _db.Users.Where(x => x.Email == sign.Email).FirstOrDefault();
                if (user == null)
                {
                    User tbl_user = new User();
                    tbl_user.FirstName = sign.FirstName;
                    tbl_user.LastName = sign.LastName;
                    tbl_user.Email = sign.Email;                   
                    string password = Global.EncodePasswordSHA256(sign.Password);
                    tbl_user.Password = password;
                    tbl_user.PhoneNumber = sign.PhoneNo;
                    tbl_user.RoleId = sign.RoleId;
                    tbl_user.IsActive = true;
                    tbl_user.IsPasswordChanged = false;
                    tbl_user.CreatedBy = sign.UserId;
                    tbl_user.CreatedOn = DateTime.Now;
                    _db.Users.Add(tbl_user);
                    _db.SaveChanges();
                    return "success";
                }
                else
                {
                    return "exists";
                }
            }
            catch (InvalidOperationException ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
        }

        public List<SignUpModel> GetRoleTypes()
        {
            try
            {
                var result = (from im in _db.Roles
                              where im.RoleName != "Super Admin"
                              select new SignUpModel
                              {
                                  RoleId = im.RoleId,
                                  RoleName = im.RoleName
                              }).ToList();
                return result;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
        }
        public string UpdatePassword(SignUpModel pass,int userId)
        {
            try
            {
                var userpass = _db.Users.Where(x => x.UserId == userId).FirstOrDefault();

                string pwd = Global.EncodePasswordSHA256(pass.Password);
                if (pwd == userpass.Password)
                {
                    string NewPassword = Global.EncodePasswordSHA256(pass.NewPassword);
                    userpass.Password = NewPassword;
                    userpass.IsPasswordChanged = true;
                    userpass.ModifiedOn = DateTime.Now;
                    userpass.ModifiedBy = userId;
                    _db.SaveChanges();
                    return "success";
                }
                else
                {
                    return "failed";
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            

        }

        public List<SignUpModel> GetAllUsers()
        {
            try 
            {
                var res = (from iom in _db.Users
                           join b in _db.Roles on iom.RoleId equals b.RoleId
                           where iom.RoleId != 1 && iom.IsActive == true
                           select new SignUpModel
                           {
                               FirstName = iom.FirstName + (iom.LastName!=null?" " + iom.LastName:""),
                               Email = iom.Email,
                               PhoneNo = iom.PhoneNumber,
                               RoleName = b.RoleName,
                               KeyId = iom.UserId

                           }).ToList();
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
           
        }

        public List<SignUpModel> GetParticularUser(long id)
        {
            try
            {
                var res = (from iom in _db.Users
                           join bb in _db.Roles on iom.RoleId equals bb.RoleId
                           where iom.UserId == id
                           select new SignUpModel
                           {
                               KeyId = iom.UserId,
                               FirstName = iom.FirstName,
                               LastName = iom.LastName,
                               Email = iom.Email,
                               PhoneNo = iom.PhoneNumber,
                               RoleId = iom.RoleId,
                               RoleName=bb.RoleName
                           }).ToList();
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
        }

        public List<SignUpModel> GetRoleDetails()
        {
            try
            {
                var res = (from iom in _db.Roles
                           where iom.RoleName != "Super Admin"
                           select new SignUpModel
                           {
                               RoleName = iom.RoleName,
                               RoleId = iom.RoleId
                           }).ToList();
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
           
        }

        public string UpdateUserDetails(SignUpModel sign)
        {
            try
            {
                var res = _db.Users.Where(x => x.UserId == sign.KeyId).FirstOrDefault();
                if (res != null)
                {
                    res.FirstName = sign.FirstName;
                    res.LastName = sign.LastName;
                    res.Email = sign.Email;
                    res.PhoneNumber = sign.PhoneNo;
                    res.RoleId = sign.RoleId;
                    res.ModifiedBy = sign.UserId;
                    res.ModifiedOn = DateTime.Now;
                    _db.SaveChanges();
                    return "success";
                }
                else
                {
                    return "failed";
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            
        }

        public string DeleteUser(long userId)
        {
            try
            {
                var res = _db.Users.Where(x => x.UserId == userId).FirstOrDefault();
                if (res != null)
                {
                    res.IsActive = false;
                    _db.SaveChanges();
                    return "success";
                }
                else
                {
                    return "failed";
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }           

        }

        public List<SignUpModel> GetRoles()
        {
            try
            {
                var res = (from a in _db.Roles
                           where a.RoleId != 1 && a.Is_Active == true
                           select new SignUpModel
                           {
                               RoleId = a.RoleId,
                               RoleName = a.RoleName,
                               RoleDescription = a.RoleDescription
                           }).ToList();
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
           
        }

        public string AddNewRole(SignUpModel sign)
        {
            try
            {
                var res = _db.Roles.Where(x => x.RoleName == sign.RoleName).FirstOrDefault();

                if (res != null)
                {
                    return "exists";
                }
                else
                {
                    Role tbl_role = new Role();
                    tbl_role.RoleDescription = sign.RoleDescription;
                    tbl_role.RoleName = sign.RoleName;
                    tbl_role.Created_By = sign.UserId;
                    tbl_role.Is_Active = true;
                    tbl_role.Created_On = DateTime.Now;
                    _db.Roles.Add(tbl_role);
                    _db.SaveChanges();

                    var newRole = _db.Roles.Where(x => x.RoleName == sign.RoleName).FirstOrDefault();

                    foreach (int i in sign.Permissions)
                    {
                        MenuRole rol = new MenuRole();
                        rol.MenuId = i;
                        rol.RoleId = newRole.RoleId;
                        rol.Created_By = sign.UserId;
                        rol.Created_On = DateTime.Now;
                        _db.MenuRoles.Add(rol);
                        _db.SaveChanges();
                    }

                    return "success";
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
        }

        public string DeleteRole(int id)
        {
            try
            {
                var res = _db.Roles.Where(x => x.RoleId == id).FirstOrDefault();
                if (res != null)
                {
                    res.Is_Active = false;
                    _db.SaveChanges();
                    return "success";
                }
                else
                {
                    return "failed";
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }            
            
        }

        public string UpdateRole(RoleDetails sign)
        {
            try
            {
                //var res = _db.Roles.Where(x => x.RoleId == sign.RoleId).FirstOrDefault();
                var res = _db.Roles.Where(x => x.RoleName == sign.RoleName).FirstOrDefault();
                if (res != null)
                {
                    res.RoleName = sign.RoleName;
                    res.RoleDescription = sign.RoleDescription;
                    res.Modified_By = sign.UserId;
                    res.Modified_On = DateTime.Now;

                    if (sign.Permissions != null && sign.Permissions.Length > 0)
                    {
                        _db.MenuRoles.RemoveRange(_db.MenuRoles.Where(x => x.RoleId == sign.RoleId));
                        foreach (int i in sign.Permissions)
                        {
                            MenuRole rol = new MenuRole();
                            rol.MenuId = i;
                            rol.RoleId = sign.RoleId;
                            rol.Created_By = sign.UserId;
                            rol.Created_On = DateTime.Now;
                            _db.MenuRoles.Add(rol);
                            //_db.SaveChanges();
                        }
                    }

                    _db.SaveChanges();
                    return "success";
                }
                else
                {
                    return "failed";
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            
            
        }

        public List<SignUpModel> GetParticularRole(int id)
        {
            try
            {
                var menus = _db.MenuRoles.Where(m => m.RoleId == id).Select(i => i.MenuId).ToArray();
                //(from m in _db.MenuRoles
                //         where m.RoleId == id
                //         select new { m.MenuId }).ToArray();
                var res = (from iom in _db.Roles
                           where iom.RoleId == id
                           select new SignUpModel
                           {
                               RoleId = iom.RoleId,
                               RoleName = iom.RoleName,
                               RoleDescription = iom.RoleDescription
                           }).ToList();
                if (res != null && res.Count > 0)
                    res[0].Permissions = menus;
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            
        }
        public List<MenuItems> GetMenuList()
        {
            try
            {
                var res = (from iom in _db.MenuLists
                           where iom.IsActive == true // where iom.ParentMenu == null
                           select new MenuItems
                           {
                               MenuId = iom.Id,
                               MenuName = iom.MenuName,
                               ParentMenu = iom.ParentMenu
                           }).ToList();
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }           
        }

        public List<MenuItems> MenuList(int roleId)
        {
            try
            {
                var res = (from i in _db.MenuLists
                           join b in _db.MenuRoles
                           on i.Id equals b.MenuId
                           where i.IsActive == true && b.RoleId == roleId
                           select new MenuItems
                           {
                               Url = i.Url,
                               MenuName = i.MenuName,
                               MenuId = i.Id,
                               ParentMenu = i.ParentMenu,
                               MenuClass = i.MenuClass
                           }).ToList();

                //return res!=null?res.ToList():null;
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
           
        }
        public DashBoard AdminDashboardDetails()
        {
            try
            {
                DashBoard res = new DashBoard();
                res.ActiveUsers = (from o in _db.Users
                                   where o.IsActive == true

                                   select o.Role).Count();
                res.InActiveUsers = (from o in _db.Users
                                     where o.IsActive == false

                                     select o.Role).Count();
                res.ActiveRoles = (from o in _db.Roles
                                   where o.Is_Active == true

                                   select o.RoleId).Count();
                res.InActiveRoles = (from o in _db.Roles
                                     where o.Is_Active == false

                                     select o.RoleId).Count();
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }            
        }

        public DashBoard EngineerDashboardDetails()
        {
            try
            {
                DashBoard res = new DashBoard();
                res.ActiveProjects = 0;
                    //(from o in _db.projmasters  select o.projectid).Count();
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            
        }

        public DashBoard CommercialDashboardDetails()
        {
            try
            {
                DashBoard res = new DashBoard();
                res.ItemCodes = 0;//(from o in _db.CommercialDatas select o.ItemCode).Count();
                return res;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            
        }
    }
}
