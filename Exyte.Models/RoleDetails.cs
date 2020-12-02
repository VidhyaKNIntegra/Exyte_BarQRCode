using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.Models
{
    public class RoleDetails
    {

        public int Id { get; set; }   
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public int UserId { get; set; }  
        public long KeyId { get; set; }
        public string RoleDescription { get; set; }
        public int[] Permissions { get; set; }        

    }

}
