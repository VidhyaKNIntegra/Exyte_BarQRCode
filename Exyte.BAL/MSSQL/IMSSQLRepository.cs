
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
        DataTable GetColumnData(DatabaseDetails dbName);
        List<CategoryModel> GetCategoryList();
        string AddCategory(CategoryModel model, int userId);
        CategoryModel GetCategoryById(int id);
        bool UpdateCategory(CategoryModel model, int userId);
        bool DeleteCategory(int id);
        List<string> GetCategory();
        List<string> GetSPNames();
    }
}
