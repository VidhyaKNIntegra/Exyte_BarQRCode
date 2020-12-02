using System.Web;
using System.Web.Optimization;

namespace Exyte_Barcode
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            #region application js

            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                       "~/Scripts/jquery/dist/jquery.min.js"));


            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                       "~/Scripts/bootstrap/dist/js/bootstrap.bundle.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/scrollbar").Include(
                      "~/Scripts/perfect-scrollbar/dist/perfect-scrollbar.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/slide").Include(
                     "~/Scripts/bigslide/dist/bigSlide.min.js"));


            bundles.Add(new ScriptBundle("~/bundles/functions").Include(
             "~/Scripts/functions.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryWizardMin").Include(
            "~/Scripts/jquery/dist/jquery.bootstrap.wizard.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/formWizard").Include(
                "~/Content/custom/form-wizard.js"));
            bundles.Add(new ScriptBundle("~/bundles/sweetAlert").Include(
                 "~/Scripts/sweetalert.min.js"));
            bundles.Add(new ScriptBundle("~/bundles/select2").Include(
                "~/Content/custom/select2/select2.full.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryValidateMin").Include(
                 "~/Scripts/jquery/dist/jquery.validate.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/DataTable").Include(
             "~/Scripts/datatables.net/js/jquery.dataTables.js",
             "~/Scripts/datatables.net-bs4/js/dataTables.bootstrap4.js"));

            bundles.Add(new ScriptBundle("~/bundles/knockout").Include(
                      "~/Scripts/knockout-3.5.0.js"));

            bundles.Add(new ScriptBundle("~/bundles/Elements").Include(
              "~/Scripts/Elements/Elements.js"));




            #endregion

            #region application styles
            //bundles.Add(new ScriptBundle("~/Content/DataTable").Include(
            //   "~/Scripts/DataTable/jquery.dataTables.css"));
            bundles.Add(new ScriptBundle("~/Content/DataTable").Include(
              "~/Scripts/datatables.net-bs4/css/dataTables.bootstrap4.css"));

            bundles.Add(new StyleBundle("~/fonts/fonts").Include(
                     "~/fonts/material-design-iconic-font/css/material-design-iconic-font.min.css",
                     "~/fonts/weather-icons-master/css/weather-icons.min.css"));

            bundles.Add(new StyleBundle("~/Content/bootstrap").Include(
                     "~/Content/jumbo-bootstrap.css",
                     "~/Content/jumbo-core.min.css",
                     "~/Content/theme-dark-indigo.css",
                     "~/Content/jumbo-forms.css",
                     "~/Content/SweetAlert/sweetalert.css",
                     "~/Content/style.css"));

            bundles.Add(new StyleBundle("~/Content/scrollbar").Include(
                     "~/Content/perfect-scrollbar/css/perfect-scrollbar.css"));

            bundles.Add(new StyleBundle("~/Content/select2").Include(
                    "~/Content/custom/select2/select2.min.css"));
            // //chart css
            //bundles.Add(new StyleBundle("~/Content/chart").Include(
            //         "~/Content/c3/c3.min.css",
            //         "~/Content/chartist/dist/chartist.min.css"));
            #endregion

            #region default style
            //bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
            //            "~/Scripts/jquery-{version}.js"));

            //bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
            //            "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            //bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
            //            "~/Scripts/modernizr-*"));

            //bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
            //          "~/Scripts/bootstrap.js"));

            //bundles.Add(new StyleBundle("~/Content/css").Include(
            //          "~/Content/bootstrap.css",
            //          "~/Content/site.css"));

            #endregion
        }
    }
}
