USE SoftUni
GO

ALTER TABLE Adresses
  ADD CONSTRAINT FK_TownId
  FOREIGN KEY (TownId)
  REFERENCES Towns (Id)

ALTER TABLE Employees
  ADD CONSTRAINT FK_DepartmentId
  FOREIGN KEY (DepartmentId)
  REFERENCES Departments (Id)

  ALTER TABLE Employees
  ADD CONSTRAINT FK_AdressId
  FOREIGN KEY (AdressId)
  REFERENCES Adresses (Id)