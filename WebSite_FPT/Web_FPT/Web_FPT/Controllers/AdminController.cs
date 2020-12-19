using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;

namespace Web_FPT.Controllers
{
    public class AdminController : Controller
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        // GET: Admin
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(FormCollection collection)
        {
            var tendn = collection["userName"];
            var matkhau = collection["password"];
            if (string.IsNullOrEmpty(tendn))
                ViewData["Loi1"] = "Tên đăng nhập không được để trống!";
            if (string.IsNullOrEmpty(matkhau))
                ViewData["Loi2"] = "Mật khẩu không được để trống!";
            else
            {
                //ChucVu chucVu = 
                if (tendn == "admin" && matkhau == "12345")
                {
                    Session["AdminIsLogin"] = true;
                    return RedirectToAction("Admin", "Admin");
                }
                else
                {
                    ViewData["Loi"] = "Tài khoản hoặc mật khẩu sai";
                }
                return View();
            }
            return View();
        }

        public ActionResult Admin()
        {
            if (Session["AdminIsLogin"] != null)
            {
                var sp = fpt.SanPhams.ToList();
                return View(sp);
            }
            else
            {
                return RedirectToAction("DangNhap", "Admin");
            }
        }
    }
}