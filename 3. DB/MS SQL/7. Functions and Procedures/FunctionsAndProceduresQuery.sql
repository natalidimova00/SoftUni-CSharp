-- 01. Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary > 35000
END

EXEC usp_GetEmployeesSalaryAbove35000

-- 02. Employees with Salary Above Number
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber @salary DECIMAL(18,4)
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary >= @salary
END

EXEC usp_GetEmployeesSalaryAboveNumber 70000

-- 03. Town Names Starting With
CREATE PROCEDURE usp_GetTownsStartingWith @inputString VARCHAR(MAX)
AS
BEGIN
	SELECT [Name] AS Town
	FROM Towns
	WHERE [Name] LIKE CONCAT(@inputString, '%')
END

-- 04. Employees from Town
CREATE PROCEDURE usp_GetEmployeesFromTown @townName VARCHAR(MAX)
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees AS e
	JOIN Addresses AS a ON a.AddressID = e.AddressID
	JOIN Towns AS t ON t.TownID = a.TownID
	WHERE t.[Name] = @townName
END

EXEC usp_GetEmployeesFromTown 'Sofia'

-- 05. Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @Result NVARCHAR(10)
	IF(@salary < 30000)
	BEGIN
		SET @Result = 'Low'
	END
	ELSE IF(@salary BETWEEN 30000 AND 50000)
	BEGIN
		SET @Result = 'Average'
	END
	ELSE
	BEGIN
		SET @Result = 'High'
	END
	RETURN @Result
END

SELECT FirstName, Salary,
	dbo.ufn_GetSalaryLevel(Salary)
FROM Employees

-- 06. Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel @salaryLevel VARCHAR(10)
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @salaryLevel
END

EXEC usp_EmployeesBySalaryLevel Low

-- 07. Define Function
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @WordLength INT = LEN(@word)
	DECLARE @Iterator INT = 1
	WHILE(@Iterator <= @WordLength)
		BEGIN
			IF(CHARINDEX(SUBSTRING(@word, @Iterator, 1), @setOfLetters) = 0)
				RETURN 0
			SET @Iterator += 1
		END
	RETURN 1
END

-- 08. *Delete Employees and Departments
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
	DECLARE @deletedEmployees TABLE(Id INT)

	INSERT INTO @deletedEmployees
		SELECT EmployeeID
		FROM Employees
		WHERE DepartmentID = @departmentId

	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL

	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN 
	(
		SELECT Id FROM @deletedEmployees
	)

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN
	(
		SELECT Id FROM @deletedEmployees
	)

	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN
	(
		SELECT Id FROM @deletedEmployees
	)

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*) FROM Employees
	WHERE DepartmentID = @departmentId
END

-- 09. Find Full Name
CREATE PROCEDURE usp_GetHoldersFullName
AS
BEGIN
	SELECT CONCAT_WS(' ', FirstName, LastName) AS [Full Name]
	FROM AccountHolders
END

-- 10. People with Balance Higher Than
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@amount money)
AS
BEGIN
	SELECT FirstName, LastName
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON a.AccountHolderId = ah.Id
	GROUP BY FirstName, LastName
	HAVING SUM(a.Balance) > @amount
	ORDER BY FirstName, LastName
END

EXEC usp_GetHoldersWithBalanceHigherThan 500

-- 11. Future Value Function
CREATE FUNCTION ufn_CalculateFutureValue(@sum DECIMAL(10,4), @interestRate FLOAT, @term INT)
RETURNS DECIMAL(10, 4)
AS
BEGIN
	RETURN @sum * (POWER((1 + @interestRate), @term))
END

-- 12. Calculating Interest
CREATE PROCEDURE usp_CalculateFutureValueForAccount(@acccountId INT, @interestRate FLOAT)
AS
	DECLARE @term INT = 5
	SELECT 
		a.Id AS [Account Id],
		FirstName, LastName, 
		Balance AS [Current Balance],
		dbo.ufn_CalculateFutureValue(Balance, @interestRate, @term) AS [Balance in 5 years]
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON a.AccountHolderId = ah.Id
	WHERE a.Id = @acccountId

-- 13. *Cash in User Games Odd Rows
CREATE FUNCTION ufn_CashInUsersGames(@gameName VARCHAR(MAX))
RETURNS TABLE
AS
RETURN(
SELECT SUM(Cash) AS SumCash
FROM
	(SELECT
		g.Id, g.[Name], ug.Cash,
		ROW_NUMBER() OVER (ORDER BY ug.Cash DESC) AS RowRank
	FROM Games AS g
	JOIN UsersGames AS ug ON ug.GameId = g.Id
	WHERE g.[Name] = @gameName
	) AS NestedQuery
	WHERE RowRank % 2 = 1)

SELECT * FROM ufn_CashInUsersGames('Love in a Mist')