using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;
using Web_FPT.Common;
using System.Text.RegularExpressions;



namespace Web_FPT.Controllers
{
    public class GioHangController : Controller
    {
        // GET: GioHang
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ThongTinKhachHang()
        {
            return View();
        }
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        public List<GioHang> LayGioHang()
        {
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang == null)
            {
                lstGioHang = new List<GioHang>();
                Session["GioHang"] = lstGioHang;
            }
            return lstGioHang;
        }

        public ActionResult ThemGioHang(string sMaSanPham, string strURL, FormCollection collection, SoLuongSanPham pd)
        {
            List<GioHang> lstGioHang = LayGioHang();
            GioHang item = lstGioHang.Find(n => n.masp == sMaSanPham);
            if (item == null)
            {

                item = new GioHang(sMaSanPham);
                lstGioHang.Add(item);


                return Redirect(strURL);

            }
            else
            {
                item.soluongSP++;
                return Redirect(strURL);
            }
        }
        public ActionResult GiamSoLuongGioHang(string sMaSanPham, string strURL, FormCollection collection, SoLuongSanPham pd)
        {
            List<GioHang> lstGioHang = LayGioHang();
            GioHang item = lstGioHang.Find(n => n.masp == sMaSanPham);
            item.soluongSP--;
            return Redirect(strURL);

        }
        private int TongSoLuong()
        {
            int iTongSoLuong = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang != null)
            {
                iTongSoLuong = lstGioHang.Sum(n => n.soluongSP);
            }
            return iTongSoLuong;
        }
        private double TongTien()
        {
            double iTongTien = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang != null)
            {
                iTongTien = lstGioHang.Sum(n => n.ThanhTien);
            }
            return iTongTien;
        }
        public ActionResult GioHang()
        {
            List<GioHang> lstGioHang = LayGioHang();

            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            if (lstGioHang.Count == 0)
            {
                Session["GioHangTrong"] = null;

            }
            else
            {
                Session["GioHangTrong"] = 1;

            }
            return View(lstGioHang);
        }
        public PartialViewResult GioHangViewPartial()
        {
            List<GioHang> lstGioHang = LayGioHang();

            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();

            return PartialView(lstGioHang);
        }
        public PartialViewResult GioHangPartial()
        {

            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            return PartialView();
        }
        public ActionResult XoaGioHang(string iMaSanPham)
        {
            List<GioHang> lstGioHang = LayGioHang();
            GioHang item = lstGioHang.SingleOrDefault(n => n.masp == iMaSanPham);
            if (item != null)
            {
                lstGioHang.RemoveAll(n => n.masp == iMaSanPham);
            }

            return RedirectToAction("GioHang");
        }
        public ActionResult ThongTinDonHang()
        {
            List<GioHang> lstGioHang = LayGioHang();
            List<SanPham> lstSanPham = new List<SanPham>();
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            if (lstGioHang.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }

            return View(lstGioHang);
        }

        //[HttpPost]
        //public ActionResult ThongTinDonHang(FormCollection collection, KHACHHANG kh, DONDATHANG ddh, CHITIETDONHANG ctdh, SANPHAM sp)
        //{

        //    var hotenkh = collection["hoten"];
        //    var email = collection["email"];
        //    var diachikh = collection["diachi"];
        //    var dienthoai = collection["sodienthoai"];
        //    var thanhpho = collection["thanhpho"];
        //    var ghichu = collection["ghichu"];
        //    var hinhthucthanhtoan = Request.Form["phuongthucthanhtoan"];
        //    var hinhthucgiaohang = Request.Form["phuongthucgiaohang"];
        //    var tongtien = TongTien();
        //    var ngaydat = DateTime.Now;


        //    var soluong = collection["soluong"];
        //    var dongia = collection["dongia"];
        //    var makh = (from khachhangs in db.KHACHHANGs orderby khachhangs.MAKH descending select new { MAKH = khachhangs.MAKH }).Take(1);

        //    string regexemail = @"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$";
        //    string regexten = @"~`!@#$%^&*()_-+=|\}]{[;:'?/>.<,123456789";
        //    int kqKiemTraSDT = kiemtraSDT(dienthoai);
        //    if (string.IsNullOrEmpty(hotenkh))
        //    {
        //        ViewData["LoiTen"] = "Họ tên không được để trống!";
        //    }

        //    else if (string.IsNullOrEmpty(dienthoai))
        //    {
        //        ViewData["LoiSDT"] = "Số điện thoại không được để trống!";
        //    }
        //    else if (string.IsNullOrEmpty(email))
        //    {
        //        ViewData["LoiEmail"] = "Email không được để trống!";
        //    }
        //    else if (string.IsNullOrEmpty(diachikh))
        //    {
        //        ViewData["LoiDiaChi"] = "Địa chỉ không được để trống!";
        //    }

        //    else if (!Regex.IsMatch(email, regexemail))
        //    {
        //        ViewData["LoiEmail"] = "Email không hợp lệ";
        //    }
        //    else if (hasSpecialChar(hotenkh))
        //    {
        //        ViewData["LoiTen"] = "Tên không hợp lệ";
        //    }
        //    else if (kqKiemTraSDT == 1)
        //    {
        //        ViewData["LoiSDT"] = "Số điện thoại phải đúng 10 kí tự";
        //    }
        //    else if (kqKiemTraSDT == 0)
        //    {
        //        ViewData["LoiSDT"] = "Số điện thoại không hợp lệ";
        //    }
        //    //else if (String.IsNullOrEmpty(thanhpho))
        //    //{
        //    //    ViewData["LoiThanhPho"] = "Thành phố không được để trống!";
        //    //}
        //    else
        //    {
        //        kh.HOTEN = hotenkh;
        //        kh.EMAIL = email;
        //        kh.DIACHIKH = diachikh;
        //        kh.DIENTHOAIKH = Convert.ToString(dienthoai);


        //        db.KHACHHANGs.InsertOnSubmit(kh);
        //        db.SubmitChanges();

        //        ddh.HINHTHUCGIAOHANG = hinhthucgiaohang;
        //        ddh.HINHTHUCTHANHTOAN = hinhthucthanhtoan;
        //        ddh.GHICHU = ghichu;
        //        ddh.TONGTIEN = Convert.ToDecimal(tongtien);
        //        ddh.NGAYDAT = ngaydat;
        //        foreach (var item in makh)
        //        {
        //            ddh.MAKH = Convert.ToInt32(item.MAKH);
        //        }


        //        ctdh.MASP = sp.MASP;
        //        ctdh.DONGIA = sp.GIA;
        //        ctdh.SOLUONG = TongSoLuong();
        //        ctdh.DONGIA = Convert.ToDecimal(dongia);

        //        db.DONDATHANGs.InsertOnSubmit(ddh);
        //        db.CHITIETDONHANGs.InsertOnSubmit(ctdh);
        //        db.SubmitChanges();

        //        return RedirectToAction("xacnhanDonHang", "GioHang");
        //    }
        //    return this.ThongTinDonHang();
        //}
        // Kiểm tra kí tự đặc biệt trong tên
        public static bool hasSpecialChar(string input)
        {
            string specialChar = @"\|!#$%&/()=?»«@£§€{}.-;'<>_,1234567890";
            foreach (var item in specialChar)
            {
                if (input.Contains(item)) return true;
            }

            return false;
        }
        // kí tự đặc biệt trừ số
        public static bool hasSpecialChar2(string input)
        {
            string specialChar = @"\|!#$%&/()=?»«@£§€{}.-;'<>_,";
            foreach (var item in specialChar)
            {
                if (input.Contains(item)) return true;
            }

            return false;
        }
        public int kiemtraSDT(string sdt)
        {
            if (sdt.Length != 10)
            {
                return 1; // không đủ 10 kí tự
            }
            if (hasSpecialChar2(sdt))
            {
                return 0;
            }
            // kiem tra chuoi co toan la chu so khong
            string[] so = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };
            int flag = 0;
            for (int i = 0; i < sdt.Length; i++)
            {

                string a = sdt.Substring(i, 1);
                for (int j = 0; j < so.Count(); j++)
                {
                    if (a.Equals(so[j].ToString()))
                    {
                        flag++;
                        break;
                    }

                }
            }
            if (flag != 10)
            {
                return 0;
            }
            // --------
            string dauso = "086,096,097,098,032,033,034,035,036,037,038,039,089,090,093,070,079,077,076,078,088,091,094,083,084,085,081,082,092,056,058,099,059";
            string[] arrDauSo = dauso.Split(',');

            string dausoInput = sdt.Substring(0, 3);

            for (int i = 0; i < arrDauSo.Count(); i++)
            {
                if (dausoInput.Equals(arrDauSo[i].ToString()))
                {
                    return 2; // đúng định dạng
                }
            }

            return 0; // sai
        }
        // Xác nhận thông tin đặt hàng thành công
        //public ActionResult xacnhanDonHang()
        //{
        //    XacNhanDonHang confirm = new XacNhanDonHang();

        //    List<GioHang> lstGioHang = LayGioHang();
        //    var makh = (from khachhangs in db.KHACHHANGs
        //                join ddh in db.DONDATHANGs on khachhangs.MAKH equals ddh.MAKH
        //                orderby khachhangs.MAKH descending
        //                select new { HoTen = khachhangs.HOTEN, DiaChi = khachhangs.DIACHIKH, SDT = khachhangs.DIENTHOAIKH, Email = khachhangs.EMAIL, PhuongThucGiaoHang = ddh.HINHTHUCGIAOHANG }).Take(1);
        //    ViewBag.TongSoLuong = TongSoLuong();


        //    confirm.lstGioHang = lstGioHang;
        //    foreach (var kh in makh)
        //    {
        //        confirm.hoten = kh.HoTen;
        //        confirm.diachi = kh.DiaChi;
        //        confirm.email = kh.Email;
        //        confirm.sdt = kh.SDT;
        //        confirm.ptgh = kh.PhuongThucGiaoHang;

        //    }
        //    if (confirm.ptgh.Equals("Giao hàng tiêu chuẩn"))
        //    {
        //        ViewBag.TongTien = TongTien() + 12000;
        //    }
        //    else
        //    {
        //        ViewBag.TongTien = TongTien() + 30000;
        //    }
        //    return View(confirm);

        //}

        public ActionResult xacnhanDonHangThanhCong(FormCollection collection)
        {


            string hoten = collection["HOTENKH"];
            if (LayGioHang() != null)
            {
                //Gửi mail
                string smtpUserName = "nguyenkimphung.060699@gmail.com";
                string smtpPassword = "phung99**";
                string smtpHost = "smtp.gmail.com";
                int smtpPort = 587;

                string emailTo = collection["EMAIL"];
                string subject = "Đơn hàng vừa mua";
                string body = string.Format("Bạn vừa nhận được liên hê từ: <b>{0}</b><br/>Email: {1}<br/>Cảm ơn bạn đã mua hàng tại website", "Admin ", "");

                EmailService service = new EmailService();
                bool kq = service.Send(smtpUserName, smtpPassword, smtpHost, smtpPort, emailTo, subject, body);
                //Session[CartSession.CartSesstion] = null;
                //message = 1;

                LayGioHang().RemoveRange(0, LayGioHang().Count);

            }
            return RedirectToAction("Index", "Home");
        }        
    }
}