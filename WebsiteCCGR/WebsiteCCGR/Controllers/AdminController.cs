using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteCCGR.Models;
using PagedList.Mvc;
using PagedList;
using System.IO;
namespace WebsiteVLXD.Controllers
{
    public class AdminController : Controller
    {
        dbCCGRDataContext data = new dbCCGRDataContext();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(FormCollection collection)
        {
            var tendn = collection["username"];
            var matkhau = collection["password"];
            if (string.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Phải nhập tên đăng nhập";
            }
            else if (string.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Phải nhập mật khẩu";
            }
            else
            {
                Admin ad = data.Admins.SingleOrDefault(n => n.UserAdmin == tendn && n.PassAdmin == matkhau);
                if (ad != null)
                {
                    Session["Taikhoanadmin"] = ad;
                    return RedirectToAction("Index", "Admin");
                }
                else
                    ViewBag.ThongBao = "Tên đăng nhập hoặc mật khẩu không đúng";
            }
            return View();
        }

        public ActionResult SanPham(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 10;
            //return View(data.SANPHAMs.ToList());
            return View(data.SANPHAMs.ToList().OrderBy(n => n.MASP).ToPagedList(pageNumber, pageSize));
        }
        [HttpGet]
        public ActionResult ThemSanPham()
        {
            ViewBag.MALOAI = new SelectList(data.LOAIHANGs.ToList().OrderBy(n => n.TENLOAI), "MALOAI", "TENLOAI");
            ViewBag.MANCC = new SelectList(data.NCCs.ToList().OrderBy(n => n.TENNCC), "MANCC", "TENNCC");
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ThemSanPham(SANPHAM sp, HttpPostedFileBase uploadfile)
        {
            //Dua du lieu vao thanh truot
            ViewBag.MALOAI = new SelectList(data.LOAIHANGs.ToList().OrderBy(n => n.TENLOAI), "MALOAI", "TENLOAI");
            ViewBag.MANCC = new SelectList(data.NCCs.ToList().OrderBy(n => n.TENNCC), "MANCC", "TENNCC");
            //Luu Ten file
            if (ModelState.IsValid)
            {
                var filename = Path.GetFileName(uploadfile.FileName);
                //Luu duong dan file
                var path = Path.Combine(Server.MapPath("~/HinhAnhSanPham"), filename);
                //Kiem Tra Hinh anh ton tai chua
                if (System.IO.File.Exists(path))
                {
                    ViewBag.ThongBao = "Hình ảnh đã tồn tại";
                }
                else
                {
                    //Luu hinh anh vao duong dan
                    uploadfile.SaveAs(path);
                }
                sp.ANH = filename;
                sp.ANHMAU = filename;
                //Luu vao csdl
                data.SANPHAMs.InsertOnSubmit(sp);
                data.SubmitChanges();
            }
            return RedirectToAction("SanPham");
        }
        public ActionResult DetailsSanPham(int id)
        {
            //lay ra doi tuong sach theo ma
            SANPHAM sp = data.SANPHAMs.SingleOrDefault(n => n.MASP == id);
            ViewBag.MASP = sp.MASP;
            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sp);
        }

        [HttpGet]
        public ActionResult DeleteSanPham(int id)
        {
            //lay ra doi tuong sach theo ma
            SANPHAM sp = data.SANPHAMs.SingleOrDefault(n => n.MASP == id);
            ViewBag.MASP = sp.MASP;
            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sp);
        }

        [HttpPost, ActionName("DeleteSanPham")]
        public ActionResult XacNhanXoa(int id)
        {
            //Lấy ra đối tượng cần xóa theo mã
            SANPHAM sp = data.SANPHAMs.SingleOrDefault(n => n.MASP == id);
            ViewBag.MASP = sp.MASP;
            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            data.SANPHAMs.DeleteOnSubmit(sp);
            data.SubmitChanges();
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult EditSanPham(int id)
        {
            //Lấy ra đối tượng cần xóa theo mã
            SANPHAM sp = data.SANPHAMs.SingleOrDefault(n => n.MASP == id);

            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            ViewBag.MALOAI = new SelectList(data.LOAIHANGs.ToList().OrderBy(n => n.TENLOAI), "MALOAI", "TENLOAI", sp.MALOAI);
            ViewBag.MANCC = new SelectList(data.NCCs.ToList().OrderBy(n => n.TENNCC), "MANCC", "TENNCC", sp.MANCC);
            return View(sp);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult EditSanPham(HttpPostedFileBase uploadfile, HttpPostedFileBase uploadfile1, FormCollection c, int id)
        {
            //Dua du lieu vao thanh truot
            ViewBag.MALOAI = new SelectList(data.LOAIHANGs.ToList().OrderBy(n => n.TENLOAI), "MALOAI", "TENLOAI");
            ViewBag.MANCC = new SelectList(data.NCCs.ToList().OrderBy(n => n.TENNCC), "MANCC", "TENNCC");
            //Luu Ten file
            if (ModelState.IsValid)
            {
                var filename = Path.GetFileName(uploadfile.FileName);
                var filename1 = Path.GetFileName(uploadfile1.FileName);
                //Luu duong dan file
                var path = Path.Combine(Server.MapPath("~/HinhAnhSanPham"), filename);
                //Kiem Tra Hinh anh ton tai chua
                if (System.IO.File.Exists(path))
                {
                    ViewBag.ThongBao = "Hình ảnh đã tồn tại";
                }
                else
                {
                    //Luu hinh anh vao duong dan
                    uploadfile.SaveAs(path);
                    //====================

                }
                //Luu vao csdl
                //UpdateModel(sp);

                SANPHAM sp = data.SANPHAMs.SingleOrDefault(n => n.MASP == id);
                sp.GIABAN = Convert.ToDecimal(c["giaban"]);
                sp.SLTON = Convert.ToInt32(c["soluong"]);
                sp.TENSP = c["tensp"];
                sp.NGAYNHAP = Convert.ToDateTime(c["NGAYNHAP"]);
                sp.ANH = filename;
                sp.ANHMAU = filename1;
                data.SubmitChanges();
            }
            return RedirectToAction("SanPham");
        }
    }
}