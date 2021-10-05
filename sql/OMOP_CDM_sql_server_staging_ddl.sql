/**************************

Standardized meta-data

***************************/

SELECT TOP 0 * INTO dbo.staging_cdm_source FROM dbo.cdm_source;

/************************

Standardized clinical data

************************/

SELECT TOP 0 * INTO dbo.staging_condition_occurrence FROM dbo.condition_occurrence;

SELECT TOP 0 * INTO dbo.staging_death FROM dbo.death;

SELECT TOP 0 * INTO dbo.staging_device_exposure FROM dbo.device_exposure;

SELECT TOP 0 * INTO dbo.staging_drug_exposure FROM dbo.drug_exposure;

SELECT TOP 0 * INTO dbo.staging_measurement FROM dbo.measurement;

SELECT TOP 0 * INTO dbo.staging_observation_period FROM dbo.observation_period;

SELECT TOP 0 * INTO dbo.staging_observation FROM dbo.observation;

SELECT TOP 0 * INTO dbo.staging_person FROM dbo.person;

SELECT TOP 0 * INTO dbo.staging_procedure_occurrence FROM dbo.procedure_occurrence;

SELECT TOP 0 * INTO dbo.staging_visit_occurrence FROM dbo.visit_occurrence;

/************************

Standardized health system data

************************/

SELECT TOP 0 * INTO dbo.staging_care_site FROM dbo.care_site;

SELECT TOP 0 * INTO dbo.staging_location FROM dbo.location;

SELECT TOP 0 * INTO dbo.staging_provider FROM dbo.provider;

/************************

Standardized health economics

************************/

SELECT TOP 0 * INTO dbo.staging_cost FROM dbo.cost;

SELECT TOP 0 * INTO dbo.staging_payer_plan_period FROM dbo.payer_plan_period;

/************************

Standardized derived elements

************************/

SELECT TOP 0 * INTO dbo.staging_condition_era FROM dbo.condition_era;

SELECT TOP 0 * INTO dbo.staging_drug_era FROM dbo.drug_era;


/************************

Helper Table to move data from staging tables to permanent tables

************************/
CREATE TABLE watermark_copy_staging_tables (table_name VARCHAR(MAX))
