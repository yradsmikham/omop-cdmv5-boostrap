CREATE PROCEDURE remove_indexes_constraints
AS
BEGIN
        DECLARE @log_date AS NVARCHAR(50);
        DECLARE @log_message NVARCHAR(512);

        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' remove_indexes_constraints is starting execution'
        RAISERROR (@log_message, 0, 1) WITH NOWAIT
        -- add foreign key constraints

        /*********************************************************************************
        # Copyright 2014 Observational Health Data Sciences and Informatics
        #
        #
        # Licensed under the Apache License, Version 2.0 (the "License")
        # you may not use this file except in compliance with the License.
        # You may obtain a copy of the License at
        #
        #     http://www.apache.org/licenses/LICENSE-2.0
        #
        # Unless required by applicable law or agreed to in writing, software
        # distributed under the License is distributed on an "AS IS" BASIS,
        # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        # See the License for the specific language governing permissions and
        # limitations under the License.
        ********************************************************************************/

        /************************
        ####### #     # ####### ######      #####  ######  #     #           #######      #####      #####
        #     # ##   ## #     # #     #    #     # #     # ##   ##    #    # #           #     #    #     #  ####  #    #  ####  ##### #####    ##   # #    # #####  ####
        #     # # # # # #     # #     #    #       #     # # # # #    #    # #                 #    #       #    # ##   # #        #   #    #  #  #  # ##   #   #   #
        #     # #  #  # #     # ######     #       #     # #  #  #    #    # ######       #####     #       #    # # #  #  ####    #   #    # #    # # # #  #   #    ####
        #     # #     # #     # #          #       #     # #     #    #    #       # ###       #    #       #    # #  # #      #   #   #####  ###### # #  # #   #        #
        #     # #     # #     # #          #     # #     # #     #     #  #  #     # ### #     #    #     # #    # #   ## #    #   #   #   #  #    # # #   ##   #   #    #
        ####### #     # ####### #           #####  ######  #     #      ##    #####  ###  #####      #####   ####  #    #  ####    #   #    # #    # # #    #   #    ####
        sql server script to create foreign key constraints within OMOP common data model, version 5.3.0
        last revised: 14-June-2018
        author:  Patrick Ryan, Clair Blacketer
        *************************/


        /************************
        *************************
        *************************
        *************************
        Foreign key constraints
        *************************
        *************************
        *************************
        ************************/


        /************************
        Standardized vocabulary
        ************************/


        ALTER TABLE concept DROP CONSTRAINT fpk_concept_domain;

        ALTER TABLE concept DROP CONSTRAINT fpk_concept_class;

        ALTER TABLE concept DROP CONSTRAINT fpk_concept_vocabulary;

        ALTER TABLE vocabulary DROP CONSTRAINT fpk_vocabulary_concept;

        ALTER TABLE domain DROP CONSTRAINT fpk_domain_concept;

        ALTER TABLE concept_class DROP CONSTRAINT fpk_concept_class_concept;

        ALTER TABLE concept_relationship DROP CONSTRAINT fpk_concept_relationship_c_1;

        ALTER TABLE concept_relationship DROP CONSTRAINT fpk_concept_relationship_c_2;

        ALTER TABLE concept_relationship DROP CONSTRAINT fpk_concept_relationship_id;

        ALTER TABLE relationship DROP CONSTRAINT fpk_relationship_concept;

        ALTER TABLE relationship DROP CONSTRAINT fpk_relationship_reverse;

        ALTER TABLE concept_synonym DROP CONSTRAINT fpk_concept_synonym_concept;

        ALTER TABLE concept_synonym DROP CONSTRAINT fpk_concept_synonym_language;

        ALTER TABLE concept_ancestor DROP CONSTRAINT fpk_concept_ancestor_concept_1;

        ALTER TABLE concept_ancestor DROP CONSTRAINT fpk_concept_ancestor_concept_2;

        ALTER TABLE source_to_concept_map DROP CONSTRAINT fpk_source_to_concept_map_v_1;

        ALTER TABLE source_to_concept_map DROP CONSTRAINT fpk_source_concept_id;

        ALTER TABLE source_to_concept_map DROP CONSTRAINT fpk_source_to_concept_map_v_2;

        ALTER TABLE source_to_concept_map DROP CONSTRAINT fpk_source_to_concept_map_c_1;

        ALTER TABLE drug_strength DROP CONSTRAINT fpk_drug_strength_concept_1;

        ALTER TABLE drug_strength DROP CONSTRAINT fpk_drug_strength_concept_2;

        ALTER TABLE drug_strength DROP CONSTRAINT fpk_drug_strength_unit_1;

        ALTER TABLE drug_strength DROP CONSTRAINT fpk_drug_strength_unit_2;

        ALTER TABLE drug_strength DROP CONSTRAINT fpk_drug_strength_unit_3;

        ALTER TABLE cohort_definition DROP CONSTRAINT fpk_cohort_definition_concept;

        ALTER TABLE cohort_definition DROP CONSTRAINT fpk_cohort_subject_concept;

        ALTER TABLE attribute_definition DROP CONSTRAINT fpk_attribute_type_concept;


        /**************************
        Standardized meta-data
        ***************************/





        /************************
        Standardized clinical data
        ************************/

        ALTER TABLE person DROP CONSTRAINT fpk_person_care_site;

        ALTER TABLE person DROP CONSTRAINT fpk_person_ethnicity_concept;

        ALTER TABLE person DROP CONSTRAINT fpk_person_ethnicity_concept_s;

        ALTER TABLE person DROP CONSTRAINT fpk_person_gender_concept;

        ALTER TABLE person DROP CONSTRAINT fpk_person_gender_concept_s;

        ALTER TABLE person DROP CONSTRAINT fpk_person_location;

        ALTER TABLE person DROP CONSTRAINT fpk_person_provider;

        ALTER TABLE person DROP CONSTRAINT fpk_person_race_concept;

        ALTER TABLE person DROP CONSTRAINT fpk_person_race_concept_s;




        ALTER TABLE observation_period DROP CONSTRAINT fpk_observation_period_concept;

        ALTER TABLE observation_period DROP CONSTRAINT fpk_observation_period_person;

        ALTER TABLE specimen DROP CONSTRAINT fpk_specimen_person;

        ALTER TABLE specimen DROP CONSTRAINT fpk_specimen_concept;

        ALTER TABLE specimen DROP CONSTRAINT fpk_specimen_type_concept;

        ALTER TABLE specimen DROP CONSTRAINT fpk_specimen_unit_concept;

        ALTER TABLE specimen DROP CONSTRAINT fpk_specimen_site_concept;

        ALTER TABLE specimen DROP CONSTRAINT fpk_specimen_status_concept;

        ALTER TABLE death DROP CONSTRAINT fpk_death_cause_concept;

        ALTER TABLE death DROP CONSTRAINT fpk_death_cause_concept_s;

        ALTER TABLE death DROP CONSTRAINT fpk_death_person;

        ALTER TABLE death DROP CONSTRAINT fpk_death_type_concept;


        ALTER TABLE visit_occurrence DROP CONSTRAINT fpk_visit_admitting_s;

        ALTER TABLE visit_occurrence DROP CONSTRAINT fpk_visit_care_site;

        ALTER TABLE visit_occurrence DROP CONSTRAINT fpk_visit_concept_s;

        ALTER TABLE visit_occurrence DROP CONSTRAINT fpk_visit_discharge;

        ALTER TABLE visit_occurrence DROP CONSTRAINT fpk_visit_person;
 
        ALTER TABLE visit_occurrence DROP CONSTRAINT fpk_visit_preceding;

        ALTER TABLE visit_occurrence DROP CONSTRAINT fpk_visit_provider;

        ALTER TABLE visit_occurrence DROP CONSTRAINT fpk_visit_type_concept;


        ALTER TABLE visit_detail DROP CONSTRAINT fpd_v_detail_visit;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_admitting_s;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_care_site;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_concept_s;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_discharge;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_parent;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_person;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_preceding;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_provider;

        ALTER TABLE visit_detail DROP CONSTRAINT fpk_v_detail_type_concept;


        ALTER TABLE procedure_occurrence DROP CONSTRAINT fpk_procedure_concept;

        ALTER TABLE procedure_occurrence DROP CONSTRAINT fpk_procedure_concept_s;

        ALTER TABLE procedure_occurrence DROP CONSTRAINT fpk_procedure_modifier;

        ALTER TABLE procedure_occurrence DROP CONSTRAINT fpk_procedure_person;
 
        ALTER TABLE procedure_occurrence DROP CONSTRAINT fpk_procedure_provider;

        ALTER TABLE procedure_occurrence DROP CONSTRAINT fpk_procedure_type_concept;

        ALTER TABLE procedure_occurrence DROP CONSTRAINT fpk_procedure_visit;




        ALTER TABLE drug_exposure DROP CONSTRAINT fpk_drug_concept;

        ALTER TABLE drug_exposure DROP CONSTRAINT fpk_drug_concept_s;

        ALTER TABLE drug_exposure DROP CONSTRAINT fpk_drug_person;

        ALTER TABLE drug_exposure DROP CONSTRAINT fpk_drug_provider;

        ALTER TABLE drug_exposure DROP CONSTRAINT fpk_drug_route_concept;

        ALTER TABLE drug_exposure DROP CONSTRAINT fpk_drug_type_concept;

        ALTER TABLE drug_exposure DROP CONSTRAINT fpk_drug_visit;




        ALTER TABLE device_exposure DROP CONSTRAINT fpk_device_concept;

        ALTER TABLE device_exposure DROP CONSTRAINT fpk_device_concept_s;

        ALTER TABLE device_exposure DROP CONSTRAINT fpk_device_person;

        ALTER TABLE device_exposure DROP CONSTRAINT fpk_device_provider;

        ALTER TABLE device_exposure DROP CONSTRAINT fpk_device_type_concept;

        ALTER TABLE device_exposure DROP CONSTRAINT fpk_device_visit;




        ALTER TABLE condition_occurrence DROP CONSTRAINT fpk_condition_person;

        ALTER TABLE condition_occurrence DROP CONSTRAINT fpk_condition_concept;

        ALTER TABLE condition_occurrence DROP CONSTRAINT fpk_condition_concept_s;

        ALTER TABLE condition_occurrence DROP CONSTRAINT fpk_condition_type_concept;

        ALTER TABLE condition_occurrence DROP CONSTRAINT fpk_condition_provider;

        ALTER TABLE condition_occurrence DROP CONSTRAINT fpk_condition_visit;


        ALTER TABLE condition_occurrence DROP CONSTRAINT fpk_condition_status_concept;



        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_concept;

        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_concept_s;

        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_operator;

        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_person;

        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_provider;

        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_type_concept;

        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_unit;

        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_value;

        ALTER TABLE measurement DROP CONSTRAINT fpk_measurement_visit;

        ALTER TABLE note DROP CONSTRAINT fpk_note_person;

        ALTER TABLE note DROP CONSTRAINT fpk_note_type_concept;

        ALTER TABLE note DROP CONSTRAINT fpk_note_class_concept;

        ALTER TABLE note DROP CONSTRAINT fpk_note_encoding_concept;

        ALTER TABLE note DROP CONSTRAINT fpk_language_concept;

        ALTER TABLE note DROP CONSTRAINT fpk_note_provider;

        ALTER TABLE note DROP CONSTRAINT fpk_note_visit;


        ALTER TABLE note_nlp DROP CONSTRAINT fpk_note_nlp_note;

        ALTER TABLE note_nlp DROP CONSTRAINT fpk_note_nlp_section_concept;

        ALTER TABLE note_nlp DROP CONSTRAINT fpk_note_nlp_concept;




        ALTER TABLE observation DROP CONSTRAINT fpk_observation_concept;

        ALTER TABLE observation DROP CONSTRAINT fpk_observation_concept_s;

        ALTER TABLE observation DROP CONSTRAINT fpk_observation_person;

        ALTER TABLE observation DROP CONSTRAINT fpk_observation_provider;

        ALTER TABLE observation DROP CONSTRAINT fpk_observation_qualifier;

        ALTER TABLE observation DROP CONSTRAINT fpk_observation_type_concept;

        ALTER TABLE observation DROP CONSTRAINT fpk_observation_unit;

        ALTER TABLE observation DROP CONSTRAINT fpk_observation_value;

        ALTER TABLE observation DROP CONSTRAINT fpk_observation_visit;



        ALTER TABLE fact_relationship DROP CONSTRAINT fpk_fact_domain_1;

        ALTER TABLE fact_relationship DROP CONSTRAINT fpk_fact_domain_2;

        ALTER TABLE fact_relationship DROP CONSTRAINT fpk_fact_relationship;



        /************************
        Standardized health system data
        ************************/

        ALTER TABLE care_site DROP CONSTRAINT fpk_care_site_location;

        ALTER TABLE care_site DROP CONSTRAINT fpk_care_site_place;



        ALTER TABLE provider DROP CONSTRAINT fpk_provider_care_site;

        ALTER TABLE provider DROP CONSTRAINT fpk_provider_gender;

        ALTER TABLE provider DROP CONSTRAINT fpk_provider_gender_s;

        ALTER TABLE provider DROP CONSTRAINT fpk_provider_specialty;

        ALTER TABLE provider DROP CONSTRAINT fpk_provider_specialty_s;





        /************************
        Standardized health economics
        ************************/

        ALTER TABLE payer_plan_period DROP CONSTRAINT fpk_payer_plan_period;

        ALTER TABLE cost DROP CONSTRAINT fpk_visit_cost_currency;

        ALTER TABLE cost DROP CONSTRAINT fpk_visit_cost_period;

        ALTER TABLE cost DROP CONSTRAINT fpk_drg_concept;

        /************************
        Standardized derived elements
        ************************/


        ALTER TABLE cohort_attribute DROP CONSTRAINT fpk_ca_cohort_definition;

        ALTER TABLE cohort_attribute DROP CONSTRAINT fpk_ca_attribute_definition;

        ALTER TABLE cohort_attribute DROP CONSTRAINT fpk_ca_value;

        ALTER TABLE drug_era DROP CONSTRAINT fpk_drug_era_concept;

        ALTER TABLE drug_era DROP CONSTRAINT fpk_drug_era_person;



        ALTER TABLE dose_era DROP CONSTRAINT fpk_dose_era_person;

        ALTER TABLE dose_era DROP CONSTRAINT fpk_dose_era_concept;

        ALTER TABLE dose_era DROP CONSTRAINT fpk_dose_era_unit_concept;


        ALTER TABLE condition_era DROP CONSTRAINT fpk_condition_era_person;

        ALTER TABLE condition_era DROP CONSTRAINT fpk_condition_era_concept;

        /************************
        *************************
        *************************
        *************************
        Unique constraints
        *************************
        *************************
        *************************
        ************************/

        -- Taken out in 5.3.2 release https://github.com/OHDSI/CommonDataModel/releases/tag/v5.3.2
        -- ALTER TABLE concept_synonym DROP CONSTRAINT uq_concept_synonym;

        -- add indices and primary keys
        /*********************************************************************************
        # Copyright 2014 Observational Health Data Sciences and Informatics
        #
        #
        # Licensed under the Apache License, Version 2.0 (the "License");
        # you may not use this file except in compliance with the License.
        # You may obtain a copy of the License at
        #
        #     http://www.apache.org/licenses/LICENSE-2.0
        #
        # Unless required by applicable law or agreed to in writing, software
        # distributed under the License is distributed on an "AS IS" BASIS,
        # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        # See the License for the specific language governing permissions and
        # limitations under the License.
        ********************************************************************************/

        /************************
        ####### #     # ####### ######      #####  ######  #     #           #######      #####     ###
        #     # ##   ## #     # #     #    #     # #     # ##   ##    #    # #           #     #     #  #    # #####  ###### #    # ######  ####
        #     # # # # # #     # #     #    #       #     # # # # #    #    # #                 #     #  ##   # #    # #       #  #  #      #
        #     # #  #  # #     # ######     #       #     # #  #  #    #    # ######       #####      #  # #  # #    # #####    ##   #####   ####
        #     # #     # #     # #          #       #     # #     #    #    #       # ###       #     #  #  # # #    # #        ##   #           #
        #     # #     # #     # #          #     # #     # #     #     #  #  #     # ### #     #     #  #   ## #    # #       #  #  #      #    #
        ####### #     # ####### #           #####  ######  #     #      ##    #####  ###  #####     ### #    # #####  ###### #    # ######  ####
        sql server script to create the required indexes within OMOP common data model, version 5.3
        last revised: 14-November-2017
        author:  Patrick Ryan, Clair Blacketer
        description:  These primary keys and indices are considered a minimal requirement to ensure adequate performance of analyses.
        *************************/


        /************************
        *************************
        *************************
        *************************
        Primary key constraints
        *************************
        *************************
        *************************
        ************************/



        /************************
        Standardized vocabulary
        ************************/



        ALTER TABLE concept DROP CONSTRAINT xpk_concept;

        ALTER TABLE vocabulary DROP CONSTRAINT xpk_vocabulary;

        ALTER TABLE domain DROP CONSTRAINT xpk_domain;

        ALTER TABLE concept_class DROP CONSTRAINT xpk_concept_class;

        ALTER TABLE concept_relationship DROP CONSTRAINT xpk_concept_relationship;

        ALTER TABLE relationship DROP CONSTRAINT xpk_relationship;

        ALTER TABLE concept_ancestor DROP CONSTRAINT xpk_concept_ancestor;

        ALTER TABLE source_to_concept_map DROP CONSTRAINT xpk_source_to_concept_map;

        ALTER TABLE drug_strength DROP CONSTRAINT xpk_drug_strength;

        ALTER TABLE cohort_definition DROP CONSTRAINT xpk_cohort_definition;

        ALTER TABLE attribute_definition DROP CONSTRAINT xpk_attribute_definition;


        /**************************
        Standardized meta-data
        ***************************/



        /************************
        Standardized clinical data
        ************************/


        /**PRIMARY KEY NONCLUSTERED constraints**/

        ALTER TABLE person DROP CONSTRAINT xpk_person;

        ALTER TABLE observation_period DROP CONSTRAINT xpk_observation_period;

        ALTER TABLE specimen DROP CONSTRAINT xpk_specimen;

        ALTER TABLE death DROP CONSTRAINT xpk_death;

        ALTER TABLE visit_occurrence DROP CONSTRAINT xpk_visit_occurrence;

        ALTER TABLE visit_detail DROP CONSTRAINT xpk_visit_detail;

        ALTER TABLE procedure_occurrence DROP CONSTRAINT xpk_procedure_occurrence;

        ALTER TABLE drug_exposure DROP CONSTRAINT xpk_drug_exposure;

        ALTER TABLE device_exposure DROP CONSTRAINT xpk_device_exposure;

        ALTER TABLE condition_occurrence DROP CONSTRAINT xpk_condition_occurrence;

        ALTER TABLE measurement DROP CONSTRAINT xpk_measurement;

        ALTER TABLE note DROP CONSTRAINT xpk_note;

        ALTER TABLE note_nlp DROP CONSTRAINT xpk_note_nlp;

        ALTER TABLE observation  DROP CONSTRAINT xpk_observation;




        /************************
        Standardized health system data
        ************************/


        ALTER TABLE location DROP CONSTRAINT xpk_location;

        ALTER TABLE care_site DROP CONSTRAINT xpk_care_site;

        ALTER TABLE provider DROP CONSTRAINT xpk_provider;



        /************************
        Standardized health economics
        ************************/


        ALTER TABLE payer_plan_period DROP CONSTRAINT xpk_payer_plan_period;

        ALTER TABLE cost DROP CONSTRAINT xpk_visit_cost;


        /************************
        Standardized derived elements
        ************************/

        ALTER TABLE cohort DROP CONSTRAINT xpk_cohort;

        ALTER TABLE cohort_attribute DROP CONSTRAINT xpk_cohort_attribute;

        ALTER TABLE drug_era DROP CONSTRAINT xpk_drug_era;

        ALTER TABLE dose_era  DROP CONSTRAINT xpk_dose_era;

        ALTER TABLE condition_era DROP CONSTRAINT xpk_condition_era;


        /************************
        *************************
        *************************
        *************************
        Indices
        *************************
        *************************
        *************************
        ************************/

        /************************
        Standardized vocabulary
        ************************/

        DROP INDEX idx_concept_concept_id ON concept;
        DROP INDEX  idx_concept_code ON concept;
        DROP INDEX  idx_concept_vocabluary_id ON concept;
        DROP INDEX  idx_concept_domain_id ON concept;
        DROP INDEX  idx_concept_class_id ON concept;

        DROP INDEX idx_vocabulary_vocabulary_id ON vocabulary;

        DROP INDEX idx_domain_domain_id ON domain;

        DROP INDEX idx_concept_class_class_id ON concept_class;

        DROP INDEX  idx_concept_relationship_id_1 ON concept_relationship;
        DROP INDEX  idx_concept_relationship_id_2 ON concept_relationship;
        DROP INDEX  idx_concept_relationship_id_3 ON concept_relationship;

        DROP INDEX idx_relationship_rel_id ON relationship;

        DROP INDEX  idx_concept_synonym_id ON concept_synonym;

        DROP INDEX  idx_concept_ancestor_id_1 ON concept_ancestor;
        DROP INDEX  idx_concept_ancestor_id_2 ON concept_ancestor;

        DROP INDEX  idx_source_to_concept_map_id_3 ON source_to_concept_map;
        DROP INDEX  idx_source_to_concept_map_id_1 ON source_to_concept_map;
        DROP INDEX  idx_source_to_concept_map_id_2 ON source_to_concept_map;
        DROP INDEX  idx_source_to_concept_map_code ON source_to_concept_map;

        DROP INDEX  idx_drug_strength_id_1 ON drug_strength;
        DROP INDEX  idx_drug_strength_id_2 ON drug_strength;

        DROP INDEX  idx_cohort_definition_id ON cohort_definition;

        DROP INDEX  idx_attribute_definition_id ON attribute_definition;


        /**************************
        Standardized meta-data
        ***************************/





        /************************
        Standardized clinical data
        ************************/

        DROP INDEX idx_person_id ON person;

        DROP INDEX  idx_observation_period_id ON observation_period;

        DROP INDEX  idx_specimen_person_id ON specimen;
        DROP INDEX  idx_specimen_concept_id ON specimen;

        DROP INDEX  idx_death_person_id ON death;

        DROP INDEX  idx_visit_person_id ON visit_occurrence;
        DROP INDEX  idx_visit_concept_id ON visit_occurrence;

        DROP INDEX  idx_visit_detail_person_id ON visit_detail;
        DROP INDEX  idx_visit_detail_concept_id ON visit_detail;

        DROP INDEX  idx_procedure_person_id ON procedure_occurrence;
        DROP INDEX  idx_procedure_concept_id ON procedure_occurrence;
        DROP INDEX  idx_procedure_visit_id ON procedure_occurrence;

        DROP INDEX  idx_drug_person_id ON drug_exposure;
        DROP INDEX  idx_drug_concept_id ON drug_exposure;
        DROP INDEX  idx_drug_visit_id ON drug_exposure;

        DROP INDEX  idx_device_person_id ON device_exposure;
        DROP INDEX  idx_device_concept_id ON device_exposure;
        DROP INDEX  idx_device_visit_id ON device_exposure;

        DROP INDEX  idx_condition_person_id ON condition_occurrence;
        DROP INDEX  idx_condition_concept_id ON condition_occurrence;
        DROP INDEX  idx_condition_visit_id ON condition_occurrence;

        DROP INDEX  idx_measurement_person_id ON measurement;
        DROP INDEX  idx_measurement_concept_id ON measurement;
        DROP INDEX  idx_measurement_visit_id ON measurement;

        DROP INDEX  idx_note_person_id ON note;
        DROP INDEX  idx_note_concept_id ON note;
        DROP INDEX  idx_note_visit_id ON note;

        DROP INDEX  idx_note_nlp_note_id ON note_nlp;
        DROP INDEX  idx_note_nlp_concept_id ON note_nlp;

        DROP INDEX  idx_observation_person_id ON observation;
        DROP INDEX  idx_observation_concept_id ON observation;
        DROP INDEX  idx_observation_visit_id ON observation;

        DROP INDEX  idx_fact_relationship_id_1 ON fact_relationship;
        DROP INDEX  idx_fact_relationship_id_2 ON fact_relationship;
        DROP INDEX  idx_fact_relationship_id_3 ON fact_relationship;



        /************************
        Standardized health system data
        ************************/





        /************************
        Standardized health economics
        ************************/

        DROP INDEX  idx_period_person_id ON payer_plan_period;





        /************************
        Standardized derived elements
        ************************/


        DROP INDEX  idx_cohort_subject_id ON cohort;
        DROP INDEX  idx_cohort_c_definition_id ON cohort;

        DROP INDEX  idx_ca_subject_id ON cohort_attribute;
        DROP INDEX  idx_ca_definition_id ON cohort_attribute;

        DROP INDEX  idx_drug_era_person_id ON drug_era;
        DROP INDEX  idx_drug_era_concept_id ON drug_era;

        DROP INDEX  idx_dose_era_person_id ON dose_era;
        DROP INDEX  idx_dose_era_concept_id ON dose_era;

        DROP INDEX  idx_condition_era_person_id ON condition_era;
        DROP INDEX  idx_condition_era_concept_id ON condition_era;

        SET @log_date = CONVERT(NVARCHAR(50),GETDATE(),121);
        SET @log_message = @log_date + ' remove_indexes_constraints is ending execution'
        RAISERROR (@log_message, 0, 1) WITH NOWAIT
END

GO

