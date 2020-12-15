using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.Models
{
    public class CategoryModel
    {
        public int SlNo { get; set; }
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
        public string SPName { get; set; }
        public string Description { get; set; }
        public int UserId { get; set; }
       
    }
}
