using Exyte.BAL.MSSQL;
using Exyte.BAL.BARCode;
using Exyte.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Exyte_Barcode.Util;
using System.Web.Mvc;
using Exyte.BAL.Account;

namespace Exyte_Barcode.Controllers
{
    [SessionTimeout]
    [CustomExceptionHandlerFilter]
    public class MSSQLController : Controller
    {
        private readonly IMSSQLRepository _repository;
        private readonly IAuditTrack _audit;
        private readonly IBarCode _barCode;
        
        public MSSQLController(IMSSQLRepository repository, IAuditTrack audit,IBarCode  barCode)
        {
            this._repository = repository;
            this._audit = audit;
            this._barCode = barCode;

        }
        // GET: MSSQL
        public ActionResult MSSQLHome()
        {
            return View();
        }

        public ActionResult GetDatabases(DatabaseDetails dbInfo)
        {
            var response = _repository.GetDatabases(dbInfo);
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetTables(DatabaseDetails dbname)
        {
            var response = _repository.GetTables(dbname);
            return Json(response, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetColumns(string dataBase, string TableName)
        {
            var response = _repository.GetColumns(dataBase, TableName);
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetTableRecords(string dataBase, string TableName)
        {

            DataTable response = _repository.GetTableRecords(dataBase, TableName);
            return Json((JsonConvert.SerializeObject(response)), JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetColumnFiterTableData(DatabaseDetails dbname)
        {
            DataTable response = _repository.GetColumnFiterTableData(dbname);
            return Json((JsonConvert.SerializeObject(response)), JsonRequestBehavior.AllowGet);
        }

        public ActionResult EncryptOrDecryptColumnData(DatabaseDetails dbname)
        {
            DataTable response = _repository.EncryptOrDecryptColumnData(dbname);
            if (dbname.CryptName == "Encrypt")
            {
                if (response != null)
                {
                    _audit.AuditOperationInsert("Encrypt column Data successfully", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit
                }
                else
                {
                    _audit.AuditOperationInsert("Encrypt column Data failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));
                }
            }
            else
            {
                if (response != null)
                {
                    _audit.AuditOperationInsert("Decrypt column Data successfully", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));//inserting into operationAudit
                }
                else
                {
                    _audit.AuditOperationInsert("Decrypt column Data failed", _audit.GetAuditId(Convert.ToInt32(Session["UserID"])));
                }
            }
            return Json((JsonConvert.SerializeObject(response)), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetColumnData(DatabaseDetails dbname)
        {
            DataTable response = _repository.GetColumnData(dbname);
            return Json((JsonConvert.SerializeObject(response)), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult SingleQRCode(string Text)
        {
            string QRCode = _barCode.GenerateQCCode(Text) != null ? "data:image/jpg;base64," +
                      _barCode.GenerateQCCode(Text) : "";           
            return Json(QRCode,JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult SingleBarCode(string Text)
        {   
            string Barcode2D = _barCode.GenerateBarCode(Text) != null ? "data:image/jpg;base64," +
                                _barCode.GenerateBarCode(Text) : "";
            return Json(Barcode2D,JsonRequestBehavior.AllowGet);
        }
    }
}