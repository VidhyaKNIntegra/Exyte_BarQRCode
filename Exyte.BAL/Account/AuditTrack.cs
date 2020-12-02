using Exyte.DAL.Account;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Exyte.BAL.Account
{
   public  class AuditTrack :IAuditTrack
    {
        private readonly IAuditTrackDal _audit;
        public AuditTrack()
        {
            this._audit = new AuditTrackDal();
        }

        public bool AuditLoginInsert(int UserId, bool IsLogin,DateTime logTime)
        {
            bool result = false;
            result = _audit.AuditLoginInsert(UserId, IsLogin, logTime);
            return result;
        }
        public bool AuditOperationInsert(string Message, int UserId) 
        {
            bool result = false;
            result = _audit.AuditOperationInsert(Message, UserId);
            return result;
        }
        public int GetAuditId(int auditId)
        {
            int id = _audit.GetAuditId(auditId);
            return id;
        }
    }
}
