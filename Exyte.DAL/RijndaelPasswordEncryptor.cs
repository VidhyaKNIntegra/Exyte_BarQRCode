namespace Exyte.DAL
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Security.Cryptography;
    using System.Text;

    /// <summary>
    /// Class for the encryption and decryption of the plain text
    /// </summary>
    public class RijndaelEncryptor
    {
        /// <summary>
        /// Passphrase from which a pseudo-random password will be derived
        /// </summary>
        private static string PassPhrase = "P@s5pr@se";

        /// <summary>
        /// Salt value used along with passphrase to generate password
        /// </summary>
        private static string SaltValue = "s@1tValue";

        /// <summary>
        /// Hash algorithm used to generate password. Default is MD5
        /// </summary>
        private static string HashAlgorithm = "MD5";

        /// <summary>
        /// Number of iterations used to generate password. Default is 2
        /// </summary>
        private static int PasswordIterations = 2;

        /// <summary>
        /// Initialization vector (or IV). This value is required to encrypt the
        /// first block of plaintext data. The value must be 16 bytes
        /// </summary>
        private static string InitVector = "A1B2C3D4E5F6G7H8";

        /// <summary>
        /// Size of encryption key in bits. Allowed values are: 128, 192, and 256. Default is 256
        /// </summary>
        private static int KeySize = 256;

        /// <summary>
        /// Encrypts specified plaintext using Rijndael symmetric key algorithm
        /// and returns a base64-encoded result.
        /// </summary>
        /// <param name="plainText">
        /// Plaintext value to be encrypted.
        /// </param>
        /// <returns>
        /// Encrypted value formatted as a base64-encoded string.
        /// </returns>
        public static string Encrypt(string plainText)
        {
            //// Convert strings into byte arrays.
            //// Let us assume that strings only contain ASCII codes.
            //// If strings include Unicode characters, use Unicode, UTF7, or UTF8 
            //// encoding.
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(RijndaelEncryptor.InitVector);
            byte[] saltValueBytes = Encoding.ASCII.GetBytes(RijndaelEncryptor.SaltValue);

            //// Convert our plaintext into a byte array.
            //// Let us assume that plaintext contains UTF8-encoded characters.
            byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

            //// First, we must create a password, from which the key will be derived.
            //// This password will be generated from the specified passphrase and 
            //// salt value. The password will be created using the specified hash 
            //// algorithm. Password creation can be done in several iterations.
            PasswordDeriveBytes password = new PasswordDeriveBytes(
                                                            RijndaelEncryptor.PassPhrase,
                                                            saltValueBytes,
                                                            RijndaelEncryptor.HashAlgorithm,
                                                            RijndaelEncryptor.PasswordIterations);

            //// Use the password to generate pseudo-random bytes for the encryption
            //// key. Specify the size of the key in bytes (instead of bits).
            byte[] keyBytes = password.GetBytes(RijndaelEncryptor.KeySize / 8);

            //// Create uninitialized Rijndael encryption object.
            RijndaelManaged symmetricKey = new RijndaelManaged();

            //// It is reasonable to set encryption mode to Cipher Block Chaining
            //// (CBC). Use default options for other symmetric key parameters.
            symmetricKey.Mode = CipherMode.CBC;

            //// Generate encryptor from the existing key bytes and initialization 
            //// vector. Key size will be defined based on the number of the key 
            //// bytes.
            ICryptoTransform encryptor = symmetricKey.CreateEncryptor(
                                                             keyBytes,
                                                             initVectorBytes);

            //// Define memory stream which will be used to hold encrypted data.
            MemoryStream memoryStream = new MemoryStream();

            //// Define cryptographic stream (always use Write mode for encryption).
            CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write);
            //// Start encrypting.
            cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);

            //// Finish encrypting.
            cryptoStream.FlushFinalBlock();

            //// Convert our encrypted data from a memory stream into a byte array.
            byte[] cipherTextBytes = memoryStream.ToArray();

            //// Close both streams.
            memoryStream.Close();
            cryptoStream.Close();

            //// Convert encrypted data into a base64-encoded string.
            string cipherText = Convert.ToBase64String(cipherTextBytes);

            //// Return encrypted string.
            return cipherText;
        }

        /// <summary>
        /// Decrypts specified ciphertext using Rijndael symmetric key algorithm.
        /// </summary>
        /// <param name="cipherText">
        /// Base64-formatted ciphertext value.
        /// </param>
        /// <returns>
        /// Decrypted string value.
        /// </returns>
        /// <remarks>
        /// Most of the logic in this function is similar to the Encrypt
        /// logic. In order for decryption to work, all parameters of this function
        /// - except cipherText value - must match the corresponding parameters of
        /// the Encrypt function which was called to generate the
        /// ciphertext.
        /// </remarks>
        public static string Decrypt(string cipherText)
        {
            //// Convert strings defining encryption key characteristics into byte
            //// arrays. Let us assume that strings only contain ASCII codes.
            //// If strings include Unicode characters, use Unicode, UTF7, or UTF8
            //// encoding.
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(RijndaelEncryptor.InitVector);
            byte[] saltValueBytes = Encoding.ASCII.GetBytes(RijndaelEncryptor.SaltValue);

            //// Convert our ciphertext into a byte array.
            byte[] cipherTextBytes = Convert.FromBase64String(cipherText);

            //// First, we must create a password, from which the key will be 
            //// derived. This password will be generated from the specified 
            //// passphrase and salt value. The password will be created using
            //// the specified hash algorithm. Password creation can be done in
            //// several iterations.
            PasswordDeriveBytes password = new PasswordDeriveBytes(
                                                            RijndaelEncryptor.PassPhrase,
                                                            saltValueBytes,
                                                            RijndaelEncryptor.HashAlgorithm,
                                                            RijndaelEncryptor.PasswordIterations);

            //// Use the password to generate pseudo-random bytes for the encryption
            //// key. Specify the size of the key in bytes (instead of bits).
            byte[] keyBytes = password.GetBytes(RijndaelEncryptor.KeySize / 8);

            //// Create uninitialized Rijndael encryption object.
            RijndaelManaged symmetricKey = new RijndaelManaged();

            //// It is reasonable to set encryption mode to Cipher Block Chaining
            //// (CBC). Use default options for other symmetric key parameters.
            symmetricKey.Mode = CipherMode.CBC;

            //// Generate decryptor from the existing key bytes and initialization 
            //// vector. Key size will be defined based on the number of the key 
            //// bytes.
            ICryptoTransform decryptor = symmetricKey.CreateDecryptor(
                                                             keyBytes,
                                                             initVectorBytes);

            //// Define memory stream which will be used to hold encrypted data.
            MemoryStream memoryStream = new MemoryStream(cipherTextBytes);

            //// Define cryptographic stream (always use Read mode for encryption).
            CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read);

            //// Since at this point we don't know what the size of decrypted data
            //// will be, allocate the buffer long enough to hold ciphertext;
            //// plaintext is never longer than ciphertext.
            byte[] plainTextBytes = new byte[cipherTextBytes.Length];

            //// Start decrypting.
            int decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);

            //// Close both streams.
            memoryStream.Close();
            cryptoStream.Close();

            //// Convert decrypted data into a string. 
            //// Let us assume that the original plaintext string was UTF8-encoded.
            string plainText = Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount);

            //// Return decrypted string.   
            return plainText;
        }
        public static string dynamicTypeEncryption(string val,Type type,bool encrypt)
        {
            var encryptVal = 5;
            if (type == typeof(System.Int16))
                return encrypt?(Convert.ToInt16(val)* encryptVal).ToString(): (Convert.ToInt16(val) / encryptVal).ToString();
            else if (type == typeof(System.Int32))
                return encrypt ? (Convert.ToInt32(val)* encryptVal).ToString(): (Convert.ToInt32(val) / encryptVal).ToString();
            else if (type == typeof(System.Int64))
                return encrypt ? (Convert.ToInt64(val)* encryptVal).ToString(): (Convert.ToInt64(val) / encryptVal).ToString();
            else if (type == typeof(System.Decimal))
                return encrypt==true ? (Convert.ToDecimal(val)* encryptVal).ToString(): (Convert.ToDecimal(val) / encryptVal).ToString();
            else if (type == typeof(System.Double))
                return encrypt ? (Convert.ToDouble(val)* encryptVal).ToString(): (Convert.ToDouble(val) / encryptVal).ToString();
            else if (type == typeof(System.Single))
                return encrypt ? (Convert.ToSingle(val)* encryptVal).ToString(): (Convert.ToSingle(val) / encryptVal).ToString();
            else
                return val;
        }
        public static string convertNumberToString(String source)
        {
            //String source = num.ToString();
            String str = "";
            for (int i = 0; i < source.Length; i++)
            {
                switch (source[i])
                {
                    case '1':
                        str = str + "5";
                        break;
                    case '2':
                        str = str + "6";
                        break;
                    case '3':
                        str = str + "8";
                        break;
                    case '4':
                        str = str + "9";
                        break;
                    case '5':
                        str = str + "1";
                        break;
                    case '6':
                        str = str + "2";
                        break;
                    case '7':
                        str = str + "7";
                        break;
                    case '8':
                        str = str + "3";
                        break;
                    case '9':
                        str = str + "4";
                        break;
                    case '0':
                        str = str + "0";
                        break;
                    case '.':
                        str = str + ".";
                        break;
                }
            }
            return str;
        }
    }
}