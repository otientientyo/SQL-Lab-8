USE master
GO

IF EXISTS(SELECT * FROM sys.databases WHERE NAME = 'test')
	DROP DATABASE test
GO

CREATE DATABASE test
GO
USE test
GO

CREATE TABLE Products (
	ProductID int CONSTRAINT pk_productid PRIMARY KEY (ProductID),
	Name varchar(50),
	Description varchar(50),
	Unit varchar(7),
	Price money,
	Quantity int,
	CompanyID int,
	CategoryID int
)

CREATE TABLE Company (
	CompanyID int CONSTRAINT pk_companyid PRIMARY KEY (CompanyID),
	CompanyName varchar(20),
	Tel varchar(13),
	Address varchar(100)
)

CREATE TABLE Category (
	CategoryID int CONSTRAINT pk_categoryid PRIMARY KEY (CategoryID),
	CategoryName varchar(20)
)

INSERT INTO Company VALUES
	(123,'DELL','0987654321','USA'),
	(124,'ASUS','0123456789','TaiWan'),
	(125,'APPLE','0543872623','California'),
	(126,'MOUSE','0986453732','Japan'),
	(127,'MSI','0484376324','China')
GO

INSERT INTO Category VALUES
	(1,'Computer'),
	(2,'Laptop'),
	(3,'NoteBook'),
	(4,'Desktop'),
	(5,'Mobile'),
	(6,'Others')
GO
	

	-- ProductID int CONSTRAINT pk_productid PRIMARY KEY (ProductID),
	-- Name varchar(20),
	-- Description varchar(50),
	-- Unit varchar(7),
	-- Price money,
	-- Quantity int,
	-- CompanyID int,
	-- CategoryID int
INSERT INTO Products VALUES
	(1,'May Tinh T450','May nhap cu','Chiec',2000000,20,123,1),
	(2,'Dien Thoai Nokia 5670','Dien thoai dang hot','Chiec',1400000,200,125,1),
	(3,'May In SamSung','May in loai trung binh','Cai',2200000,6,124,6)
GO

--4a
SELECT * FROM Company
GO

--4b
SELECT * FROM Products
GO

--5a
SELECT * FROM Company ORDER BY CompanyName DESC
GO

--5b
SELECT * FROM Products ORDER BY Price DESC
GO

--5c
SELECT * FROM Company WHERE CompanyName LIKE 'ASUS'
GO

--5d
SELECT * FROM Products WHERE Quantity < 11
GO

--5e
SELECT * FROM Products
	JOIN Company ON Products.CompanyID = Company.CompanyID 
	WHERE CompanyName LIKE 'ASUS'
GO

--6a
SELECT DISTINCT COUNT(Company.CompanyID) AS 'So hang sp co trong cua hang' FROM Company
GO

--6b
SELECT DISTINCT COUNT(Products.ProductID) AS 'So sp trong cua hang' FROM Products
GO

--6c
SELECT DISTINCT Company.CompanyName,COUNT(Products.ProductID) AS 'Tong so sp' FROM Company
	JOIN Products ON Products.CompanyID = Company.CompanyID
	GROUP BY Company.CompanyName
GO

--6d
SELECT COUNT(ProductID) FROM Products
GO

--7a
ALTER TABLE Products
	ADD CONSTRAINT chk_productprice CHECK (Price > 0)
GO

--7b
ALTER TABLE Company
	ADD CONSTRAINT chk_tel CHECK (Tel LIKE '0%')
GO

--7c
ALTER TABLE Products
	ADD CONSTRAINT fk_companyid FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
ALTER TABLE Products
	ADD CONSTRAINT fk_categoryid FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
GO

--8a
CREATE INDEX IX_ProductName ON Products(Name)
GO

CREATE INDEX IX_Description ON Products(Description)
GO