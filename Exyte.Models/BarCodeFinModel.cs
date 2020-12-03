using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exyte.Models
{
   public  class BarCodeFinModel
    {
        public int Id { get; set; }
        public string Text { get; set; }
        public string QRCode { get; set; }
        public string Barcode2D { get; set; }
        public string Barcode1D_CODE_128 { get; set; }
        public string Barcode2D_DataMatrix { get; set; }
        public string Barcode2D_AZTEC { get; set; }
        public string Barcode1D_CODE_39 { get; set; }
        public string BarCode1D_CODE_93 { get; set; }
    }
}
