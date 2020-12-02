using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LiteDrive.Exceptions
{
    public class LogError
    {
        public enum LogLevel : short
        {
            /// <summary>
            /// The debug level
            /// </summary>
            Debug = 0,

            /// <summary>
            /// The info level
            /// </summary>
            Info = 1,

            /// <summary>
            /// The warn level
            /// </summary>
            Warn = 2,

            /// <summary>
            /// The error level
            /// </summary>
            Error = 3,

            /// <summary>
            /// The fatal level
            /// </summary>
            Fatal = 4,
        }
        private static ILog log = LogManager.GetLogger(typeof(LogError));
        /// <summary>
        /// This function will give the error message from the exception. 
        /// If the exception is of EASException type then it will retrive the message from the resource.
        /// Else gives the actual message from the exception
        /// </summary>
        /// <param name="ex">The exception for which the message to be retrieved</param>
        /// <returns>The error message</returns>
        public static string GetErrorMessage(Exception ex)
        {
            string strErrorMessage = string.Empty;
            try
            {
                if (ex != null)
                {
                    if (ex is AppException)
                    {
                        AppException appEx = ex as AppException;
                        if (appEx.msgArgs != null && appEx.msgArgs.Length > 0)
                        {
                            strErrorMessage = appEx.msgCode;
                            //Resource.GetResourceValue(appEx.msgCode, appEx.msgArgs, Resource.MessageResourceFile);
                        }
                        else
                        {
                            strErrorMessage = appEx.msgCode;
                            //Resource.GetResourceValue(appEx.msgCode, Resource.MessageResourceFile);
                        }
                    }
                    else
                    {
                        strErrorMessage = AppException.ERR_GET_RESOURCEMSG;
                        //Resource.GetResourceValue(AppException.ERR_GET_RESOURCEMSG, Resource.MessageResourceFile);
                    }
                }
            }
            catch (Exception)
            {
                strErrorMessage = AppException.ERR_GET_RESOURCEMSG; 
                // Resource.GetResourceValue(EASException.ERR_GET_RESOURCEMSG, Resource.MessageResourceFile);
            }

            return strErrorMessage;
        }

        /// <summary>
        /// This function will log the exception using log4net
        /// </summary>
        /// <param name="ex">Exception to be logged</param>
        public static void LogErrors(Exception ex)
        {
            try
            {
                if (ex is AppException)
                {
                    AppException baseException = (AppException)ex;
                    log.Error(baseException.msgCode);
                    log.Error(baseException.oldException.Message + " " + baseException.oldException.StackTrace, baseException);
                }
                else
                {
                    log.Error(ex.Message + " " + ex.StackTrace, ex);
                }

                if (ex.InnerException != null)
                {
                    log.Error(ex.InnerException.Message + " " + ex.InnerException.StackTrace, ex.InnerException);
                }
            }
            catch (Exception)
            {
            }
        }

        /// <summary>
        /// This function will written the complete error message in the exception 
        /// </summary>
        /// <param name="ex">return complete message in the Exception</param>
        public static string GetLogMessage(Exception ex)
        {
            StringBuilder sb = new StringBuilder();
            try
            {
                if (ex is AppException)
                {
                    AppException baseException = (AppException)ex;
                    sb.Append(baseException.msgCode).Append(" ");
                    sb.Append(baseException.oldException.Message).Append(" ").Append(baseException.oldException.StackTrace);
                }
                else
                {
                    sb.Append(ex.Message).Append(" ").Append(ex.StackTrace);
                }

                if (ex.InnerException != null)
                {
                    sb.Append(ex.InnerException.Message).Append(" ").Append(ex.InnerException.StackTrace);
                }
            }
            catch (Exception)
            {
            }
            return sb.ToString();
        }

        /// <summary>
        /// This function will log the exception using log4net
        /// </summary>
        /// <param name="ex">Exception to be logged</param>
        /// <param name="level">The level of the log. The level can be DEBUG,INFO, WARN, ERROR, FATAL </param>
        public static void LogMessage(Exception ex, LogLevel level)
        {
            try
            {
                if (ex is AppException)
                {
                    AppException baseException = (AppException)ex;
                    switch (level)
                    {
                        case LogLevel.Debug:
                            log.Debug(baseException.msgCode);
                            log.Debug(baseException.oldException.Message + " " + baseException.oldException.StackTrace, baseException);
                            break;
                        case LogLevel.Info:
                            log.Info(baseException.msgCode);
                            log.Info(baseException.oldException.Message + " " + baseException.oldException.StackTrace, baseException);
                            break;
                        case LogLevel.Warn:
                            log.Warn(baseException.msgCode);
                            log.Warn(baseException.oldException.Message + " " + baseException.oldException.StackTrace, baseException);
                            break;
                        case LogLevel.Error:
                            log.Error(baseException.msgCode);
                            log.Error(baseException.oldException.Message + " " + baseException.oldException.StackTrace, baseException);
                            if (baseException.oldException.InnerException != null)
                            {
                                log.Error(baseException.oldException.InnerException.Message + " " + baseException.oldException.InnerException.StackTrace, baseException.oldException.InnerException);
                            }

                            break;
                        case LogLevel.Fatal:
                            log.Fatal(baseException.msgCode);
                            log.Fatal(baseException.oldException.Message + " " + baseException.oldException.StackTrace, baseException);
                            if (baseException.oldException.InnerException != null)
                            {
                                log.Error(baseException.oldException.InnerException.Message + " " + baseException.oldException.InnerException.StackTrace, baseException.oldException.InnerException);
                            }

                            break;
                    }
                }
                else
                {
                    switch (level)
                    {
                        case LogLevel.Debug:                            
                            log.Debug(ex.Message + " " + ex.StackTrace, ex);
                            break;
                        case LogLevel.Info:
                            log.Info(ex.Message + " " + ex.StackTrace, ex);
                            break;
                        case LogLevel.Warn:
                            log.Warn(ex.Message + " " + ex.StackTrace, ex);
                            break;
                        case LogLevel.Error:
                            log.Error(ex.Message + " " + ex.StackTrace, ex);
                            if (ex.InnerException != null)
                            {
                                log.Error(ex.InnerException.Message + " " + ex.InnerException.StackTrace, ex.InnerException);
                            }

                            break;
                        case LogLevel.Fatal:
                            log.Fatal(ex.Message + " " + ex.StackTrace, ex);
                            break;
                    }
                }
            }
            catch (Exception)
            {
            }
        }
    }
}
