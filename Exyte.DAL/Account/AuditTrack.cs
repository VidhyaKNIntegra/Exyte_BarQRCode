using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.DAL.Account
{
   public  class AuditTrackDal: IAuditTrackDal
   {
        private readonly ToolCostingEntities _db = new ToolCostingEntities();
        log4net.ILog logger = log4net.LogManager.GetLogger(typeof(AccountDal));
        public bool AuditLoginInsert(int UserId,bool IsLogin,DateTime logTime)
        {
            try
            {
                if (UserId != 0)
                {
                    //bool result = false;
                    UserAudit audit = new UserAudit();
                    audit.UserID = UserId;
                    audit.IsLogin = IsLogin;
                    if (IsLogin == true)
                    {
                        audit.LoginOn = logTime;
                    }
                    else
                    {
                        audit.LogoutOn = DateTime.Now;
                    }
                    _db.UserAudits.Add(audit);
                    _db.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            
        }
        public bool AuditOperationInsert(string Message, int AuditId)
        {
            try
            {
                //bool result = false;
                if (AuditId != 0 && Message != null)
                {
                    OperationAudit opAudit = new OperationAudit();
                    opAudit.AuditId = AuditId;
                    opAudit.Opertaion = Message;
                    opAudit.CreatedOn = DateTime.Now;
                    _db.OperationAudits.Add(opAudit);
                    _db.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            

        }
        public int GetAuditId(int userId)
        {
            try
            {
                var id = from a in _db.UserAudits
                         where a.UserID == userId
                         orderby a.Sno descending
                         select a.Sno;

                return Convert.ToInt32(id.First());
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
            
        }
    }
}
