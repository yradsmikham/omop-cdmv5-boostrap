CREATE PROCEDURE move_data_to_permanent_tables @watermark_table NVARCHAR(100)
AS
    BEGIN TRY
        BEGIN TRANSACTION move_data_to_permanent_tables
        
        DECLARE @current_table_name VARCHAR(MAX);
        DECLARE @staging_table_name VARCHAR(MAX);
        DECLARE @log_date AS NVARCHAR(50);
        DECLARE @log_message NVARCHAR(512);
        SET @current_table_name = ''

        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' move_data_to_permanent_tables is starting execution'
        RAISERROR (@log_message, 0, 1) WITH NOWAIT

        
        EXEC dbo.remove_indexes_constraints;
        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' move_data_to_permanent_tables removed all indexes and constraints on OMOP tables'
        RAISERROR (@log_message, 0, 1) WITH NOWAIT

        DECLARE @cursor_sql VARCHAR(MAX)
        SET @cursor_sql = 'DECLARE omop_tables_cursor CURSOR FOR SELECT table_name FROM ' + @watermark_table
        EXEC(@cursor_sql)
        
        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' move_data_to_permanent_tables is moving data for tables in ' + @watermark_table
        RAISERROR (@log_message, 0, 1) WITH NOWAIT
        -- https://www.mssqltips.com/sqlservertip/1599/cursor-in-sql-server/
        OPEN omop_tables_cursor
        FETCH NEXT FROM omop_tables_cursor INTO @current_table_name

        WHILE @@FETCH_STATUS = 0

        BEGIN  
        DECLARE @truncate_sql VARCHAR(MAX)
        DECLARE @switch_sql VARCHAR(MAX)
        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' move_data_to_permanent_tables is truncating table ' + @current_table_name
        RAISERROR (@log_message, 0, 1) WITH NOWAIT
        SET @truncate_sql = 'TRUNCATE TABLE ' + @current_table_name
        SET @staging_table_name = 'staging_' + @current_table_name
        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' move_data_to_permanent_tables is moving data from staging to ' + @current_table_name
        RAISERROR (@log_message, 0, 1) WITH NOWAIT
        SET @switch_sql = 'ALTER TABLE ' + @staging_table_name + ' SWITCH TO ' + @current_table_name
        EXEC (@truncate_sql)
        EXEC (@switch_sql)
        FETCH NEXT FROM omop_tables_cursor INTO @current_table_name;
        END 
        CLOSE omop_tables_cursor;  
        DEALLOCATE omop_tables_cursor; 

        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' move_data_to_permanent_tables moved all data from staging for tables in ' + @watermark_table
        RAISERROR (@log_message, 0, 1) WITH NOWAIT
        
        EXEC dbo.add_indexes_constraints;
        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' move_data_to_permanent_tables applied all indexes and constraints on OMOP tables'
        RAISERROR (@log_message, 0, 1) WITH NOWAIT
        COMMIT TRANSACTION move_data_to_permanent_tables;
        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' move_data_to_permanent_tables is ending execution'
        RAISERROR (@log_message, 0, 1) WITH NOWAIT
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

GO

