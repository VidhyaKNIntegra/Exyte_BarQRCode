using Exyte.BAL.Account;
using Exyte.Models;
using Exyte_Barcode.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;


namespace Exyte_Barcode.Controllers
{
    [CustomExceptionHandlerFilter]
    public class AccountController : Controller
    {
        private readonly IAccountRepository userRepository;
        private readonly IAuditTrack _audit;
        log4net.ILog logger = log4net.LogManager.GetLogger(typeof(AccountController));
        public AccountController(IAccountRepository repository, IAuditTrack audit)
        {
            this.userRepository = repository;
            this._audit = audit;
        }
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult Register()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult RegisterUser(SignUpModel sign)
        {
            var response = userRepository.Register(sign);
            if (response == "success")
            {
                _audit.AuditOperationInsert("user added successfully", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit                
            }
            else
            {
                _audit.AuditOperationInsert("add user failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));
            }
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult uploadFile()
        {
            return View();
        }


        public ActionResult LoginUser(string email, string password)
        {
            logger.Info("Login Started...");
            var result = userRepository.Login(email, password);
            string[] val = new string[] { };
            if (result.Contains("-"))
            {
                val = result.Split('-');
            }
            if (val.Count() > 0 && val[0].Equals("success"))
            {
                //model.Message = val[0];
                logger.Info("Logged in Successfully...");
                Session["RoleID"] = val[1];
                Session["UserName"] = val[2];
                Session["UserID"] = val[3];
                Session["URL"] = "/Home/Index";               
                _audit.AuditLoginInsert(Convert.ToInt32(Session["UserID"]), true,DateTime.Now);//login audit insert
                var roles = userRepository.GetParticularRole(Convert.ToInt32(val[1]));
                if (roles[0].RoleName.ToLower() == "superadmin" || roles[0].RoleName.ToLower() == "admin")
                {
                    Session["URL"] = "/Account/AdminDashBoard";
                    return Json(Url.Action("AdminDashBoard", "Account"), JsonRequestBehavior.AllowGet);
                }
                else if (roles[0].RoleName.ToLower() == "engineer")
                {
                    Session["URL"] = "/Account/EngineerDashBoard";
                    return Json(Url.Action("EngineerDashBoard", "Account"), JsonRequestBehavior.AllowGet);
                }
                else if (roles[0].RoleName.ToLower() == "commercial")
                {
                    Session["URL"] = "/Account/CommercialDashBoard";
                    return Json(Url.Action("CommercialDashBoard", "Account"), JsonRequestBehavior.AllowGet);
                }
                else
                    return Json(Url.Action("User", "Account"), JsonRequestBehavior.AllowGet);
            }
            logger.Info("Login failed...");
            return Json("failed", JsonRequestBehavior.AllowGet);
        }


        public ActionResult LogOut()
        {            
            _audit.AuditLoginInsert(Convert.ToInt32(Session["UserID"]), false,DateTime.Now);//logout audit insert
            FormsAuthentication.SignOut();
            Session.Abandon(); // it will clear the session at the end of request   
            logger.Info("Logged out Successfully...");
            //return View("Index");
            return RedirectToAction("Index", "Account");
        }
        [SessionTimeout]
        public ActionResult GetRoleTypes()
        {
            var response = userRepository.GetRoleTypes();
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult Settings()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult UpdatePassword(SignUpModel pass)
        {
            var response = userRepository.UpdatePassword(pass, Convert.ToInt32(Session["UserID"].ToString()));
            if (response== "success")
            {                
                _audit.AuditOperationInsert("password updated", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit
                _audit.AuditLoginInsert(Convert.ToInt32(Session["UserID"].ToString()), false, DateTime.Now);//logout and redirect to login screen
            }
            else
            {
                _audit.AuditOperationInsert("password update failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"].ToString())));
            }
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult Users()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult GetAllUsers()
        {
            List<SignUpModel> response = new List<SignUpModel>();
            response = userRepository.GetAllUsers();
            int c = 1;
            foreach (var s in response)
            {
                s.Id = c++;
            }
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult GetParticularUser(long id)
        {
            var response = userRepository.GetParticularUser(id);
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult GetRoleDetails()
        {
            var response = userRepository.GetRoleDetails();
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult UpdateUserDetails(SignUpModel sign)
        {
            var response = userRepository.UpdateUserDetails(sign);
            if (response== "success")
            {
                _audit.AuditOperationInsert("user details updated", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit
            }
            else
            {
                _audit.AuditOperationInsert("user details update failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));
            }
           
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [SessionTimeout]
        [HttpPost]
        public ActionResult DeleteUser(long id)
        {
            var response = userRepository.DeleteUser(id);
            if (response == "success")
            {
                _audit.AuditOperationInsert("user deleted successfully", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit
            }
            else
            {
                _audit.AuditOperationInsert("user delete failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));
            }
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult Roles()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult GetRoles()
        {
            List<SignUpModel> response = new List<SignUpModel>();
            response = userRepository.GetRoles();
            int c = 1;
            foreach (var x in response)
            {
                x.Id = c++;
            }
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult AddRole()
        {
            return View();

        }
        [SessionTimeout]
        public ActionResult AddNewRole(SignUpModel sign)
        {
            var response = userRepository.AddNewRole(sign);
            if (response == "success")
            {
                _audit.AuditOperationInsert("new user added successfully", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit
            }
            else
            {
                _audit.AuditOperationInsert("add user failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));
            }
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        [HttpPost]
        public ActionResult DeleteRole(int id)
        {
            var response = userRepository.DeleteRole(id);
            if (response == "success")
            {
                _audit.AuditOperationInsert("Role deleted successfully", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit
            }
            else
            {
                _audit.AuditOperationInsert("delete role failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));
            }
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        [HttpPost]
        public ActionResult UpdateRole(RoleDetails sign)
        {
            var response = userRepository.UpdateRole(sign);
            if (response == "success")
            {
                _audit.AuditOperationInsert("Role updated successfully", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit
            }
            else
            {
                _audit.AuditOperationInsert("update role failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));
            }
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult GetParticularRole(int id)
        {
            var response = userRepository.GetParticularRole(id);
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        public ActionResult MenuPermission()
        {
            return View();

        }
        [SessionTimeout]
        public ActionResult GetMenuList()
        {
            var response = userRepository.GetMenuList();
            return Json(response, JsonRequestBehavior.AllowGet);
        }
        [SessionTimeout]
        [ChildActionOnly]
        public ActionResult Menu()
        {
            var response = userRepository.MenuList(int.Parse(Session["RoleID"].ToString()));
            return View(response);
        }
        [SessionTimeout]
        public ActionResult AdminDashBoard()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult AdminDashboardDetails()
        {
            DashBoard response = new DashBoard();
            response = userRepository.AdminDashboardDetails();
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [SessionTimeout]
        public ActionResult EngineerDashBoard()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult EngineerDashboardDetails()
        {
            DashBoard response = new DashBoard();
            response = userRepository.EngineerDashboardDetails();
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [SessionTimeout]
        public ActionResult CommercialDashBoard()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult CommercialDashboardDetails()
        {
            DashBoard response = new DashBoard();
            response = userRepository.CommercialDashboardDetails();
            return Json(response, JsonRequestBehavior.AllowGet);
        }
    }
}