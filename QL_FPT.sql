CREATE DATABASE  QL_FPT
GO

USE QL_FPT
GO
--Drop table ChucVu

Create table ChucVu
(
	MaPQ VarChar(5),
	TenChucVu Nvarchar(max),
	Constraint PK_MaPQ_ChucVu Primary key(MaPQ)
)
GO

Create table NhanVien
(
	MaNV Char(5),
	TenNV NVarChar(max),
	GioiTinhNV Bit,
	NgaySinhNV Date,
	EmailNV VarChar(40),
	SDTNV int,
	DiaChiNV NVarChar(max),
	MatKhauNV VarChar(20),
	MaPQ VarChar(5),
	TinhTrang bit,
	Constraint PK_MaNV_NhanVien Primary key(MaNV),
	Constraint FK_MaPQ_NhanVien Foreign key(MaPQ) References ChucVu(MaPQ)
)
GO
--drop table KhachHang

Create table KhachHang
(
	MaKH Char(5),
	TenKH NVarChar(max),
	GioiTinhKH Bit,
	NgaySinhKH Date,
	EmailKH VarChar(40),
	SDTKH int,
	DiaChiKH NVarChar(max),
	TinhTrang bit,
	Constraint PK_MaKH_KhachHang Primary key(MaKH)
)
GO

Create table NhomSanPham
(
	MaNhomSP Char(5),
	TenNSP NVarChar(max),
	TinhTrang bit,
	Constraint PK_MaNhomSP_NhomSanPham Primary key(MaNhomSP)
)
GO

Create table Hang
(
	MaHang Char(5),
	TenHang NVarChar(max),
	MaNhomSP Char(5),
	TinhTrang bit,
	Constraint PK_MaHang_Hang Primary key(MaHang),
	Constraint FK_MaNhomSP_Hang Foreign key(MaNhomSP) References NhomSanPham(MaNhomSP)

)
GO


Create table SanPham
(
	MaSP Char(5),
	TenSP NVarChar(max),
	SoLuong int,
	GiaBan int,
	HinhAnh NVarChar(10),
	TrangThai NVarChar(max),
	MaNhomSP Char(5),
	MaHang Char(5),
	TinhTrang bit,
	Constraint PK_MaSP_SanPham Primary key(MaSP),
	Constraint FK_MaNhomSP_SanPham Foreign key(MaNhomSP) References NhomSanPham(MaNhomSP),
	Constraint FK_MaHang_SanPham Foreign key(MaHang) References Hang(MaHang)
)
GO


Create table ChiTietSanPham
(
	MaSP Char(5),
	MaNhomSP Char(5),
	ManHinh NVarChar(max),
	Camara NVarChar(max),
	OCung NVarChar(max),
	Ram NVarChar(max),
	HeDieuHanh NVarChar(max),
	CPU NVarChar(max),
	BoNhoTrong NVarChar(max),
	DungLuong NVarChar(max),  
	DoPhanGiai NVarChar(max),
	KetNoi NVarChar(max),
	TinhNang NVarChar(max),
	DongMayTuongThich NVarChar(max),
	CuPhap NVarChar(max),
	TocDoDoc Char(5),
	MauSac NVarChar(max),
	ThuongHieu NVarChar(max),
	ChatLieu NVarChar(max),
	XuatXu NVarChar(max),
	BaoHanh NVarChar(max),
	Constraint Pk_MaSP Primary key(MaSP, MaNhomSP),
	Constraint FK_MaNhomSP_ChiTietSanPham Foreign key(MaNhomSP) References NhomSanPham(MaNhomSP),
	Constraint FK_MaSP_ChiTietSanPham Foreign key(MaSP) References SanPham(MaSP)
)
GO

Create table HoaDon
(
	MaHD Char(5),
	MaNV Char(5),
	MaKH Char(5),
	Constraint PK_MaHD_HoaDon Primary key(MaHD),
	Constraint FK_MaNV_HoaDon Foreign key(MaNV) References NhanVien(MaNV),
	Constraint FK_MaKH_HoaDon Foreign key(MaKH) References KhachHang(MaKH)

)
GO
--drop table ChiTietHoaDon
Create table ChiTietHoaDon
(
	MaCTHD Char(10),
	MaHD Char(5),
	MaSP Char(5),
	SoLuong int,
	ThanhTien Money,
	NgayLap Date,
	TinhTrang bit,
	Constraint PK_MaCTHDMaHDMaSP_ChiTietHoaDon Primary key(MaCTHD, MaHD, MaSP),
	Constraint FK_MaHD_ChiTietHoaDon Foreign key(MaHD) References HoaDon(MaHD),
	Constraint FK_MaSP_ChiTietHoaDon Foreign key(MaSP) References SanPham(MaSP)
)
GO


Create table NhaCungCap 
(
	MaNCC Char(5),
	TenNCC NVarChar(max),
	DiaChiNCC NVarChar(max),
	SDTNCC int,
	EmailNCC VarChar(40),
	Constraint PK_MaNCC_NhaCungCap Primary key(MaNCC)
)
GO

Create table KhuyenMai 
(
	MaKM Char(5),
	MaSP Char(5),
	NgayBatDau Date,
	NgayKetThuc Date,
	MucGiamGia Float,
	Constraint PK_MaKM_KhuyenMai Primary key(MaKM),
	Constraint FK_MaSP_KhuyenMai Foreign key(MaSP) References SanPham(MaSP)
)
GO

Create table LaiSuat
(
	MaSP Char(5),
	LaiSuat Float,
	GiaTG int,
	TraTruoc int,
	GopMoiThang int,
	LaiSuatMoiThang Float,
	PhiThuHo int,
	GiayToCanCo Nvarchar(max),
	LoaiNganHang Nvarchar(max),
	Constraint PK_MaSP_LaiSuat Primary key(MaSP,LaiSuat),
	Constraint FK_MaSP_Laisuat Foreign key(MaSP) References SanPham(MaSP),

)
GO


Create table TraGop
(
	MaSP Char(5),
	ThoiHanTG NVarChar(10),
	LaiSuatTG Float,
	Constraint PK_MaSP_TraGop Primary key(MaSP,LaiSuatTG),
	Constraint FK_MaSP_TraGop Foreign key(MaSP) References SanPham(MaSP)
)
GO
--drop table TraGop


Create table Kho
(
	MaSP Char(5),
	SoLuongTon int,
	LoaiKe NChar(5),
	Constraint PK_MaSP_Kho Primary key(MaSP),
	Constraint FK_MaSP_Kho Foreign key(MaSP) References SanPham(MaSP)
)
GO

Create table BaoHanh
(
	MaSP Char(5),
	TinhTrang NVarChar(30),
	MaKH Char(5),
	ThoiGianBH NVarChar(10),
	Constraint PK_MaSP_BaoHanh Primary key(MaSP, MaKH),
	Constraint FK_MaSP_BaoHanh Foreign key(MaSP) References SanPham(MaSP),
	Constraint FK_MaKH_BaoHanh Foreign key(MaKH) References KhachHang(MaKH)
)
GO

Create table ThongKe 
(
	NgayThongKe Date,
	MaHD Char(5),
	MaSP Char(5),
	TongTien Money,
	Constraint PK_NgayThongKe_ThongKe Primary key(NgayThongKe),
	Constraint FK_MaHD_ThongKe Foreign key(MaHD) References HoaDon(MaHD),
	Constraint FK_MaSP_ThongKe Foreign key(MaSP) References SanPham(MaSP)
)
GO

Create table PhieuNhap 
(
	MaPN Char(5),
	MaNV Char(5),
	MaNCC Char(5),
	NgayLap Date,
	TongTien Money,
	GhiChu NVarChar(max),
	Constraint PK_MaPN_PhieuNhap Primary key(MaPN),
	Constraint FK_MaNV_PhieuNhap Foreign Key(MaNV) References NhanVien(MaNV),
	Constraint FK_MaNCC_PhieuNhap Foreign Key(MaNCC) References NhaCungCap(MaNCC)
)
GO
--drop table ChiTietPhieuNhap
Create table ChiTietPhieuNhap 
(
	MaCTPN Char(10),
	MaPN Char(5),
	MaSP Char(5),
	SoLuong int,
	ThanhTien Money,
	Constraint PK_MaPN_ChiTietPhieuNhap Primary key(MaPN, MaSP, MaCTPN),
	Constraint FK_MaPN_ChiTietPhieuNhap Foreign Key(MaPN) References PhieuNhap(MaPN),
	Constraint FK_MaSP_ChiTietPhieuNhap Foreign Key(MaSP) References SanPham(MaSP)
)
GO

Create table ThanhToan
(
	MaSP Char(5), 
	NgayMua Date,
	Constraint PK_MaSP_ThanhToan Primary key(MaSP, NgayMua),
	Constraint FK_MaSP_ThanhToan Foreign Key(MaSP) References SanPham(MaSP)

)
GO

Insert into ChucVu values ('QL', N'Quản Lý') --nam or nữ
Insert into ChucVu values ('NVBH', N'Nhân viên bán hàng') --nam or nữ
Insert into ChucVu values ('NVK', N'Nhân viên kho') --nam
Insert into ChucVu values ('NVTN', N'Nhân viên thu ngân') --nữ
Insert into ChucVu values ('NVKT', N'Nhân viên kĩ thuật')
Select * from ChucVu

Set DateForMat DMY  -- nam true 1 nữ false 0
Insert into NhanVien values ('NV01', N'Nguyễn Hoàng Huy', 'True','10-10-1995','hoanghuy1011@gmail.com',0795894033, N'Quận Bình Thạnh', 456, 'QL', 'true')
Insert into NhanVien values ('NV02', N'Phan Thị Caatm Giang', 'False','01-01-1999','camgiang0101@gmail.com',0879332350, N'Quận Tây Thạnh', 123, 'NVBH', 'true')
Insert into NhanVien values ('NV03', N'Ninh Thế Lâm', 'True','12-01-1996','thelam120101@gmail.com',0833123456, N'Quận 1', 789, 'NVBH', 'true')
Insert into NhanVien values ('NV04', N'Võ Anh Thư', 'False','23-12-1997','anhthu2312@gmail.com',0914007732, N'Quận 5', 012, 'NVBH', 'true')
Insert into NhanVien values ('NV05', N'Đặng Bảo Toàn', 'True','28-02-1997','baotoan3002@gmail.com',0365265311, N'Quận Gò Vấp', 234, 'NVK', 'true')
Insert into NhanVien values ('NV06', N'Nguyễn Hồng Quân', 'True','26-10-1990','hongquan2610@gmail.com',0790098765, N'Quận 3', 678, 'NVK', 'true')
Insert into NhanVien values ('NV07', N'Đặng Thương', 'False','11-11-1997','thuong1111@gmail.com',0792782774, N'Quận 1', 098, 'NVTN', 'true')
Insert into NhanVien values ('NV08', N'Trương Thị Mẫn', 'False','09-10-1987','thiman0910@gmail.com',0889145842, N'Quận 12', 111, 'NVTN', 'true')
Insert into NhanVien values ('NV09', N'Văn Thế Trung', 'True','17-12-1998','thetrung1712@gmail.com',0830198543, N'Quận 11', 222, 'NVKT', 'true')
Insert into NhanVien values ('NV10', N'Nguyễn Anh Kha', 'True','11-12-1998','anhkha1112@gmail.com',0789094574, N'Quận 9', 333, 'NVKT', 'true')
Select * from NhanVien

Set DateForMat DMY
Insert  into KhachHang values ('KH01', N'Phan Thị Cẩm Yên', 'False', '12-12-2000', 'camyen1212@gmail.com', 0792645393, N'Bến Lức', 'true')
Insert  into KhachHang values ('KH02', N'Cao Ngọc Thảo Vi', 'False', '11-10-1999', 'tthaovi1110@gmail.com', 0349876145, N'Tân An', 'true')
Insert  into KhachHang values ('KH03', N'Danh Cẩm Nhung', 'False', '09-12-1998', 'camnhung0912@gmail.com', 0798765912, N'Đức Hòa', 'true')
Insert  into KhachHang values ('KH04', N'Pham Thanh Trúc', 'False', '10-11-1997', 'thanhtruc1011@gmail.com', 0822645393, N'Đức Huệ', 'true')
Insert  into KhachHang values ('KH05', N'Nguyễn Hồng Trâm', 'False', '09-09-1996', 'hongtram0909@gmail.com', 0581234878, N'Quận 8', 'true')
Insert  into KhachHang values ('KH06', N'Nguyễn Ngọc Dung', 'False', '12-01-2000', 'ngocdung1201@gmail.com', 0992645393, N'Tân Tạo', 'true')
Insert  into KhachHang values ('KH07', N'Phan Thị Cẩm Hà', 'False', '08-02-1988', 'camha0802@gmail.com', 0562645393, N'Tân Túc', 'true')
Insert  into KhachHang values ('KH08', N'Nguyễn Kim Phụng', 'False', '13-10-1995', 'kimphung1310@gmail.com', 0922645393, N'Tân Bửu', 'true')
Insert  into KhachHang values ('KH09', N'Nguyễn Ngọc Hoa', 'False', '09-01-1990', 'ngochoa0901@gmail.com', 0782645393, N'Bình Chánh', 'true')
Insert  into KhachHang values ('KH10', N'Nguyễn Văn Kiệt', 'True', '11-02-1995', 'vankiet@gmail.com', 0772645393, N'Nhựt Chánh', 'true')
Insert  into KhachHang values ('KH11', N'Nguyễn Kim Ngân', 'False', '12-09-1994', 'kimngan1209@gmail.com', 0702645393, N'Tân Tạo', 'true')
Insert  into KhachHang values ('KH12', N'Nguyễn Thanh Tú', 'False', '12-12-1995', 'thanhtu1212@gmail.com', 0942645393, N'Bến Lức', 'true')
Insert  into KhachHang values ('KH13', N'Trườg Minh Quang', 'False', '02-01-1998', 'minhquang0201@gmail.com', 0940987632, N'An Thạnh', 'true')
Insert  into KhachHang values ('KH14', N'Vũ Minh Hòa', 'True', '01-01-1995', 'minhhoa0101@gmail.com', 0799876543, N'Quận 1', 'true')
Insert  into KhachHang values ('KH15', N'Trương Ngọc Ánh ', 'False', '12-10-2001', 'ngocanh1210@gmail.com', 0902645393, N'Quận 2', 'true')
Insert  into KhachHang values ('KH16', N'Trương Như Ý', 'False', '11-07-1996', 'nhuy1107@gmail.com', 0914007745, N'Tân An', 'true')
Insert  into KhachHang values ('KH17', N'Phan Đức Tài', 'True', '13-10-1994', 'ductai1310@gmail.com', 0729876523, N'Quận 12', 'true')
Insert  into KhachHang values ('KH18', N'Lưu Chi Vĩ', 'True', '12-12-1995', 'chivi1212@gmail.com', 0799876541, N'Bến Lức', 'true')
Insert  into KhachHang values ('KH19', N'Bùi Công Anh', 'True', '11-02-1989', 'conganh1102@gmail.com', 0701234534, N'Nhựt Chánh', 'true')
Insert  into KhachHang values ('KH20', N'Phan Thị Cẩm Vân', 'False', '01-01-1990', 'camvan0101@gmail.com', 0795678983, N'Cần Giuộc', 'true')
Select * from KhachHang

Insert into NhomSanPham values ('DT', N'Điện thoại', 'true')
Insert into NhomSanPham values ('LT', N'Laptop', 'true')
Insert into NhomSanPham values ('DH', N'Đồng hồ', 'true')
Insert into NhomSanPham values ('TL', N'Tablet', 'true')
Insert into NhomSanPham values ('PK', N'Phụ kiện', 'true')
Insert into NhomSanPham values ('S',N'Sim điện thoại', 'true')
Select * from NhomSanPham

Insert into Hang values ('MH01', N'Apple(iPhone)','DT', 'true')
Insert into Hang values ('MH02', N'Vsmart','DT', 'true')
Insert into Hang values ('MH03', N'Vivo','DT', 'true')
Insert into Hang values ('MH04', N'Masstel','DT', 'true')
Insert into Hang values ('MH05', N'Samsung','DT', 'true')
Insert into Hang values ('MH06', N'Xiaomi','DT', 'true')
Insert into Hang values ('MH07', N'Nokia','DT', 'true')
Insert into Hang values ('MH08', N'Huawei','DT', 'true')
Insert into Hang values ('MH09', N'Oppo','DT', 'true')
Insert into Hang values ('MH10', N'Realme','DT', 'true')
Insert into Hang values ('MH11', N'Apple(MacBook)','LT', 'true')
Insert into Hang values ('MH12', N'Dell','LT', 'true')
Insert into Hang values ('MH13', N'HP','LT', 'true')
Insert into Hang values ('MH14', N'Asus','LT', 'true')
Insert into Hang values ('MH15', N'Huawei','LT', 'true')
Insert into Hang values ('MH16', N'Lenovo','LT', 'true')
Insert into Hang values ('MH17', N'MSI','LT', 'true')
Insert into Hang values ('MH18', N'Acer','LT', 'true')
Insert into Hang values ('MH19', N'Apple Watch','DH', 'true')
Insert into Hang values ('MH20', N'Đồng hồ mặt kim','DH', 'true')
Insert into Hang values ('MH21', N'Pin Dự Phòng','PK', 'true')
Insert into Hang values ('MH22', N'Tai nge','PK', 'true')
Insert into Hang values ('MH23', N'Ốp lưng','PK', 'true')
Insert into Hang values ('MH24', N'Bàn phím','PK', 'true')
Insert into Hang values ('MH25', N'Chuột','PK', 'true')
Insert into Hang values ('MH26', N'Apple(Ipad)','TL', 'true')
Insert into Hang values ('MH27', N'Samsung','TL', 'true')
Insert into Hang values ('MH28', N'Huawei','TL', 'true')
Insert into Hang values ('MH29', N'Masstel','TL', 'true')
Insert into Hang values ('MH30', N'Lenovo','TL', 'true')
Insert into Hang values ('MH31', N'Sim','S', 'true')
Select * from Hang

Insert into SanPham values ('DT001', N'Điện thoại IPhone 12 Mini 64GB',5, 21990000,'DT01.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT002', N'Điện thoại IPhone 12 64GB',1, 24990000, 'DT02.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT003', N'Điện thoại IPhone 12 Pro 128GB',1, 30990000, 'DT03.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT004', N'Điện thoại IPhone 12 Pro Max 128GB',1, 33990000, 'DT04.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT005', N'Điện thoại IPhone 11 64GB',6, 17990000, 'DT05.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT006', N'Điện thoại IPhone 11 Pro Max 512GB',7, 34990000, 'DT06.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT007', N'Điện thoại IPhone 11 Pro 64GB',1, 24990000, 'DT07.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT008', N'Điện thoại IPhone XR 64GB',7, 13490000, 'DT08.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT009', N'Điện thoại IPhone SE (2020) 64GB',1, 11990000, 'DT09.png',N'Còn hàng','DT','MH01', 'true')
Insert into SanPham values ('DT010', N'Điện thoại IPhone 8 Plus 64GB',1, 13490000, 'DT10.png',N'Còn hàng','DT','MH01', 'true')
 
Insert into SanPham values ('DT011', N'Điện thoại Samsung Galaxy Z Fold2 5G',8, 50000000, 'DT11.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT012', N'Điện thoại Samsung Galaxy Z Flip',1, 29000000, 'DT12.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT013', N'Điện thoại Samsung Galaxy S20+',1, 23990000, 'DT13.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT014', N'Điện thoại Samsung Galaxy S20 Ultra',1, 21990000, 'DT14.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT015', N'Điện thoại Samsung Galaxy S20 FE',1, 12990000, 'DT15.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT016', N'Điện thoại Samsung Galaxy Note 20 Ultra 5G',7, 29990000, 'DT16.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT017', N'Điện thoại Samsung Galaxy Note 20',5, 20990000, 'DT17.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT018', N'Điện thoại Samsung Galaxy Note 10 Lite',1, 10990000, 'DT18.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT019', N'Điện thoại Samsung Galaxy A51',1, 7190000, 'DT19.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT020', N'Điện thoại Samsung Galaxy M31',1, 5490000, 'DT20.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT021', N'Điện thoại Samsung Galaxy A11',1, 3690000, 'DT21.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT022', N'Điện thoại Samsung Galaxy A10s',1, 3690000, 'DT22.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT023', N'Điện thoại Samsung Galaxy A01 Core',1, 1990000, 'DT23.png',N'Còn hàng','DT','MH05', 'true')
Insert into SanPham values ('DT024', N'Điện thoại Samsung Galaxy A31',1, 6490000, 'DT24.png',N'Còn hàng','DT','MH05', 'true')
 
Insert into SanPham values ('DT025', N'Điện thoại OPPO Reno4',1, 7990000, 'DT25.png',N'Còn hàng','DT','MH09', 'true')
Insert into SanPham values ('DT026', N'Điện thoại OPPO Reno4 Pro',5, 11990000, 'DT26.png',N'Còn hàng','DT','MH09', 'true')
Insert into SanPham values ('DT027', N'Điện thoại OPPO A53 4GB-128GB',1, 4990000, 'DT27.png',N'Còn hàng','DT','MH09', 'true')
Insert into SanPham values ('DT028', N'Điện thoại OPPO A52 6GB-128GB',1, 5690000, 'DT28.png',N'Còn hàng','DT','MH09', 'true')
Insert into SanPham values ('DT029', N'Điện thoại OPPO A92',1, 6190000, 'DT29.png',N'Còn hàng','DT','MH09', 'true')
Insert into SanPham values ('DT030', N'Điện thoại OPPO A93 8GB-128GB',1, 7490000, 'DT30.png',N'Còn hàng','DT','MH09', 'true')
Insert into SanPham values ('DT031', N'Điện thoại OPPO A12 3GB-32GB',5, 2990000, 'DT31.png',N'Còn hàng','DT','MH09', 'true')

Insert into SanPham values ('DT032', N'Điện thoại Vsmart Aris Pro 8GB-128GB',1, 9990000, 'DT32.png',N'Còn hàng','DT','MH02', 'true')
Insert into SanPham values ('DT033', N'Điện thoại Vsmart Aris 8GB-128GB',1, 7490000, 'DT33.png',N'Còn hàng','DT','MH02', 'true')
Insert into SanPham values ('DT034', N'Điện thoại Vsmart Live4 6GB-64GB',1, 4590000, 'DT34.png', N'Còn hàng','DT','MH02', 'true')
Insert into SanPham values ('DT035', N'Điện thoại Vsmart Joy 4 3GB-64GB',1, 3290000, 'DT35.png',N'Còn hàng','DT','MH02', 'true')
Insert into SanPham values ('DT036', N'Điện thoại Vsmart Star 4 3GB-32GB',1, 2490000, 'DT36.png',N'Còn hàng','DT','MH02', 'true')
Insert into SanPham values ('DT037', N'Điện thoại Vsmart Bee 3 2GB-16GB',10, 1590000, 'DT37.png',N'Còn hàng','DT','MH02', 'true')

Insert into SanPham values ('DT038', N'Điện thoại Xiaomi Mi 10T Pro 5G 8GB-256GB',1, 12990000, 'DT37.png',N'Còn hàng','DT','MH06', 'true')
Insert into SanPham values ('DT039', N'Điện thoại Xiaomi Poco X3 NFC 6GB-128GB',1, 6990000, 'DT39.png',N'Còn hàng','DT','MH06', 'true')
Insert into SanPham values ('DT040', N'Điện thoại Xiaomi Redmin Note 9 Pro 6GB-128GB Xanh',1, 6990000, 'DT40.png',N'Còn hàng','DT','MH06', 'true')
Insert into SanPham values ('DT041', N'Điện thoại Xiaomi Redmin Note 8 4GB-64GB Xanh',1, 4490000, 'DT41.png',N'Còn hàng','DT','MH06', 'true')
Insert into SanPham values ('DT042', N'Điện thoại Xiaomi Redmin 9 3GB-32GB',8, 3590000, 'DT42.png',N'Còn hàng','DT','MH06', 'true')
Insert into SanPham values ('DT043', N'Điện thoại Xiaomi Redmin 9C 3GB-64GB',1, 2990000, 'DT43.png',N'Còn hàng','DT','MH06', 'true')
Insert into SanPham values ('DT044', N'Điện thoại Xiaomi Redmin 9A 2GB-32GB',1, 1990000, 'DT44.png',N'Còn hàng','DT','MH06', 'true')

Insert into SanPham values ('DT045', N'Điện thoại Realme 7i 8GB-128GB',1, 6290000, 'DT45.png',N'Còn hàng','DT','MH10', 'true')
Insert into SanPham values ('DT046', N'Điện thoại Realme 6 4GB-128GB',1, 5490000, 'DT46.png',N'Còn hàng','DT','MH10', 'true')
Insert into SanPham values ('DT047', N'Điện thoại Realme C15 4GB-64GB',1, 4190000, 'DT47.png',N'Còn hàng','DT','MH10', 'true')
Insert into SanPham values ('DT048', N'Điện thoại Realme 5i 4GB-64GB',1, 3690000, 'DT48.png',N'Còn hàng','DT','MH10', 'true')
Insert into SanPham values ('DT049', N'Điện thoại Realme C3 3GB-32GB',1, 2990000, 'DT49.png',N'Còn hàng','DT','MH10', 'true')

Insert into SanPham values ('DT050', N'Điện thoại Vivo V20 8GB-128GB',1, 8190000, 'DT50.png',N'Còn hàng','DT','MH03', 'true')
Insert into SanPham values ('DT051', N'Điện thoại Vivo V19 8GB-128GB',1, 7990000, 'DT51.png',N'Còn hàng','DT','MH03', 'true')
Insert into SanPham values ('DT052', N'Điện thoại Vivo Y50 8GB-128GB',1, 6290000, 'DT52.png',N'Còn hàng','DT','MH03', 'true')
Insert into SanPham values ('DT053', N'Điện thoại Vivo Y20s 6GB-128GB',1, 4990000, 'DT53.png',N'Còn hàng','DT','MH03', 'true')
Insert into SanPham values ('DT053', N'Điện thoại Vivo Y20s 6GB-128GB',1, 4990000, 'DT53.png',N'Còn hàng','DT','MH03', 'true')
Insert into SanPham values ('DT054', N'Điện thoại Vivo Y19 6GB-128GB',1, 3990000, 'DT54.png', N'Còn hàng','DT','MH03', 'true')
Insert into SanPham values ('DT055', N'Điện thoại Vivo Y1s 2GB-32GB',10, 2490000, 'DT55.png',N'Còn hàng','DT','MH03', 'true')

Insert into SanPham values ('DT056', N'Điện thoại Nokia 8.3 5G',1, 11990000, 'DT56.png',N'Còn hàng','DT','MH07', 'true')
Insert into SanPham values ('DT057', N'Điện thoại Nokia 2.4',1, 2490000, 'DT57.png', N'Còn hàng','DT','MH07', 'true')
Insert into SanPham values ('DT058', N'Điện thoại Nokia 2.4',1, 1790000, 'DT58.png',N'Còn hàng','DT','MH07', 'true')
Insert into SanPham values ('DT059', N'Điện thoại Nokia 230 (Không kèm thẻ nhớ)',1, 1250000, 'DT59.png',N'Còn hàng','DT','MH07', 'true')
Insert into SanPham values ('DT060', N'Điện thoại Nokia 215 DS 4G',1, 749000, 'DT60.png',N'Còn hàng','DT','MH07', 'true')
Insert into SanPham values ('DT061', N'Điện thoại Nokia 105 SS (2019)',1, 359000, 'DT61.png',N'Còn hàng','DT','MH07', 'true')

Insert into SanPham values ('DT062', N'Điện thoại Huawei Nova 5T 8GB-128GB',1, 8990000, 'DT62.png',N'Còn hàng','DT','MH08', 'true')
Insert into SanPham values ('DT063', N'Điện thoại Huawei Nova 7i',1, 6990000, 'DT63.png',N'Còn hàng','DT','MH08', 'true')
Insert into SanPham values ('DT064', N'Điện thoại Huawei Y6p',1, 3340000, 'DT64.png',N'Còn hàng','DT','MH08', 'true')

Insert into SanPham values ('DT065', N'Điện thoại Masstel Hapi 10 Fami',1, 1190000, 'DT65.png',N'Còn hàng','DT','MH04', 'true')
Insert into SanPham values ('DT066', N'Điện thoại Masstel Fami P20',1, 550000, 'DT66.png',N'Còn hàng','DT','MH04', 'true')
Insert into SanPham values ('DT067', N'Điện thoại Masstel Fami 12',1, 450000, 'DT67.png',N'Còn hàng','DT','MH04', 'true')
Insert into SanPham values ('DT068', N'Điện thoại Masstel Izi 300',1, 400000, 'DT68.png',N'Còn hàng','DT','MH04', 'true')
Insert into SanPham values ('DT069', N'Điện thoại Masstel Izi 230',1, 350000, 'DT69.png',N'Còn hàng','DT','MH04', 'true')
Insert into SanPham values ('DT070', N'Điện thoại Masstel Izi 120',1, 119000, 'DT70.png',N'Còn hàng','DT','MH04', 'true')

Insert into SanPham values ('LT071', N'LapTop MacBook Pro 16"',1, 69990000,'LT71.png',N'Còn hàng','LT','MH11', 'true')
Insert into SanPham values ('LT072', N'LapTop MacBook Pro 13"',1, 41490000,'LT72.png',N'Còn hàng','LT','MH11', 'true')
Insert into SanPham values ('LT073', N'LapTop MacBook Pro 13"',7, 34990000,'LT73.png',N'Còn hàng','LT','MH11', 'true')
Insert into SanPham values ('LT074', N'LapTop MacBook Pro 13"',5, 34990000,'LT74.png',N'Còn hàng','LT','MH11', 'true')
Insert into SanPham values ('LT075', N'LapTop MacBook Air 13"',1, 28990000,'LT75.png',N'Còn hàng','LT','MH11', 'true')
Insert into SanPham values ('LT076', N'LapTop MacBook Air 13"',1, 19990000,'LT76.png',N'Còn hàng','LT','MH11', 'true')
Insert into SanPham values ('LT077', N'LapTop MacBook Air 13"',1, 28990000,'LT77.png',N'Còn hàng','LT','MH11', 'true')
Insert into SanPham values ('LT078', N'LapTop MacBook Air 13"',7, 31990000,'LT78.png',N'Còn hàng','LT','MH11', 'true')

Insert into SanPham values ('LT079', N'LapTop Asus Vivobook X509JAEJ247T i3',1, 11690000,'LT79.png',N'Còn hàng','LT','MH14', 'true')
Insert into SanPham values ('LT080', N'LapTop Asus Vivobook A412DA EK347T R3',1, 11190000,'LT80.png',N'Còn hàng','LT','MH14', 'true')
Insert into SanPham values ('LT081', N'LapTop Asus Vivobook X509MA-BR063',1, 7990000,'LT81.png',N'Còn hàng','LT','MH14', 'true')
Insert into SanPham values ('LT082', N'LapTop Asus TUF FX506LI HN096T i7',5, 26490000,'LT82.png',N'Còn hàng','LT','MH14', 'true')
Insert into SanPham values ('LT083', N'LapTop Asus TUF FX505GT HN11 1T i5',1, 20490000,'LT83.png',N'Còn hàng','LT','MH14', 'true')
Insert into SanPham values ('LT084', N'LapTop Asus VivoBook M413I EK480T R5',1, 15890000,'LT84.png',N'Còn hàng','LT','MH14', 'true')

Insert into SanPham values ('LT085', N'LapTop Dell G3 15 3500B i7',6, 31490000,'LT85.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT086', N'LapTop Dell XPS 13 9310 i5',5, 40990000,'LT86.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT087', N'LapTop Dell Inspiron N7306 i5',1, 27190000,'LT87.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT088', N'LapTop Dell Vostro V5402 i7',1, 24990000,'LT88.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT089', N'LapTop Dell Inspiron N5584/Core i5',1, 16990000,'LT89.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT090', N'LapTop Dell Vostro V3405 R7',1, 15990000,'LT90.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT091', N'LapTop Dell Vostro V5490 i3',1, 13690000,'LT91.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT092', N'LapTop Dell N3581/Core i3',1, 12290000,'LT92.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT093', N'LapTop Dell Inspiron N3501 i3',1, 11890000,'LT93.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT094', N'LapTop Dell Inspiron N3593C i3',1, 11690000,'LT94.png',N'Còn hàng','LT','MH12', 'true')
Insert into SanPham values ('LT095', N'LapTop Dell Inspiron N3593 i3',1, 10590000,'LT95.png',N'Còn hàng','LT','MH12', 'true')

Insert into SanPham values ('LT096', N'LapTop Acer Nitro 5 AN515-55-55E3 i5',9, 30490000,'LT96.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT097', N'LapTop Acer Nitro 5 AN515-55-55E3 i5',1, 22490000,'LT97.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT098', N'LapTop Acer Swift 5 SF514 53T 58PN/Core i5',5, 21590000,'LT98.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT099', N'LapTop Acer Aspire Gaming A715 41G R282 R5',1, 19490000,'LT99.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT100', N'LapTop Acer Aspire 5 A514 53 50JA i5',1, 14690000,'LT100.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT101', N'LapTop Acer Swift SF315',1, 13490000,'LT101.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT102', N'LapTop Acer Aspire 5 A514 53 346U i3',1, 13190000,'LT102.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT103', N'LapTop Acer Aspire 3 A315-23G-R33Y R5',1, 12490000,'LT103.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT104', N'LapTop Acer Aspire 3 A315 23 R8BA R3',1, 9490000,'LT104.png',N'Còn hàng','LT','MH18', 'true')
Insert into SanPham values ('LT105', N'LapTop Acer Aspire 3 A315 34 C38Y CDC',1, 6990000,'LT105.png',N'Còn hàng','LT','MH18', 'true')

Insert into SanPham values ('LT106', N'LapTop HP Envy 13 aq1047TU i7',5, 28290000,'LT106.png',N'Còn hàng','LT','MH13', 'true')
Insert into SanPham values ('LT107', N'LapTop HP Envy 13 aq1023TU i7',1, 27890000,'LT107.png',N'Còn hàng','LT','MH13', 'true')
Insert into SanPham values ('LT108', N'LapTop HP ENVY 13 ba0046TU i5',1, 22690000,'LT108.png',N'Còn hàng','LT','MH13', 'true')
Insert into SanPham values ('LT109', N'LapTop HP Pavilion 15-eg0069TU i5',1, 17590000,'LT109.png',N'Còn hàng','LT','MH13', 'true')
Insert into SanPham values ('LT110', N'LapTop HP Pavilion',6, 14790000,'LT110.png',N'Còn hàng','LT','MH13', 'true')
Insert into SanPham values ('LT111', N'LapTop HP i3',1, 12690000,'LT111.png',N'Còn hàng','LT','MH13', 'true')
Insert into SanPham values ('LT112', N'LapTop HP Pavilion 14-ce1014TU/Core i3',1, 9490000,'LT112.png',N'Còn hàng','LT','MH13', 'true')
Insert into SanPham values ('LT113', N'LapTop HP 348 G7 i3',1, 10690000,'LT113.png',N'Còn hàng','LT','MH13', 'true')
Insert into SanPham values ('LT114', N'LapTop HP Spectre x360 13 i7',1, 45490000,'LT114.png',N'Còn hàng','LT','MH13', 'true')

Insert into SanPham values ('LT115', N'LapTop Lenovo IdeaPad S145 14IIL i3',1, 9890000,'LT115.png',N'Còn hàng','LT','MH16', 'true')
Insert into SanPham values ('LT116', N'LapTop Lenovo Ideapad S340-14IIL i3',1, 11990000,'LT116.png',N'Còn hàng','LT','MH16', 'true')
Insert into SanPham values ('LT117', N'LapTop Lenovo IdeaPad C340 15IIL i5',1, 15790000,'LT117.png',N'Còn hàng','LT','MH16', 'true')
Insert into SanPham values ('LT118', N'LapTop Lenovo ThinkPad E14 i5',1, 17790000,'LT118.png',N'Còn hàng','LT','MH16', 'true')
Insert into SanPham values ('LT119', N'LapTop Lenovo Legion 5 15IMH05 i5',5, 23490000,'LT119.png',N'Còn hàng','LT','MH16', 'true')
Insert into SanPham values ('LT120', N'LapTop Lenovo ThinkPad X1 Carbon 8 i7',1, 44990000,'LT120.png',N'Còn hàng','LT','MH16', 'true')
Insert into SanPham values ('LT121', N'LapTop Lenovo ThinkPad T14s Gen 1 i7',5, 34990000,'LT121.png',N'Còn hàng','LT','MH16', 'true')
Insert into SanPham values ('LT122', N'LapTop Huawei MateBook 13 i5',1, 29990000,'LT122.png',N'Còn hàng','LT','MH15', 'true')

Insert into SanPham values ('LT123', N'LapTop MSI Modern 14 A10M 1053VN i5',1, 15690000,'LT123.png',N'Còn hàng','LT','MH17', 'true')
Insert into SanPham values ('LT124', N'LapTop MSI GF63 9SCXR i5',1, 18490000,'LT124.png',N'Còn hàng','LT','MH17', 'true')
Insert into SanPham values ('LT125', N'LapTop MSI Gaming GF63-1218VN i5',1, 20690000,'LT125.png',N'Còn hàng','LT','MH17', 'true')
Insert into SanPham values ('LT126', N'LapTop MSI Prestige 14-206VN i5',1, 24990000,'LT126.png',N'Còn hàng','LT','MH17', 'true')
Insert into SanPham values ('LT127', N'LapTop MSI GF65 10SDR-623VN i5',1, 28990000,'LT127.png',N'Còn hàng','LT','MH17', 'true')

Insert into SanPham values ('DH128', N'Đồng hồ Daniel Klein',1, 1000000,'DH128.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH129', N'Đồng hồ Daniel Klein',1, 920000,'DH129.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH130', N'Đồng hồ Daniel Klein',1, 970000,'DH130.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH131', N'Đồng hồ Sinobi',1, 790000,'DH131.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH132', N'Đồng hồ Ferrari',1, 2800000,'DH132.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH133', N'Đồng hồ Daniel Klein',1, 1240000,'DH133.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH134', N'Đồng hồ Anne Klein',1, 2900000,'DH134.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH135', N'Đồng hồ Fossil',1, 3750000,'DH135.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH136', N'Đồng hồ Lacoste',1, 5000000,'DH136.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH137', N'Đồng hồ Citizen',1, 5570000,'DH137.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH138', N'Đồng hồ Bulova',1, 9600000,'DH138.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH139', N'Đồng hồ Ferrari',1, 7600000,'DH139.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH140', N'Đồng Hồ Citizen',1, 11600000,'DH140.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH141', N'Đồng Hồ Bulova',1, 12000000,'DH141.png',N'Còn hàng','DH','MH20', 'true')
Insert into SanPham values ('DH142', N'Đồng Hồ Citizen',1, 12500000,'DH142.png',N'Còn hàng','DH','MH20','true')

Insert into SanPham values ('DH143', N'Apple Watch Series 3 GPS 38mm viền nhôm dây cao su',1, 5490000,'DH143.png',N'Còn hàng','DH','MH19', 'true')
Insert into SanPham values ('DH144', N'Apple Watch Series 3 GPS Cellular 42mm viền nhôm dây cao su',1, 6990000,'DH144.png',N'Còn hàng','DH','MH19','true')
Insert into SanPham values ('DH145', N'Apple Watch Nike Series 5 GPS 40mm viền nhôm dây cao su',1, 9990000,'DH145.png',N'Còn hàng','DH','MH19','true')
Insert into SanPham values ('DH146', N'Apple Watch Series 5 GPS 44mm viền nhôm dây cao su',1, 10990000,'DH146.png',N'Còn hàng','DH','MH19','true')
Insert into SanPham values ('DH147', N'Apple Watch Series 5 GPS Cellular 44mm viền nhôm dây cao su',1, 12990000,'DH147.png',N'Còn hàng','DH','MH19','true')
Insert into SanPham values ('DH148', N'Apple Watch Series 5 GPS Cellular 40mm viền thép dây milanese',10, 18990000,'DH148.png',N'Còn hàng','DH','MH19','true')
Insert into SanPham values ('DH149', N'Apple Watch Series 6 GPS 40mm viền nhôm dây cao su',6, 11990000,'DH149.png',N'Còn hàng','DH','MH19','true')
Insert into SanPham values ('DH150', N'Apple Watch Series 6 GPS + Cellular 40mm viền nhôm dây cao su',1, 14490000,'DH150.png',N'Còn hàng','DH','MH19','true')
Insert into SanPham values ('DH151', N'Apple Watch Series 6 GPS + Cellular 44mm viền thép dây thép',8, 21490000,'DH151.png',N'Còn hàng','DH','MH19','true')

Insert into SanPham values ('TL152', N'Máy tính bảng Samsung Galaxy Tab S7 ',5, 18990000, 'TL152.png',N'Còn hàng','TL','MH27','true')
Insert into SanPham values ('TL153', N'Máy tính bảng Samsung Galaxy Tab S6 Lite ',1, 9990000, 'TL153.png',N'Còn hàng','TL','MH27','true')
Insert into SanPham values ('TL154', N'Máy tính bảng Samsung Tab A 10.1 (2019)',1, 7490000, 'TL154.png',N'Còn hàng','TL','MH27','true')
Insert into SanPham values ('TL155', N'Máy tính bảng Samsung Galaxy Tab A Plus 8.0 (2019)',1, 6990000, 'TL155.png',N'Còn hàng','TL','MH27','true')
Insert into SanPham values ('TL156', N'Máy tính bảng Samsung Galaxy Tab A8 (2019)',1, 3690000, 'TL156.png',N'Còn hàng','TL','MH27','true')

Insert into SanPham values ('TL157', N'Máy tính bảng iPad Pro 12.9 2020 WI-FI 4G 128GB',6, 30990000, 'TL157.png',N'Còn hàng','TL','MH26','true')
Insert into SanPham values ('TL158', N'Máy tính bảng iPad Pro 11 2020 WI-FI 4G 128GB',8, 25990000, 'TL158.png',N'Còn hàng','TL','MH26','true')
Insert into SanPham values ('TL159', N'Máy tính bảng iPad Air 10.9 2020 Wi-Fi + Cellular 64GB',1, 20990000, 'TL159.png',N'Còn hàng','TL','MH26','true')
Insert into SanPham values ('TL160', N'Máy tính bảng iPad Mini 5 7.9 Wi-Fi 4G 256GB',1, 18990000, 'TL160.png',N'Còn hàng','TL','MH26','true')
Insert into SanPham values ('TL161', N'Máy tính bảng iPad Air 10.9 2020 Wi-Fi 64GB',1, 16990000, 'TL161.png',N'Còn hàng','TL','MH26','true')
Insert into SanPham values ('TL162', N'Máy tính bảng iPad 10.2 2020 Wi-Fi + Cellular 32GB',1, 8990000, 'TL162.png',N'Còn hàng','TL','MH26','true')
Insert into SanPham values ('TL163', N'Máy tính bảng iPad 10.2 2020 Wi-Fi + Cellular 32GB',1, 12990000, 'TL163.png',N'Còn hàng','TL','MH26','true')
Insert into SanPham values ('TL164', N'Máy tính bảng iPad Mini 5 7.9 Wi-Fi 64GB',1, 9990000, 'TL164.png',N'Còn hàng','TL','MH26','true')

Insert into SanPham values ('TL165', N'Máy tính bảng Masstel Tab 8 Plus',10, 1890000, 'TL165.png',N'Còn hàng','TL','MH29','true')
Insert into SanPham values ('TL166', N'Máy tính bảng Masstel Tab 10 Plus',1, 2290000, 'TL166.png',N'Còn hàng','TL','MH29','true')
Insert into SanPham values ('TL167', N'Máy tính bảng Masstel Tab 10 Ultra',1, 3490000, 'TL167.png',N'Còn hàng','TL','MH29','true')
Insert into SanPham values ('TL168', N'Máy tính bảng Masstel Tab 10 Pro',1, 2590000, 'TL168.png',N'Còn hàng','TL','MH29','true')

Insert into SanPham values ('TL169', N'Máy tính bảng Huawei MediaPad T5 10',1, 4990000, 'TL169.png',N'Còn hàng','TL','MH28','true')
Insert into SanPham values ('TL170', N'Máy tính bảng Huawei MatePad T',1, 3190000, 'TL170.png',N'Còn hàng','TL','MH28','true')
Insert into SanPham values ('TL171', N'Máy tính bảng Huawei MediaPad M5 Lite 64GB',5, 7990000, 'TL171.png',N'Còn hàng','TL','MH28','true')
Insert into SanPham values ('TL172', N'Máy tính bảng Huawei MediaPad T3 10.0',1, 3890000, 'TL172.png',N'Còn hàng','TL','MH28','true')

Insert into SanPham values ('PK173', N'Chuột có dây Rapoo N200 ',1, 100000, 'PK173.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK174', N'Chuột không dây Zadez M390 Đỏ',1, 200000, 'PK174.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK175', N'Chuột không dây HP X3000',1, 300000, 'PK175.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK176', N'Chuột không dây quang Microsoft',1, 350000, 'PK176.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK177', N'Chuột game Asus CERBERUS',1, 455000, 'PK177.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK178', N'Chuột game có dây Zadez GT-613M',1, 350000, 'PK178.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK179', N'Chuột game có dây Zadez GT615M',1, 550000, 'PK179.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK180', N'Chuột game có dây Zadez GT616M',1, 650000, 'PK180.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK181', N'Chuột Game không dây Logitech',1, 890000, 'PK181.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK182', N'Chuột Game có dây Logitech G502 HERO High Performance',1, 1759000, 'PK182.png',N'Còn hàng','PK','MH25','true')
Insert into SanPham values ('PK183', N'Chuột không dây Magic Mouse 2 White',1, 2459000, 'PK183.png',N'Còn hàng','PK','MH25','true')


Insert into SanPham values ('PK184', N'Pin dự phòng Li-ion 7500mAh ivalue MTL75002',1, 399000, 'PK184.png',N'Còn hàng','PK','MH21','true')
Insert into SanPham values ('PK185', N'Pin dự phòng Li-ion 10000mAh ivalue MT-L100-015 (T-100CF) Xanh Royal',1, 499000, 'PK185.png',N'Còn hàng','PK','MH21','true') 
Insert into SanPham values ('PK186', N'Pin dự phòng Wireless Li-polymer 10000mAH UMETRAVEL PW1',1, 699000, 'PK186.png',N'Còn hàng','PK','MH21','true') 
Insert into SanPham values ('PK187', N'Sạc phòng Veger V17 Pro 10000mAh (quick charge)',1, 700000, 'PK187.png',N'Còn hàng','PK','MH21','true') 
Insert into SanPham values ('PK188', N'Pin dự phòng Li-ion 20000mAh ivalue MTL200001 Trắng',1, 889000, 'PK188.png',N'Còn hàng','PK','MH21','true') 
Insert into SanPham values ('PK189', N'Pin dự phòng Li-ion 20000mAh ivalue MTL200001 Trắng',1, 1000000, 'PK189.png',N'Còn hàng','PK','MH21','true') 
Insert into SanPham values ('PK190', N'Pin dự phòng Li-ion 26800mAh Anker PowerCore+ A1375 Đen',1, 2400000, 'PK190.png',N'Còn hàng','PK','MH21','true') 
Insert into SanPham values ('PK191', N'Pin dự phòng Li-ion 10000mAh ivalue MT-L100-014 (RT-130) Trắng',1, 499000, 'PK191.png',N'Còn hàng','PK','MH21','true') 
Insert into SanPham values ('PK192', N'Pin dự phòng Li- polymer 10000mAh ivalue MTP100005 Blue',1, 599000, 'PK192.png',N'Còn hàng','PK','MH21','true') 

Insert into SanPham values ('PK193', N'Bao da iPhone 12 Pro Max Leather Sleeve with MagSafe',1, 2990000, 'PK193.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK194', N'Ốp lưng iPhone 12 & 12 Pro Clear Case with MagSafe',1, 1590000, 'PK194.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK195', N'Ốp lưng iPhone 12 Pro Max Silicone Case with MagSafe',1, 1590000, 'PK195.png', N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK196', N'Ốp lưng iPhone 12 Pro Max Leather Case with MagSafe',1, 1890000, 'PK196.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK197', N'Ốp lưng iPhone 12 Mini Nhựa dẻo Naked TPU Meetu',1, 69000, 'PK197.png', N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK198', N'Ốp lưng UAG cho iPhone 12 / 12 Pro Plasma',1, 950000, 'PK198.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK199', N'Ốp lưng UAG cho iPhone 12 / 12 Pro Plasma',1, 950000, 'PK199.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK200', N'Ốp lưng UAG cho iPhone 12 Pro Max Civilian',1, 1150000, 'PK200.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK201', N'Ốp lưng iPhone 12 Pro Max Giả da Hotforming PU Case Meetu',1, 399000, 'PK201.png', N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK202', N'Ví iPhone Leather Wallet with MagSafe',1, 159000, 'PK202.png', N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK203', N'Vỏ iPad 10.2 & Air 3 10.5 inchs Smart Cover Black',1, 1590000, 'PK203.png', N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK204', N'Bao da kèm bàn phím Logitech Slim Folio Pro cho iPad Pro 12.9',1, 4000000, 'PK204.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK205', N'Ốp lưng iPhone 6 Plus/6S Plus Nhựa dẻo TPU UV Printing Meetu MT-2020003',1, 33000, 'PK205.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK206', N'Ốp lưng iPhone 11 Nhựa dẻo TPU Silicone Feel Case Meetu MT-2020001',1, 66000, 'PK206.png',N'Còn hàng','PK','MH23','true')
Insert into SanPham values ('PK207', N'Ốp lưng iPhone 7 Plus/8 Plus Nhựa dẻo TPU UV Printing Meetu MT-2020005',1, 66000, 'PK207.png',N'Còn hàng','PK','MH23','true')

Insert into SanPham values ('PK208', N'Bàn phím không dây iPad Pro 11 Magic Keyboard',1, 5490000, 'PK208.png',N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK209', N'Bàn phím không dây iPad Pro 12.9 2020 Smart Keyboard Folio',1, 5990000, 'PK209.png',N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK210', N'Bàn phím Kingston HyperX Alloy Origins Mechanical Gaming Keyboard - HyperX Red Switch_HX-KB6RDX-US',1, 27900000, 'PK210.png', N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK211', N'Bàn phím + chuột không dây Microsoft 850',1, 750000, 'PK211.png',N'12 Tháng','PK','MH24','true')
Insert into SanPham values ('PK212', N'Bàn phím Prolink PKCM-2005',1, 200000, 'PK212.png',N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK213', N'Bàn phím Bluetooth Logitech K380',1, 750000, 'PK213.png',N' Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK214', N'Bàn phím không dây Magic Keyboard with Numeric Keypad',1, 3999000, 'PK214.png', N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK215', N'Bàn phím Game Zadez G-852K ',1, 600000, 'PK215.png',N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK216', N'Bàn phím Zadez có dây G-851K',1, 290000, 'PK216.png',N'Còn hàng','PK','MH24','true')

Insert into SanPham values ('PK217', N'Tai nghe AirPods Max',1, 13990000, 'PK217.png',N'Còn hàng','PK','MH22','true')
Insert into SanPham values ('PK218', N'Tai nghe choàng đầu có mic Gaming Logitech G331',1, 1699000, 'PK218.png', N'Còn hàng','PK','MH22','true')
Insert into SanPham values ('PK219', N'Tai nghe Samsung Galaxy Buds Live',1, 3290000, 'PK219.png',N'Còn hàng','PK','MH22','true')
Insert into SanPham values ('PK221', N'Tai nghe dây nhét tai JBL T110',1, 390000, 'PK221.png', N'Còn hàng','PK','MH22','true')
Insert into SanPham values ('PK222', N'Tai nghe bluetooth nhét tai i.value BT008 ',1, 450000, 'PK222.png', N'Còn hàng','PK','MH22','true')
Insert into SanPham values ('PK223', N'Tai nghe bluetooth choàng đầu có mic i.value A8 ',1, 550000, 'PK223.png', N'Còn hàng','PK','MH22','true')

Insert into SanPham values ('S224', N'Sim Mobi', 4, 270000, 'Sim224.png',N'Còn hàng', 'S', 'MH31','true')
Insert into SanPham values ('S225', N'Sim Vietnamobile', 4, 120000, 'Sim225.png', N'Còn hàng', 'S','MH31','true')
Insert into SanPham values ('S226', N'Sim Viettel', 4, 280000, 'Sim226.png', N'Còn hàng', 'PK','MH31','true')
Insert into SanPham values ('S227', N'Sim Vinaphone', 4, 200000, 'Sim227.png', N'Còn hàng', 'S','MH31','true')

Insert into SanPham values ('PK228', N'Thẻ nhớ MicroSD 32GB Toshiba C10 UHS-1 M203',1, 290000, 'PK228.png',N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK229', N'Bàn phím Zadez có dây G-851K',1, 290000, 'PK229.png',N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK230', N'Bàn phím Zadez có dây G-851K',1, 290000, 'PK230.png',N'Còn hàng','PK','MH24','true')
Insert into SanPham values ('PK231', N'Bàn phím Zadez có dây G-851K',1, 290000, 'PK232.png',N'Còn hàng','PK','MH24','true')


Select * from SanPham
--delete from SanPham
--Select * from ChiTietSanPham

 --drop table ChiTietSanPham	
Insert into ChiTietSanPham values('DT001', 'DT', '6.1, Super Retina XDR, AMOLED', '12.0 MP + 12.0 MP-12.0 MP,', null, '4 GB', 'iOS 14', 'A14 Bionic','64 GB','2227 mAh', null, null,null, null, null, null, null, null,null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT002', 'DT', '6.1, Super Retina XDR, AMOLED','12.0 MP + 12.0 MP-12.0 MP ', null, '4 GB', 'iOS 14', 'A14 Bionic','64 GB','2227 mAh', null,null, null, null, null, null,null, null,null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT003', 'DT', '6.1, Super Retina XDR, AMOLED','12.0 MP + 12.0 MP + 12.0 MP-12.0 MP', null, '6 GB', 'iOS 14', 'A14 Bionic','128 GB','2815 mAh', null, null,null, null, null, null,null, null,null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT004', 'DT', '6.7,Super Retina XDR,AMOLED','12.0 MP + 12.0 MP + 12.0 MP-12.0 MP', null, '6 GB', 'iOS 14', 'A14 Bionic','128 GB','3687  mAh', null,null, null, null, null,null,null, null, null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT005', 'DT', '6.1,Liquid Retina HD,IPS LCD,828 x 1792 Pixel','12.0 MP + 12.0 MP + 12.0 MP-12.0 MP', null, '4 GB', 'iOS 14', 'A13 Bionic','64  GB','3110 mAh',null, null, null, null,null,null, null, null, null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT006', 'DT', '6.5,Super Retina XDR,Super AMOLED,1242 x 2688 Pixel','12.0 MP + 12.0 MP + 12.0 MP-12.0 MP', null, '4 GB', 'iOS 14', 'A13 Bionic','512 GB','3969 mAh', null,null, null, null,null,null, null, null, null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT007', 'DT', '5.8,Super Retina XDR,Super AMOLED, 1125 x 2436 Pixel','12.0 MP + 12.0 MP + 12.0 MP-12.0 MP', null, '4 GB', 'iOS 14', 'A13 Bionic','64 GB','3046  mAh', null, null, null, null,null,null, null, null, null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT008', 'DT', '6.1", Liquid Retina HD, IPS LCD, 828 x 1792 Pixel','12.0 MP-7.0 MP', null, '3 GB', 'iOS 14', 'A13 Bionic','64 GB','3046  mAh', null,null, null, null, null,null,null, null, null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT009', 'DT', '4.7, Retina HD, IPS LCD, 750 x 1334 Pixel','12.0 MP-7.0 MP', null, '3 GB', 'iOS 14', 'A13 Bionic','64 GB','3046  mAh', null,null, null, null, null,null,null,null, null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT010', 'DT', '5.5", Retina HD, IPS LCD, 1080 x 1920 Pixel','12.0 MP + 12.0 MP-7.0 MP', null, '3 GB', 'iOS 14', 'A11 Bionic','64 GB','2691 mAh', null, null,null, null, null, null,null, null, null, N'Trung Quốc', N'12 tháng ')
Insert into ChiTietSanPham values('DT011', 'DT', N'Màn hình trước:6.2-Màn hình chính: 7.6", HD+, Chính: Dynamic AMOLED 2X, phụ: Super AMOLED, 1768 x 2208 Pixel','12.0 MP + 12.0 MP-10.0  MP', null, '12 GB', 'Android 10.0', 'Snapdragon 865+','256 GB','4500 mAh', null,null, null, null, null,null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT012', 'DT', N'6.7, FHD+, Chính: Dynamic AMOLED, phụ: Super AMOLED, 1080 x 2636 Pixel','12.0 MP + 12.0 MP-10.0  MP', null, '8 GB', 'Android 10.0', 'Snapdragon 855+','256 GB','3300  mAh', null, null,null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT013', 'DT', N'6.7, QHD+, Dynamic AMOLED 2X, 1440 x 3200 Pixel','12.0 MP + 12.0 MP + 64.0 MP + 0.5 MP-10.0  MP', null, '8 GB', 'Android 10.0', 'Snapdragon 855+','128  GB','3300  mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT014', 'DT', N'6.9, QHD+, Dynamic AMOLED 2X, 1440 x 3200 Pixel','108.0 MP + 12.0 MP + 48.0 MP + 0.5 MP-40.0 MP', null, '12 GB', 'Android 10.0', 'Snapdragon 855+','128  GB','3300  mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT015', 'DT', N'6.5, FHD+, Super AMOLED, 1080 x 2400 Pixel','108.0 MP + 12.0 MP + 48.0 MP + 0.5 MP-40.0 MP', null, '8 GB', 'Android 10.0', 'Exynos 990','8 GB','4500 mAh', null, null,null, null, null, null,null, null, null,N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT016', 'DT', N'6.9, 2K+, Dynamic AMOLED 2X, 1440 x 3088 Pixel','108.0 MP + 12.0 MP + 12.0 MP-10.0 MP', null, '12 GB', 'Android 10.0', 'Exynos 990','256 GB','4500 mAh',null, null,null,null, null, null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT017', 'DT', N'6.7, FHD+, Super AMOLED Plus, 1080 x 2400 Pixel','12.0 MP + 12.0 MP + 64.0 MP-10.0 MP', null, '8 GB', 'Android 10.0', 'Exynos 990','256 GB','4300 mAh',null, null,null, null,null,null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT018', 'DT', N'6.7, FHD+, Super AMOLED, 1080 x 2400 Pixel','12.0 MP + 12.0 MP + 12.0 MP-32.0 MP', null, '8 GB', 'Android 10.0', 'Exynos 990','128 GB','4500 mAh', null, null,null, null, null,null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT019', 'DT', N'6.5, FHD+, Super AMOLED, 1080 x 2400 Pixel','48.0 MP + 12.0 MP + 5.0 MP + 5.0 MP-32.0 MP', null, '6  GB','Android 10.0', 'Exynos 9611','128 GB','4000 mAh',null, null,null, null, null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT020', 'DT', N'6.4, FHD+, Super AMOLED, 1080 x 2340 Pixel','64.0 MP + 8.0 MP + 5.0 MP + 5.0 MP-32.0 MP', null, '6  GB', 'Android 10.0', 'Exynos 9611','128 GB','4000 mAh',null, null, null, null, null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT021', 'DT', N'6.4, HD+, PLS TFT LCD, 720 x 1560 Pixel','13.0 MP + 5.0 MP + 2.0 MP-8.0 MP', null, '3 GB', 'Android 10.0', 'Snapdragon 450','32  GB','4000 mAh',null, null,null, null, null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT022', 'DT', N'6.2, HD+, PLS TFT LCD, 720 x 1520 Pixel','13.0 MP + 2.0 MP-8.0 MP', null, '2 GB', 'Android 10.0', 'Helio P22','32 GB','4000 mAh', null, null, null, null,null, null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT023', 'DT', N'5.3, HD+, TFT LCD, 720 × 1480 Pixel','8.0 MP-5.0 MP', null, '1 GB', 'Android 10.0', 'MediaTek MT6739','16 GB','4000 mAh', null, null, null,null, null,null, null, null,null,  N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT024', 'DT', N'6.4, FHD+, Super AMOLED, 1080 x 2400 Pixel','48.0 MP + 8.0 MP + 5.0 MP + 5.0 MP-20.0 MP', null, '6 GB', 'Android 10.0', 'MediaTek MT6739Helio P65','128  GB','5000  mAh',null,null, null, null, null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT025', 'DT', N'6.4, FHD+, AMOLED, 1080 x 2400 Pixel','48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-32.0 MP + ', null, '8 GB', 'Android 10.0', 'Snapdragon 720G','128  GB','4015 mAh',null, null,null, null, null,null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT026', 'DT', N'6.5, FHD+, AMOLED, 1080 x 2400 Pixel','48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-32.0 MP + ', null, '8 GB', 'Android 10.0', 'Snapdragon 720G','128  GB','4000  mAh',null, null,null, null, null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT027', 'DT', N'6.5, HD+, IPS LCD, 720 x 1600 Pixel','13.0 MP + 2.0 MP + 2.0 MP-16.0 MP ', null, '4 GB', 'Android 10.0', 'Snapdragon 460','128  GB','4000  mAh', null, null, null, null, null,null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT028', 'DT', N'6.5, FHD+, TFT LCD, 1080 x 2400 Pixel','12.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-16.0 MP + ', null, '6 GB', 'Android 10.0', 'Snapdragon 665','128  GB','4000  mAh', null,null, null, null,null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT029', 'DT', N'6.5, FHD+, TFT LCD, 1080 x 2400 Pixel','48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-16.0 MP + 2.0 MP', null, '8 GB', 'Android 10.0', 'Snapdragon 460','128 GB','5000   mAh', null, null,null, null, null,null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT030', 'DT', N'6.43, FHD+, AMOLED, 1080 x 2400 Pixel','48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-16.0 MP + 2.0 MP ', null, '8 GB', 'Android 10.0', 'Snapdragon 460','128 GB','5000   mAh',null,null, null, null, null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT031', 'DT', N'6.22, HD+, IPS LCD, 720 x 1560 Pixel','13.0 MP + 2.0 MP-5.0 MP', null, '3 GB', 'Android 10.0', 'Helio P35','128 GB','4230    mAh', null, null,null, null,null, null, null, null,null, N'Trung Quốc', N'12 tháng')

Insert into ChiTietSanPham values('DT032', 'DT', N'6.39, FHD+, AMOLED, 1080 x 2340 Pixel','64.0 MP + 8.0 MP + 8.0 MP + 2.0 MP-20.0 MP', null, '8 GB', 'Android 10.0', 'Snapdragon 730','128 GB','4230    mAh',null, null,null,  null, null,null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT033', 'DT', N'6.39, FHD+, AMOLED, 1080 x 2340 Pixel','64.0 MP + 8.0 MP + 8.0 MP + 2.0 MP-20.0 MP', null, '8 GB', 'Android 10.0', 'Adreno 618','128 GB','4000 mAh',null, null,null, null, null,  null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DT034', 'DT', N'6.5, FHD+, IPS LCD, 1080 x 2340 Pixel','48.0 MP + 8.0 MP + 5.0 MP + 2.0 MP-13.0 MP', null, '6 GB', 'Android 10.0', 'Snapdragon 675','128 GB','5000  mAh', null, null,null,  null,null,null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT035', 'DT', N'6.53, FHD+, TFT LCD, 1080 x 2340 Pixel','16.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-13.0 MP', null, '3 GB', 'Android 10.0', 'Snapdragon 675','64  GB','5000  mAh', null, null,null, null, null,null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT036', 'DT', N'6.09, HD+, IPS LCD, 720 x 1560 Pixel','8.0 MP + 5.0 MP-8.0 MP', null, '3 GB', 'Android 10.0', 'Helio P35','32 GB','5000  mAh', null, null, null,null, null, null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT037', 'DT', N'6.0, HD+, IPS LCD, 720 x 1440 Pixel','8.0 MP-5.0  MP', null, '2 GB', 'Android 9.0', 'MT6739WW','16 GB','3000   mAh', null, null, null, null, null,null, null, null,null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT038', 'DT', N'6.67, FHD+, IPS LCD, 2440 x 1080 Pixel','108.0 MP + 13.0 MP + 5.0 MP-20.0 MP', null, '8 GB', 'Android 9.0', 'Snapdragon 865','256  GB','5000 mAh', null,null, null,null, null, null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT039', 'DT', N'6.67, FHD+, IPS LCD, 2440 x 1080 Pixel','64.0 MP + 13.0 MP + 2.0 MP + 2.0 MP-20.0 MP', null, '6 GB', 'Android 10.0', 'Snapdragon 732G','256  GB','5160  mAh',null, null,null, null, null, null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT040', 'DT', N'6.67, FHD+, IPS LCD, 1080 x 2400 Pixel','64.0 MP + 8.0 MP + 5.0 MP + 2.0 MP-16.0 MP', null, '6 GB', 'Android 10.0', 'Snapdragon 720G','128   GB','5020 mAh', null, null,null, null, null,null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT041', 'DT', N'6.3, FHD+, IPS LCD, 1080 x 2340 Pixel','48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-13.0 MP', null, '4  GB', 'Android 10.0', 'Snapdragon 665','64 GB','5020 mAh',null, null,null, null, null,null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT042', 'DT', N'6.53, FHD+, IPS LCD, 1080 x 2340 Pixel','13.0 MP + 8.0 MP + 5.0 MP + 2.0 MP-8.0 MP', null, '3 GB', 'Android 10.0', 'Helio G80','32  GB','5020 mAh', null,null, null,null, null, null, null,null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT043', 'DT', N'6.53, HD+, IPS LCD, 720 x 1600 Pixel','13.0 MP + 2.0 MP + 2.0 MP-5.0 MP', null, '3 GB', 'Android 10.0', 'Mediatek Helio G35','64 GB','5020 mAh', null,null, null,null, null, null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT044', 'DT', N'6.53, HD+, IPS LCD, 720 x 1600 Pixel','13.0 MP-5.0 MP', null, '3 GB', 'Android 10.0', 'Mediatek Helio G25','32  GB','5000  mAh', null, null,null,null, null,null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT045', 'DT', N'6.5, HD+, IPS LCD, 720 x 1600 Pixel','64.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-16.0 MP', null, '8  GB', 'Android 10.0', 'Mediatek Helio G25','128 GB','5000  mAh',null,null, null,null,  null, null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT046', 'DT', N'6.5, FHD+, IPS LCD, 1080 x 2400 Pixel','64.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-16.0 MP', null, '4 GB', 'Android 10.0', 'Mediatek Helio G25','128 GB',N'Đang cập nhật', null,null, null,null, null,null, null, null,null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT047', 'DT', N'6.52, HD+, LCD, 720 x 1600 Pixel','13.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-8.0 MP', null, '4 GB', 'Android 10.0', 'Mediatek Helio G25','64  GB','6000 mAh', null, null, null,null, null,null, null,null,null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT048', 'DT', N'6.52, HD+, IPS LCD, 720 x 1600 Pixel','12.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-8.0 MP', null, '4   GB', 'Android 9.0', 'Snapdragon 665','64  GB','5000 mAh', null, null,null, null,null,  null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT049', 'DT', N'6.5, HD+, IPS LCD, 720 x 1600 Pixel','12.0 MP + 2.0 MP + 2.0 MP-5.0 MP', null, '4 GB', 'Android 9.0', 'Helio G70','64  GB','5000  mAh', null, null, null,null, null,null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT050', 'DT', N'6.44, FHD+, AMOLED, 1080 x 2400 Pixel','64.0 MP + 8.0 MP + 2.0 MP-44.0 MP', null, '8 GB', N'Đang cập nhật', 'Snapdragon 720G','128 GB','4000 mAh', null, null,null, null, null, null, null,null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT051', 'DT', N'6.44, FHD+, Super AMOLED, 1080 x 2400 Pixel','48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-32.0 MP + 8.0 MP', null, '8 GB', 'Đang cập nhật', 'Snapdragon 712','128 GB','4000 mAh', null,null, null, null, null,null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT052', 'DT', N'6.53, FHD+, LCD, 1080 x 2340 Pixel','13.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-16.0 MP', null, '8 GB', 'Android 10.0', 'Snapdragon 665','128 GB','4000 mAh', null,null, null, null, null,null, null, null,null,N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT053', 'DT', N'6.51, HD+, IPS LCD, 720 x 1600 Pixel','13.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-8.0 MP', null, '8 GB', 'Android 10.0', 'Snapdragon 460','128 GB','5000 mAh', null,null, null, null,null, null,null, null,  null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT054', 'DT', N'6.53, FHD+, IPS LCD, 1080 x 2340 Pixel','16.0 MP + 8.0 MP + 2.0 MP-16.0 MP', null, '6  GB', 'Android 9.0', 'Helio P65','128 GB','5000 mAh', null, null,null,null, null,null, null, null, null,  N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT055', 'DT', N'6.22, HD+, IPS LCD, 720 x 1520 Pixel','13.0 MP-5.0 MP', null, '2 GB', 'Android 10.0', 'MediaTek Helio P35','32  GB','4030 mAh', null, null,null, null,null, null, null,null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT056', 'DT', N'6.8, FHD+, IPS LCD, 1080 x 2400 Pixel','64.0 MP + 12.0 MP + 2.0 MP + 2.0 MP-24.0', null, '8 GB', 'Android 10.0', 'MediaTek Helio P35','128 GB','4030 mAh', null,null,null, null,null, null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT057', 'DT', N'6.5, HD+, IPS LCD, 720 x 1600 Pixel','13.0 MP + 2.0 MP-5.0 MP', null, '2 GB', 'Android 10.0', 'PowerVR','32  GB','4500 mAh', null, null,null,null, null,null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT058', 'DT', N'2.8, QVGA, TFT, 320 x 240 Pixel','2.0 M', null, '512  GB', 'Android 10.0', 'Adreno 304','4 GB','1500  mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT059', 'DT', N'22.8, QVGA, TFT, 240 x 320 Pixel','2.0 MP-2.0 MP', null, N'Đang cập nhật', N'Không', N'Đang cập nhật',N'Đang cập nhật','1200 mAh', null,null, null,null, null,null, null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT060', 'DT', N'2.8, QVGA, TFT, 240 x 320 Pixel',null, null, '64 MB', 'Nokia S30+', N'Không','128 MB','1150 mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT061', 'DT', N'1.77, QQVGA, TFT, 120 x 160 Pixel',null, null, '4 MB', 'Android 10.0', 'Không','4 MB','800 mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'18 tháng')
Insert into ChiTietSanPham values('DT062', 'DT', N'6.26, FHD+, IPS LCD, 1080 x 2340 Pixel','48.0 MP + 16.0 MP + 2.0 MP + 2.0 MP-32.0', null, '8 GB', 'Android 10.0', 'Kirin 980','128 MB','3750 mAh', null, null,null, null,null, null, null, null, null, N'Trung Quốc', N'18 tháng') 
Insert into ChiTietSanPham values('DT063', 'DT', N'6.4, FHD+, LCD, 1080 x 2312 Pixel','48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP-16.0 MP', null, '8 GB', 'Android 10.0', 'Mali-G52','128 MB','4200 mAh', null,null,null, null,null, null, null, null, null,  N'Trung Quốc', N'12 tháng')   
Insert into ChiTietSanPham values('DT064', 'DT', N'6.3, HD+, IPS LCD, 720 x 1600 Pixel','13.0 MP + 5.0 MP + 2.0 MP-8.0 MP', null, '4 GB', 'Android 10.0', 'MediaTek Helio P22 (MT6762R)','64 GB','5000 mAh',null, null,null, null, null, null,null,  null, null, N'Trung Quốc', N'12 tháng')  
Insert into ChiTietSanPham values('DT065', 'DT', N'5.0, HD, IPS, 720 x 1280 Pixel','5.0 MP', null, '2 GB', 'Android 10.0', 'IMG GE8100','16 GB','2000 mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')  
Insert into ChiTietSanPham values('DT066', 'DT', N'2.2, FWVGA, TFT, 176 x 220 Pixel','0.08 MP', null, '32 GB', 'Android 10.0', 'Không','32 GB','1400 mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')  
Insert into ChiTietSanPham values('DT067', 'DT', N'1.77, QVGA, TFT, 128 x 160 Pixel','0.3 MP', null, N'Đang cập nhật', 'Không', N'Không',N'Không cập nhật','1000  mAh', null, null,null, null, null,null, null, null,null, N'Trung Quốc', N'12 tháng')  
Insert into ChiTietSanPham values('DT068', 'DT', N'2.4, QVGA, TFT, 320 x 240 Pixel','0.08 MP', null, '32 GB', 'Không', 'Không','32 GB','2500 mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')  
Insert into ChiTietSanPham values('DT069', 'DT', N'2.4, QVGA, TFT, 240 x 320 Pixels','0.08 MP', null, '32 GB', 'Không', 'Không','32 GB','1700 mAh', null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')  
Insert into ChiTietSanPham values('DT070', 'DT', N'1.77, QQVGA, TFT, 128 x 160 Pixel','0.3 MP', null, '32 GB', 'Không', 'Không','32 GB','800 mAh', null, null, null, null,null, null,null, null, null,N'Trung Quốc', N'12 tháng') 

Insert into ChiTietSanPham values('LT071', 'LT', N'16.0", 3072 x 1920 Pixel, IPS, IPS LCD LED Backlit, True Tone, IPS LCD LED Backlit, True Tone',null, 'SSD 1 TB', '16 GB, DDR4, 2666 MHz', 'Mac OS', 'Intel Core i9-9th-gen','128 MB',null, null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT072', 'LT', N'13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone',null, 'SSD 256 GB', '16 GB, DDR4, 2666 MHz', 'Mac OS', 'Intel Core i5-8th-gen',null,null, null,null, null, null,null,null, null, null, null,N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT073', 'LT', N'13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone',null, 'SSD 256 GB', ' LPDDR3, 2133 MHz, LPDDR3, 2133 MHz', 'Mac OS', 'Intel Iris Plus Graphics 645',null,null, null,null, null, null, null,null, null,null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT074', 'LT', N'13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone',null, 'SSD 512 GB', '8 GB, LPDDR4, 3733 MHz', 'Mac OS', 'Intel Core i5-10th-gen',null,null,null, null,null, null,null, null,  null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT074', 'LT', N'13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone',null, 'SSD 512 GB', '8 GB, LPDDR4, 3733 MHz', 'Mac OS', 'Intel Core i5-10th-gen',null,null,null,null, null, null, null, null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT075', 'LT', N'13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone',null, 'SSD 256 GB', '8 GB, LPDDR4, 3733 MHz', 'Mac OS', 'Intel Core i3-10th-gen',null,null,null,null, null, null, null, null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT076', 'LT', N'13.3", 1440 x 900 Pixel, LED-backlit',null, 'SSD 128 GB', '8 GB, LPDDR4, 3733 MHz', 'Mac OS', 'Intel Core i5-5th-gen',null,null, null, null,null, null, null,null, null,null, null,  N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT077', 'LT', N'13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone',null, 'SSD 256 GB', '8 GB', 'Mac OS', 'Apple M1',null,null, null, null,null, null, null, null, null,null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT078', 'LT', N'13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone',null, 'SSD 256 GB', '8 GB, LPDDR3, 2133 MHz', 'Mac OS', 'Intel Core i5-8th-gen',null,null, null,null,null, null, null, null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT079', 'LT', N'13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone',null, 'SSD 512 GB', '8 GB, DDR4, 2666 MHz', 'Mac OS', 'Intel Core i3-1005G1',null,null,null, null, null,null, null,null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT080', 'LT', N'14.0", 1920 x 1080 Pixel, 60 Hz, LED-backlit',null, 'SSD 512 GB', '4 GB, DDR4, 2400 MHz', 'Windows 10', 'Intel Core i3-1005G1',null,null, null,null, null, null, null,null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT081', 'LT', N'14.0", 1920 x 1080 Pixel, 60 Hz, LED-backlit',null, 'SSD 256 GB', '4 GB, DDR4, 2400 MHz', 'Windows 10', 'Intel Pentium N5000',null,null, null,null, null, null, null,null, null,null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT082', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 144 Hz, 250 nits, LED Backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2933 MHz', 'Windows 10', 'Intel Core i7-10610U',null,null,null, null,null, null,null, null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT083', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 144 Hz, 250 nits, Anti-glare LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2933 MHz', 'Windows 10', 'Intel Core i7-10610U',null,null, null,null, null,null, null, null, null, null,null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT084', 'LT', N'114.0", 1920 x 1080 Pixels, 60Hz, Anti-Glare with 45% NTSC, TN, 60 Hz, 200 nits, FHD',null, 'SSD 512 GB', '8 GB, DDR4, 3200 MHz', 'Windows 10', 'AMD Ryzen 5-4500U',null,null, null, null, null,null, null, null, null, null,null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT085', 'LT', N'15.6", 1920 x 1080 Pixel, WVA, 120 Hz, 250 nits, WVA Anti-glare LED Backlit Narrow Border',null, 'SSD 512 GB', '16 GB, DDR4, 2933 MHz', 'Windows 10', 'Intel Core i7-10750H', null,null, null, null,null,null, null,null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT086', 'LT', N'13.4", 1920 x 1080 Pixel, WVA, 60 Hz, 400 nits, LED-backlit',null, 'SSD 256 GB', '8 GB, LPDDR4, 4266 MHz', 'Windows 10', 'Intel Core i5-1135G7',null,null,null, null, null,null, null, null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT087', 'LT', N'13.4", 1920 x 1080 Pixel, WVA, 60 Hz, 400 nits, LED-backlit',null, 'SSD 512 GB', '8 GB, LPDDR4, 4266 MHz', 'Windows 10', 'Intel Core i5-1135G7',null,null,null, null, null,null, null, null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT088', 'LT', N'13.3", Truelife LED-Backlit',null, 'SSD 512 GB', '8 GB, LPDDR4, 4266 MHz', 'Windows 10', 'Intel Core i5-1135G7',null, null, null,null, null,null, null,null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT089', 'LT', N'15.6", 1920 x 1080 Pixel',null, 'HDD 1 TB', '16 GB, DDR4, 3200 MHz', 'Windows 10', 'Intel Core i5-8265U',null,null, null, null,null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT090', 'LT', N'13.3", Truelife LED-Backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2400 MHz', 'Windows 10', 'AMD Ryzen 7-3700U',null,null, null,null, null, null,null, null, null,null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT091', 'LT', N'14.0", 1920 x 1080 Pixel, TN, 60 Hz, 220 nits, Anti-glare LED-backlit',null, 'SSD 128 GB', '4 GB, DDR4', 'Windows 10', 'Intel Core i3-10110U',null,null,null, null,null, null,null, null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT092', 'LT', N'14.0", 1920 x 1080 Pixel, TN, 60 Hz, 220 nits, Anti-glare LED-backlit',null, N'Đang cập nhật', '4 GB, DDR4', 'Windows 10', 'Intel Core i3-7020U',null,null,null, null, null,null,  null,null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT093', 'LT', N'15.6", 1920 x 1080 Pixel, WVA, 60 Hz, 220 nits',null, N'Đang cập nhật', '4 GB, DDR4', 'Windows 10', 'Intel Core i3-1005G1',null,null, null,null, null, null, null,null, null,null, null,  N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT094', 'LT', N'15.6", 1920 x 1080 Pixel, WVA, 60 Hz, 220 nits',null, 'SSD 256 GB', '4 GB, DDR4', 'Windows 10', 'Intel Core i3-1005G1',null,null,null, null, null, null, null,null, null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT095', 'LT', N'14.0", 1920 x 1080 Pixel, LED-backlit',null, 'SSD 256 GB', '4 GB, DDR4', 'Windows 10', 'Intel Core i3-1005G1',null, null,null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT096', 'LT', N'14.0", 1920 x 1080 Pixel, LED-backlit',null, 'SSD 512 GB', '16 GB, DDR4, 2933 MHz', 'Windows 10', 'Intel Core i5-10300H',null,null,null, null, null, null, null,null, null,null, null, N'Trung Quốc', N'12 tháng') 
Insert into ChiTietSanPham values('LT097', 'LT', N'14.0", 1920 x 1080 Pixel, LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i5-10300H',null,null, null,null, null, null, null,null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT098', 'LT', N'14.0", 1920 x 1080 Pixel, LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2400 MHz', 'Windows 10', 'Intel Core i5-8265U',null,null, null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT099', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2666 MHz', 'Windows 10', 'AMD Ryzen 5-3550H',null, null, null, null,null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT100', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit',null, 'HDD 1 TB', '4 GB, DDR4, 2666 MHz', 'Windows 10', 'AMD Ryzen 5-3550H',null,null, null, null, null, null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT101', 'LT', N'15.6", 1920 x 1080 Pixel',null, 'HDD 1 TB', '4 GB, DDR4, 2666 MHz', 'Windows 10', 'AMD Ryzen 5-2500U',null, null, null, null,null,null, null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT102', 'LT', N'14.0", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit',null, 'SSD 512 GB', '4 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i3-1005G1',null,null,null, null, null, null, null,null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT103', 'LT', N'15.6", 1920 x 1080 Pixel, TN, 60 Hz, Acer ComfyView LED-backlit',null, 'SSD 512 GB', '4 GB, DDR4, 2666 MHz', 'Windows 10', 'AMD Ryzen 5-3500U',null,null,null, null, null, null, null, null,null, null, null, N'Trung Quốc', N'12 tháng')

Insert into ChiTietSanPham values('LT104', 'LT', N'15.6", 1920 x 1080 Pixel, 60 Hz, LED-backlit',null, 'SSD 256 GB', '4 GB, DDR4, 2400 MHz', 'Windows 10', 'AMD Ryzen 3-3250U',null,null, null,null, null, null, null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT105', 'LT', N'15.6", 1280 x 720 Pixel, Acer ComfyView LED-backlit',null, 'SSD 256 GB', '4 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Celeron N4020',null,null,null, null,null, null, null, null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT106', 'LT', N'13.3", 1920 x 1080 Pixel, IPS, BrightView Micro-edge WLED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2400 MHz', 'Windows 10', 'Intel Core i7-10510U',null, null,null, null, null,null,null, null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT107', 'LT', N'13.3", 1920 x 1080 Pixel, IPS, BrightView Micro-edge WLED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2400 MHz', 'Windows 10', 'Intel Core i7-10510U',null, null,null, null, null,null,null, null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT108', 'LT', N'13.3", 1920 x 1080 Pixel, IPS, 60 Hz, 300 nits, Micro-edge WLED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 3200 MHz', 'Windows 10', 'Intel Core i5-1035G4',null, null,null, null, null,null, null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT109', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 60 Hz, BrightView Micro-edge WLED-backlit, IPS, 60 Hz, 300 nits, Micro-edge WLED-backlit',null, 'SSD 512 GB', '8 GB, LPDDR4, 3200 MHz', 'Windows 10', 'Intel Core i5-1135G7',null,null,null, null,null, null, null, null,null, null, null,  N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT110', 'LT', N'14.0", 1920 x 1080 Pixel, IPS, 60 Hz, 250 nits, WLED-backlit',null, 'SSD 512 GB', '4 GB, DDR4, 3200 MHz', 'Windows 10', 'Intel Core i3-1005G1',null,null, null,null, null, null,null,null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT111', 'LT', N'15.6", 1366 x 768 Pixel, SVA, 60 Hz, 220 nits, Micro-edge WLED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i3-1005G1',null, null,null, null, null,null,null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT112', 'LT', N'14.0", 1920 x 1080 Pixel, 60 Hz, LED-backlit',null, 'SSD 512 GB', '4 GB, DDR4, 2400 MHz', 'Windows 10', 'Intel Core i3-8145U',null,null,null, null, null, null,null, null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT113', 'LT', N'14.0", 1366 x 768 Pixel, 60 Hz, 220 nits, WLED-backlit',null, 'SSD 256 GB', '4 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i3-8130U',null,null,null,null, null,null, null, null,  null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT114', 'LT', N'14.0", 1366 x 768 Pixel, 60 Hz, 220 nits, WLED-backlit',null, 'SSD 256 GB', '16 GB, LPDDR4, 3200 MHz', 'Windows 10', 'Intel Core i7-1065G7',null,null, null,null, null,null, null, null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT115', 'LT', N'14.0", 1920 x 1080 Pixel, TN, 220 nits, LED-backlit',null, 'SSD 256 GB', '4 GB, DDR4, 2667 MHz', 'Windows 10', 'Intel Core i3-1005G1',null,null,null,null, null,null, null, null, null,  null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT116', 'LT', N'14.0", 1920 x 1080 Pixel, TN, LED-backlit',null, 'SSD 256 GB', '4 GB, DDR4, 2667 MHz', 'Windows 10', 'Intel Core i3-1005G1',null,null, null,null, null,null, null, null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT117', 'LT', N'14.0", 1920 x 1080 Pixel, TN, LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i3-1005G1',null,null, null,null, null, null,null, null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT118', 'LT', N'14.0", 1920 x 1080 Pixel, TN, 60 Hz, 220 nits, LED-backlit',null, 'SSD 512 GB', 'GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i3-1005G1',null,null,null, null,null, null, null, null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT119', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 120 Hz, 250 nits, LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2933 MHz', 'Windows 10', '8 GB, DDR4, 2933 MHz',null,null, null,null, null,null,null, null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT120', 'LT', N'14.0", 2560 x 1440 Pixel, WVA, 60 Hz, 300 nits, WVA Anti-glare LED Backlit Narrow Border',null, 'SSD 512 GB', '16 GB, LPDDR3, 2133 MHz', 'Windows 10', '8 GB, DDR4, 2933 MHz',null, null, null, null, null,null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT121', 'LT', N'14.0", 2560 x 1440 Pixel, WVA, 60 Hz, 300 nits, WVA Anti-glare LED Backlit Narrow Border',null, 'SSD 512 GB', '16 GB, LPDDR3, 2133 MHz', 'Windows 10', 'Intel Core i7-10510U', null,null, null, null,null,null, null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT122', 'LT', N'13.0", 2160 x 1440 Pixel, IPS, 60 Hz, 300 nits',null, 'SSD 512 GB', '16 GB, LPDDR3, 2133 MHz', 'Windows 10', 'Intel Core i5-10210U',null,null, null, null,null, null, null,null,null, null,  null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT123', 'LT', N'14.0", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit',null, 'SSD 512 GB', '4 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i5-10210U',null,null, null,null, null, null,null, null,null, null, null,  N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT124', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i5-9300H',null,null, null,null, null, null,null, null, null,null, null,  N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT125', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i5-10300H',null,null, null,null, null, null,null, null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT126', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit',null, 'SSD 512 GB', '8 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i5-10300H',null, null,null, null, null,null,null, null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('LT127', 'LT', N'15.6", 1920 x 1080 Pixel, IPS, 144 Hz, 300 nits, Acer ComfyView Anti-glare LED-backlit',null, 'SSD 512 GB', '16 GB, DDR4, 2666 MHz', 'Windows 10', 'Intel Core i5-10300H',null, null,null, null,null, null, null, null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('DH128', 'DH',null,null, null, null, null, null,null,null, null, null,null, null, null, null, N'Bạc', N'DANIEL KLEIN',N'Kim loại', N'Hong Kong', N'22 tháng')
Insert into ChiTietSanPham values('DH129', 'DH',null,null, null, null, null, null,null,null, null, null,null, null, null,null, N'Vàng hồng', N'Daniel Klein DK',N'Kim loại', N'Hong Kong', N'22 tháng')
Insert into ChiTietSanPham values('DH130', 'DH',null,null,null, null, null, null,null, null, null,  null,null,null, null, null, N'Bạc', N'DANIEL KLEIN',N'Da', N'Hong Kong', N'22 tháng')
Insert into ChiTietSanPham values('DH131', 'DH',null,null,null, null, null, null,null, null, null, null,null,null, null, null, N'Bạc', N'Sinobi',N'Thép Không Gỉ', N'Hong Kong', N'22 tháng')
Insert into ChiTietSanPham values('DH132', 'DH',null,null, null, null, null, null,null,null, null, null,null, null, null, null,N'Đen', N'Ferrari',N'Cao su', N'Hong Kong', N'22 tháng')
Insert into ChiTietSanPham values('DH133', 'DH',null,null, null, null, null,null,null, null, null, null,null,null, null, null, N'Vàng', N'Ferrari',N'Kim loại', N'Hong Kong', N'22 tháng')
Insert into ChiTietSanPham values('DH134', 'DH',null,null, null, null, null,null,null, null, null, null,null,null, null, null, N'Hồng nhạt', N'Anne Klein',N'Da', N'Hong Kong', N'22 tháng')  
Insert into ChiTietSanPham values('DH135', 'DH',null,null, null, null, null, null,null,null, null, null,null,null,  null, null, N'Xanh dương', N'Fossil',N'Da', N'Hong Kong', N'22 tháng')  
Insert into ChiTietSanPham values('DH136', 'DH',null,null, null, null, null, null,null,null, null,null,null, null, null, null, N'Demi vàng ', N'Lacoste',N'Da', N'Hong Kong', N'24 tháng')  
Insert into ChiTietSanPham values('DH137', 'DH',null,null, null, null, null, null,null,null, null,  null,null, null, null, null,N'Demi vàng ', N'Lacoste',N'Da', N'Hong Kong', N'24 tháng')
Insert into ChiTietSanPham values('DH138', 'DH',null,null, null, null, null,null,null, null, null,null,null,null, null, null, N'Demi vàng ', N'Bulova',N'Thép Không Gỉ', N'Hong Kong', N'24 tháng')
Insert into ChiTietSanPham values('DH139', 'DH',null,null, null, null, null, null,null,null, null, null,null,null, null, null,N'Đen', N'Ferrari',N'Da', N'Hong Kong', N'24 tháng')
Insert into ChiTietSanPham values('DH139', 'DH',null,null, null, null, null, null,null,null, null, null,null,null, null, null,N'Đen', N'Ferrari',N'Da', N'Hong Kong', N'24 tháng')
Insert into ChiTietSanPham values('DH140', 'DH',null,null, null, null, null, null,null,null, null, null, null,null, null, null,N'Đen', N'Citizen',N'Thép Không Gỉ', N'Hong Kong', N'24 tháng')
Insert into ChiTietSanPham values('DH141', 'DH',null,null, null, null, null, null,null,null, null, null, null,null, null, null,N'Xanh', N'Bulova',N'Thép Không Gỉ', N'Hong Kong', N'24 tháng')
Insert into ChiTietSanPham values('DH142', 'DH',null,null, null, null, null, null,null,null, null, null,null,null, null, null, N'Xanh', N'Citizen',N'Da', N'Hong Kong', N'24 tháng')

Insert into ChiTietSanPham values('DH143', 'DH','38mm',null, null, null, 'watchOS', 'Apple S3',null,null, null, 'iOS', null, null,null,null,null, null, N'Cao su', N'Hong Kong', N'12 tháng')
Insert into ChiTietSanPham values('DH144', 'DH','42mm',null, null, null, 'watchOS', 'Apple S3',null,null, null, 'iOS', null,null,null, null, null,null, N'Cao su', N'Hong Kong', N'12 tháng')
Insert into ChiTietSanPham values('DH145', 'DH','40mm',null, null, null, 'watchOS', 'Apple S3',null,null, null, 'iOS',null, null,null,null, null, null,N'Cao su', N'Hong Kong', N'12 tháng')
Insert into ChiTietSanPham values('DH146', 'DH','44mm',null, null, null, 'watchOS', 'Apple S5',null,null, null, 'iOS', null, null,null, null, null,null,N'Cao su', N'Hong Kong', N'12 tháng')
Insert into ChiTietSanPham values('DH147', 'DH','44mm',null, null, null, 'watchOS', 'Apple S5',null,null, null, 'iOS', null, null,null, null, null,null,N'Cao su', N'Hong Kong', N'12 tháng')
Insert into ChiTietSanPham values('DH148', 'DH','40mm',null, null, null, 'watchOS', 'Apple S5',null,null, null, 'iOS', null,null,null, null, null,null, N'Milanese', N'Hong Kong', N'12 tháng')
Insert into ChiTietSanPham values('DH149', 'DH','40mm',null, null, null, 'watchOS', 'Apple S6',null,null, null, 'iOS', null, null,null, null, null,null,N'Cao su', N'Hong Kong', N'12 tháng')
Insert into ChiTietSanPham values('DH150', 'DH','40mm',null, null, null, 'watchOS', 'Apple S6',null,null, null, 'iOS', null, null, null, null,null,null,N'Cao su', N'Hong Kong', N'12 tháng')
Insert into ChiTietSanPham values('DH151', 'DH','40mm',null, null, null, 'watchOS', 'Apple S6',null,null, null, 'iOS', null,null,null, null, null,null,N'Thép', N'Hong Kong', N'12 tháng')

Insert into ChiTietSanPham values('TL152', 'TL', N'11.0" , WQHD+ , LTPS IPS LCD , 1600 x 2560 Pixel','5.0 MP + 13.0 MP-8.0 MP', null, '6 GB', 'Android 10.0', 'Snapdragon 865+; ','128 GB','8000 mAh', null,null,null,null, null, null, null, null, null, N'Trung Quốc', N'12 tháng')  
Insert into ChiTietSanPham values('TL153', 'TL', N'10.4" , FHD , PLS LCD , 1200 x 2000 Pixel','8.0 MP-5.0 MP', null, '4 GB', 'Android 10.0', 'Exynos 9611; ','64 GBB','7040 mAh', null,null, null, null,null,null, null, null,null,  N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL154', 'TL', N'1010.1" , FHD , TFT LCD , 1920 x 1280 Pixel','8.0 MP-5.0 MP', null, '3 GB', 'Android 10.0', 'Exynos 9611; ','32 GB','6150 mAh', null,null, null, null,null,null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL155', 'TL', N'8.0" , WUXGA , TFT , 1920 x 1200 Pixel','8.0 MP-5.0 MP', null, '3 GB', 'Android 9.0', 'Exynos 7904; ','32 GB','4200 mAh', null,null, null, null, null,null, null, null,null,N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL156', 'TL', N'8.0" , HD+ , TFT LCD , 1280 x 800 Pixel','8.0 MP-5.0 MP', null, '2 GB', 'Android 9.0', 'Snapdragon 429; ','32 GB','4200 mAh', null,null, null, null, null,null, null, null,null,N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL157', 'TL', N'8.0" , HD+ , TFT LCD , 1280 x 800 Pixel','8.0 MP10.0 MP + 12.0 MP-7.0 MP', null, '6 GB', 'iPadOS', 'A12Z Bionic; ','128 GBB','9720 mAh', null,null,null,null, null, null,null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL158', 'TL', N'8.0" , HD+ , TFT LCD , 1280 x 800 Pixel','10.0 MP + 12.0 MP-7.0 MP', null, '8 GB', 'A12Z Bionic', 'iPadOS; ','128 GBB','7540 mAh', null,null, null,null,null, null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL159', 'TL', N'7.9" , Retina HD , IPS LCD , 2048 x 1536 Pixel','12.0 MP-7.0 MP', null, '64 GB', 'A12 Bionic', 'iPadOS; ','256 GB','5124 mAh', null,null, null, null, null,null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL160', 'TL', N'10.9" , Liquid Retina HD , IPS LCD , 2360 x 1640 Pixel','8.0 MP-7.0 MP', null, '3 GB', 'A12 Bionic', 'iPadOS; ','256 GB','5124 mAh', null,null, null, null,null,null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL161', 'TL', N'10.9" , Liquid Retina HD , IPS LCD , 2360 x 1640 Pixel','8.0 MP-7.0 MP', null, '3 GB', 'A14 Bionic', 'iPadOS; ','256 GB','5124 mAh', null,null, null, null,null,null, null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL162', 'TL', N'10.2" , Retina HD , IPS LCD , 2160 x 1620 Pixel','8.0 MP-1.2 MP', null, '3 GB', 'A12 Bionic', 'iPadOS; ','32 GB;','5124 mAh',null, null, null,null, null, null,null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL163', 'TL', N'10.2" , Retina HD , IPS LCD , 2160 x 1620 Pixel','8.0 MP-1.2 MP', null, '3 GB', 'A12 Bionic', 'iPadOS; ','32 GB;',N'Đang cập nhật', null,null, null, null,null,null, null, null,null,  N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL164', 'TL', N'7.9", Retina HD , IPS LCD , 2048 x 1536 Pixel','8.0 MP-7.0 MP', null, '3 GB', 'A12 Bionic', 'iPadOS; ','32 GB;',N'5124 mAh', null,null, null, null, null,null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL165', 'TL', N'8.0", WXGA, IPS, 1280 x 800 Pixel','5.0 MP-2.0 MP', null, '1GB', 'A12 Bionic', 'Android 8.1; ','8 GB;',N'4000 mAh', null,null, null,null,null, null, null,null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL166', 'TL', N'10.1", WXGA, IPS TFT, 800 x 1280 Pixel','8.0 MP-2.0 MPP', null, '1 GB', 'Mali-T400', 'Android 8.1; ','8 GB;',N'5000 mAh',null, null, null, null, null,null, null, null,null,N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL167', 'TL', N'10.1", HD, IPS, 800 x 1280 Pixel','8.0 MP-2.0 MP', null, '3 GB', N'Đang cập nhât', 'Android 10.0; ','32 GB;',N'5000 mAh', null,null, null, null, null,null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL168', 'TL', N'10.1", WXGA, IPS, 1280 x 800 Pixel','5.0 MP-2.0 MP', null, '2 GB', N'Mali-T400', 'Android 9.0; ','16 GB;',N'5000 mAh', null, null, null, null,null,null, null, null,null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL169', 'TL', N'10.1", FHD, IPS LCD, 1920 x 1200 Pixel','5.0 MP-2.0 MPP', null, '2 GB', N'Mali-T400', 'Android 8.0 ','32 GB',N'5100 mAh', null,null, null, null, null,null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL170', 'TL', N'8.0", HD+, IPS LCD, 800 x 1280 Pixel','5.0 MP-2.0 MP', null, '2 GB', N'MediaTek MT8768', 'Android 10.0 ','32 GB;',N'5100 mAh', null,null, null, null, null,null,null, null, null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL171', 'TL', N'10.1", WUXGA, IPS TFT, 1920 x 1200 Pixel','8.0 MP-8.0 MP', null, '2 GB', N'MediaTek MT8768', 'Android 10.0','32 GB',N'5100 mAh', null,null, null,null,null, null, null,null, null,  N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('TL172', 'TL', N'9.6", HD, IPS, 720 x 1280 Pixel','5.0 MP-2.0 MP', null, '2 GB', N'MediaTek MT8768', 'Android 7.0','16 GB;',N'4800 mAh', null, null, null,null,null, null, null,null, null, N'Trung Quốc', N'12 tháng')

Insert into ChiTietSanPham values('PK173', 'PK', null,null, null, null ,null,null, null,null, null, 'USB',null,null,null,null, null, 'Rapoo',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK174','PK',  null, null,null,  null ,null,null, null,null, null, 'Wireless', null,null,null,null,null,  'Zadez',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK175', 'PK', null,null, null, null ,null,null, null,null, null, 'Bluetooth', null,null,null,null, null, 'HP',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK176', 'PK', null,null, null, null ,null,null, null,null, null, 'Wireless',null, null,null,null, null, 'Microsoft',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK177', 'PK', null,null, null, null ,null,null, null,null, null, 'USB', null,null,null,null, null, 'Asus',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK178', 'PK', null,null, null, null ,null,null, null,null, null, 'USB', null,null,null,null, null, 'Zadez',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK179', 'PK', null,null, null, null ,null,null, null,null, null, 'USB', null,null,null,null, null, 'Zadez',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK180', 'PK', null,null, null, null ,null,null, null,null, null, 'USB', null,null,null,null, null, 'Zadez',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK181', 'PK', null,null, null, null ,null,null, null,null, null, 'USB', null,null,null,null, null, 'Logitech',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK182', 'PK', null,null, null, null ,null,null, null,null, null, 'USB', null,null,null,null, null, 'Logitech',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK183', 'PK', null,null, null, null ,null,null, null,null, null, 'USB', null,null,null,null, null, 'Apple',null, N'Trung Quốc', N'12 tháng')

Insert into ChiTietSanPham values('PK184', 'PK', null,null, null, null ,null,null, null,'7000 mAah', null, '5V/2A-2', N'Quản lý nguồn,Tự động cân bằng thời gian sạc và hiệu chỉnh dòng',null,null,null, N'Đen' ,'i.value',N'Nhựa ABS', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK185', 'PK', null,null, null, null ,null,null, null,'10000 mAah', null, '5V/1A, 5V/2A-5V/2A', N'Quản lý nguồn,Tự động cân bằng thời gian sạc và hiệu chỉnh dòng',null,null,null, N'Xanh', 'i.value',N'Nhựa ABS', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK186', 'PK', null,null, null, null ,null,null, null,'10000 mAah', null, '5V/3A - 9V/2A-MicroUSB', N'Hỗ trợ sạc không dây cho các thiết bị hỗ trợ chuẩn QI, Tự động cân bằng thời gian sạc và hiệu chỉnh dòng',null,null,null, N'Đen', 'i.value',N'ABS+PC Rubber Coating', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK187', 'PK', null,null, null, null ,null,null, null,'10000 mAah', null, '5V/2.4A-5V/2A, 9V/2A', N'Tích hợp công nghệ Sạc nhanh In-Out giúp giảm ngắn thời gian sạc thiết bị một cách nhanh chóng. - Tương thích sạc cùng lúc 2 thiết bị khác nhau. - 2 cổng sạc vào tiện lợi thích hợp với Androi và Ios - Tự tắt nguồn sau 10s không sử dụng',null,null,null, N'Đen', 'i.value',N'Nhôm', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK188', 'PK', null,null, null, null ,null,null, null,'10000 mAah', null, '5V/1A, 5V/2A-5V/2A', N'Tích hợp công nghệ Sạc nhanh In-Out giúp giảm ngắn thời gian sạc thiết bị một cách nhanh chóng. - Tương thích sạc cùng lúc 2 thiết bị khác nhau. - 2 cổng sạc vào tiện lợi thích hợp với Androi và Ios - Tự tắt nguồn sau 10s không sử dụng	Quản lý nguồn, Tự động cân bằng thời gian sạc và hiệu chỉnh dòng',null,null,null, N'Trắng', 'i.value',N'Nhựa ASB', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK189', 'PK', null,null, null, null ,null,null, null,'10000 mAah', null, '5V - 3A, 9V - 2A, 15V - 1.2 A, 5V - 2.4A-5V - 3A, 9V - 2A, 15V - 1.2 A', N'sạc chuẩn USB-C, có PD, sạc chuẩn USB-A',null,null,null, N'Trắng', 'Anker',N'Nhựa', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK190', 'PK', null,null, null, null ,null,null, null,'10000 mAah', null, '5V-3A, 5V=3A, 9V=3A, 15V=2A, 20=1,25A- 5V=3A, 9V=3A', N'ssạc nhanh power delivery',null,null,null, N'Trắng', 'Anker',N'Nhựa', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK191', 'PK', null,null, null, null ,null,null, null,'10000 mAah', null, '5V/2A, 5V/2A-5V/2A', N'Quản lý nguồn, Tự động cân bằng thời gian sạc và hiệu chỉnh dòng',null,null,null, N'Trắng', 'i.value',N'Nhựa', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK192', 'PK', null,null, null, null ,null,null, null,'10000 mAah', null, '5V/2A, 5V/2A-5V/2A', N'Quản lý nguồn, Tự động cân bằng thời gian sạc và hiệu chỉnh dòng',null,null,null, N'Xanh', 'i.value',N'Nhựa', N'Trung Quốc', N'12 tháng')

Insert into ChiTietSanPham values('PK193', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống trầy xước, Tương thích với sạc không dây MagSafe ','iPhone 12 Pro Max',null,null, N'Baltic Blue', 'Apple',N'Nhựa', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK194', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống trầy xước, Tương thích với sạc không dây MagSafe ','iPhone 12 ',null,null, N'Clear', 'Apple',N'Nhựa', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK195', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống trầy xước, Tương thích với sạc không dây MagSafe ','iPhone 12 ',null,null, N'Clear', 'Apple',N'Silion', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK196', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống trầy xước, Tương thích với sạc không dây MagSafe ','iPhone 12 Pro Max',null,null, N'Black', 'Apple',N'Silion', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK197', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPhone 12 mini',null,null, N'Baltic Nude', 'Meetu',N'Silion', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK198', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPhone 12',null,null, N'Ice', 'UAG',N'Silion', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK199', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPhone 12 Pro',null,null, N'Ice', 'UAG',N'Silion', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK200', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPhone 12 Pro',null,null, N'Midnigh Camo', 'UAG',N'Nhựa', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK201', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPhone 12 Pro',null,null, N'Midnigh Camo', 'UAG',N'Da', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK202', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPhone 12 Pro',null,null, N'Baltic Blue', 'Apple',N'Da', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK203', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPad 10.2 2019',null,null, N'Black', 'Apple',N'Da', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK204', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPad Pro 12.9 2018',null,null, N'Black', 'Apple',N'Da', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK205', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống sốc','iPhone 6 Plus',null,null, N'MT-2020003', 'Apple',N'Nhựa', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK206', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống trầy xước','iPhone 11',null,null, N'MT-2020003', 'Apple',N'Nhựa', N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK207', 'PK', null,null, null, null ,null,null, null,null, null, null, N'Chống trầy xước','iPhone 7 Plus',null,null, N'MT-2020003', 'Meetu',N'Nhựa', N'Trung Quốc', N'12 tháng')

Insert into ChiTietSanPham values('PK208', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI','iPadOS',null,null, N'Space Grey', 'Apple',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK209', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI','iPadOS',null,null, N'Black', 'Apple',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK210', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI','iPadOS',null,null, N'Đen Led RGB ', 'HYPERX',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK211', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI','iPadOS',null,null, N'Đen Led RGB ', 'Microsoft',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK212', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI','iPadOS',null,null, N'Đen Led RGB ', 'Prolink',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK213', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI','iPadOS',null,null, N'Đen Led RGB ', 'Logitech',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK214', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI','MacOS, iOS, iPadOS, Windows',null,null, N'Đen Led RGB ', 'Apple',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK215', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím chơi game chuyên dụng, switch Membrance (bán cơ) bền bỉ có khả năng kháng nước, tích hợp đèn nền LED. 11 phím multimedia, 26 phím N-Rollover, in laser, chất liệu ABS, nút khóa WIN.Hỗ trợ Macro Editor qua phần mềm, 4 phím nóng tổ hợp marco','MacOS, iOS, iPadOS, Windows',null,null, N'Đen', 'Zadez',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK216', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Bàn phím chơi game chuyên dụng, switch Membrance (bán cơ) bền bỉ có khả năng kháng nước, tích hợp đèn nền LED. 11 phím multimedia, 26 phím N-Rollover, in laser, chất liệu ABS, nút khóa WIN.Hỗ trợ Macro Editor qua phần mềm, 4 phím nóng tổ hợp marco','MacOS, iOS, iPadOS, Windows',null,null, N'Đen', 'Zadez',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK217', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Thiết kế sang trọng, âm thanh đỉnh cao., Trang bị tính năng chống ồn chủ động (NFC), điều chỉnh âm thanh (Adaptive EQ), chế độ xuyên âm (Transparency Mode) và âm thanh vòm (Spatial Audio)., Điều khiển thông minh với nút Digital Crown','MacOS, iOS, iPadOS, Windows',null,null, N'Đen', 'Apple',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK218', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Thiết kế sang trọng, âm thanh đỉnh cao., Trang bị tính năng chống ồn chủ động (NFC), điều chỉnh âm thanh (Adaptive EQ), chế độ xuyên âm (Transparency Mode) và âm thanh vòm (Spatial Audio)., Điều khiển thông minh với nút Digital Crown','Windows® 10, Windows 8.1, Windows 7, Mac, Nintendo Switch, PlayStation 4, Xbox One',null,null, N'Đen', 'Apple',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK219', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Thiết kế sang trọng, âm thanh đỉnh cao., Trang bị tính năng chống ồn chủ động (NFC), điều chỉnh âm thanh (Adaptive EQ), chế độ xuyên âm (Transparency Mode) và âm thanh vòm (Spatial Audio)., Điều khiển thông minh với nút Digital Crown','iPhone, iPad, iPod, Apple Watch, Apple TV',null,null, N'Đen', 'Samsung',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK220', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Tất cả điện thoại, máy tính bảng, laptop, có tích hợp bluetooth','iPhone, iPad, iPod, Apple Watch, Apple TV',null,null, N'Đen', 'Sony',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK221', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Tất cả điện thoại, máy tính bảng, laptop, có tích hợp bluetooth','iPhone, iPad, iPod, Apple Watch, Apple TV',null,null, N'Đen', 'Sony',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK222', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Tất cả điện thoại, máy tính bảng, laptop, có tích hợp bluetooth','iPhone, iPad, iPod, Apple Watch, Apple TV',null,null, N'Đỏ đen', 'i.value',null, N'Trung Quốc', N'12 tháng')
Insert into ChiTietSanPham values('PK223', 'PK', null,null, null, null ,null,null, null,null, null, N'Smart Connector', N'Tất cả điện thoại, máy tính bảng, laptop, có tích hợp bluetooth','iPhone, iPad, iPod, Apple Watch, Apple TV',null,null, N'Đỏ đen', 'i.value',null, N'Trung Quốc', N'12 tháng')

Insert into ChiTietSanPham values('S224','S', null,null, null, null ,null,null, null,null, N'2GB/ngày data tốc độ cao. Hết dung lượng ngưng kết nối; Miễn phí truy cập FPT Play', N'Đăng ký: DK ITEL79 gửi 8968; Kiểm tra KM: TRACUU ITEL79 gửi 8968;Hủy: HUY ITEL79 gửi 8968', null, null,null,null,null, null,null, null,null)
Insert into ChiTietSanPham values('S225','S', null,null, null, null ,null,null, null,null, N'6GB/ngày. Hết 6GB hạ băng thông 128Kbps
', N'Đăng ký: DK THANHLUOT gửi 345; Kiểm tra KM: *101# OK hoặc *102# OK:Hủy: HUY THANHLUOT gửi 345', null, null,null,null,null, null,null, null,null)
Insert into ChiTietSanPham values('S225','S', null,null, null, null ,null,null, null,null, N'6GB/ngày. Hết 6GB hạ băng thông 128Kbps
', N'Đăng ký: DK THANHLUOT gửi 345; Kiểm tra KM: *101# OK hoặc *102# OK:Hủy: HUY THANHLUOT gửi 345', null, null,null,null,null, null,null, null,null)
Insert into ChiTietSanPham values('S226','S', null,null, null, null ,null,null, null,null, N'6GB/ngày. Hết 6GB hạ băng thông 128Kbps
', N'Đăng ký: DK THANHLUOT gửi 345; Kiểm tra KM: *101# OK hoặc *102# OK:Hủy: HUY THANHLUOT gửi 345', null, null,null,null,null, null,null, null,null)
Insert into ChiTietSanPham values('S227','S', null,null, null, null ,null,null, null,null, N'6GB/ngày. Hết 6GB hạ băng thông 128Kbps', N'Đăng ký: DK THANHLUOT gửi 345; Kiểm tra KM: *101# OK hoặc *102# OK:Hủy: HUY THANHLUOT gửi 345', null, null,null,null,null, null,null, null,null)

Insert into ChiTietSanPham values('PK228', 'S',null, null, null, null, null,null,null,'32 GB',null, '100MB/s',null, null, null,null,null, 'Toshiba', null,null,N'12 tháng')
Insert into ChiTietSanPham values('PK229', 'S',null, null, null, null, null,null,null,'16 GB',null, '100MB/s',null, null, null,null,null, 'Adata', null,null,N'12 tháng')
Insert into ChiTietSanPham values('PK229', 'S',null, null, null, null, null,null,null,'16 GB',null, '100MB/s',null, null, null,null,null, 'Adata', null,null,N'12 tháng')
Insert into ChiTietSanPham values('PK230', 'S',null, null, null, null, null,null,null,'16 GB',null, '100MB/s',null, null, null,null,null, 'Adata', null,null,N'12 tháng')
Insert into ChiTietSanPham values('PK231', 'S',null, null, null, null, null,null,null,'16 GB',null, '100MB/s',null, null, null,null,null, 'Adata', null,null,N'12 tháng')
Select * from ChiTietSanPham
--delete from ChiTietSanPham

Insert into HoaDon values ('HD01', 'NV08', 'KH01')
Insert into HoaDon values ('HD02', 'NV08', 'KH02')
Insert into HoaDon values ('HD03', 'NV07', 'KH03')
Insert into HoaDon values ('HD04', 'NV07', 'KH04')
Insert into HoaDon values ('HD05', 'NV07', 'KH05')
Insert into HoaDon values ('HD06', 'NV07', 'KH06')
Insert into HoaDon values ('HD07', 'NV08', 'KH07')
Insert into HoaDon values ('HD08', 'NV07', 'KH08')
Insert into HoaDon values ('HD09', 'NV08', 'KH09')
Insert into HoaDon values ('HD10', 'NV08', 'KH10')
Insert into HoaDon values ('HD11', 'NV07', 'KH11')
Insert into HoaDon values ('HD12', 'NV08', 'KH13')
Insert into HoaDon values ('HD13', 'NV07', 'KH14')
Insert into HoaDon values ('HD14', 'NV08', 'KH15')
Insert into HoaDon values ('HD15', 'NV08', 'KH15')
Insert into HoaDon values ('HD16', 'NV07', 'KH16')
Insert into HoaDon values ('HD17', 'NV08', 'KH17')
Insert into HoaDon values ('HD18', 'NV08', 'KH18')
Insert into HoaDon values ('HD19', 'NV07', 'KH19')
Insert into HoaDon values ('HD20', 'NV08', 'KH20')
Insert into HoaDon values ('HD21', 'NV07', 'KH20')
Insert into HoaDon values ('HD22', 'NV07', 'KH11')
Insert into HoaDon values ('HD23', 'NV07', 'KH13')
Insert into HoaDon values ('HD24', 'NV08', 'KH09')
Insert into HoaDon values ('HD25', 'NV08', 'KH16')
Insert into HoaDon values ('HD26', 'NV08', 'KH18')
Insert into HoaDon values ('HD27', 'NV08', 'KH01')
Insert into HoaDon values ('HD28', 'NV08', 'KH13')
Insert into HoaDon values ('HD29', 'NV08', 'KH11')
Insert into HoaDon values ('HD30', 'NV08', 'KH10')
Insert into HoaDon values ('HD31', 'NV07', 'KH20')
Insert into HoaDon values ('HD32', 'NV07', 'KH11')
Insert into HoaDon values ('HD33', 'NV07', 'KH13')
Insert into HoaDon values ('HD34', 'NV08', 'KH09')
Insert into HoaDon values ('HD35', 'NV08', 'KH14')
Insert into HoaDon values ('HD36', 'NV08', 'KH08')
Insert into HoaDon values ('HD37', 'NV08', 'KH05')
Insert into HoaDon values ('HD38', 'NV07', 'KH02')
Insert into HoaDon values ('HD39', 'NV07', 'KH03')
Insert into HoaDon values ('HD40', 'NV07', 'KH01')
Insert into HoaDon values ('HD41', 'NV08', 'KH09')
Insert into HoaDon values ('HD42', 'NV08', 'KH14')
Insert into HoaDon values ('HD43', 'NV08', 'KH08')
Insert into HoaDon values ('HD44', 'NV08', 'KH05')
Insert into HoaDon values ('HD45', 'NV07', 'KH02')
Insert into HoaDon values ('HD46', 'NV07', 'KH03')
Insert into HoaDon values ('HD47', 'NV07', 'KH01')
Select * from HoaDon

Set DateFormat DMY
Insert into ChiTietHoaDon values ('CTHD001','HD01', 'DT001', 5, 10995000, '12-12-2020','true')
Insert into ChiTietHoaDon values ('CTHD002','HD02', 'DT002', 1, 24990000, '10-10-2020','true')
Insert into ChiTietHoaDon values ('CTHD003','HD03', 'DT003', 1, 30990000, '01-09-2020','true')
Insert into ChiTietHoaDon values ('CTHD004','HD04', 'DT004', 1, 33990000, '11-11-2020','true')
Insert into ChiTietHoaDon values ('CTHD005','HD05', 'DT005', 1, 17990000, '09-12-2020','true')

Insert into ChiTietHoaDon values ('CTHD006','HD06', 'DT011', 8, 400000000, '08-11-2020','true')
Insert into ChiTietHoaDon values ('CTHD007','HD07', 'DT012', 1, 29000000, '30-01-2020','true')
Insert into ChiTietHoaDon values ('CTHD008','HD08', 'DT013', 7, 23990000, '12-12-2020','true')
Insert into ChiTietHoaDon values ('CTHD009','HD09', 'DT014', 1, 21990000, '05-10-2020','true')
Insert into ChiTietHoaDon values ('CTHD010','HD10', 'DT015', 1, 12990000, '29-10-2020','true')

Insert into ChiTietHoaDon values ('CTHD011','HD11', 'DT025', 8, 400000000, '12-01-2020','true')
Insert into ChiTietHoaDon values ('CTHD012','HD12', 'DT026', 5, 59950000,'28-02-2020','true')
Insert into ChiTietHoaDon values ('CTHD013','HD13', 'DT027', 1, 4990000, '11-11-2020','true')
Insert into ChiTietHoaDon values ('CTHD014','HD14', 'DT028', 1, 5690000, '22-12-2020','true')
Insert into ChiTietHoaDon values ('CTHD015','HD15', 'DT029', 1, 6190000, '30-12-2020','true')

Insert into ChiTietHoaDon values ('CTHD016','HD16', 'DT033', 1, 7490000, '11-11-2020','true')
Insert into ChiTietHoaDon values ('CTHD017','HD17', 'DT034', 1, 4590000, '15-09-2020','true')
Insert into ChiTietHoaDon values ('CTHD018','HD18', 'DT035', 1, 3290000, '09-06-2020','true')
Insert into ChiTietHoaDon values ('CTHD019','HD19', 'DT036', 1, 2490000, '01-04-2020','true')
Insert into ChiTietHoaDon values ('CTHD020','HD20', 'DT037', 10, 15900000, '06-01-2020','true')

Insert into ChiTietHoaDon values ('CTHD021','HD21', 'DT038', 1, 12990000, '11-11-2020','true')
Insert into ChiTietHoaDon values ('CTHD022','HD22', 'DT039', 1, 6990000, '15-09-2020','true')
Insert into ChiTietHoaDon values ('CTHD023','HD23', 'DT040', 1, 6990000, '09-06-2020','true')
Insert into ChiTietHoaDon values ('CTHD024','HD24', 'DT041', 1, 4490000, '01-04-2020','true')
Insert into ChiTietHoaDon values ('CTHD025','HD25', 'DT042', 8, 28720000, '06-01-2020','true')

Insert into ChiTietHoaDon values ('CTHD026','HD26', 'DT045', 1, 6290000, '12-12-2020','true')
Insert into ChiTietHoaDon values ('CTHD027','HD27', 'DT046', 1, 5490000, '10-10-2020','true')
Insert into ChiTietHoaDon values ('CTHD028','HD28', 'DT047', 1, 4190000, '01-09-2020','true')
Insert into ChiTietHoaDon values ('CTHD029','HD29', 'DT048', 1, 3690000, '11-11-2020','true')
Insert into ChiTietHoaDon values ('CTHD030','HD30', 'DT049', 1, 2990000, '09-12-2020','true')

Insert into ChiTietHoaDon values ('CTHD031','HD31', 'DT050', 1, 8190000, '11-11-2020','true')
Insert into ChiTietHoaDon values ('CTHD032','HD32', 'DT051', 1, 7990000, '15-09-2020','true')
Insert into ChiTietHoaDon values ('CTHD033','HD33', 'DT052', 1, 6290000, '09-06-2020','true')
Insert into ChiTietHoaDon values ('CTHD034','HD34', 'DT053', 1, 4490000, '01-04-2020','true')
Insert into ChiTietHoaDon values ('CTHD035','HD35', 'DT054', 8, 31920000, '06-01-2020','true')

Insert into ChiTietHoaDon values ('CTHD036','HD36', 'DT057', 1, 11990000, '12-12-2020','true')
Insert into ChiTietHoaDon values ('CTHD037','HD37', 'DT058', 1, 2490000, '10-10-2020','true')
Insert into ChiTietHoaDon values ('CTHD038','HD38', 'DT059', 1, 1790000, '01-09-2020','true')
Insert into ChiTietHoaDon values ('CTHD039','HD39', 'DT060', 1, 1250000, '11-01-2020','true')
Insert into ChiTietHoaDon values ('CTHD040','HD40', 'DT061', 1, 749000, '09-02-2020','true')

Insert into ChiTietHoaDon values ('CTHD041','HD37', 'DT062', 1, 8990000, '12-12-2020','true')
Insert into ChiTietHoaDon values ('CTHD042','HD38', 'DT063', 1, 6990000, '10-10-2020','true')
Insert into ChiTietHoaDon values ('CTHD043','HD39', 'DT064', 1, 3340000, '01-09-2020','true')

Insert into ChiTietHoaDon values ('CTHD044','HD40', 'DT071', 1, 69990000, '12-12-2020','true')
Insert into ChiTietHoaDon values ('CTHD045','HD41', 'DT072', 1, 41490000, '10-10-2020','true')
Insert into ChiTietHoaDon values ('CTHD046','HD42', 'DT073', 7, 244930000, '01-09-2020','true')
Insert into ChiTietHoaDon values ('CTHD047','HD43', 'DT074', 5, 174950000, '11-01-2020','true')
Insert into ChiTietHoaDon values ('CTHD048','HD44', 'DT075', 1, 28990000, '09-02-2020','true')
Select * from ChiTietHoaDon
--delete from ChiTietHoaDon

Insert into NhaCungCap values ('NCC01', N'SamSung',N'Hà Nội', 0796342450, 'samsung@gmail.com')
Insert into NhaCungCap values ('NCC02', N'Xiaomi',N'Quận 3', 0861232450, 'Xiaomi@gmail.com')
Insert into NhaCungCap values ('NCC03', N'Oppo',N'Quận 12', 0332655311, 'Oppo@gmail.com')
Insert into NhaCungCap values ('NCC04', N'Huwaei',N'Quân bình thạnh', 0381234967, 'huwai@gmail.com')
Insert into NhaCungCap values ('NCC05', N'Apple',N'Quận 1', 0816342450, 'apple@gmail.com')
Insert into NhaCungCap values ('NCC06', N'Nokia',N'Quận 1', 0916342451, 'nokia@gmail.com')
Select * from NhaCungCap

Set DateForMat DMY
Insert into KhuyenMai values ('KM01','DT001', '25-12-2020', '26-01-2021', 0.1)
Insert into KhuyenMai values ('KM02','DT002', '01-12-2020', '02-02-2021', 0.2)
Insert into KhuyenMai values ('KM03','DT003', '25-12-2020', '26-01-2021', 0.2)
Insert into KhuyenMai values ('KM04','DT004', '30-12-2020', '25-02-2021', 0.2)
Insert into KhuyenMai values ('KM05','DT005', '15-12-2020', '01-01-2021', 0.1)

Insert into KhuyenMai values ('KM06','DT011', '14-12-2020', '14-02-2021', 0.5)
Insert into KhuyenMai values ('KM07','DT012', '08-11-2020', '15-01-2021', 0.2)
Insert into KhuyenMai values ('KM08','DT013', '25-12-2020', '26-01-2021', 0.2)
Insert into KhuyenMai values ('KM09','DT014', '01-09-2020', '02-01-2021', 0.2)
Insert into KhuyenMai values ('KM10','DT015', '26-12-2020', '01-02-2021', 0.3)

Insert into KhuyenMai values ('KM11','DT026', '25-12-2020', '26-01-2021', 0.1)
Insert into KhuyenMai values ('KM12','DT027', '01-11-2020', '02-02-2021', 0.2)
Insert into KhuyenMai values ('KM13','DT028', '14-12-2020', '14-03-2021', 0.1)
Insert into KhuyenMai values ('KM14','DT029', '08-12-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM15','DT030', '08-12-2020', '08-01-2021', 0.3)

Insert into KhuyenMai values ('KM16','DT032', '01-01-2020', '02-02-2021', 0.1)
Insert into KhuyenMai values ('KM17','DT033', '25-12-2020', '26-01-2021', 0.1)
Insert into KhuyenMai values ('KM18','DT034', '01-10-2020', '01-01-2021', 0.3)
Insert into KhuyenMai values ('KM19','DT035', '01-12-2020', '02-02-2021', 0.3)
Insert into KhuyenMai values ('KM20','DT036', '08-12-2020', '08-01-2021', 0.1)

Insert into KhuyenMai values ('KM21','DT040', '08-09-2020', '08-01-2021', 0.1)
Insert into KhuyenMai values ('KM22','DT041', '01-10-2020', '02-02-2021', 0.2)
Insert into KhuyenMai values ('KM23','DT042', '01-12-2020', '01-02-2021', 0.3)
Insert into KhuyenMai values ('KM24','DT043', '25-09-2020', '26-01-2021', 0.3)
Insert into KhuyenMai values ('KM25','DT044', '25-12-2020', '26-01-2021', 0.2)

Insert into KhuyenMai values ('KM26','DT045', '01-12-2020', '02-02-2021', 0.2)
Insert into KhuyenMai values ('KM27','DT046', '08-12-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM28','DT047', '25-11-2020', '26-01-2021', 0.2)
Insert into KhuyenMai values ('KM29','DT048', '01-12-2020', '01-01-2021', 0.1)
Insert into KhuyenMai values ('KM30','DT049', '14-12-2020', '14-03-2021', 0.4)

Insert into KhuyenMai values ('KM31','DT053', '01-12-2020', '02-02-2021', 0.4)
Insert into KhuyenMai values ('KM32','DT054', '08-10-2020', '08-01-2021', 0.3)
Insert into KhuyenMai values ('KM33','DT055', '01-12-2020', '02-02-2021', 0.4)

Insert into KhuyenMai values ('KM34','DT056', '01-11-2020', '02-02-2021', 0.1)
Insert into KhuyenMai values ('KM35','DT058', '25-10-2020', '26-01-2021', 0.5)
Insert into KhuyenMai values ('KM36','DT059', '08-09-2020', '08-10-2021', 0.3)

Insert into KhuyenMai values ('KM37','DT062', '01-11-2020', '02-02-2021', 0.3)
Insert into KhuyenMai values ('KM38','DT063', '08-09-2020', '08-10-2021', 0.5)
Insert into KhuyenMai values ('KM39','DT064', '14-12-2020', '14-03-2021', 0.2)

Insert into KhuyenMai values ('KM40','DT065', '25-12-2020', '26-01-2021', 0.5)
Insert into KhuyenMai values ('KM41','DT066', '01-11-2020', '02-02-2021', 0.3)
Insert into KhuyenMai values ('KM42','DT067', '25-10-2020', '26-01-2021', 0.2)

Insert into KhuyenMai values ('KM43','DT070', '01-12-2020', '02-02-2021', 0.5)
Insert into KhuyenMai values ('KM44','DT024', '14-12-2020', '14-03-2021', 0.1)
Insert into KhuyenMai values ('KM45','DT028', '25-11-2020', '26-02-2021', 0.2)

Insert into KhuyenMai values ('KM46','LT071', '01-09-2020', '02-02-2021', 0.3)
Insert into KhuyenMai values ('KM47','LT074', '11-12-2020', '26-01-2021', 0.2)
Insert into KhuyenMai values ('KM48','LT078', '14-12-2020', '14-03-2021', 0.5)

Insert into KhuyenMai values ('KM49','LT080', '08-09-2020', '08-10-2021', 0.2)
Insert into KhuyenMai values ('KM50','LT081', '25-11-2020', '26-01-2021', 0.5)
Insert into KhuyenMai values ('KM51','LT082', '25-11-2020', '26-01-2021', 0.1)

Insert into KhuyenMai values ('KM52','LT088', '25-01-2020', '26-01-2021', 0.4)
Insert into KhuyenMai values ('KM53','LT089', '08-09-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM54','LT090', '25-05-2020', '26-01-2021', 0.2)

Insert into KhuyenMai values ('KM55','LT101', '08-09-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM56','LT102', '25-05-2020', '26-01-2021', 0.1)
Insert into KhuyenMai values ('KM57','LT103', '01-11-2020', '02-02-2021', 0.2)

Insert into KhuyenMai values ('KM58','LT112', '08-09-2020', '08-10-2021', 0.2)
Insert into KhuyenMai values ('KM59','LT113', '25-10-2020', '26-01-2021', 0.1)
Insert into KhuyenMai values ('KM60','LT114', '08-09-2020', '08-10-2021', 0.3)

Insert into KhuyenMai values ('KM61','LT118', '25-08-2020', '26-01-2021', 0.2)
Insert into KhuyenMai values ('KM62','LT119', '01-10-2020', '01-02-2021', 0.3)
Insert into KhuyenMai values ('KM63','LT120', '08-12-2020', '08-04-2021', 0.5)

Insert into KhuyenMai values ('KM64','LT125', '08-09-2020', '08-10-2021', 0.1)
Insert into KhuyenMai values ('KM65','LT126', '25-07-2020', '26-01-2021', 0.2)
Insert into KhuyenMai values ('KM66','LT127', '25-12-2020', '26-01-2021', 0.3)

Insert into KhuyenMai values ('KM67','DH132', '01-01-2020', '02-02-2021', 0.3)
Insert into KhuyenMai values ('KM68','DH144', '08-09-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM69','TL153', '25-01-2020', '26-01-2021', 0.2)

Insert into KhuyenMai values ('KM70','LT095', '08-09-2020', '08-10-2021', 0.2)
Insert into KhuyenMai values ('KM71','LT096', '01-01-2020', '02-02-2021', 0.2)
Insert into KhuyenMai values ('KM72','LT100', '08-09-2020', '08-10-2021', 0.3)

Insert into KhuyenMai values ('KM73','DH130', '08-09-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM74','DH131', '25-01-2020', '26-01-2021', 0.2)
Insert into KhuyenMai values ('KM75','DH132', '25-01-2020', '26-01-2021', 0.5)

Insert into KhuyenMai values ('KM76','DH133', '08-09-2020', '08-10-2021', 0.2)
Insert into KhuyenMai values ('KM77','DH134', '25-01-2020', '26-01-2021', 0.3)
Insert into KhuyenMai values ('KM78','DH135', '08-09-2020', '08-10-2021', 0.2)

Insert into KhuyenMai values ('KM79','DH128', '08-09-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM80','DH129', '25-01-2020', '26-02-2021', 0.2)
Insert into KhuyenMai values ('KM81','DH142', '25-01-2020', '26-02-2021', 0.3)

Insert into KhuyenMai values ('KM82','DH149', '08-09-2020', '08-10-2021', 0.2)
Insert into KhuyenMai values ('KM83','DH150', '08-09-2020', '08-10-2021', 0.1)
Insert into KhuyenMai values ('KM84','DH151', '08-09-2020', '08-10-2021', 0.3)

Insert into KhuyenMai values ('KM85','TL152', '08-09-2020', '08-10-2021', 0.2)
Insert into KhuyenMai values ('KM86','TL153', '08-09-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM87','TL155', '25-01-2020', '26-01-2021', 0.2)

Insert into KhuyenMai values ('KM88','TL163', '08-09-2020', '08-10-2021', 0.3)
Insert into KhuyenMai values ('KM89','TL164', '25-01-2020', '26-01-2021', 0.2)

Insert into KhuyenMai values ('KM90','TL165', '30-04-2020', '30-05-2021', 0.1)
Insert into KhuyenMai values ('KM91','TL166', '08-09-2020', '08-10-2021', 0.4)
Insert into KhuyenMai values ('KM92','TL170', '30-04-2020', '30-05-2021', 0.3)
Insert into KhuyenMai values ('KM93','TL172', '01-01-2020', '02-02-2021', 0.2)

Insert into KhuyenMai values ('KM94','DH136', '01-01-2020', '02-02-2021', 0.2)
Insert into KhuyenMai values ('KM95','DH138', '01-05-2020', '01-06-2021', 0.2)
Insert into KhuyenMai values ('KM96','DH132', '25-01-2020', '26-01-2021', 0.1)
Insert into KhuyenMai values ('KM97','DH130', '14-02-2020', '14-03-2021', 0.3)
Insert into KhuyenMai values ('KM98','DH129', '08-09-2020', '08-10-2021', 0.2)
Select * from KhuyenMai
--delete from KhuyenMai

Insert into Kho values ('DT001', 10, N'Kệ A')
Insert into Kho values ('DT002', 9, N'Kệ A')
Insert into Kho values ('DT003', 5, N'Kệ A')
Insert into Kho values ('DT004', 5, N'Kệ A')
Insert into Kho values ('DT005', 3, N'Kệ A')
Insert into Kho values ('DT006', 5, N'Kệ A')
Insert into Kho values ('DT007', 11, N'Kệ A')
Insert into Kho values ('DT008', 15, N'Kệ A')
Insert into Kho values ('DT009', 1, N'Kệ A')
Insert into Kho values ('DT010', 2, N'Kệ A')

Insert into Kho values ('DT011', 1, N'Kệ B')
Insert into Kho values ('DT012', 11, N'Kệ B')
Insert into Kho values ('DT013', 1, N'Kệ B')
Insert into Kho values ('DT014', 3, N'Kệ B')
Insert into Kho values ('DT015', 9, N'Kệ B')
Insert into Kho values ('DT016', 2, N'Kệ B')
Insert into Kho values ('DT017', 5, N'Kệ B')
Insert into Kho values ('DT018', 11, N'Kệ B')
Insert into Kho values ('DT019', 10, N'Kệ B')
Insert into Kho values ('DT020', 12, N'Kệ B')
Insert into Kho values ('DT021', 10, N'Kệ B')
Insert into Kho values ('DT022', 7, N'Kệ B')
Insert into Kho values ('DT023', 6, N'Kệ B')
Insert into Kho values ('DT024', 3, N'Kệ B')

Insert into Kho values ('DT025', 8, N'Kệ C')
Insert into Kho values ('DT026', 5, N'Kệ C')
Insert into Kho values ('DT027', 4, N'Kệ C')
Insert into Kho values ('DT028', 5, N'Kệ C')
Insert into Kho values ('DT029', 2, N'Kệ C')
Insert into Kho values ('DT030', 2, N'Kệ C')
Insert into Kho values ('DT031', 1, N'Kệ C')

Insert into Kho values ('DT032', 6, N'Kệ D')
Insert into Kho values ('DT033', 10, N'Kệ D')
Insert into Kho values ('DT034', 14, N'Kệ D')
Insert into Kho values ('DT035', 3, N'Kệ D')
Insert into Kho values ('DT036', 3, N'Kệ D')
Insert into Kho values ('DT037', 9, N'Kệ D')

Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
select * from Kho

Insert into BaoHanh values ('DT001', N'Lỗi phần cứng', 'KH01', N'12 tháng')
Insert into BaoHanh values ('DT002', N'Nàm hình bể', 'KH02', N'12 tháng')
Insert into BaoHanh values ('DT085', N'camera bị lỗi', 'KH18', N'12 tháng')
Insert into BaoHanh values ('DT070', N'Loa nghe bị lỗi', 'KH14', N'12 tháng')
Insert into BaoHanh values ('DT100', N'Lỗi phần mền', 'KH16', N'12 tháng')
Insert into BaoHanh values ('DT011', N'Bể màn hình', 'KH20', N'12 tháng')
Insert into BaoHanh values ('DT105', N'Cấu hình bị lỗi', 'KH11', N'12 tháng')
Insert into BaoHanh values ('DT066', N'Lỗi nút âm lượng', 'KH19', N'12 tháng')
Insert into BaoHanh values ('DT127', N'Lỗi nút nguồn', 'KH12', N'12 tháng')
Insert into BaoHanh values ('DT050', N'Màn hình bể', 'KH09', N'12 tháng')
Insert into BaoHanh values ('DT123', N'Lỗi phần cứng', 'KH06', N'12 tháng')
Insert into BaoHanh values ('DT057', N'Loa nghe bị lỗi', 'KH08', N'12 tháng')
Insert into BaoHanh values ('DT030', N'Bể màn hình', 'KH15', N'12 tháng')
Insert into BaoHanh values ('DT040', N'Lỗi nút âm lượng', 'KH17', N'12 tháng')
Insert into BaoHanh values ('DT021', N'Lỗi nút home', 'KH03', N'12 tháng')
Insert into BaoHanh values ('DT010', N'Lỗi Lỗ sạc pin', 'KH04', N'12 tháng')
Insert into BaoHanh values ('DT088', N'Lỗi phần mền', 'KH05', N'12 tháng')
Insert into BaoHanh values ('DT051', N'Màn hình bể', 'KH08', N'12 tháng')
Insert into BaoHanh values ('DT020', N'Lỗi nút âm lượng', 'KH07', N'12 tháng')
Insert into BaoHanh values ('DT030', N'Camera bị lỗi', 'KH20', N'12 tháng')
Insert into BaoHanh values ('DT001', N'Camera bị lỗi', 'KH12', N'12 tháng')
Insert into BaoHanh values ('DT033', N'Loa nghe bị lỗi', 'KH09', N'12 tháng')
Insert into BaoHanh values ('DT036', N'Nút âm lượng bị lỗi', 'KH12', N'12 tháng')
Insert into BaoHanh values ('DT111', N'Nút nguồn bị lỗi', 'KH11', N'12 tháng')
Insert into BaoHanh values ('DT095', N'Camere bị lỗi', 'KH13', N'12 tháng')
Select * from BaoHanh

Set DateForMat DMY  
Insert into PhieuNhap values ('PN001', 'NV05', 'NCC01', '12-04-2020',100000000, null )
Insert into PhieuNhap values ('PN002', 'NV06', 'NCC02', '10-12-2020',100000000, null )
Insert into PhieuNhap values ('PN003', 'NV06', 'NCC03', '30-11-2020',100000000, null )
Insert into PhieuNhap values ('PN004', 'NV05', 'NCC04', '29-10-2019',100000000, null )
Insert into PhieuNhap values ('PN005', 'NV06', 'NCC05', '12-08-2020',100000000, null )
Insert into PhieuNhap values ('PN006', 'NV05', 'NCC06', '28-10-2020',100000000, null )
Insert into PhieuNhap values ('PN007', 'NV06', 'NCC02', '30-12-2020',100000000, null )
Insert into PhieuNhap values ('PN008', 'NV05', 'NCC06', '11-12-2020',100000000, null )
Insert into PhieuNhap values ('PN009', 'NV06', 'NCC04', '14-11-2020',100000000, null )
Insert into PhieuNhap values ('PN010', 'NV05', 'NCC03', '17-10-2020',100000000, null )
Insert into PhieuNhap values ('PN011', 'NV05', 'NCC02', '25-01-2020',100000000, null )
Insert into PhieuNhap values ('PN012', 'NV06', 'NCC06', '26-03-2019',100000000, null )
Insert into PhieuNhap values ('PN013', 'NV06', 'NCC01', '01-09-2020',100000000, null )
Insert into PhieuNhap values ('PN014', 'NV05', 'NCC05', '09-11-2020',100000000, null )
Insert into PhieuNhap values ('PN015', 'NV06', 'NCC06', '18-01-2020',100000000, null )
Select * from PhieuNhap
--delete from PhieuNhap


Insert into ChiTietPhieuNhap values ('CTPN001', 'PN001','DT001', 10, 1000000000000 )
Insert into ChiTietPhieuNhap values ('CTPN002', 'PN002','DT001', 10, 1100000000000 )
Insert into ChiTietPhieuNhap values ('CTPN003', 'PN003','DT001', 10, 1200000000000 )
Insert into ChiTietPhieuNhap values ('CTPN004', 'PN004','DT001', 10, 1300000000000 )
Insert into ChiTietPhieuNhap values ('CTPN005', 'PN005','DT001', 10, 1100000000000 )
Insert into ChiTietPhieuNhap values ('CTPN006', 'PN006','DT001', 10, 1400000000000 )
Insert into ChiTietPhieuNhap values ('CTPN007', 'PN007','DT001', 10, 1700000000000 )
Insert into ChiTietPhieuNhap values ('CTPN008', 'PN008','DT001', 10, 1800000000000 )
Insert into ChiTietPhieuNhap values ('CTPN009', 'PN009','DT001', 10, 1900000000000 )
Insert into ChiTietPhieuNhap values ('CTPN010', 'PN010','DT001', 10, 1700000000000 )
Insert into ChiTietPhieuNhap values ('CTPN011', 'PN011','DT001', 10, 1900000000000 )
Insert into ChiTietPhieuNhap values ('CTPN013', 'PN012','DT001', 10, 2000000000000 )
Insert into ChiTietPhieuNhap values ('CTPN012', 'PN013','DT001', 10, 2000000000000 )
Insert into ChiTietPhieuNhap values ('CTPN014', 'PN014','DT001', 10, 3000000000000 )
Insert into ChiTietPhieuNhap values ('CTPN015', 'PN015','DT001', 10, 1000000000000 )
Select * from ChiTietPhieuNhap


Select * from SanPham where MaNhomSP = N'LT'