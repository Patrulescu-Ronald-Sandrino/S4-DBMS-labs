USE [dbms-a3]
GO


CREATE OR ALTER PROCEDURE run0RollbackAddCommit
AS
    BEGIN TRAN
    BEGIN TRY
        EXEC addT1 'Name 1-1', 15
        EXEC addT2 'Name 2-1', 20
        EXEC addT1mn2 1, 1
        COMMIT TRAN
    end try
    begin catch
        ROLLBACK TRAN
        RETURN
    end catch
GO


CREATE OR ALTER PROCEDURE run0RollbackAddRollback
AS
    BEGIN TRAN
    BEGIN TRY
        EXEC addT1 'Name 1-2', 15
        EXEC addT2 'Name 2-2', -1 -- fails bc. value < 0
        EXEC addT1mn2 2, 2
        COMMIT TRAN
    end try
    begin catch
        ROLLBACK TRAN
        RETURN
    end catch
GO
