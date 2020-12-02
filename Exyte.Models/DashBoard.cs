using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.Models
{
    public class DashBoard
    {
        public int ActiveUsers { get; set; }
        public int InActiveUsers { get; set; }
        public int ActiveRoles { get; set; }
        public int InActiveRoles { get; set; }
        public int ActiveProjects { get; set; }
        public int ItemCodes { get; set; }
    }
}
