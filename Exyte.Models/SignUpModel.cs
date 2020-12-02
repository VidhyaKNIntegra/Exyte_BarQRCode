using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.Models
{
    public class SignUpModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNo { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public int UserId { get; set; }
        public string NewPassword { get; set; }
        public long KeyId { get; set; }
        public string RoleDescription { get; set; }
        public long[] Permissions { get; set; }
    }

}
