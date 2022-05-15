USE [dbms-a3]; GO

CREATE OR ALTER PROCEDURE clearTables AS
    DELETE FROM [T1mn2] WHERE 1 = 1
    DELETE FROM [T1] WHERE 1 = 1
    DELETE FROM [T2] WHERE 1 = 1
    DELETE FROM [LogsDML] WHERE 1 = 1
GO

CREATE OR ALTER PROCEDURE addT1 (@name VARCHAR(30), @value REAL) AS
    EXEC validateT @name, @value
    INSERT INTO [T1] VALUES (@name, @value)
    INSERT INTO [LogsDML] VALUES ('add', 'T1', GETDATE())
GO

CREATE OR ALTER PROCEDURE addT2 (@name VARCHAR(30), @value REAL) AS
    EXEC validateT @name, @value
    INSERT INTO [T2] VALUES (@name, @value)
    INSERT INTO [LogsDML] VALUES ('add', 'T2', GETDATE())
GO

CREATE OR ALTER PROCEDURE addT1mn2 (@id1 INT, @id2 INT) AS
    INSERT INTO [T1mn2] VALUES (@id1, @id2) -- fails if FK constraint conflict
    INSERT INTO [LogsDML] VALUES ('add', 'T1mn2', GETDATE())
GO


CREATE OR ALTER PROCEDURE addTransactT1 (@name VARCHAR(30), @value REAL) AS
    BEGIN TRAN
    BEGIN TRY
        EXEC addT1 @name, @value
        COMMIT TRAN
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
    END CATCH
GO

CREATE OR ALTER PROCEDURE addTransactT2 (@name VARCHAR(30), @value REAL) AS
    BEGIN TRAN
    BEGIN TRY
        EXEC addT2 @name, @value
        COMMIT TRAN
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
    END CATCH
GO

CREATE OR ALTER PROCEDURE addTransactT1mn2 (@id1 INT, @id2 INT) AS
    BEGIN TRAN
    BEGIN TRY
        EXEC addT1mn2 @id1, @id2
        COMMIT TRAN
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
    END CATCH
GO
