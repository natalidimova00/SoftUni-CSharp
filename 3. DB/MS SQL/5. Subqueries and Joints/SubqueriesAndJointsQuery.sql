-- 01. Employee Address
SELECT TOP(5) 
	EmployeeID, JobTitle, e.AddressID, AddressText
FROM 
	Employees AS e
JOIN Addresses AS a ON a.AddressID = e.AddressID
ORDER BY AddressID

-- 02. Addresses with Towns
SELECT TOP(50)
	e.FirstName, e.LastName, t.[Name] AS Town, a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON a.AddressID = e.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY
	FirstName, LastName

-- 03. Sales Employees
SELECT
	EmployeeID, FirstName, LastName, [Name]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE
	d.[Name] = 'Sales'
ORDER BY
	EmployeeID

-- 04. Employee Departments
SELECT TOP(5)
	EmployeeID, FirstName, Salary, [Name]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE
	Salary > 15000
ORDER BY
	e.DepartmentID

-- 05. Employees Without Projects
SELECT TOP(3)
	EmployeeID, FirstName
FROM Employees
WHERE
	EmployeeID NOT IN
		(SELECT DISTINCT EmployeeID FROM EmployeesProjects)

-- 06. Employees Hired After
SELECT
	FirstName, LastName, HireDate, [Name]
FROM Employees AS e
JOIN Departments AS d  ON e.DepartmentID = d.DepartmentID
WHERE
	HireDate > '1999-01-01' AND
	[Name] IN ('Sales', 'Finance')
ORDER BY
	HireDate

-- 07. Employees With Project
SELECT TOP(5)
	e.EmployeeID, FirstName, [Name] AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE StartDate > '2002-08-13' AND
	  EndDate IS NULL
ORDER BY
	e.EmployeeID

-- 08. Employee 24
