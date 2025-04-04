SELECT COUNT(*)
FROM WizzardDeposits

SELECT 
	MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits

SELECT 
	DepositGroup, 
	MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup