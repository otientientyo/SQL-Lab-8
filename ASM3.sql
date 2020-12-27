USE master
GO

IF EXISTS(SELECT * FROM sys.databases WHERE NAME = 'test')
	DROP DATABASE test
GO

CREATE DATABASE test
GO

USE test
GO

CREATE TABLE Customer (
	CustomerID int,
	Name varchar(50),
	ID varchar(20),
	Address varchar(100)
)

CREATE TABLE CustomerTel (
	CustomerID int,
	Tel varchar(15),
	ServiceID int,
	StartDate Datetime,
	EndDate Datetime NULL
)

CREATE TABLE Services (
	ServiceID int,
	Name varchar(50),
	Description varchar(100)
)
GO

INSERT INTO Customer VALUES
	(1,'Nguyen Nguyet Nga','123456789','Ha Noi'),
	(2,'Nguyen Van A','00845936126','Ha Nam'),
	(3,'Nguyen Van B','00000374252','Thai Binh')
GO

INSERT INTO CustomerTel VALUES
	(1,'0923456789',1,'12-12-2009',NULL),
	(1,'0986325323',2,'11-11-2020','12-11-2020'),
	(2,'0927347543',1,'10-10-2020',NULL),
	(3,'0994023743',3,'09-09-2020',NULL),
	(3,'0995672342',1,'08-08-2020',NULL)
GO

INSERT INTO Services VALUES
	(1,'5G','Toc do 50mb'),
	(2,'4G','Toc do 25mb'),
	(3,'3G','Toc do 10mb')
GO

--4a
SELECT * FROM Customer
GO

--4b
SELECT * FROM CustomerTel
GO

--5a
SELECT * FROM CustomerTel WHERE Tel LIKE '0123456789'
GO

--5b
SELECT * FROM Customer WHERE ID LIKE '123456789'
GO

--5c
SELECT Customer.Name, Customer.ID, CustomerTel.Tel FROM Customer
	JOIN CustomerTel ON CustomerTel.CustomerID = Customer.CustomerID
	WHERE ID LIKE '123456789'
GO

--5d
SELECT Tel FROM CustomerTel WHERE StartDate = '12-12-2009'
GO

--5e
SELECT CustomerTel.Tel, Customer.Address FROM CustomerTel
	JOIN Customer ON Customer.CustomerID = CustomerTel.CustomerID
	WHERE Customer.Address LIKE 'Ha Noi'
GO

--6a
SELECT COUNT(CustomerID) AS 'So luong khach hang' FROM Customer
GO

--6b
SELECT DISTINCT COUNT(Tel) AS 'So thue bao' FROM CustomerTel
GO

--6c
SELECT COUNT(CustomerTel.Tel) AS 'So thue bao dang ky',CustomerTel.StartDate FROM CustomerTel
	WHERE CustomerTel.StartDate = '12-12-2009'
	GROUP BY CustomerTel.Tel,CustomerTel.StartDate
GO

--6d
SELECT * FROM CustomerTel
	JOIN Customer ON Customer.CustomerID = CustomerTel.CustomerID
GO

--7a
ALTER TABLE CustomerTel
	ALTER COLUMN StartDate Datetime NOT NULL
GO

--7b
ALTER TABLE CustomerTel
	ADD CONSTRAINT chk_startdate CHECK (StartDate <= GETDATE())
GO

--7c
ALTER TABLE CustomerTel
	ADD CONSTRAINT chk_tel CHECK (Tel LIKE '09%')
GO

--7d
ALTER TABLE CustomerTel
	ADD GiftPoint int NULL
GO