using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.Models
{
    public class MenuItems
    {
        public long MenuId { get; set; }
        public string MenuName { get; set; }
        public string Url { get; set; }
        public long? ParentMenu { get; set; }
        public string MenuClass { get; set; }
    }
}
