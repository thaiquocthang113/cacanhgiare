CREATE DATABASE Bancacanhgiare
GO
USE Bancacanhgiare
GO

create table Admin
(
	UserAdmin VARCHAR(30) PRIMARY KEY,
	PassAdmin Varchar(50) NOT NULL,
	HoTen NVarchar(100)  
)
INSERT INTO dbo.Admin
        ( UserAdmin, PassAdmin, HoTen )
VALUES  ( 'quocthang', -- UserAdmin - varchar(30)
          'quocthang', -- PassAdmin - varchar(50)
          N'Quốc Thắng'  -- HoTen - nvarchar(100)
          )
create table KHACHHANG
(
	MAKH INT IDENTITY(1,1),
	HOTEN nVarchar(50) NOT NULL,
	TAIKHOAN NVARCHAR(50),
	MATKHAU NVARCHAR(50),
	EMAIL Varchar(100) UNIQUE,  
	DIACHIKH nVarchar(200),  
	DIENTHOAIKH Varchar(50),   
	NGAYSINH DATETIME 
	PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO KHACHHANG  VALUES (N'Thái Quốc Thắng',N'quocthang1',N'quocthang1',N'Thangvippro123@gmail.com',N'Xô Viết Nghệ Tĩnh,Quận Bình Thạnh,tp.hcm','0376158462','2000/05/14')
INSERT INTO KHACHHANG  VALUES (N'Hà Phước Hậu',N'phuochau',N'phuochau',N'hauprovip@gmail.com',N'1762/2/14, Tổ 2,Khu Phố 3, Phường Tân Thới Hiệp, Quận 12, Thành Phố Hồ Chí Minh','0774251783','2000/07/17')
INSERT INTO KHACHHANG  VALUES (N'Trần Thanh Bình',N'wibu',N'wibu',N'wibureal@gmail.com',N' KCN Hiệp Phước, xã Long Thới, Huyện Nhà Bè, Thành Phố Hồ Chí Minh','0885647125','2000/12/24')
INSERT INTO KHACHHANG  VALUES (N'Nguyễn Quang Huy',N'huy',N'huy',N'quanghuy@gmail.com',N' Khu CNC, Quận 9, Thành Phố Hồ Chí Minh','0885647125','2000/12/25')

CREATE TABLE LOAIHANG
(
	MALOAI  INT IDENTITY(1,1) PRIMARY KEY,
	TENLOAI NVARCHAR(100) NOT NULL,	
)
insert into LOAIHANG values(N'Cá')
insert into LOAIHANG values (N'Dụng Cụ Nuôi Cá')
insert into LOAIHANG values (N'Sỏi')
insert into LOAIHANG values (N'Bể Cá')

CREATE TABLE NCC
(
	MANCC INT IDENTITY(1,1) PRIMARY KEY,
	TENNCC NVARCHAR(50) NOT NULL,
	DIENTHOAI VARCHAR(50),
	DIACHI NVARCHAR(100)	
)

INSERT INTO NCC VALUES ( N'Dương Thành Phết','0123456789',N'Lê Hồng Phong, P. 1, Q. 10, Tp. Hồ Chí Minh')


CREATE TABLE DONDAT
(
	MADONDAT INT IDENTITY(1,1),  
	THANHTOAN BIT,  
	TINHTRANGGIAOHANG BIT,  
	NGAYDAT DATETIME,  
	NGAYGIAO Datetime,   
	MAKH INT
	PRIMARY KEY CLUSTERED 
(
	[MADONDAT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE DONDAT ADD FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)
ON DELETE CASCADE
GO


--set dateformat mdy
insert into DONDAT values (1,1,'07/03/2019','08/03/2019',2)
insert into DONDAT values (0,1,'03/03/2019','08/03/2019',1)
insert into DONDAT values (1,0,'06/03/2019','08/03/2019',3)



CREATE TABLE SANPHAM
(
	MASP INT IDENTITY(1,1) PRIMARY KEY,
	MALOAI INT NULL DEFAULT ((0)),
	TENSP NVARCHAR(100) NOT NULL,
	GIABAN Decimal(18,0) CHECK (GIABAN>=0),  
	ANH VARCHAR(100),  
	ANHMAU VARCHAR(100),
	NGAYNHAP DATETIME,  
	SLTON INT,
	MANCC INT	   
)
ALTER TABLE SANPHAM ADD FOREIGN KEY(MANCC) REFERENCES NCC(MANCC)
ON DELETE CASCADE
GO	
ALTER TABLE SANPHAM ADD FOREIGN KEY(MALOAI) REFERENCES dbo.LOAIHANG(MALOAI)
ON DELETE CASCADE
GO	
INSERT dbo.SANPHAM
        (MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 4 , -- MALOAI - int
          N'Cá bảy màu' , -- TENSP - nvarchar(100)
          25000 , -- GIABAN - decimal
          'tong-hop-hinh-anh-ca-choi-dep-nhat_114911972.jpg' , -- ANH - varchar(75)
          'Mautong-hop-hinh-anh-ca-choi-dep-nhat_114911972.jpg' , -- ANHMAU - varchar(75)
          '5/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (4 , -- MALOAI - int
          N'Cá siêu đỏ' , -- TENSP - nvarchar(100)
          25000 , -- GIABAN - decimal
          'anh-ca-choi-mau-do-dep-nhat_114908083.jpg' , -- ANH - varchar(75)
          'Mauanh-ca-choi-mau-do-dep-nhat_114908083.jpg' , -- ANHMAU - varchar(75)
          '5/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 4 , -- MALOAI - int
          N'Cá hổ vằn' , -- TENSP - nvarchar(100)
          25000 , -- GIABAN - decimal
          'images (1).jpg' , -- ANH - varchar(50)
          'Mauimages (1).jpg' , -- ANHMAU - varchar(50)
          '5/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (  MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (  4 , -- MALOAI - int
          N'Cá nửa hổ' , -- TENSP - nvarchar(100)
          200000 , -- GIABAN - decimal
          'hinh-anh-ca-canh-dep-nhat-gioi1.jpg' , -- ANH - varchar(50)
          'Mauhinh-anh-ca-canh-dep-nhat-gioi1.jpg' , -- ANHMAU - varchar(50)
          '5/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 1 , -- MALOAI - int
          N'Ô vuông cho cá ăn' , -- TENSP - nvarchar(100)
          45000 , -- GIABAN - decimal
          '0a525fb5faf1e867f01eb9c136512799_tn.jpg' , -- ANH - varchar(50)
          '0a525fb5faf1e867f01eb9c136512799_tn.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (  MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (  1 , -- MALOAI - int
          N'Khuếch tán khí CO2' , -- TENSP - nvarchar(100)
          50000 , -- GIABAN - decimal
          'a31db6de7573279b4b6b0d8df351c850.jpg' , -- ANH - varchar(50)
          'a31db6de7573279b4b6b0d8df351c850.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (  MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 1 , -- MALOAI - int
          N'Bộ lọc đáy vách ngăn bể cá' , -- TENSP - nvarchar(100)
         30000 , -- GIABAN - decimal
          'images.jpg' , -- ANH - varchar(50)
           'images.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        ( MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 1 , -- MALOAI - int
          N'Dụng cụ đếm số bằng bong bóng nước' , -- TENSP - nvarchar(100)
          150000 , -- GIABAN - decimal
          '732700be2759db970a81cdfbf7160094.jpg' , -- ANH - varchar(50)
          '732700be2759db970a81cdfbf7160094.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 3 , -- MALOAI - int
          N'Sỏi Trắng' , -- TENSP - nvarchar(100)
          35000 , -- GIABAN - decimal
          'soi-be-ca-canh.jpg' , -- ANH - varchar(50)
          'soi-be-ca-canh.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (  MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (3 , -- MALOAI - int
          N'Sỏi bảy màu' , -- TENSP - nvarchar(100)
          15000 , -- GIABAN - decimal
          'soi-suoi-lam-nen-ho-ca-hoac-trai-nen-ho-thuy-sinh.jpg' , -- ANH - varchar(50)
          'soi-suoi-lam-nen-ho-ca-hoac-trai-nen-ho-thuy-sinh.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        ( MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (  3 , -- MALOAI - int
          N'Sỏi lớn' , -- TENSP - nvarchar(100)
          50000 , -- GIABAN - decimal
          '128.jpg' , -- ANH - varchar(50)
          '128.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (  MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 3 , -- MALOAI - int
          N'Đá Cuội' , -- TENSP - nvarchar(100)
          4000000 , -- GIABAN - decimal
          'tải xuống.jpg' , -- ANH - varchar(50)
          'tải xuống.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        ( MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (  2 , -- MALOAI - int
          N'Bể cá hình trụ' , -- TENSP - nvarchar(100)
          4500000 , -- GIABAN - decimal
          'be-ca-canh-ban-nguyet-nhap-khau-cao-cap-BC02.jpg' , -- ANH - varchar(50)
          'be-ca-canh-ban-nguyet-nhap-khau-cao-cap-BC02.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (  MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 2 , -- MALOAI - int
          N'Bể cá gỗ đứng' , -- TENSP - nvarchar(100)
          9000000 , -- GIABAN - decimal
          'Be-ca-canh-dep-va-doc-dao.jpg' , -- ANH - varchar(50)
          'Be-ca-canh-dep-va-doc-dao.jpg' , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (  2 , -- MALOAI - int
          N'Bể cá hình chữ nhật' , -- TENSP - nvarchar(100)
          1500000 , -- GIABAN - decimal
          'ho-ca-cho-tot.jpg' , -- ANH - varchar(50)
          'ho-ca-cho-tot.jpg'  , -- ANHMAU - varchar(50)
          '4/6/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (  MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (  4 , -- MALOAI - int
          N'Cá Huyết Long' , -- TENSP - nvarchar(100)
          50000000 , -- GIABAN - decimal
          'ca-rong-huyet-long-3.jpg' , -- ANH - varchar(50)
          'ca-rong-huyet-long-3.jpg' , -- ANHMAU - varchar(50)
          '3/5/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        ( MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 4 , -- MALOAI - int
          N'Cá La Hán ' , -- TENSP - nvarchar(100)
          2500000 , -- GIABAN - decimal
          'trai-ca-la-han-tai-tphcm-2.jpg' , -- ANH - varchar(50)
          'trai-ca-la-han-tai-tphcm-2.jpg' , -- ANHMAU - varchar(50)
          '3/5/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (  MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (  4 , -- MALOAI - int
          N'Cá Kim Long Quá Bối' , -- TENSP - nvarchar(100)
          2000000 , -- GIABAN - decimal
          'tải xuống (2).jpg' , -- ANH - varchar(50)
          'tải xuống (2).jpg' , -- ANHMAU - varchar(50)
          '3/5/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        ( MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (4 , -- MALOAI - int
          N'Cá Hồng Vĩ Mỏ Vịt ' , -- TENSP - nvarchar(100)
          100000 , -- GIABAN - decimal
          'tải xuống (3).jpg' , -- ANH - varchar(50)
          'tải xuống (3).jpg' , -- ANHMAU - varchar(50)
          '3/5/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        ( MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  ( 4 , -- MALOAI - int
          N'Cá Phi Phụng ' , -- TENSP - nvarchar(100)
          750000 , -- GIABAN - decimal
          'cach-nuoi-ca-phi-phung.jpg' , -- ANH - varchar(50)
          'cach-nuoi-ca-phi-phung.jpg' , -- ANHMAU - varchar(50)
          '3/5/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )
INSERT dbo.SANPHAM
        (MALOAI ,
          TENSP ,
          GIABAN ,
          ANH ,
          ANHMAU ,
          NGAYNHAP ,
          SLTON ,
          MANCC
        )
VALUES  (  4 , -- MALOAI - int
          N'Cá dĩa ' , -- TENSP - nvarchar(100)
          250000 , -- GIABAN - decimal
          'tải xuống (1).jpg' , -- ANH - varchar(50)
          'tải xuống (1).jpg' , -- ANHMAU - varchar(50)
          '3/5/2020' , -- NGAYNHAP - datetime
          500 , -- SLTON - int
          1  -- MANCC - int
        )


CREATE TABLE CTDONDAT
(
	MADONDAT INT,  
	MASP INT ,	
	SL Int Check(SL>0),  
	DONGIA DECIMAL(15,0) Check(Dongia>=0)
	PRIMARY KEY CLUSTERED 
(
	[MADONDAT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE CTDONDAT ADD FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)
GO	
ALTER TABLE CTDONDAT ADD FOREIGN KEY(MADONDAT) REFERENCES DONDAT(MADONDAT)
GO	


