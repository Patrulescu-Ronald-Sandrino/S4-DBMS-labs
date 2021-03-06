USE MASTER
GO

-- DROP DATABASE IF EXISTS [dbms-a3]; CREATE DATABASE [dbms-a3]
GO

USE [dbms-a3]
GO

DROP TABLE IF EXISTS [T1mn2]
DROP TABLE IF EXISTS [T1]
DROP TABLE IF EXISTS [T2]
DROP TABLE IF EXISTS [LogsDML]
GO

CREATE TABLE [T1] (
    [id] INT IDENTITY(1, 1) PRIMARY KEY,
    [name] VARCHAR(100),
    [value] real
)
DBCC CHECKIDENT ([T1], RESEED, 0)
GO


CREATE TABLE [T2] (
    [id] INT IDENTITY(1, 1) PRIMARY KEY,
    [name] VARCHAR(100),
    [value] real
)
DBCC CHECKIDENT ([T2], RESEED, 0)
GO

CREATE TABLE [T1mn2] (
    [id1] INT FOREIGN KEY REFERENCES [T1]([id]),
    [id2] INT FOREIGN KEY REFERENCES [T2]([id]),
    PRIMARY KEY (id1, id2)
)
GO

CREATE TABLE [LogsDML] (
    [id] INT IDENTITY(1, 1) PRIMARY KEY,
    [operation] VARCHAR(30),
    [table] VARCHAR(30),
    [executionDateTime] DATETIME
)
DBCC CHECKIDENT ([LogsDML], RESEED, 0)
GO