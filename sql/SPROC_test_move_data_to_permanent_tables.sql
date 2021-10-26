CREATE PROCEDURE test_move_data_to_permanent_tables
AS
BEGIN
    -- Watermark table for SPROC
    CREATE TABLE watermark_test (table_name VARCHAR(MAX));

    -- Target table when moving data from staging
    CREATE TABLE test_table
    (
    col1 INTEGER NOT NULL,
    col2 INTEGER NOT NULL ,
    col3 VARCHAR(20) NOT NULL,
    );

    CREATE TABLE expected_test_table
    (
    col1 INTEGER NOT NULL,
    col2 INTEGER NOT NULL ,
    col3 VARCHAR(20) NOT NULL,
    );

    -- Staging table for moving data to target table
    SELECT TOP 0 * INTO dbo.staging_test_table FROM dbo.test_table;

    INSERT INTO staging_test_table VALUES(1, 2, 'test');
    INSERT INTO expected_test_table VALUES(1, 2, 'test');
    INSERT INTO watermark_test VALUES('test_table');

    EXEC dbo.move_data_to_permanent_tables 'watermark_test'; 


    DECLARE @Expected AS VARCHAR(100)
    DECLARE @Actual AS VARCHAR(100)

    SET @Expected = (SELECT COUNT(*) FROM expected_test_table)
    SET @Actual = (SELECT COUNT(*) FROM test_table)
    -- Validate test table has the same number of rows as expected table
    IF (SELECT COUNT(*) FROM test_table) = (SELECT COUNT(*) FROM expected_test_table)
        RAISERROR ('Expected and Actual Count is Equal', 0, 1) WITH NOWAIT;
    ELSE       
        RAISERROR ('Actual Value(%s) is not Equal to expected value (%s) ', 0, 1, @Actual, @Expected) WITH NOWAIT;

    -- Validate test table has the same value for col1 as expected table
    SET @Expected = (SELECT col1 FROM expected_test_table)
    SET @Actual = (SELECT col1 FROM test_table)
    IF (SELECT col1 FROM test_table) = (SELECT col1 FROM expected_test_table)
        RAISERROR ('Actual Col 1 is Equal to Expected Col 1', 0, 1) WITH NOWAIT;
    ELSE
        RAISERROR ('Actual Value(%s) is not Equal to expected value (%s) ', 0, 1, @Actual, @Expected) WITH NOWAIT;


    -- Validate test table has the same value for col2 as expected table
    SET @Expected = (SELECT col2 FROM expected_test_table)
    SET @Actual = (SELECT col2 FROM test_table)
    IF (SELECT col2 FROM test_table) = (SELECT col2 FROM expected_test_table)
        RAISERROR ('Actual Col 2 is Equal to Expected Col 2', 0, 1) WITH NOWAIT;
    ELSE
        RAISERROR ('Actual Value(%s) is not Equal to expected value (%s) ', 0, 1, @Actual, @Expected) WITH NOWAIT;

    -- Validate test table has the same value for col3 as expected table
    SET @Expected = (SELECT col3 FROM expected_test_table)
    SET @Actual = (SELECT col3 FROM test_table)
    IF (SELECT col3 FROM test_table) = (SELECT col3 FROM expected_test_table)
        RAISERROR ('Actual Col 3 is Equal to Expected Col 3', 0, 1) WITH NOWAIT;
    ELSE
        RAISERROR ('Actual Value(%s) is not Equal to expected value (%s) ', 0, 1, @Actual, @Expected) WITH NOWAIT;
 
    DROP TABLE watermark_test;
    DROP TABLE test_table;
    DROP TABLE staging_test_table;
    DROP TABLE expected_test_table;
END