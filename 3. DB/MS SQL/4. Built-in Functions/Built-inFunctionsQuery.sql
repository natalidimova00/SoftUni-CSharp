-- 01. Find Names of All Employees by First Name
SELECT FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'SA%'

-- 02. Find Names of All Employees by Last Name
SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '%EI%'

-- 03. Find First Names of All Employees
SELECT FirstName
FROM Employees
WHERE DepartmentID IN (3, 10) AND
	  DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005

-- 04. Find All Employees Except Engineers
SELECT FirstName, LastName
FROM Employees
WHERE JobTitle NOT LIKE '%ENGINEER%'

-- 05. Find Towns with Name Length
SELECT [Name]
FROM Towns
WHERE LEN([Name]) BETWEEN 5 AND  6
ORDER BY [Name]

-- 06. Find Towns Starting With
SELECT TownID, [Name]
FROM Towns
WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name]

-- 07. Find Towns Not Starting With
SELECT TownID, [Name]
FROM Towns
WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name]

-- 08. Create View Employees Hired After 2000 Year
