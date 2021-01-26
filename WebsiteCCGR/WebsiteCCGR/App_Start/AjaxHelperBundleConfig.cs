using System.Web.Optimization;

[assembly: WebActivatorEx.PostApplicationStartMethod(typeof(WebsiteCCGR.App_Start.AjaxHelperBundleConfig), "RegisterBundles")]

namespace WebsiteCCGR.App_Start
{
	public class AjaxHelperBundleConfig
	{
		public static void RegisterBundles()
		{
			BundleTable.Bundles.Add(new ScriptBundle("~/bundles/ajaxhelper").Include("~/Scripts/jquery.ajaxhelper.js"));
		}
	}
}