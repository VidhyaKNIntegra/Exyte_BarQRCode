using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LiteDrive.Exceptions
{
    public class AppException : Exception
    {
        public const string ERR_GET_RESOURCEMSG = "General Error";
        /// <summary>
        /// Error message code
        /// </summary>
        public string msgCode { get; set; }

        /// <summary>
        /// Arguments to pass to the exception string
        /// </summary>
        public object[] msgArgs { get; set; }

        /// <summary>
        /// Actual exception
        /// </summary>
        public Exception oldException { get; set; }

        /// <summary>
        /// Initializes a new instance of the AppException class.
        /// </summary>
        /// <param name="msgCode">Error message code</param>
        /// <param name="msgArgs">Arguments to pass to the exception string</param>
        /// <param name="ex">Actual exception</param>
        public AppException(string msgCode, object[] msgArgs, Exception ex)
        {
            this.msgCode = msgCode;
            this.oldException = ex;
            this.msgArgs = msgArgs;
        }

        /// <summary>
        /// Initializes a new instance of the AppException class
        /// </summary>
        /// <param name="msgCode">Error message code</param>
        /// <param name="ex">Actual exception</param>
        public AppException(string msgCode, Exception ex)
        {
            this.msgCode = msgCode;
            this.oldException = ex;
            this.msgArgs = null;
        }

    }
}
