using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteCCGR.Models;
using PagedList.Mvc;
using PagedList;
using System.IO;
using System.Data;

namespace WebsiteCCGR.Controllers
{
    public class NguoidungController : Controller
    {
        dbCCGRDataContext data = new dbCCGRDataContext();
        // GET: Nguoidung
        [HttpGet]
        public ActionResult Dangky()
        {
            return View();
        }
        // POST: Hàm Dangky(post) Nhận dữ liệu từ trang Dangky và thực hiện việc tạo mới dữ liệu
        [HttpPost]
        public ActionResult Dangky(FormCollection collection, KHACHHANG kh)
        {
            // Gán các giá trị người dùng nhập liệu cho các biến
            var hoten = collection["HotenKH"];
            var tendn = collection["TenDN"];
            var matkhau = collection["Matkhau"];
            var matkhaunhaplai = collection["Matkhaunhaplai"];
            var email = collection["Email"];
            var diachi = collection["Diachi"];
            var dienthoai = collection["Dienthoai"];
            var ngaysinh = string.Format("{0:MM/dd/yyyy}", collection["Ngaysinh"]);
            if (string.IsNullOrEmpty(hoten))
            {
                ViewData["Loi1"] = "Họ tên khách hàng không được để trống";
            }
            else if (string.IsNullOrEmpty(tendn))
            {
                ViewData["Loi2"] = "Phải nhập tên đăng nhập";
            }
            else if (string.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi3"] = "Phải nhập mật khẩu";
            }
            else if (string.IsNullOrEmpty(matkhaunhaplai))
            {
                ViewData["Loi4"] = "Phải nhập lại mật khẩu";
            }
            if (string.IsNullOrEmpty(email))
            {
                ViewData["Loi5"] = "Email không được bỏ trống";
            }
            if (string.IsNullOrEmpty(dienthoai))
            {
                ViewData["Loi7"] = "Phải nhập lại điện thoại";
            }
            else
            {
                // Gán giá trị cho đối tượng được tạo mới (kh)
                kh.HOTEN = hoten;
                kh.TAIKHOAN = tendn;
                kh.MATKHAU = matkhau;
                kh.EMAIL = email;
                kh.DIACHIKH = diachi;
                kh.DIENTHOAIKH = dienthoai;
                kh.NGAYSINH = DateTime.Parse(ngaysinh);
                data.KHACHHANGs.InsertOnSubmit(kh);
                data.SubmitChanges();

                return RedirectToAction("Dangnhap");

            }
            return this.Dangky();

        }

        [HttpGet]
        public ActionResult Dangnhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Dangnhap(FormCollection collection)
        {
            // Gán các giá trị người dùng nhập liệu cho các biến
            var tendn = collection["TenDN"];
            var matkhau = collection["Matkhau"];
            if (string.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Phải nhập tên đăng nhập";
            }
            else if (String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Phải nhập mật khẩu";
            }
            else
            {
                // Gán giá trị cho đối tượng tạo mới (kh)
                KHACHHANG kh = data.KHACHHANGs.SingleOrDefault(n => n.TAIKHOAN == tendn && n.MATKHAU == matkhau);
                if (kh != null)
                {
                    Session["Username"] = kh.HOTEN;
                    Session["IDKH"] = kh.MAKH;
                    Session["Taikhoan"] = kh;
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ViewBag.Thongbao = "Đăng nhập thất bại";
                }
            }
            return View();
        }
        public ActionResult DangXuat()
        {
            Session.Clear();
            return RedirectToAction("Index", "Home");
        }
    }
}