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


    -- Validate test table has the same number of rows as expected table
    IF (SELECT COUNT(*) FROM test_table) = (SELECT COUNT(*) FROM expected_test_table)
        RAISERROR ('Equal', 0, 1) WITH NOWAIT
    ELSE
        RAISERROR ('Not Equal', 0, 1);

    -- Validate test table has the same value for col1 as expected table
    IF (SELECT col1 FROM test_table) = (SELECT col1 FROM expected_test_table)
        RAISERROR ('Equal', 0, 1) WITH NOWAIT;
    ELSE
        RAISERROR ('Not Equal', 0, 1);


    -- Validate test table has the same value for col2 as expected table
    IF (SELECT col2 FROM test_table) = (SELECT col2 FROM expected_test_table)
        RAISERROR ('Equal', 0, 1) WITH NOWAIT
    ELSE
        RAISERROR ('Not Equal', 0, 1);

    -- Validate test table has the same value for col3 as expected table
    IF (SELECT col3 FROM test_table) = (SELECT col3 FROM expected_test_table)
        RAISERROR ('Equal', 0, 1) WITH NOWAIT
    ELSE
        RAISERROR ('Not Equal', 0, 1);

    DROP TABLE watermark_test;
    DROP TABLE test_table;
    DROP TABLE staging_test_table;
    DROP TABLE expected_test_table;
END