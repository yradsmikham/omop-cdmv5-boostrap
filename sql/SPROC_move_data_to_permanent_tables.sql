-- TODO: Output results, Clean up cursor 
CREATE PROCEDURE move_data_to_permanent_tables
AS
    BEGIN TRY
        BEGIN TRANSACTION move_data_to_permanent_tables
        EXEC dbo.remove_indexes_constraints;
        DECLARE @current_table_name VARCHAR(MAX);
        DECLARE @staging_table_name VARCHAR(MAX);
        SET @current_table_name = ''

        DECLARE omop_tables_cursor CURSOR FOR 
        SELECT table_name 
        FROM watermark_copy_staging_tables

        -- https://www.mssqltips.com/sqlservertip/1599/cursor-in-sql-server/
        OPEN omop_tables_cursor
        FETCH NEXT FROM omop_tables_cursor INTO @current_table_name

        WHILE @@FETCH_STATUS = 0

        BEGIN  
        DECLARE @truncate_sql VARCHAR(MAX)
        DECLARE @switch_sql VARCHAR(MAX)
        SET @truncate_sql = 'TRUNCATE TABLE ' + @current_table_name
        SET @staging_table_name = 'staging_' + @current_table_name
        SET @switch_sql = 'ALTER TABLE ' + @staging_table_name + ' SWITCH TO ' + @current_table_name
        EXEC (@truncate_sql)
        EXEC (@switch_sql)
        FETCH NEXT FROM omop_tables_cursor INTO @current_table_name;
        END 
        CLOSE omop_tables_cursor;  
        DEALLOCATE omop_tables_cursor; 

        EXEC dbo.add_indexes_constraints;
        TRUNCATE TABLE table_names;
        COMMIT TRANSACTION move_data_to_permanent_tables;
        RETURN 1; 
    END TRY
    BEGIN CATCH

        IF (SELECT CURSOR_STATUS('global','omop_tables_cursor')) >= -1
        BEGIN
        DEALLOCATE omop_tables_cursor;
        END

        -- Transaction uncommittable
        IF (XACT_STATE()) = -1
        ROLLBACK TRANSACTION move_data_to_permanent_tables;
    
        -- Transaction committable
        IF (XACT_STATE()) = 1
        COMMIT TRANSACTION move_data_to_permanent_tables;

        THROW;

    END CATCH;

