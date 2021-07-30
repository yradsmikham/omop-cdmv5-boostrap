-- remove any previously added database connection configuration data
-- truncate webapi.source;
-- truncate webapi.source_daimon;

-- OHDSI CDM source
INSERT INTO webapi.source( source_id, source_name, source_key, source_connection, source_dialect)
VALUES (1, 'OHDSI CDM V5 Database', 'OHDSI-CDMV5',
  'jdbc:sqlserver://<env>-sql-server.database.windows.net:1433;database=<database_name>;user=omop_admin;password=<password>', 'sql server');

-- CDM daimon
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1, 1, 0, 'dbo', 2);

-- VOCABULARY daimon
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2, 1, 1, 'dbo', 2);

-- RESULTS daimon
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3, 1, 2, 'webapi', 2);

-- EVIDENCE daimon
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (4, 1, 3, 'webapi', 2);
