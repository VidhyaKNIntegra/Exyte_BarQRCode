using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LiteDrive.Exceptions
{
    public class ApplicationExceptions: AppException
    {
        public const string sql_db_connection_error = "Exception raised on sql command.";
        public const string sql_db_bulk_update_error = "Exception raised on sql command bulk update.";
        public const string sql_db_filter_Data_error = "Exception raised on sql command filter data search.";
        public const string sql_db_Table_Data_error = "Exception raised on sql command table data.";

        public const string db_connection_error = "Please check sql lite file in given path.";
        public const string default_db_connection_error = "Please check app.db file in current execution folder path.";
        public const string table_error = "table might not available.";
        public const string catalog_error = "catalog not available.";
        public ApplicationExceptions(string msgCode, Exception ex) 
            :base(msgCode, ex)
        {
        }
        public ApplicationExceptions(string msgCode, object[] msgArgs, Exception ex)
            : base(msgCode, msgArgs, ex)
        {
        }
    }
}
