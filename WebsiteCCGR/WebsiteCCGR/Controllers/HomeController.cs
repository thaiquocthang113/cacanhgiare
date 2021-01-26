using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteCCGR.Models;
using PagedList;

namespace MVC5_HelloWorld.Controllers
{
    public class HomeController : Controller
    {
        dbCCGRDataContext data = new dbCCGRDataContext();

        // GET: Home
        public ActionResult Index(int ? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 8;
            //var vatlieumoi = layvatlieumoi(9);
            return View(data.SANPHAMs.ToList().OrderBy(n => n.MASP).ToPagedList(pageNumber, pageSize));
        }
        public ActionResult SPTheoLoaiHang(int id)
        {
            var SANPHAM = from sp in data.SANPHAMs where sp.MALOAI == id select sp;
            return View(SANPHAM);
        }
    }
}
