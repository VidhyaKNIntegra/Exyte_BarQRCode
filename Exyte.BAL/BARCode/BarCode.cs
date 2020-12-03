using System;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using ZXing;
using ZXing.PDF417;


namespace Exyte.BAL.BARCode
{
    public class BarCode :IBarCode 
    {
        public  string GenerateQCCode(string QCText)
        {
            var QCwriter = new BarcodeWriter();
            QCwriter.Format = BarcodeFormat.QR_CODE;
            var result = QCwriter.Write(QCText);

            var barcodeBitmap = new Bitmap(result);
            string ReturnQr = string.Empty;
            using (MemoryStream memory = new MemoryStream())
            {
                barcodeBitmap.Save(memory, ImageFormat.Jpeg);
                byte[] bytes = memory.ToArray();
                ReturnQr = Convert.ToBase64String(bytes);
            }
            return ReturnQr;



        }


        //Bar code generation - Zxing -2d barcode
        public  string GenerateBarCode(string BarCodeText)
        {
            var byteArrayAsString = new String(BarCodeText.Select(b => (char)b).ToArray());

            var writer = new BarcodeWriter
            {
                Format = BarcodeFormat.PDF_417,
                Options = new PDF417EncodingOptions
                {
                    Height = 150,
                    Width = 150,
                    Margin = 10
                }
            };
            var result = writer.Write(byteArrayAsString);

            var barcodeBitmap = new Bitmap(result);
            string returndetails = string.Empty;
            using (MemoryStream memory = new MemoryStream())
            {

                barcodeBitmap.Save(memory, ImageFormat.Jpeg);
                byte[] bytes = memory.ToArray();
                returndetails = Convert.ToBase64String(bytes);

            }
            return returndetails;
        }
    }
}
