using Exyte.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.DAL.MSSQL
{
    public interface IMSSQLDal
    {
        List<string> GetDatabases(DatabaseDetails dbInfo);
        List<string> GetTables(DatabaseDetails dbName);
        List<string> GetColumns(string dataBase, string TableName);
        DataTable  GetTableRecords(string dataBase, string TableName);
        DataTable GetColumnFiterTableData(DatabaseDetails dbName);
        DataTable EncryptOrDecryptColumnData(DatabaseDetails dbName);
        DataTable GetColumnData(DatabaseDetails dbName);

    }
}
