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
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        // GET: GioHang
        public ActionResult ThongTinKhachHang()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ThongTinKhachHang(FormCollection collection)
        {
            var sdt = collection["SoDT"];
            if (kiemtraSDT(sdt)== 0){
                ViewData["Loi5"] = "Sai định dạng";
            }
            return View();
        }
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
                    return 1; // đúng định dạng
                }
            }

            return 0; // sai
        }

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
                string body = string.Format("Bạn vừa nhận được liên hệ từ cửa hàng FPTshop.com.vn: <b>{0}</b><br/>Email: {1}<br/>" + " Xin chào quý khách, Chúng tôi, xin thông báo đơn hàng của quý khách đã được xác nhận.Đơn hàng sẽ được giao đến tận tay quý khách từ 2 - 3 ngày. Xin chân thành cảm ơn quý khách đã sử dụng dịch vụ của công ty chúng tôi.Chúc quý khách một ngày tốt lành.! Mọi thắc mắc xin liên hệ website: Fptshop.vn.comHoặc góp ý khiếu nại dịch vụ(8h00 - 22h00): 1800 6616. Cảm ơn bạn đã mua hàng tại website", "Admin ", "");

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