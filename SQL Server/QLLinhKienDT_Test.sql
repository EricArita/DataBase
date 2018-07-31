USE QLLinhKienDT;
--DECLARE @Date varchar(20);
--SET @Date = CONVERT(varchar, GETDATE(), 103);
go
SELECT COUNT(*) FROM Kho
SET IDENTITY_INSERT Kho OFF;
insert into Kho values('TP001',N'Tai nghe Sony','KTHT', '24/07/2018', N'Nhập',100,'Test');
DELETE FROM Kho WHERE IDKho = '2';
SET IDENTITY_INSERT Kho ON;
DBCC CHECKIDENT (Kho, RESEED, 1);
SELECT * FROM Kho;
SELECT * FROM KhoTamThoi;
SELECT * FROM view_TongSPNhap;
SELECT * FROM view_TongSPXuat;

go

CREATE TABLE KhoTamThoi(
  MaSP varchar(5),
  TenSP nvarchar(50),
  MaNguon varchar(5),
  ThoiGian varchar(20) ,
  TrangThai nvarchar(5),
  SoLuong int,
  GhiChu nvarchar(50),
);


INSERT INTO KhoTamThoi SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM Kho ORDER BY IDKho ASC;



DROP TABLE Kho;

create table Kho(
  IDKho int IDENTITY(1,1)Primary Key,
  MaSP varchar(5) FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE,
  TenSP nvarchar(50),
  MaNguon varchar(5) foreign key (MaNguon) references NguonCungCap(MaNguon),
  ThoiGian varchar(20) ,
  TrangThai nvarchar(5),
  SoLuong int,
  GhiChu nvarchar(50),
);

INSERT INTO Kho SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM Temporary;

SELECT* FROM KhoTamThoi;


go
CREATE PROC SortID
AS
BEGIN
	DECLARE @BangTam TABLE(	
		 MaSP varchar(5),
		 TenSP nvarchar(50),
		 MaNguon varchar(5),
		 ThoiGian varchar(20) ,
		 TrangThai nvarchar(5),
		 SoLuong int,
		 GhiChu nvarchar(50)
	);

	INSERT INTO @BangTam SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM Kho ORDER BY IDKho ASC;
	DROP TABLE Kho;
	CREATE TABLE Kho(
		 IDKho int IDENTITY(1,1)Primary Key,
		 MaSP varchar(5) FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE,
		 TenSP nvarchar(50),
		 MaNguon varchar(5) foreign key (MaNguon) references NguonCungCap(MaNguon),
		 ThoiGian varchar(20) ,
		 TrangThai nvarchar(5),
		 SoLuong int,
	     GhiChu nvarchar(50),
	);
	INSERT INTO Kho SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM @BangTam;
END;

EXEC SortID;
SELECT * FROM Kho;

