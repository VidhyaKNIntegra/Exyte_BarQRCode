using Exyte.DAL.MSSQL;
using Exyte.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.BAL.MSSQL
{    
    public class MSSQLRepository: IMSSQLRepository
    {
        private readonly IMSSQLDal _service;
        public MSSQLRepository()
        {
            this._service = new MSSQLDal();
        }

        public List<string> GetDatabases(DatabaseDetails dbInfo)
        {
            var res = _service.GetDatabases(dbInfo);
            return res;
        }

        public List<string> GetTables(DatabaseDetails dbName)
        {
            var res = _service.GetTables(dbName);
            return res;
        }
        public List<string> GetColumns(string dataBase, string TableName)
        {
            var res = _service.GetColumns(dataBase, TableName);
            return res;
        }

        public DataTable GetTableRecords(string dataBase, string TableName)
        {
            var res = _service.GetTableRecords(dataBase, TableName);
            return res;
        }

        public DataTable GetColumnFiterTableData(DatabaseDetails dbName)
        {
            var res = _service.GetColumnFiterTableData(dbName);
            return res;
        }

        public DataTable EncryptOrDecryptColumnData(DatabaseDetails dbName)
        {
            var res = _service.EncryptOrDecryptColumnData(dbName);
            return res;
        }

    }
}
