
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Exyte.Models;

namespace Exyte.BAL.MSSQL
{
    public interface IMSSQLRepository
    {
        List<string> GetDatabases(DatabaseDetails dbInfo);
        List<string> GetTables(DatabaseDetails dbName);
        List<string>  GetColumns(string dataBase, string TableName);
        DataTable GetTableRecords(string dataBase, string TableName);
        DataTable GetColumnFiterTableData(DatabaseDetails dbName);
        DataTable EncryptOrDecryptColumnData(DatabaseDetails dbName);
    }
}
