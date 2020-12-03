using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.BAL.BARCode
{
 public   interface IBarCode
    {
        string GenerateQCCode(string QCText);
        string GenerateBarCode(string BarCodeText);
    }
}
