-- test move_data_to_permanent_tables works as expected
EXEC dbo.test_move_data_to_permanent_tables;

-- remove test SPROC
DROP PROCEDURE dbo.test_move_data_to_permanent_tables;