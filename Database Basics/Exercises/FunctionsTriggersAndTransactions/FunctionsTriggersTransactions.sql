-- Part I – Queries for SoftUni Database
-- Problem 1
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS 
  SELECT e.FirstName, e.LastName
    FROM Employees AS e
   WHERE e.Salary > 35000
   
 -- Problem 2
CREATE PROC usp_GetEmployeesSalaryAboveNumber @Amount MONEY
AS 
  SELECT e.FirstName, e.LastName
    FROM Employees AS e
   WHERE e.Salary >= @Amount
  
-- Problem 3
CREATE PROC usp_GetTownsStartingWith @Prefix VARCHAR(50)
AS 
  SELECT t.[Name]
    FROM Towns AS t
   WHERE @Prefix = LEFT(t.[Name], LEN(@Prefix))

-- Problem 4
CREATE PROC usp_GetEmployeesFromTown @TownName VARCHAR(50)
AS 
  SELECT e.FirstName, e.LastName
    FROM Employees AS e
	JOIN Addresses AS a
	  ON e.AddressID = a.AddressID
	JOIN Towns AS t
	  ON a.TownID = t.TownID
   WHERE t.[Name] = @TownName

-- Problem 5
CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY)
RETURNS VARCHAR(30)
AS
BEGIN
     RETURN
	   CASE WHEN @salary < 30000 THEN 'Low'
	        WHEN @salary BETWEEN 30000 AND 50000 THEN 'Average'
	  	    WHEN @salary > 50000 THEN 'High'
	   END
END

-- Problem 6
CREATE PROC usp_EmployeesBySalaryLevel @SalaryLevel VARCHAR(10)
AS
  IF (@SalaryLevel = 'Low')
      SELECT FirstName + ' ' + LastName FROM Employees WHERE Salary < 30000
  ELSE IF (@SalaryLevel = 'Average')
	  SELECT FirstName + ' ' + LastName FROM Employees WHERE Salary BETWEEN 30000 AND 50000
  ELSE IF (@SalaryLevel = 'High')
      SELECT FirstName + ' ' + LastName FROM Employees WHERE Salary > 50000

-- Problem 7
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR (50), @word VARCHAR (50)) 
RETURNS BIT
AS
BEGIN
     DECLARE @index INT = 1
	 DECLARE @length INT = LEN(@word)
	 DECLARE @letter CHAR(1)

	 WHILE (@index <= @length)
	 BEGIN
		  SET @letter = SUBSTRING(@word, @index, 1)
	      IF (CHARINDEX(@letter, @setOfLetters) > 0)
		     SET @index = @index + 1
		  ELSE
		     RETURN 0
	 END
	 RETURN 1
END 

-- Problem 8
 -- No queries needed

 -- PART II – Queries for Bank Database
-- Problem 9
CREATE PROC usp_GetHoldersFullName 
AS
BEGIN
     SELECT ah.FirstName + ' ' + ah.LastName AS [Full Name]
	   FROM AccountHolders AS ah
END

-- Problem 10
CREATE PROC usp_GetHoldersWithBalanceHigherThan  @balance MONEY
AS
  SELECT ah.FirstName, ah.LastName
    FROM AccountHolders AS ah
	JOIN Accounts AS a
	  ON ah.Id = a.AccountHolderId
   GROUP BY ah.FirstName, ah.LastName
   HAVING SUM(a.Balance) > @balance

-- Problem 11
CREATE FUNCTION ufn_CalculateFutureValue (@sum MONEY, @interestRate FLOAT, @years FLOAT)
RETURNS MONEY
BEGIN
  DECLARE @futureValue MONEY
  SET @futureValue = @sum * POWER((1 + @interestRate), @years)
  RETURN @futureValue
END

-- Problem 12
CREATE PROC usp_CalculateFutureValueForAccount
AS
  SELECT a.Id AS [Account Id],
         ah.FirstName,
		 ah.LastName, 
		 a.Balance, 
		 dbo.ufn_CalculateFutureValue(a.Balance, 0.1, 5)
    FROM Accounts AS a
	JOIN AccountHolders AS ah
	  ON a.AccountHolderId = a.id


-- Problem 13
CREATE PROC usp_DepositMoney (@accountId INT, @moneyAmount MONEY)
AS
  BEGIN
       BEGIN TRAN;
	   UPDATE Accounts
	   SET Balance = Balance + @moneyAmount
	   WHERE Id = @accountId
	   IF (@moneyAmount < 0)
	   BEGIN
	        ROLLBACK;
			RAISERROR('Invalid Account', 16, 1);
			RETURN;
	   END
	   COMMIT
  END

-- Problem 14
CREATE PROC usp_WithdrawMoney (@accountId INT, @moneyAmount MONEY)
AS
  BEGIN
       BEGIN TRAN;
	   UPDATE Accounts
	   SET Balance = Balance - @moneyAmount
	   WHERE Id = @accountId
	   IF (@moneyAmount < 0)
	   BEGIN
	        ROLLBACK;
			RAISERROR('Invalid Account', 16, 1);
			RETURN;
	   END
	   COMMIT
  END
  
-- Problem 15
CREATE PROC usp_TransferMoney @senderId INT, @receiverId INT, @amount MONEY
AS
BEGIN
     BEGIN TRAN;
	 UPDATE Acounts SET Balance = Balance - @amount
	 WHERE Id = @senderId

	 IF (@senderId = (SELECT TOP 1 Id FROM AccountHolders WHERE Id = @senderId)
	    OR @receiverId = (SELECT TOP 1 Id FROM AccountHolders WHERE Id = @receiverId)
		OR @amount < 0)
	 BEGIN
	      ROLLBACK;
		  RAISERROR('Invalid input!', 16, 1);
		  RETURN;
	 END
	 COMMIT;
END
 
-- Problem 16
USE Bank
GO

CREATE TABLE Logs
(
LogId INT IDENTITY PRIMARY KEY,
AccountId INT,
OldBalance MONEY,
NewBalance MONEY
CONSTRAINT FK_Logs_Accounts FOREIGN KEY (AccountId)
REFERENCES Accounts (Id)
)
GO

CREATE TRIGGER tr_LogBalance
ON Accounts
AFTER UPDATE
AS
BEGIN
     DECLARE @accountId INT = (SELECT Id FROM inserted);
	 DECLARE @oldBalance INT = (SELECT Balance FROM deleted);
	 DECLARE @newBalance MONEY = (SELECT Balance FROM inserted);
	 INSERT INTO Logs (AccountId, OldBalance, NewBalance)
	 VALUES(@accountId, @oldBalance, @newBalance);
END
GO


-- Problem 17
USE Bank
GO

CREATE TABLE NotificationEmails
(
Id INT IDENTITY PRIMARY KEY,
Recipient INT,
[Subject] VARCHAR(50),
Body VARCHAR(200)
)
GO

CREATE TRIGGER tr_NofityLogAdded
ON Logs
AFTER INSERT
AS
BEGIN
     DECLARE @oldBalance MONEY = (SELECT OldBalance FROM inserted);
	 DECLARE @newBalance MONEY = (SELECT NewBalance FROM inserted);

     DECLARE @recipient INT = (SELECT AccountId FROM inserted);
	 DECLARE @subject VARCHAR(50) = CONCAT('Balance change for account: ', @recipient);
	 DECLARE @body VARCHAR(200) = CONCAT('On ', GETDATE(), ' your balance was changed from ', @oldBalance,' to ',  @newBalance, '.');

     INSERT INTO NotificationEmails (Recipient, [Subject], Body)
	 VALUES (@recipient, @subject, @body);
END
GO

-- PART III – Queries for Diablo Database
-- Problem 18
CREATE FUNCTION ufn_CashInUsersGames(@gameName NVARCHAR(100))
RETURNS TABLE
AS
  RETURN
  (
   SELECT SUM(cr.Cash) AS [SumCash] 
     FROM
         (SELECT 
		         ug.Cash,
	             (ROW_NUMBER() OVER(ORDER BY ug.Cash DESC)) AS [RowNumber]
	        FROM UsersGames AS ug
	        JOIN Games AS g
              ON ug.GameId = g.Id
		   WHERE g.Name = @gameName) AS cr
    WHERE cr.RowNumber % 2 = 1
  )       

-- Problem 19
CREATE TRIGGER tr_UserGameItems on UserGameItems
INSTEAD OF INSERT
AS
	INSERT INTO UserGameItems
	SELECT ItemId, UserGameId FROM inserted
	WHERE
		ItemId in (
			SELECT Id 
			FROM Items 
			WHERE MinLevel <= (
				SELECT [Level]
				FROM UsersGames 
				WHERE Id = UserGameId
			)
		)
GO

-- Add bonus cash for users
UPDATE UsersGames
SET Cash = Cash + 50000 + (SELECT SUM(i.Price) FROM Items i JOIN UserGameItems ugi ON ugi.ItemId = i.Id WHERE ugi.UserGameId = UsersGames.Id)
WHERE UserId IN (
	SELECT Id 
	FROM Users 
	WHERE Username IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
)
AND GameId = (SELECT Id FROM Games WHERE Name = 'Bali')

-- Buy items for users

INSERT INTO UserGameItems (UserGameId, ItemId)
SELECT  UsersGames.Id, i.Id 
FROM UsersGames, Items i
WHERE UserId in (
	SELECT Id 
	FROM Users 
	WHERE Username IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
) AND GameId = (SELECT Id FROM Games WHERE Name = 'Bali' ) AND ((i.Id > 250 AND i.Id < 300) OR (i.Id > 500 AND i.Id < 540))


-- Get cash from users
UPDATE UsersGames
SET Cash = Cash - (SELECT SUM(i.Price) FROM Items i JOIN UserGameItems ugi ON ugi.ItemId = i.Id WHERE ugi.UserGameId = UsersGames.Id)
WHERE UserId IN (
	SELECT Id 
	FROM Users 
	WHERE Username IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
)
AND GameId = (SELECT Id FROM Games where Name = 'Bali')


SELECT u.Username, g.Name, ug.Cash, i.Name [Item Name] FROM UsersGames ug
JOIN Games g ON ug.GameId = g.Id
JOIN Users u ON ug.UserId = u.Id
JOIN UserGameItems ugi ON ugi.UserGameId = ug.Id
JOIN Items i ON i.Id = ugi.ItemId
WHERE g.Name = 'Bali'
ORDER BY Username, [Item Name]

-- Problem 20
SET XACT_ABORT ON 
BEGIN TRANSACTION [Tran1]

BEGIN TRY
	UPDATE 
		UsersGames 
	SET 
		Cash = Cash - (
			SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 11 AND 12
		) 
	WHERE Id = 110

	INSERT INTO UserGameItems (UserGameId, ItemId)
	SELECT 110, Id FROM Items WHERE MinLevel BETWEEN 11 AND 12

COMMIT TRANSACTION [Tran1]

END TRY
BEGIN CATCH
  ROLLBACK TRANSACTION [Tran1]
END CATCH 
GO

BEGIN TRANSACTION [Tran2]

BEGIN TRY
	UPDATE 
		UsersGames 
	SET 
		Cash = Cash - (
			SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 19 AND 21
		) 
	WHERE Id = 110

	INSERT INTO UserGameItems (UserGameId, ItemId)
	SELECT 110, Id FROM Items WHERE MinLevel BETWEEN 19 AND 21

COMMIT TRANSACTION [Tran2]
END TRY
BEGIN CATCH
  ROLLBACK TRANSACTION [Tran2]
END CATCH
GO

SELECT Items.Name [Item Name] 
FROM Items 
INNER JOIN UserGameItems ON Items.Id = UserGameItems.ItemId 
WHERE UserGameId = 110 
ORDER BY [Item Name]

-- Problem 21
select 
	SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email)) as [Email Provider],
	COUNT(Username) [Number Of Users]
from Users
group by SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email))
order by COUNT(Username) desc, [Email Provider]

--Problem 22
select g.Name as Game, gt.Name as [Game Type], u.Username, ug.Level, ug.Cash, c.Name as Character from Games g
join GameTypes gt on gt.Id = g.GameTypeId
join UsersGames ug on ug.GameId = g.Id
join Users u on ug.UserId = u.Id
join Characters c on c.Id = ug.CharacterId
order by Level desc, Username, Game

--Problem 23
select u.Username, g.Name as Game, COUNT(i.Id) as [Items Count], SUM(i.Price) as [Items Price] 
from Users u
join UsersGames ug on ug.UserId = u.Id
join Games g on ug.GameId = g.Id
join Characters c on ug.CharacterId = c.Id
join UserGameItems ugi on ugi.UserGameId = ug.Id
join Items i on i.Id = ugi.ItemId
group by u.Username, g.Name
having COUNT(i.Id) >= 10
order by [Items Count] desc, [Items Price] desc, Username

-- Problem 24
select 
	u.Username, 
	g.Name as Game, 
	MAX(c.Name) Character,
	SUM(its.Strength) + MAX(gts.Strength) + MAX(cs.Strength) as Strength,
	SUM(its.Defence) + MAX(gts.Defence) + MAX(cs.Defence) as Defence,
	SUM(its.Speed) + MAX(gts.Speed) + MAX(cs.Speed) as Speed,
	SUM(its.Mind) + MAX(gts.Mind) + MAX(cs.Mind) as Mind,
	SUM(its.Luck) + MAX(gts.Luck) + MAX(cs.Luck) as Luck
from Users u
join UsersGames ug on ug.UserId = u.Id
join Games g on ug.GameId = g.Id
join GameTypes gt on gt.Id = g.GameTypeId
join [Statistics] gts on gts.Id = gt.BonusStatsId
join Characters c on ug.CharacterId = c.Id
join [Statistics] cs on cs.Id = c.StatisticId
join UserGameItems ugi on ugi.UserGameId = ug.Id
join Items i on i.Id = ugi.ItemId
join [Statistics] its on its.Id = i.StatisticId
group by u.Username, g.Name
order by Strength desc, Defence desc, Speed desc, Mind desc, Luck desc

-- Problem 25
select 
	i.Name, 
	i.Price, 
	i.MinLevel,
	s.Strength,
	s.Defence,
	s.Speed,
	s.Luck,
	s.Mind
from Items i
join [Statistics] s on s.Id = i.StatisticId
where s.Mind > (
	select AVG(s.Mind) from Items i 
	join [Statistics] s on s.Id = i.StatisticId
) and s.Luck > (
	select AVG(s.Luck) from Items i 
	join [Statistics] s on s.Id = i.StatisticId
) and s.Speed > (
	select AVG(s.Speed) from Items i 
	join [Statistics] s on s.Id = i.StatisticId
) 
ORDER BY i.Name

-- Problem 26
select i.Name as Item, Price, MinLevel, gt.Name as [Forbidden Game Type] from Items i
left join GameTypeForbiddenItems gtf on gtf.ItemId = i.Id
left join GameTypes gt on gt.Id = gtf.GameTypeId
order by [Forbidden Game Type] desc, Item 

-- Problem 27
INSERT INTO UserGameItems(ItemId, UserGameId)
VALUES 
	(
		(select Id from Items where Name = 'Blackguard'), 
		(select ug.Id from UsersGames ug 
			join Users u on u.Id = ug.UserId
			join Games g on g.Id = ug.GameId
			where u.Username = 'Alex' and g.Name = 'Edinburgh')
	)

update UsersGames
set Cash = Cash - (select Price from Items where Name = 'Blackguard')
where Id = (select ug.Id from UsersGames ug 
			join Users u on u.Id = ug.UserId
			join Games g on g.Id = ug.GameId
			where u.Username = 'Alex' and g.Name = 'Edinburgh')

insert into UserGameItems(ItemId, UserGameId)
values 
	(
		(select Id from Items where Name = 'Bottomless Potion of Amplification'), 
		(select ug.Id from UsersGames ug 
			join Users u on u.Id = ug.UserId
			join Games g on g.Id = ug.GameId
			where u.Username = 'Alex' and g.Name = 'Edinburgh')
	)

update UsersGames
set Cash = Cash - (select Price from Items where Name = 'Bottomless Potion of Amplification')
where Id = (select ug.Id from UsersGames ug 
	join Users u on u.Id = ug.UserId
	join Games g on g.Id = ug.GameId
	where u.Username = 'Alex' and g.Name = 'Edinburgh')

insert into UserGameItems(ItemId, UserGameId)
values (
		(select Id from Items where Name = 'Eye of Etlich (Diablo III)'), 
		(select ug.Id from UsersGames ug 
			join Users u on u.Id = ug.UserId
			join Games g on g.Id = ug.GameId
			where u.Username = 'Alex' and g.Name = 'Edinburgh')
	)

update UsersGames
set Cash = Cash - (select Price from Items where Name = 'Eye of Etlich (Diablo III)')
where Id = (select ug.Id from UsersGames ug 
	join Users u on u.Id = ug.UserId
	join Games g on g.Id = ug.GameId
	where u.Username = 'Alex' and g.Name = 'Edinburgh')

insert into UserGameItems(ItemId, UserGameId)
values (
		(select Id from Items where Name = 'Gem of Efficacious Toxin'), 
		(select ug.Id from UsersGames ug 
			join Users u on u.Id = ug.UserId
			join Games g on g.Id = ug.GameId
			where u.Username = 'Alex' and g.Name = 'Edinburgh')
	)

update UsersGames
set Cash = Cash - (select Price from Items where Name = 'Gem of Efficacious Toxin')
where Id = (select ug.Id from UsersGames ug 
	join Users u on u.Id = ug.UserId
	join Games g on g.Id = ug.GameId
	where u.Username = 'Alex' and g.Name = 'Edinburgh')

insert into UserGameItems(ItemId, UserGameId)
values (
		(select Id from Items where Name = 'Golden Gorget of Leoric'), 
		(select ug.Id from UsersGames ug 
			join Users u on u.Id = ug.UserId
			join Games g on g.Id = ug.GameId
			where u.Username = 'Alex' and g.Name = 'Edinburgh')
	)

update UsersGames
set Cash = Cash - (select Price from Items where Name = 'Golden Gorget of Leoric')
where Id = (select ug.Id from UsersGames ug 
	join Users u on u.Id = ug.UserId
	join Games g on g.Id = ug.GameId
	where u.Username = 'Alex' and g.Name = 'Edinburgh')

	
insert into UserGameItems(ItemId, UserGameId)
values (
		(select Id from Items where Name = 'Hellfire Amulet'), 
		(select ug.Id from UsersGames ug 
			join Users u on u.Id = ug.UserId
			join Games g on g.Id = ug.GameId
			where u.Username = 'Alex' and g.Name = 'Edinburgh')
	)

update UsersGames
set Cash = Cash - (select Price from Items where Name = 'Hellfire Amulet')
where Id = (select ug.Id from UsersGames ug 
	join Users u on u.Id = ug.UserId
	join Games g on g.Id = ug.GameId
	where u.Username = 'Alex' and g.Name = 'Edinburgh')

select u.Username, g.Name, ug.Cash, i.Name [Item Name] from UsersGames ug
join Games g on ug.GameId = g.Id
join Users u on ug.UserId = u.Id
join UserGameItems ugi on ugi.UserGameId = ug.Id
join Items i on i.Id = ugi.ItemId
where g.Name = 'Edinburgh'
order by i.Name

-- PART IV – Queries for Geography Database
-- Problem 28
SELECT 
  PeakName, MountainRange as Mountain, Elevation
FROM 
  Peaks p 
  JOIN Mountains m ON p.MountainId = m.Id
ORDER BY Elevation DESC, PeakName

-- Problem 29
SELECT 
  PeakName, MountainRange as Mountain, c.CountryName, cn.ContinentName
FROM 
  Peaks p
  JOIN Mountains m ON p.MountainId = m.Id
  JOIN MountainsCountries mc ON m.Id = mc.MountainId
  JOIN Countries c ON c.CountryCode = mc.CountryCode
  JOIN Continents cn ON cn.ContinentCode = c.ContinentCode
ORDER BY PeakName, CountryName

-- Problem 30
SELECT
  c.CountryName, ct.ContinentName,
  COUNT(r.RiverName) AS RiversCount,
  ISNULL(SUM(r.Length), 0) AS TotalLength
FROM
  Countries c
  LEFT JOIN Continents ct ON ct.ContinentCode = c.ContinentCode
  LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
  LEFT JOIN Rivers r ON r.Id = cr.RiverId
GROUP BY c.CountryName, ct.ContinentName
ORDER BY RiversCount DESC, TotalLength DESC, CountryName

-- Problem 31
SELECT
  cur.CurrencyCode,
  MIN(cur.Description) AS Currency,
  COUNT(c.CountryName) AS NumberOfCountries
FROM
  Currencies cur
  LEFT JOIN Countries c ON cur.CurrencyCode = c.CurrencyCode
GROUP BY cur.CurrencyCode
ORDER BY NumberOfCountries DESC, Currency ASC

-- Problem 32
SELECT
  ct.ContinentName,
  SUM(CONVERT(numeric, c.AreaInSqKm)) AS CountriesArea,
  SUM(CONVERT(numeric, c.Population)) AS CountriesPopulation
FROM
  Countries c
  LEFT JOIN Continents ct ON ct.ContinentCode = c.ContinentCode
GROUP BY ct.ContinentName
ORDER BY CountriesPopulation DESC

-- Problem 33
CREATE TABLE Monasteries(
  Id INT PRIMARY KEY IDENTITY,
  Name NVARCHAR(50),
  CountryCode CHAR(2)
  CONSTRAINT FK_Monasteries_Countries FOREIGN KEY (CountryCode) REFERENCES Countries(CountryCode)
)


INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')

ALTER TABLE Countries
ADD IsDeleted BIT NOT NULL
DEFAULT 0

UPDATE Countries
SET IsDeleted = 1
WHERE CountryCode IN (
	SELECT c.CountryCode
	FROM Countries c
	  JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
	  JOIN Rivers r ON r.Id = cr.RiverId
	GROUP BY c.CountryCode
	HAVING COUNT(r.Id) > 3
)

SELECT 
  m.Name AS Monastery, c.CountryName AS Country
FROM 
  Countries c
  JOIN Monasteries m ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted = 0
ORDER BY m.Name

-- Problem 34
UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'

INSERT INTO Monasteries(Name, CountryCode) VALUES
('Hanga Abbey', (SELECT CountryCode FROM Countries WHERE CountryName = 'Tanzania'))
INSERT INTO Monasteries(Name, CountryCode) VALUES
('Myin-Tin-Daik', (SELECT CountryCode FROM Countries WHERE CountryName = 'Maynmar'))

SELECT ct.ContinentName, c.CountryName, COUNT(m.Id) AS MonasteriesCount
FROM Continents ct
  LEFT JOIN Countries c ON ct.ContinentCode = c.ContinentCode
  LEFT JOIN Monasteries m ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted = 0
GROUP BY ct.ContinentName, c.CountryName
ORDER BY MonasteriesCount DESC, c.CountryName