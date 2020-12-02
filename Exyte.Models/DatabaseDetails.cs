using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.Models
{
    public class DatabaseDetails
    {
        public string DataSource { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string DataBase { get; set; }
        public string TableName { get; set; }
        public string ColumnName { get; set; }
        public string Wildcard { get; set; }
        public string SearchText { get; set; }
        public string CryptName { get; set; }
        public string[] ColumnNames { get; set; }
    }
}
