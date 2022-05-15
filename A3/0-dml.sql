USE [dbms-a3]
GO


CREATE OR ALTER PROCEDURE addT1 (@name VARCHAR(30), @value REAL) AS
    BEGIN
        EXEC validateT @name, @value
        INSERT INTO [T1] VALUES (@name, @value)
        INSERT INTO [LogsDML] VALUES ('add', 'T1', GETDATE())
    END
GO

CREATE OR ALTER PROCEDURE addT2 (@name VARCHAR(30), @value REAL) AS
    BEGIN
        EXEC validateT @name, @value
        INSERT INTO [T2] VALUES (@name, @value)
        INSERT INTO [LogsDML] VALUES ('add', 'T2', GETDATE())
    END
GO

CREATE OR ALTER PROCEDURE addT1mn2 (@id1 INT, @id2 INT) AS
    BEGIN
        INSERT INTO T1mn2 VALUES (@id1, @id2) -- fails FK constraint conflict
        INSERT INTO [LogsDML] VALUES ('add', 'T1mn2', GETDATE())
    END
GO
