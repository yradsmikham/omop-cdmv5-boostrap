/************************

The OMOP_CDM_sql_server_ddl.sql is modified due to problems with importing cdm vocabulary.
Therefore, small modifications are required to convert object types back to how they
originally are.

************************/


alter table concept alter column valid_start_date date not null
alter table concept alter column valid_end_date date not null
alter table drug_strength alter column valid_start_date date not null
alter table drug_strength alter column valid_end_date date not null
alter table concept_relationship alter column valid_start_date date not null
alter table concept_relationship alter column valid_end_date date not null
