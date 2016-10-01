CREATE DATABASE CarRental

CREATE TABLE Categories
  (
     Id          INT NOT NULL,
     Category    NVARCHAR(50) NOT NULL,
     DailyRate   DECIMAL,
     WeeklyRate  DECIMAL,
     MonthlyRate DECIMAL NOT NULL,
     WeekendRate DECIMAL
  )

ALTER TABLE Categories
  ADD CONSTRAINT PK_CategoryId PRIMARY KEY (Id)

CREATE TABLE Cars
  (
     Id          INT NOT NULL,
     PlateNumber VARCHAR(10) NOT NULL,
     Make        NVARCHAR(50) NOT NULL,
     Model       NVARCHAR(50) NOT NULL,
     CarYear     DATE NOT NULL,
     Doors       INT,
     Picture     VARBINARY(MAX),
     Condition   VARCHAR(50) NOT NULL CHECK (Condition IN('Bad', 'Average',
     'Good')),
     Available   BIT NOT NULL
  )

ALTER TABLE Cars
  ADD CONSTRAINT PK_CarId PRIMARY KEY (Id)

CREATE TABLE Employees
  (
     Id        INT NOT NULL,
     FirstName NVARCHAR(50) NOT NULL,
     LastName  NVARCHAR(50) NOT NULL,
     Title     NVARCHAR(50) NOT NULL,
     Notes     NVARCHAR(MAX)
  )

ALTER TABLE Employees
  ADD CONSTRAINT PK_EmployeeId PRIMARY KEY (Id)

CREATE TABLE Customers
  (
     Id                  INT NOT NULL,
     DriverLicenseNumber VARCHAR(50) NOT NULL,
     FullName            NVARCHAR(50) NOT NULL,
     Adress              NVARCHAR(50),
     City                NVARCHAR(50),
     ZIPCode             INT,
     Notes               NVARCHAR(MAX)
  )

ALTER TABLE Customers
  ADD CONSTRAINT PK_CustomerId PRIMARY KEY (Id)

CREATE TABLE RentalOrders
  (
     Id               INT NOT NULL,
     EmployeeId       INT NOT NULL,
     CustomerId       INT NOT NULL,
     CarId            INT NOT NULL,
     CarCondition     VARCHAR(50) NOT NULL,
     TankLevel        NVARCHAR(50),
     KilometrageStart FLOAT NOT NULL,
     KilometrageEnd   FLOAT NOT NULL,
     TotalKilometrage FLOAT,
     StartDate        DATE NOT NULL,
     EndDate          DATE NOT NULL,
     TotalDays        DATE,
     RateApplied      DECIMAL NOT NULL,
     TaxRate          DECIMAL,
     OrderStatus      NVARCHAR(50) CHECK (OrderStatus IN ('Active', 'Inactive'))
     ,
     Notes            NVARCHAR(MAX)
  )

ALTER TABLE RentalOrders
  ADD CONSTRAINT PK_RentalOrderId PRIMARY KEY (Id)

INSERT INTO Categories
            (Id,
             Category,
             MonthlyRate)
VALUES      (1,
             'Cars',
             '500')

INSERT INTO Categories
            (Id,
             Category,
             MonthlyRate)
VALUES      (2,
             'Trucks',
             '950')

INSERT INTO Categories
            (Id,
             Category,
             MonthlyRate)
VALUES      (3,
             'Cars',
             '600');

INSERT INTO Cars
            (Id,
             PlateNumber,
             Make,
             Model,
             CarYear,
             Condition,
             Available)
VALUES      (1,
             'GB2514',
             'BMW',
             '5 Series',
             '20000101',
             'Good',
             1)

INSERT INTO Cars
            (Id,
             PlateNumber,
             Make,
             Model,
             CarYear,
             Condition,
             Available)
VALUES      (2,
             'CH9696',
             'Mercedes',
             'CL200',
             '20000101',
             'Good',
             1)

INSERT INTO Cars
            (Id,
             PlateNumber,
             Make,
             Model,
             CarYear,
             Condition,
             Available)
VALUES      (3,
             'FR2414',
             'Audi',
             'A6',
             '20000101',
             'Good',
             0);

INSERT INTO Employees
            (Id,
             FirstName,
             LastName,
             Title)
VALUES      (1,
             'Dan',
             'Wise',
             'CEO')

INSERT INTO Employees
            (Id,
             FirstName,
             LastName,
             Title)
VALUES      (2,
             'Phil',
             'Jones',
             'Secretary')

INSERT INTO Employees
            (Id,
             FirstName,
             LastName,
             Title)
VALUES      (3,
             'Vinnie',
             'Northman',
             'Janitor')

INSERT INTO Customers
            (Id,
             DriverLicenseNumber,
             FullName)
VALUES      (1,
             'asd486453',
             'Mark Dane')

INSERT INTO Customers
            (Id,
             DriverLicenseNumber,
             FullName)
VALUES      (2,
             'htr8451',
             'Peter Griffin')

INSERT INTO Customers
            (Id,
             DriverLicenseNumber,
             FullName)
VALUES      (3,
             'erty897897',
             'Louis Jefferson');

INSERT INTO RentalOrders
            (Id,
             EmployeeId,
             CustomerId,
             CarId,
             CarCondition,
             TankLevel,
             KilometrageStart,
             KilometrageEnd,
             TotalKilometrage,
             StartDate,
             EndDate,
             TotalDays,
             RateApplied)
VALUES     (1,
            1,
            1,
            1,
            'Good',
            'Full',
            10,
            20,
            10,
            '2015-01-01',
            '2015-02-03',
            NULL,
            1987.15);

INSERT INTO RentalOrders
            (Id,
             EmployeeId,
             CustomerId,
             CarId,
             CarCondition,
             TankLevel,
             KilometrageStart,
             KilometrageEnd,
             TotalKilometrage,
             StartDate,
             EndDate,
             TotalDays,
             RateApplied)
VALUES     (2,
            2,
            2,
            2,
            'Good',
            'Full',
            20,
            30,
            10,
            '2015-01-01',
            '2015-02-03',
            NULL,
            567.15);

INSERT INTO RentalOrders
            (Id,
             EmployeeId,
             CustomerId,
             CarId,
             CarCondition,
             TankLevel,
             KilometrageStart,
             KilometrageEnd,
             TotalKilometrage,
             StartDate,
             EndDate,
             TotalDays,
             RateApplied)
VALUES     (3,
            3,
            3,
            3,
            'Good',
            'Full',
            40,
            50,
            10,
            '2015-02-01',
            '2015-02-03',
            NULL,
            95.35); 