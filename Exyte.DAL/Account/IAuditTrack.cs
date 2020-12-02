using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.DAL.Account
{
    public interface IAuditTrackDal
    {
        bool AuditLoginInsert(int UserId, bool IsLogin,DateTime logTime);
        bool AuditOperationInsert(string Message, int UserId);
        int GetAuditId(int auditId);
    }
}
