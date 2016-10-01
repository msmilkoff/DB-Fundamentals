DECLARE @table NVARCHAR(512), @sql NVARCHAR(MAX);

SELECT @table = N'dbo.Users';

SELECT @sql = 'ALTER TABLE ' + @table 
    + ' DROP CONSTRAINT ' + name + ';'
    FROM sys.key_constraints
    WHERE [type] = 'PK'
    AND [parent_object_id] = OBJECT_ID(@table);

EXEC sp_executeSQL @sql;