CREATE DATABASE Problem08_Users;

CREATE TABLE Users
(
Id BIGINT NOT NULL IDENTITY PRIMARY KEY,
Username VARCHAR(30) NOT NULL,
[Password] VARCHAR (26) NOT NULL,
ProfilePicture VARBINARY(7200),
LastLoginTime DATE,
IsDeleted BIT
)

INSERT INTO Users (Username, [Password], ProfilePicture, LastLoginTime, IsDeleted)
	VALUES ('kir4o', 'qwerty', NULL, NULL, NULL);
INSERT INTO Users (Username, [Password], ProfilePicture, LastLoginTime, IsDeleted)
	VALUES ('vasko', '123456', NULL, NULL, NULL);
INSERT INTO Users (Username, [Password], ProfilePicture, LastLoginTime, IsDeleted)
	VALUES ('mir4o', 'password123', NULL, NULL, NULL);
INSERT INTO Users (Username, [Password], ProfilePicture, LastLoginTime, IsDeleted)
	VALUES ('molly', 'verybadpassword', NULL, NULL, NULL);
INSERT INTO Users (Username, [Password], ProfilePicture, LastLoginTime, IsDeleted)
	VALUES ('pyth0n', 'easy123456', NULL, NULL, NULL);