using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Exyte_Barcode.Util
{
    public class CustomExceptionHandlerFilter : FilterAttribute, IExceptionFilter
    {
        log4net.ILog logger = log4net.LogManager.GetLogger(typeof(CustomExceptionHandlerFilter));
        public void OnException(ExceptionContext filterContext)
        {
            //logger.Error(filterContext.Exception.Message);
            logger.Error("Unhandled Exception: " + filterContext.Exception);
            filterContext.ExceptionHandled = true;

            //filterContext.Result = new ViewResult()
            //{
            //    ViewName = "Error"
            //};


        }
    }
}