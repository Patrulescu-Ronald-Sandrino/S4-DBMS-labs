USE [dbms-a3]; GO


CREATE OR ALTER PROCEDURE run1RollbackAddSuccess AS
    BEGIN TRAN
    BEGIN TRY
        -- autogenerate the names based on the ids that will be assigned
        DECLARE @id1 INT = 1 + (SELECT MAX(id) FROM [T1])
        DECLARE @id2 INT = 1 + (SELECT MAX(id) FROM [T2])
        IF @id1 IS NULL
            SET @id1 = 0
        IF @id2 iS NULl
            SET @id2 = 0
        DECLARE @name1 VARCHAR(30) = CONCAT('Name 1-', @id1)
        DECLARE @name2 VARCHAR(30) = CONCAT('Name 2-', @id2)

        EXEC addT1  @name1, 15
        EXEC addT2 @name2, 20
        SET @id1 = (SELECT MAX(id) FROM [T1])
        SET @id2 = (SELECT MAX(id) FROM [T2])
        EXEC addT1mn2 @id1, @id2
        COMMIT TRAN
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
        RETURN
    END CATCH
GO


CREATE OR ALTER PROCEDURE run1RollbackAddFailure AS
    BEGIN TRAN
    BEGIN TRY
        EXEC addT1 'Name 1-2', 15
        EXEC addT2 'Name 2-2', -1 -- fails bc. @value < 0
        EXEC addT1mn2 2, 2
        COMMIT TRAN
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
    END CATCH
GO
