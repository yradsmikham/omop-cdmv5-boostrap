EXEC sys.sp_cdc_enable_db /*System tables are created along with cdc schema*/

/* View System Tables
SELECT * FROM cdc.captured_columns
SELECT * FROM cdc.change_tables
SELECT * FROM cdc.ddl_history 
SELECT * FROM cdc.index_columns 
SELECT * FROM cdc.lsn_time_mapping 
SELECT * FROM cdc.cdc_jobs
*/

/* Template for enabling table 
EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'',
@role_name = NULL; /* Control access to change data. */
/*@supports_net_changes = 1 */
/*@captured_column_list = 'column1', 'column2'*/


EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'drug_era',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'dose_era',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'condition_era',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'concept',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'vocabulary',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'domain',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'concept_class',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'concept_relationship',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'relationship',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'concept_synonym',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'concept_ancestor',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'source_to_concept_map',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'drug_strength',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'cohort_definition',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'attribute_definition',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'cdm_source',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'metadata',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'person',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'observation_period',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'specimen',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'death',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'visit_occurrence',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'visit_detail',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'procedure_occurrence',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'drug_exposure',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'device_exposure',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'condition_occurrence',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'measurement',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'note',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'note_nlp',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'observation',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'fact_relationship',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'location',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'care_site',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'provider',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'payer_plan_period',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'cost',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'cohort',
@role_name = NULL; /* Control access to change data. */

EXEC sys.sp_cdc_enable_table 
@source_schema = N'dbo',
@source_name = N'cohort_attribute',
@role_name = NULL; /* Control access to change data. */

/* View Capture Table for Specific Table 
SELECT * FROM cdc.dbo_drug_era_CT
SELECT * FROM cdc.dbo_dose_era_CT
SELECT * FROM cdc.dbo_condition_era_CT
SELECT * FROM cdc.dbo_concept_CT
SELECT * FROM cdc.dbo_vocabulary_CT
SELECT * FROM cdc.dbo_domain_CT
SELECT * FROM cdc.dbo_concept_class_CT
SELECT * FROM cdc.dbo_concept_relationship_CT
SELECT * FROM cdc.dbo_relationship_CT
SELECT * FROM cdc.dbo_concept_synonym_CT
SELECT * FROM cdc.dbo_concept_ancestor_CT
SELECT * FROM cdc.dbo_source_to_concept_map_CT
SELECT * FROM cdc.dbo_drug_strength_CT
SELECT * FROM cdc.dbo_cohort_definition_CT
SELECT * FROM cdc.dbo_attribute_definition_CT
SELECT * FROM cdc.dbo_cdm_source_CT
SELECT * FROM cdc.dbo_metadata_CT
SELECT * FROM cdc.dbo_person_CT
SELECT * FROM cdc.dbo_observation_period_CT
SELECT * FROM cdc.dbo_specimen_CT
SELECT * FROM cdc.dbo_death_CT
SELECT * FROM cdc.dbo_visit_occurrence_CT
SELECT * FROM cdc.dbo_visit_detail_CT
SELECT * FROM cdc.dbo_procedure_occurrence_CT
SELECT * FROM cdc.dbo_drug_exposure_CT
SELECT * FROM cdc.dbo_device_exposure_CT
SELECT * FROM cdc.dbo_condition_occurrence_CT
SELECT * FROM cdc.dbo_measurement_CT
SELECT * FROM cdc.dbo_note_CT
SELECT * FROM cdc.dbo_note_nlp_CT
SELECT * FROM cdc.dbo_observation_CT
SELECT * FROM cdc.dbo_fact_relationship_CT
SELECT * FROM cdc.dbo_location_CT
SELECT * FROM cdc.dbo_care_site_CT
SELECT * FROM cdc.dbo_provider_CT
SELECT * FROM cdc.dbo_payer_plan_period_CT
SELECT * FROM cdc.dbo_cost_CT
SELECT * FROM cdc.dbo_cohort_CT
SELECT * FROM cdc.dbo_cohort_attribute_CT
*/

/* Manually triggers scans 
EXEC sys.sp_cdc_scan 
*/

