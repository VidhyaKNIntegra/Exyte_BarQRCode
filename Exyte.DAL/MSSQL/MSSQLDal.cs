using Exyte.Models;
using Exyte.Provider;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.DAL.MSSQL
{
    public class MSSQLDal : IMSSQLDal
    {
        log4net.ILog logger = log4net.LogManager.GetLogger(typeof(MSSQLDal));
        private readonly ToolCostingEntities _db = new ToolCostingEntities();

        public List<string> GetDatabases(DatabaseDetails dbInfo)
        {

            // assumes a connectionString name in .config of Exyte_Tool_CostEntities
            var selectedDb = new ToolCostingEntities();
            // so only reference the changed properties
            // using the object parameters by name
            if (dbInfo.UserName == null && dbInfo.Password == null)
            {
                selectedDb.ChangeDatabase
                (
                    //initialCatalog: "name-of-another-initialcatalog",
                    //userId: dbInfo.UserName,
                    //password: dbInfo.Password,
                    dataSource: @"" + dbInfo.DataSource + "" // could be ip address 120.273.435.167 etc
                );
            }
            else
            {
                selectedDb.ChangeDatabase
                               (
                                   //initialCatalog: "name-of-another-initialcatalog",
                                   userId: dbInfo.UserName,
                                   password: dbInfo.Password,
                                   dataSource: @"" + dbInfo.DataSource + "" // could be ip address 120.273.435.167 etc
                               );
            }
            try
            {
                var dbNames = selectedDb.Database.SqlQuery<string>(
                          "SELECT name FROM dbo.sysdatabases where name like '" + dbInfo.DataBase + "%'"
                          ).ToList();
                return dbNames;

            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                List<string> ss = new List<string>();
                ss.Add("failed");
                return ss;
            }


        }

        public List<string> GetTables(DatabaseDetails dbName)
        {
            try
            {
                using (var db = new ToolCostingEntities())
                {
                    List<string> results = db.Database.SqlQuery<string>("SELECT TABLE_NAME FROM [" + dbName.DataBase + "].INFORMATION_SCHEMA.TABLES ORDER BY TABLE_NAME").ToList();
                    return results;
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }



        }

        public List<string> GetColumns(string dataBase, string TableName)
        {
            try
            {
                string sp = "";
                using (var db = new ToolCostingEntities())
                {
                    sp = _db.Categories.Where(x => x.CategoryName == TableName).Select(y => y.SPName).FirstOrDefault();
                    //DataTable retVal = new DataTable();
                    //retVal = db.Database.SqlQuery<DataTable>("exec " + sp + " @DBName", new SqlParameter("DBName", dataBase)).FirstOrDefault();                
                }
                List<string> ss = new List<string>();
                SqlConnection con = new SqlConnection(Global.SqlConnection);
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DBName", dataBase);
                DataTable dt = new DataTable();
                con.Open();
                using (var rdr = cmd.ExecuteReader())
                {
                    dt.Load(rdr);
                }
                List<string> columnNames = dt.Columns.Cast<DataColumn>()
                                 .Select(x => x.ColumnName)
                                 .ToList();
                return columnNames;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }

        }

        public DataTable GetTableRecords(string dataBase, string TableName)
        {
            try
            {
                string sp = "";
                using (var db = new ToolCostingEntities())
                {
                    sp = _db.Categories.Where(x => x.CategoryName == TableName).Select(y => y.SPName).FirstOrDefault();

                    SqlConnection con = new SqlConnection(Provider.Global.SqlConnection);
                    con.Open();
                    SqlCommand cmd = new SqlCommand(sp, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@DBName", dataBase);
                    SqlDataReader dr = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    if (dr.HasRows)
                    {
                        dt.Load(dr);
                    }
                    con.Close();
                    return dt;
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }

        }
        public DataTable GetColumnFiterTableData(DatabaseDetails dbName)
        {
            try
            {
                SqlConnection con = new SqlConnection(Provider.Global.SqlConnection);
                con.Open();
                if (dbName.Wildcard == "start")
                {
                    dbName.Wildcard = dbName.SearchText + "%";
                }
                else
                {
                    dbName.Wildcard = "%" + dbName.SearchText;
                }
                SqlCommand cmd = new SqlCommand("SELECT * from [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "] where [" + dbName.ColumnName + "] like " + " '" + dbName.Wildcard + "' ", con);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                if (dr.HasRows)
                {
                    dt.Load(dr);
                }
                con.Close();
                return dt;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }

        }

        public DataTable EncryptOrDecryptColumnData(DatabaseDetails dbName)
        {
            try
            {
                if (dbName.CryptName == "Encrypt")
                {
                    SqlConnection con = new SqlConnection(Provider.Global.SqlConnection);
                    con.Open();
                    SqlCommand cmd = new SqlCommand("select * from [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "]", con);
                    SqlDataReader dr = cmd.ExecuteReader();
                    DataTable dt = new DataTable();

                    if (dr.HasRows == true)
                    {
                        dt.Load(dr);

                    }

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["PnPID"] != null)
                            {
                                foreach (var columnName in dbName.ColumnNames)
                                {
                                    dbName.ColumnName = columnName;
                                    var type = dt.Rows[i]["" + dbName.ColumnName + ""].GetType();
                                    var dttype = dt.Columns[0].DataType.Name.ToString();
                                    var pnpid = dt.Rows[i]["PnPID"];
                                    var values = "";
                                    var columndata = "";
                                    if (type != typeof(System.DBNull))
                                    {

                                        if (type == typeof(System.String))
                                        {
                                            columndata = dt.Rows[i].Field<string>("" + dbName.ColumnName + "");
                                        }

                                        if (type == typeof(System.Int64))
                                        {
                                            columndata = Convert.ToInt64(dt.Rows[i].Field<Int64>("" + dbName.ColumnName + "")).ToString();
                                        }
                                        else if (type == typeof(System.Int32))
                                        {
                                            columndata = Convert.ToString(dt.Rows[i].Field<Int32>("" + dbName.ColumnName + ""));
                                        }
                                        else if (type == typeof(System.Int16))
                                        {
                                            columndata = Convert.ToString(dt.Rows[i].Field<Int16>("" + dbName.ColumnName + ""));
                                        }
                                        else if (type == typeof(System.Double))
                                        {
                                            columndata = Convert.ToDouble(dt.Rows[i].Field<double>("" + dbName.ColumnName + "")).ToString();
                                        }
                                        else if (type == typeof(System.Boolean))
                                        {
                                            columndata = Convert.ToString(dt.Rows[i].Field<bool>("" + dbName.ColumnName + ""));
                                        }
                                        else if (type == typeof(System.Decimal))
                                        {
                                            columndata = Convert.ToString(dt.Rows[i].Field<Decimal>("" + dbName.ColumnName + ""));
                                        }

                                        if (type == typeof(System.Int16) ||
                                        type == typeof(System.Int32) ||
                                        type == typeof(System.Int64) ||
                                        type == typeof(System.Decimal) ||
                                        //type == typeof(System.Single) ||
                                        type == typeof(System.Double))
                                        {
                                            var val = RijndaelEncryptor.dynamicTypeEncryption(columndata, type, true);
                                            values = RijndaelEncryptor.convertNumberToString(val);
                                        }
                                        else
                                            values = RijndaelEncryptor.Encrypt(columndata);

                                        SqlCommand cmd1 = new SqlCommand("update [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "] SET [" + dbName.ColumnName + "]= '" + values + "' where PnPID=" + pnpid, con);
                                        cmd1.ExecuteNonQuery();
                                    }
                                    else
                                    {
                                        SqlCommand cmd1 = new SqlCommand("update [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "] SET [" + dbName.ColumnName + "]= NULL where PnPID=" + pnpid, con);
                                        cmd1.ExecuteNonQuery();
                                    }
                                }
                            }

                        }
                    }
                    dr.Close();

                    SqlCommand cmd3 = new SqlCommand("select * from [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "]", con);
                    SqlDataReader dr3 = cmd3.ExecuteReader();

                    DataTable dt3 = new DataTable();
                    if (dr3.HasRows == true)
                    {
                        dt3.Load(dr3);
                    }
                    con.Close();
                    return dt3;
                }
                else
                {
                    SqlConnection con = new SqlConnection(Provider.Global.SqlConnection);
                    con.Open();
                    SqlCommand cmd = new SqlCommand("select * from [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "]", con);
                    SqlDataReader dr = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    if (dr.HasRows == true)
                    {
                        dt.Load(dr);
                    }

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["PnPID"] != null)
                            {
                                foreach (var columnName in dbName.ColumnNames)
                                {
                                    dbName.ColumnName = columnName;
                                    var pnpid = dt.Rows[i]["PnPID"];
                                    var values = "";
                                    var type = dt.Rows[i]["" + dbName.ColumnName + ""].GetType();
                                    var columndata = "";
                                    if (type != typeof(System.DBNull))
                                    {

                                        if (type == typeof(System.String))
                                        {
                                            columndata = dt.Rows[i].Field<string>("" + dbName.ColumnName + "");
                                        }

                                        if (type == typeof(System.Int64))
                                        {
                                            columndata = Convert.ToInt64(dt.Rows[i].Field<Int64>("" + dbName.ColumnName + "")).ToString();
                                        }
                                        else if (type == typeof(System.Int32))
                                        {
                                            columndata = Convert.ToString(dt.Rows[i].Field<Int32>("" + dbName.ColumnName + ""));
                                        }
                                        else if (type == typeof(System.Int16))
                                        {
                                            columndata = Convert.ToString(dt.Rows[i].Field<Int16>("" + dbName.ColumnName + ""));
                                        }
                                        else if (type == typeof(System.Double))
                                        {
                                            columndata = Convert.ToDouble(dt.Rows[i].Field<double>("" + dbName.ColumnName + "")).ToString();
                                        }
                                        else if (type == typeof(System.Boolean))
                                        {
                                            columndata = Convert.ToString(dt.Rows[i].Field<bool>("" + dbName.ColumnName + ""));
                                        }

                                        if (type == typeof(System.Int16) ||
                                      type == typeof(System.Int32) ||
                                      type == typeof(System.Int64) ||
                                      type == typeof(System.Single) ||
                                      type == typeof(System.Double) ||
                                      type == typeof(System.Decimal))
                                        {
                                            var val = RijndaelEncryptor.convertNumberToString(columndata);
                                            values = RijndaelEncryptor.dynamicTypeEncryption(val, type, false);
                                        }
                                        else
                                            values = RijndaelEncryptor.Decrypt(columndata);

                                        SqlCommand cmd1 = new SqlCommand("update [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "] SET [" + dbName.ColumnName + "]= '" + values + "' where PnPID=" + pnpid, con);
                                        //SqlDataReader dr1 = cmd1.ExecuteReader();
                                        cmd1.ExecuteNonQuery();
                                    }
                                    else
                                    {
                                        SqlCommand cmd1 = new SqlCommand("update [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "] SET [" + dbName.ColumnName + "]= NULL where PnPID=" + pnpid, con);
                                        //SqlDataReader dr1 = cmd1.ExecuteReader();
                                        cmd1.ExecuteNonQuery();
                                    }
                                }
                            }
                        }
                    }
                    dr.Close();

                    SqlCommand cmd3 = new SqlCommand("select * from [" + dbName.DataBase + "].[dbo].[" + dbName.TableName + "]", con);
                    SqlDataReader dr3 = cmd3.ExecuteReader();

                    DataTable dt3 = new DataTable();
                    if (dr3.HasRows == true)
                    {
                        dt3.Load(dr3);

                    }
                    con.Close();
                    return dt3;
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }

        }
        public DataTable GetColumnData(DatabaseDetails dbName)
        {
            try
            {               
                string sp = "";
                sp = _db.Categories.Where(x => x.CategoryName == dbName.TableName).Select(y => y.SPName).FirstOrDefault();
                SqlConnection con = new SqlConnection(Provider.Global.SqlConnection);
                con.Open();
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DBName", dbName.DataBase);
                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                if (dr.HasRows == true)
                {
                    dt.Load(dr);
                }                
                DataTable dt1=dt.DefaultView.ToTable(false, dbName.ColumnNames);                
                dr.Close();
                con.Close();
                return dt1;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
        }

        public List<CategoryModel> GetCategoryList()
        {
            var res = (from aa in _db.Categories
                       select new CategoryModel
                       {
                           CategoryID = aa.CategoryID,
                           CategoryName = aa.CategoryName,
                           SPName = aa.SPName,
                           Description = aa.Description,
                       }).ToList();

            return res;

        }
        public string AddCategory(CategoryModel model, int userId)
        {
            try
            {
                var result = _db.Categories.Where(x => x.CategoryName.Trim() == model.CategoryName.Trim()).FirstOrDefault();
                if (result != null)
                {
                    return "exists";
                }
                else if (result == null)
                {
                    Category cat = new Category();
                    cat.CategoryName = model.CategoryName;
                    cat.SPName = model.SPName;
                    cat.Description = model.Description;
                    cat.CreatedBy = userId;
                    cat.CreatedOn = DateTime.Now;
                    _db.Categories.Add(cat);
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

        public CategoryModel GetCategoryById(int id)
        {
            var res = (from aa in _db.Categories
                       where aa.CategoryID == id
                       select new CategoryModel
                       {
                           CategoryID = aa.CategoryID,
                           CategoryName = aa.CategoryName,
                           SPName = aa.SPName,
                           Description = aa.Description,
                       }).ToList();

            return res[0];

        }
        public bool UpdateCategory(CategoryModel model, int userId)
        {
            try
            {
                var result = _db.Categories.Where(x => x.CategoryID == model.CategoryID).FirstOrDefault();
                if (result != null)
                {
                    result.CategoryName = model.CategoryName;
                    result.SPName = model.SPName;
                    result.Description = model.Description;
                    result.ModifiedBy = userId;
                    result.ModifiedOn = DateTime.Now;
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
        public bool DeleteCategory(int id)
        {
            try
            {
                var res = _db.Categories.Where(x => x.CategoryID == id).FirstOrDefault();
                if (res != null)
                {
                    _db.Categories.Remove(res);
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

        public List<string> GetCategory()
        {
            var res = _db.Categories.Select(x => x.CategoryName).ToList();
            return res;
        }
        public List<string> GetSPNames()
        {
            try
            {
                var ss = _db.Database.SqlQuery<string>("SELECT [name] FROM SYS.PROCEDURES").ToList();
                return ss;
            }
            catch (Exception ex)
            {
                logger.Error(ex.ToString());
                throw ex;
            }
        }
    }
}
