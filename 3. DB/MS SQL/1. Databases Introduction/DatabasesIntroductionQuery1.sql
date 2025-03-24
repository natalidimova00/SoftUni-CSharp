-- 01. Create Database
CREATE DATABASE Minions

-- 02. Create Tables
CREATE TABLE Minions
(
	Id INT PRIMARY KEY,
	[Name] VARCHAR(50),
	Age INT
)
CREATE TABLE Towns
(
	Id INT PRIMARY KEY,
	[Name] VARCHAR(50)
)

-- 03. Alter Minions Table
ALTER TABLE Minions
ADD TownId INT

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)

-- 04. Insert Records in Both Tables
INSERT INTO Towns
VALUES (1, 'Sofia'),
	   (2, 'Plovdiv'),
	   (3, 'Varna')

INSERT INTO Minions (Id, [Name], Age, TownId)
VALUES (1, 'Kevin', 22, 1),
	   (2, 'Bob', 15, 3),
	   (3, 'Steward', NULL, 2)

-- 05. Truncate table
TRUNCATE TABLE Minions
SELECT * FROM Minions

-- 06. Drop Tables
DROP TABLE Minions
DROP TABLE Towns

-- 07. Create Table People
CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX),
	Height DECIMAL(3,2),
	[Weiht] DECIMAL(5,2),
	Gender CHAR(1) NOT NULL,
		CHECK(Gender in('m', 'f')),
	Birthdate DATETIME2 NOT NULL,
	Biography VARCHAR(MAX)
)

INSERT INTO People ([Name], Gender, Birthdate)
			VALUES('Pesho', 'm', '1998-05-05'),
				  ('Mimi', 'f', '1994-07-05'),
				  ('Ivan', 'm', '1998-05-02'),
				  ('Nina', 'f', '2001-06-05'),
				  ('Radka', 'f', '1990-12-12')

SELECT * FROM People

-- 08. Create Table Users
CREATE TABLE Users
(
	Id BIGINT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	LastLoginTime DATETIME2,
	IsDeleted BIT
)

INSERT INTO Users (Username, [Password])
			VALUES ('pesho123', '123456'),
				   ('ivan45', '987654321'),
				   ('maria', '525256'),
				   ('petyo90', '644929216'),
				   ('radi17', '45482181669')

-- 09. Delete (Drop) Primary Key
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC073FC83AE5
-- Set new composite Primary Key
ALTER TABLE Users
ADD CONSTRAINT PK_UsersTable PRIMARY KEY(Id, Username)

-- 10. Check constraint for password field
ALTER TABLE Users
ADD CONSTRAINT CHK_PasswordIsAtLeastFiveSymols
	CHECK(LEN(Password) >= 5)

-- 16. Create SoftUni Database
CREATE DATABASE SoftUni
USE SoftUni

CREATE TABLE Towns
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(60)
)

CREATE TABLE Addresses
(
	Id INT PRIMARY KEY IDENTITY,
	AddressText VARCHAR(MAX),
	TownId INT FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(60)
)

CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(60) NOT NULL,
	MiddleName VARCHAR(60),
	LastName VARCHAR(60) NOT NULL,
	JobTitle VARCHAR(60) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
	HireDate DATETIME2 NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

-- 18. Basic Insert
INSERT INTO Departments
			VALUES('Software Development'),
				  ('Enineering'),
				  ('Quality Assuurance'),
				  ('Sales'),
				  ('Marketing')

INSERT INTO Towns
			VALUES('Sofia'),
				  ('Plovdiv'),
				  ('Varna'),
				  ('Burgas')

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
			VALUES('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 1, '2013-02-01', 3500),
				  ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 2, '2004-02-01', 4000),
				  ('Maria', 'Ivanova', 'Petrova', 'Intern', 3, '2016-08-10', 525.25),
				  ('Georgi', 'Ivanov', 'Georgiev', 'CEO', 4, '2007-10-9', 3000),
				  ('Atanas', 'Ivanov', 'Dimov', 'Intern', 5, '2016-08-10', 599.88)

-- 22. Increase Employee Salaries
UPDATE Employees
SET Salary = Salary * 1.1
SELECT Salary FROM Employees