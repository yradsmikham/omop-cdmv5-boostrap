CREATE PROCEDURE add_indexes_constraints
AS
BEGIN
       
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



    ALTER TABLE concept ADD CONSTRAINT xpk_concept PRIMARY KEY NONCLUSTERED (concept_id);

    ALTER TABLE vocabulary ADD CONSTRAINT xpk_vocabulary PRIMARY KEY NONCLUSTERED (vocabulary_id);

    ALTER TABLE domain ADD CONSTRAINT xpk_domain PRIMARY KEY NONCLUSTERED (domain_id);

    ALTER TABLE concept_class ADD CONSTRAINT xpk_concept_class PRIMARY KEY NONCLUSTERED (concept_class_id);

    ALTER TABLE concept_relationship ADD CONSTRAINT xpk_concept_relationship PRIMARY KEY NONCLUSTERED (concept_id_1,concept_id_2,relationship_id);

    ALTER TABLE relationship ADD CONSTRAINT xpk_relationship PRIMARY KEY NONCLUSTERED (relationship_id);

    ALTER TABLE concept_ancestor ADD CONSTRAINT xpk_concept_ancestor PRIMARY KEY NONCLUSTERED (ancestor_concept_id,descendant_concept_id);

    ALTER TABLE source_to_concept_map ADD CONSTRAINT xpk_source_to_concept_map PRIMARY KEY NONCLUSTERED (source_vocabulary_id,target_concept_id,source_code,valid_end_date);

    ALTER TABLE drug_strength ADD CONSTRAINT xpk_drug_strength PRIMARY KEY NONCLUSTERED (drug_concept_id, ingredient_concept_id);

    ALTER TABLE cohort_definition ADD CONSTRAINT xpk_cohort_definition PRIMARY KEY NONCLUSTERED (cohort_definition_id);

    ALTER TABLE attribute_definition ADD CONSTRAINT xpk_attribute_definition PRIMARY KEY NONCLUSTERED (attribute_definition_id);


    /**************************
    Standardized meta-data
    ***************************/



    /************************
    Standardized clinical data
    ************************/


    /**PRIMARY KEY NONCLUSTERED constraints**/

    ALTER TABLE person ADD CONSTRAINT xpk_person PRIMARY KEY NONCLUSTERED ( person_id ) ;

    ALTER TABLE observation_period ADD CONSTRAINT xpk_observation_period PRIMARY KEY NONCLUSTERED ( observation_period_id ) ;

    ALTER TABLE specimen ADD CONSTRAINT xpk_specimen PRIMARY KEY NONCLUSTERED ( specimen_id ) ;

    ALTER TABLE death ADD CONSTRAINT xpk_death PRIMARY KEY NONCLUSTERED ( person_id ) ;

    ALTER TABLE visit_occurrence ADD CONSTRAINT xpk_visit_occurrence PRIMARY KEY NONCLUSTERED ( visit_occurrence_id ) ;

    -- ALTER TABLE visit_detail ADD CONSTRAINT xpk_visit_detail PRIMARY KEY NONCLUSTERED ( visit_detail_id ) ;

    ALTER TABLE procedure_occurrence ADD CONSTRAINT xpk_procedure_occurrence PRIMARY KEY NONCLUSTERED ( procedure_occurrence_id ) ;

    ALTER TABLE drug_exposure ADD CONSTRAINT xpk_drug_exposure PRIMARY KEY NONCLUSTERED ( drug_exposure_id ) ;

    ALTER TABLE device_exposure ADD CONSTRAINT xpk_device_exposure PRIMARY KEY NONCLUSTERED ( device_exposure_id ) ;

    ALTER TABLE condition_occurrence ADD CONSTRAINT xpk_condition_occurrence PRIMARY KEY NONCLUSTERED ( condition_occurrence_id ) ;

    ALTER TABLE measurement ADD CONSTRAINT xpk_measurement PRIMARY KEY NONCLUSTERED ( measurement_id ) ;

    ALTER TABLE note ADD CONSTRAINT xpk_note PRIMARY KEY NONCLUSTERED ( note_id ) ;

    ALTER TABLE note_nlp ADD CONSTRAINT xpk_note_nlp PRIMARY KEY NONCLUSTERED ( note_nlp_id ) ;

    ALTER TABLE observation  ADD CONSTRAINT xpk_observation PRIMARY KEY NONCLUSTERED ( observation_id ) ;




    /************************
    Standardized health system data
    ************************/


    ALTER TABLE location ADD CONSTRAINT xpk_location PRIMARY KEY NONCLUSTERED ( location_id ) ;

    ALTER TABLE care_site ADD CONSTRAINT xpk_care_site PRIMARY KEY NONCLUSTERED ( care_site_id ) ;

    ALTER TABLE provider ADD CONSTRAINT xpk_provider PRIMARY KEY NONCLUSTERED ( provider_id ) ;



    /************************
    Standardized health economics
    ************************/


    ALTER TABLE payer_plan_period ADD CONSTRAINT xpk_payer_plan_period PRIMARY KEY NONCLUSTERED ( payer_plan_period_id ) ;

    ALTER TABLE cost ADD CONSTRAINT xpk_visit_cost PRIMARY KEY NONCLUSTERED ( cost_id ) ;


    /************************
    Standardized derived elements
    ************************/

    ALTER TABLE cohort ADD CONSTRAINT xpk_cohort PRIMARY KEY NONCLUSTERED ( cohort_definition_id, subject_id, cohort_start_date, cohort_end_date  ) ;

    ALTER TABLE cohort_attribute ADD CONSTRAINT xpk_cohort_attribute PRIMARY KEY NONCLUSTERED ( cohort_definition_id, subject_id, cohort_start_date, cohort_end_date, attribute_definition_id ) ;

    ALTER TABLE drug_era ADD CONSTRAINT xpk_drug_era PRIMARY KEY NONCLUSTERED ( drug_era_id ) ;

    ALTER TABLE dose_era  ADD CONSTRAINT xpk_dose_era PRIMARY KEY NONCLUSTERED ( dose_era_id ) ;

    ALTER TABLE condition_era ADD CONSTRAINT xpk_condition_era PRIMARY KEY NONCLUSTERED ( condition_era_id ) ;


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

    CREATE UNIQUE CLUSTERED INDEX idx_concept_concept_id ON concept (concept_id ASC);
    CREATE INDEX idx_concept_code ON concept (concept_code ASC);
    CREATE INDEX idx_concept_vocabluary_id ON concept (vocabulary_id ASC);
    CREATE INDEX idx_concept_domain_id ON concept (domain_id ASC);
    CREATE INDEX idx_concept_class_id ON concept (concept_class_id ASC);

    CREATE UNIQUE CLUSTERED INDEX idx_vocabulary_vocabulary_id ON vocabulary (vocabulary_id ASC);

    CREATE UNIQUE CLUSTERED INDEX idx_domain_domain_id ON domain (domain_id ASC);

    CREATE UNIQUE CLUSTERED INDEX idx_concept_class_class_id ON concept_class (concept_class_id ASC);

    CREATE INDEX idx_concept_relationship_id_1 ON concept_relationship (concept_id_1 ASC);
    CREATE INDEX idx_concept_relationship_id_2 ON concept_relationship (concept_id_2 ASC);
    CREATE INDEX idx_concept_relationship_id_3 ON concept_relationship (relationship_id ASC);

    CREATE UNIQUE CLUSTERED INDEX idx_relationship_rel_id ON relationship (relationship_id ASC);

    CREATE CLUSTERED INDEX idx_concept_synonym_id ON concept_synonym (concept_id ASC);

    CREATE CLUSTERED INDEX idx_concept_ancestor_id_1 ON concept_ancestor (ancestor_concept_id ASC);
    CREATE INDEX idx_concept_ancestor_id_2 ON concept_ancestor (descendant_concept_id ASC);

    CREATE CLUSTERED INDEX idx_source_to_concept_map_id_3 ON source_to_concept_map (target_concept_id ASC);
    CREATE INDEX idx_source_to_concept_map_id_1 ON source_to_concept_map (source_vocabulary_id ASC);
    CREATE INDEX idx_source_to_concept_map_id_2 ON source_to_concept_map (target_vocabulary_id ASC);
    CREATE INDEX idx_source_to_concept_map_code ON source_to_concept_map (source_code ASC);

    CREATE CLUSTERED INDEX idx_drug_strength_id_1 ON drug_strength (drug_concept_id ASC);
    CREATE INDEX idx_drug_strength_id_2 ON drug_strength (ingredient_concept_id ASC);

    CREATE CLUSTERED INDEX idx_cohort_definition_id ON cohort_definition (cohort_definition_id ASC);

    CREATE CLUSTERED INDEX idx_attribute_definition_id ON attribute_definition (attribute_definition_id ASC);


    /**************************
    Standardized meta-data
    ***************************/





    /************************
    Standardized clinical data
    ************************/

    CREATE UNIQUE CLUSTERED INDEX idx_person_id ON person (person_id ASC);

    CREATE CLUSTERED INDEX idx_observation_period_id ON observation_period (person_id ASC);

    CREATE CLUSTERED INDEX idx_specimen_person_id ON specimen (person_id ASC);
    CREATE INDEX idx_specimen_concept_id ON specimen (specimen_concept_id ASC);

    CREATE CLUSTERED INDEX idx_death_person_id ON death (person_id ASC);

    CREATE CLUSTERED INDEX idx_visit_person_id ON visit_occurrence (person_id ASC);
    CREATE INDEX idx_visit_concept_id ON visit_occurrence (visit_concept_id ASC);

    -- CREATE CLUSTERED INDEX idx_visit_detail_person_id ON visit_detail (person_id ASC);
    -- CREATE INDEX idx_visit_detail_concept_id ON visit_detail (visit_detail_concept_id ASC);

    CREATE CLUSTERED INDEX idx_procedure_person_id ON procedure_occurrence (person_id ASC);
    CREATE INDEX idx_procedure_concept_id ON procedure_occurrence (procedure_concept_id ASC);
    CREATE INDEX idx_procedure_visit_id ON procedure_occurrence (visit_occurrence_id ASC);

    CREATE CLUSTERED INDEX idx_drug_person_id ON drug_exposure (person_id ASC);
    CREATE INDEX idx_drug_concept_id ON drug_exposure (drug_concept_id ASC);
    CREATE INDEX idx_drug_visit_id ON drug_exposure (visit_occurrence_id ASC);

    CREATE CLUSTERED INDEX idx_device_person_id ON device_exposure (person_id ASC);
    CREATE INDEX idx_device_concept_id ON device_exposure (device_concept_id ASC);
    CREATE INDEX idx_device_visit_id ON device_exposure (visit_occurrence_id ASC);

    CREATE CLUSTERED INDEX idx_condition_person_id ON condition_occurrence (person_id ASC);
    CREATE INDEX idx_condition_concept_id ON condition_occurrence (condition_concept_id ASC);
    CREATE INDEX idx_condition_visit_id ON condition_occurrence (visit_occurrence_id ASC);

    CREATE CLUSTERED INDEX idx_measurement_person_id ON measurement (person_id ASC);
    CREATE INDEX idx_measurement_concept_id ON measurement (measurement_concept_id ASC);
    CREATE INDEX idx_measurement_visit_id ON measurement (visit_occurrence_id ASC);

    CREATE CLUSTERED INDEX idx_note_person_id ON note (person_id ASC);
    CREATE INDEX idx_note_concept_id ON note (note_type_concept_id ASC);
    CREATE INDEX idx_note_visit_id ON note (visit_occurrence_id ASC);

    CREATE CLUSTERED INDEX idx_note_nlp_note_id ON note_nlp (note_id ASC);
    CREATE INDEX idx_note_nlp_concept_id ON note_nlp (note_nlp_concept_id ASC);

    CREATE CLUSTERED INDEX idx_observation_person_id ON observation (person_id ASC);
    CREATE INDEX idx_observation_concept_id ON observation (observation_concept_id ASC);
    CREATE INDEX idx_observation_visit_id ON observation (visit_occurrence_id ASC);

    CREATE INDEX idx_fact_relationship_id_1 ON fact_relationship (domain_concept_id_1 ASC);
    CREATE INDEX idx_fact_relationship_id_2 ON fact_relationship (domain_concept_id_2 ASC);
    CREATE INDEX idx_fact_relationship_id_3 ON fact_relationship (relationship_concept_id ASC);



    /************************
    Standardized health system data
    ************************/





    /************************
    Standardized health economics
    ************************/

    CREATE CLUSTERED INDEX idx_period_person_id ON payer_plan_period (person_id ASC);





    /************************
    Standardized derived elements
    ************************/


    CREATE INDEX idx_cohort_subject_id ON cohort (subject_id ASC);
    CREATE INDEX idx_cohort_c_definition_id ON cohort (cohort_definition_id ASC);

    CREATE INDEX idx_ca_subject_id ON cohort_attribute (subject_id ASC);
    CREATE INDEX idx_ca_definition_id ON cohort_attribute (cohort_definition_id ASC);

    CREATE CLUSTERED INDEX idx_drug_era_person_id ON drug_era (person_id ASC);
    CREATE INDEX idx_drug_era_concept_id ON drug_era (drug_concept_id ASC);

    CREATE CLUSTERED INDEX idx_dose_era_person_id ON dose_era (person_id ASC);
    CREATE INDEX idx_dose_era_concept_id ON dose_era (drug_concept_id ASC);

    CREATE CLUSTERED INDEX idx_condition_era_person_id ON condition_era (person_id ASC);
    CREATE INDEX idx_condition_era_concept_id ON condition_era (condition_concept_id ASC);
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


    ALTER TABLE concept ADD CONSTRAINT fpk_concept_domain FOREIGN KEY (domain_id)  REFERENCES domain (domain_id);

    ALTER TABLE concept ADD CONSTRAINT fpk_concept_class FOREIGN KEY (concept_class_id)  REFERENCES concept_class (concept_class_id);

    ALTER TABLE concept ADD CONSTRAINT fpk_concept_vocabulary FOREIGN KEY (vocabulary_id)  REFERENCES vocabulary (vocabulary_id);

    ALTER TABLE vocabulary ADD CONSTRAINT fpk_vocabulary_concept FOREIGN KEY (vocabulary_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE domain ADD CONSTRAINT fpk_domain_concept FOREIGN KEY (domain_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE concept_class ADD CONSTRAINT fpk_concept_class_concept FOREIGN KEY (concept_class_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE concept_relationship ADD CONSTRAINT fpk_concept_relationship_c_1 FOREIGN KEY (concept_id_1)  REFERENCES concept (concept_id);

    ALTER TABLE concept_relationship ADD CONSTRAINT fpk_concept_relationship_c_2 FOREIGN KEY (concept_id_2)  REFERENCES concept (concept_id);

    ALTER TABLE concept_relationship ADD CONSTRAINT fpk_concept_relationship_id FOREIGN KEY (relationship_id)  REFERENCES relationship (relationship_id);

    ALTER TABLE relationship ADD CONSTRAINT fpk_relationship_concept FOREIGN KEY (relationship_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE relationship ADD CONSTRAINT fpk_relationship_reverse FOREIGN KEY (reverse_relationship_id)  REFERENCES relationship (relationship_id);

    ALTER TABLE concept_synonym ADD CONSTRAINT fpk_concept_synonym_concept FOREIGN KEY (concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE concept_synonym ADD CONSTRAINT fpk_concept_synonym_language FOREIGN KEY (language_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE concept_ancestor ADD CONSTRAINT fpk_concept_ancestor_concept_1 FOREIGN KEY (ancestor_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE concept_ancestor ADD CONSTRAINT fpk_concept_ancestor_concept_2 FOREIGN KEY (descendant_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_v_1 FOREIGN KEY (source_vocabulary_id)  REFERENCES vocabulary (vocabulary_id);

    ALTER TABLE source_to_concept_map ADD CONSTRAINT fpk_source_concept_id FOREIGN KEY (source_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_v_2 FOREIGN KEY (target_vocabulary_id)  REFERENCES vocabulary (vocabulary_id);

    ALTER TABLE source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_c_1 FOREIGN KEY (target_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE drug_strength ADD CONSTRAINT fpk_drug_strength_concept_1 FOREIGN KEY (drug_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE drug_strength ADD CONSTRAINT fpk_drug_strength_concept_2 FOREIGN KEY (ingredient_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE drug_strength ADD CONSTRAINT fpk_drug_strength_unit_1 FOREIGN KEY (amount_unit_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE drug_strength ADD CONSTRAINT fpk_drug_strength_unit_2 FOREIGN KEY (numerator_unit_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE drug_strength ADD CONSTRAINT fpk_drug_strength_unit_3 FOREIGN KEY (denominator_unit_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE cohort_definition ADD CONSTRAINT fpk_cohort_definition_concept FOREIGN KEY (definition_type_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE cohort_definition ADD CONSTRAINT fpk_cohort_subject_concept FOREIGN KEY (subject_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE attribute_definition ADD CONSTRAINT fpk_attribute_type_concept FOREIGN KEY (attribute_type_concept_id)  REFERENCES concept (concept_id);


    /**************************
    Standardized meta-data
    ***************************/





    /************************
    Standardized clinical data
    ************************/

    -- ALTER TABLE person ADD CONSTRAINT fpk_person_gender_concept FOREIGN KEY (gender_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE person ADD CONSTRAINT fpk_person_race_concept FOREIGN KEY (race_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE person ADD CONSTRAINT fpk_person_ethnicity_concept FOREIGN KEY (ethnicity_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE person ADD CONSTRAINT fpk_person_gender_concept_s FOREIGN KEY (gender_source_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE person ADD CONSTRAINT fpk_person_race_concept_s FOREIGN KEY (race_source_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE person ADD CONSTRAINT fpk_person_ethnicity_concept_s FOREIGN KEY (ethnicity_source_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE person ADD CONSTRAINT fpk_person_location FOREIGN KEY (location_id)  REFERENCES location (location_id);

    ALTER TABLE person ADD CONSTRAINT fpk_person_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    ALTER TABLE person ADD CONSTRAINT fpk_person_care_site FOREIGN KEY (care_site_id)  REFERENCES care_site (care_site_id);


    -- TODO: The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "fpk_observation_period_person". The conflict occurred in database "ss-sql", table "dbo.person", column 'person_id'.

    -- ALTER TABLE observation_period ADD CONSTRAINT fpk_observation_period_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE observation_period ADD CONSTRAINT fpk_observation_period_concept FOREIGN KEY (period_type_concept_id)  REFERENCES concept (concept_id);


    ALTER TABLE specimen ADD CONSTRAINT fpk_specimen_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    ALTER TABLE specimen ADD CONSTRAINT fpk_specimen_concept FOREIGN KEY (specimen_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE specimen ADD CONSTRAINT fpk_specimen_type_concept FOREIGN KEY (specimen_type_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE specimen ADD CONSTRAINT fpk_specimen_unit_concept FOREIGN KEY (unit_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE specimen ADD CONSTRAINT fpk_specimen_site_concept FOREIGN KEY (anatomic_site_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE specimen ADD CONSTRAINT fpk_specimen_status_concept FOREIGN KEY (disease_status_concept_id)  REFERENCES concept (concept_id);


    -- TODO: The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "fpk_death_person". The conflict occurred in database "ss-sql", table "dbo.person", column 'person_id'.
    -- ALTER TABLE death ADD CONSTRAINT fpk_death_person FOREIGN KEY (person_id)  REFERENCES person (person_id);
    -- TODO: The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "fpk_death_type_concept". The conflict occurred in database "ss-sql", table "dbo.concept", column 'concept_id'.
    -- ALTER TABLE death ADD CONSTRAINT fpk_death_type_concept FOREIGN KEY (death_type_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE death ADD CONSTRAINT fpk_death_cause_concept FOREIGN KEY (cause_concept_id)  REFERENCES concept (concept_id);
    -- TODO: The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "fpk_death_cause_concept_s". The conflict occurred in database "ss-sql", table "dbo.concept", column 'concept_id'.
    -- ALTER TABLE death ADD CONSTRAINT fpk_death_cause_concept_s FOREIGN KEY (cause_source_concept_id)  REFERENCES concept (concept_id);

    -- TODO: The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "fpk_visit_person". The conflict occurred in database "ss-sql", table "dbo.person", column 'person_id'.
    -- ALTER TABLE visit_occurrence ADD CONSTRAINT fpk_visit_person FOREIGN KEY (person_id)  REFERENCES person (person_id);
    -- ALTER TABLE visit_occurrence ADD CONSTRAINT fpk_visit_type_concept FOREIGN KEY (visit_type_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE visit_occurrence ADD CONSTRAINT fpk_visit_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);
    -- -- TODO
    -- ALTER TABLE visit_occurrence ADD CONSTRAINT fpk_visit_care_site FOREIGN KEY (care_site_id)  REFERENCES care_site (care_site_id);

    ALTER TABLE visit_occurrence ADD CONSTRAINT fpk_visit_concept_s FOREIGN KEY (visit_source_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE visit_occurrence ADD CONSTRAINT fpk_visit_admitting_s FOREIGN KEY (admitting_source_concept_id) REFERENCES concept (concept_id);

    -- ALTER TABLE visit_occurrence ADD CONSTRAINT fpk_visit_discharge FOREIGN KEY (discharge_to_concept_id) REFERENCES concept (concept_id);

    ALTER TABLE visit_occurrence ADD CONSTRAINT fpk_visit_preceding FOREIGN KEY (preceding_visit_occurrence_id) REFERENCES visit_occurrence (visit_occurrence_id);


    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_type_concept FOREIGN KEY (visit_detail_type_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_care_site FOREIGN KEY (care_site_id)  REFERENCES care_site (care_site_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_concept_s FOREIGN KEY (visit_detail_source_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_admitting_s FOREIGN KEY (admitting_source_concept_id) REFERENCES concept (concept_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_discharge FOREIGN KEY (discharge_to_concept_id) REFERENCES concept (concept_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_preceding FOREIGN KEY (preceding_visit_detail_id) REFERENCES visit_detail (visit_detail_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpk_v_detail_parent FOREIGN KEY (visit_detail_parent_id) REFERENCES visit_detail (visit_detail_id);

    -- ALTER TABLE visit_detail ADD CONSTRAINT fpd_v_detail_visit FOREIGN KEY (visit_occurrence_id) REFERENCES visit_occurrence (visit_occurrence_id);


    -- ALTER TABLE procedure_occurrence ADD CONSTRAINT fpk_procedure_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE procedure_occurrence ADD CONSTRAINT fpk_procedure_concept FOREIGN KEY (procedure_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE procedure_occurrence ADD CONSTRAINT fpk_procedure_type_concept FOREIGN KEY (procedure_type_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE procedure_occurrence ADD CONSTRAINT fpk_procedure_modifier FOREIGN KEY (modifier_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE procedure_occurrence ADD CONSTRAINT fpk_procedure_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    ALTER TABLE procedure_occurrence ADD CONSTRAINT fpk_procedure_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES visit_occurrence (visit_occurrence_id);

    -- ALTER TABLE procedure_occurrence ADD CONSTRAINT fpk_procedure_concept_s FOREIGN KEY (procedure_source_concept_id)  REFERENCES concept (concept_id);


    -- ALTER TABLE drug_exposure ADD CONSTRAINT fpk_drug_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE drug_exposure ADD CONSTRAINT fpk_drug_concept FOREIGN KEY (drug_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE drug_exposure ADD CONSTRAINT fpk_drug_type_concept FOREIGN KEY (drug_type_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE drug_exposure ADD CONSTRAINT fpk_drug_route_concept FOREIGN KEY (route_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE drug_exposure ADD CONSTRAINT fpk_drug_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    ALTER TABLE drug_exposure ADD CONSTRAINT fpk_drug_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES visit_occurrence (visit_occurrence_id);

    -- ALTER TABLE drug_exposure ADD CONSTRAINT fpk_drug_concept_s FOREIGN KEY (drug_source_concept_id)  REFERENCES concept (concept_id);


    -- ALTER TABLE device_exposure ADD CONSTRAINT fpk_device_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE device_exposure ADD CONSTRAINT fpk_device_concept FOREIGN KEY (device_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE device_exposure ADD CONSTRAINT fpk_device_type_concept FOREIGN KEY (device_type_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE device_exposure ADD CONSTRAINT fpk_device_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    ALTER TABLE device_exposure ADD CONSTRAINT fpk_device_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES visit_occurrence (visit_occurrence_id);

    -- ALTER TABLE device_exposure ADD CONSTRAINT fpk_device_concept_s FOREIGN KEY (device_source_concept_id)  REFERENCES concept (concept_id);


    -- ALTER TABLE condition_occurrence ADD CONSTRAINT fpk_condition_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE condition_occurrence ADD CONSTRAINT fpk_condition_concept FOREIGN KEY (condition_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE condition_occurrence ADD CONSTRAINT fpk_condition_type_concept FOREIGN KEY (condition_type_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE condition_occurrence ADD CONSTRAINT fpk_condition_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    ALTER TABLE condition_occurrence ADD CONSTRAINT fpk_condition_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES visit_occurrence (visit_occurrence_id);

    -- ALTER TABLE condition_occurrence ADD CONSTRAINT fpk_condition_concept_s FOREIGN KEY (condition_source_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE condition_occurrence ADD CONSTRAINT fpk_condition_status_concept FOREIGN KEY (condition_status_concept_id) REFERENCES concept (concept_id);


    -- ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_concept FOREIGN KEY (measurement_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_type_concept FOREIGN KEY (measurement_type_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_operator FOREIGN KEY (operator_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_value FOREIGN KEY (value_as_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_unit FOREIGN KEY (unit_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES visit_occurrence (visit_occurrence_id);

    -- ALTER TABLE measurement ADD CONSTRAINT fpk_measurement_concept_s FOREIGN KEY (measurement_source_concept_id)  REFERENCES concept (concept_id);


    ALTER TABLE note ADD CONSTRAINT fpk_note_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    ALTER TABLE note ADD CONSTRAINT fpk_note_type_concept FOREIGN KEY (note_type_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE note ADD CONSTRAINT fpk_note_class_concept FOREIGN KEY (note_class_concept_id) REFERENCES concept (concept_id);

    ALTER TABLE note ADD CONSTRAINT fpk_note_encoding_concept FOREIGN KEY (encoding_concept_id) REFERENCES concept (concept_id);

    ALTER TABLE note ADD CONSTRAINT fpk_language_concept FOREIGN KEY (language_concept_id) REFERENCES concept (concept_id);

    ALTER TABLE note ADD CONSTRAINT fpk_note_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    ALTER TABLE note ADD CONSTRAINT fpk_note_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES visit_occurrence (visit_occurrence_id);


    ALTER TABLE note_nlp ADD CONSTRAINT fpk_note_nlp_note FOREIGN KEY (note_id) REFERENCES note (note_id);

    ALTER TABLE note_nlp ADD CONSTRAINT fpk_note_nlp_section_concept FOREIGN KEY (section_concept_id) REFERENCES concept (concept_id);

    ALTER TABLE note_nlp ADD CONSTRAINT fpk_note_nlp_concept FOREIGN KEY (note_nlp_concept_id) REFERENCES concept (concept_id);



    -- ALTER TABLE observation ADD CONSTRAINT fpk_observation_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE observation ADD CONSTRAINT fpk_observation_concept FOREIGN KEY (observation_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE observation ADD CONSTRAINT fpk_observation_type_concept FOREIGN KEY (observation_type_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE observation ADD CONSTRAINT fpk_observation_value FOREIGN KEY (value_as_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE observation ADD CONSTRAINT fpk_observation_qualifier FOREIGN KEY (qualifier_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE observation ADD CONSTRAINT fpk_observation_unit FOREIGN KEY (unit_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE observation ADD CONSTRAINT fpk_observation_provider FOREIGN KEY (provider_id)  REFERENCES provider (provider_id);

    ALTER TABLE observation ADD CONSTRAINT fpk_observation_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES visit_occurrence (visit_occurrence_id);

    -- ALTER TABLE observation ADD CONSTRAINT fpk_observation_concept_s FOREIGN KEY (observation_source_concept_id)  REFERENCES concept (concept_id);


    ALTER TABLE fact_relationship ADD CONSTRAINT fpk_fact_domain_1 FOREIGN KEY (domain_concept_id_1)  REFERENCES concept (concept_id);

    ALTER TABLE fact_relationship ADD CONSTRAINT fpk_fact_domain_2 FOREIGN KEY (domain_concept_id_2)  REFERENCES concept (concept_id);

    ALTER TABLE fact_relationship ADD CONSTRAINT fpk_fact_relationship FOREIGN KEY (relationship_concept_id)  REFERENCES concept (concept_id);



    /************************
    Standardized health system data
    ************************/

    ALTER TABLE care_site ADD CONSTRAINT fpk_care_site_location FOREIGN KEY (location_id)  REFERENCES location (location_id);

    -- ALTER TABLE care_site ADD CONSTRAINT fpk_care_site_place FOREIGN KEY (place_of_service_concept_id)  REFERENCES concept (concept_id);


    -- ALTER TABLE provider ADD CONSTRAINT fpk_provider_specialty FOREIGN KEY (specialty_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE provider ADD CONSTRAINT fpk_provider_care_site FOREIGN KEY (care_site_id)  REFERENCES care_site (care_site_id);

    -- ALTER TABLE provider ADD CONSTRAINT fpk_provider_gender FOREIGN KEY (gender_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE provider ADD CONSTRAINT fpk_provider_specialty_s FOREIGN KEY (specialty_source_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE provider ADD CONSTRAINT fpk_provider_gender_s FOREIGN KEY (gender_source_concept_id)  REFERENCES concept (concept_id);




    /************************
    Standardized health economics
    ************************/

    -- ALTER TABLE payer_plan_period ADD CONSTRAINT fpk_payer_plan_period FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE cost ADD CONSTRAINT fpk_visit_cost_currency FOREIGN KEY (currency_concept_id)  REFERENCES concept (concept_id);

    -- ALTER TABLE cost ADD CONSTRAINT fpk_visit_cost_period FOREIGN KEY (payer_plan_period_id)  REFERENCES payer_plan_period (payer_plan_period_id);

    -- ALTER TABLE cost ADD CONSTRAINT fpk_drg_concept FOREIGN KEY (drg_concept_id) REFERENCES concept (concept_id);

    /************************
    Standardized derived elements
    ************************/


    --ALTER TABLE cohort ADD CONSTRAINT fpk_cohort_definition FOREIGN KEY (cohort_definition_id)  REFERENCES cohort_definition (cohort_definition_id);


    ALTER TABLE cohort_attribute ADD CONSTRAINT fpk_ca_cohort_definition FOREIGN KEY (cohort_definition_id)  REFERENCES cohort_definition (cohort_definition_id);

    ALTER TABLE cohort_attribute ADD CONSTRAINT fpk_ca_attribute_definition FOREIGN KEY (attribute_definition_id)  REFERENCES attribute_definition (attribute_definition_id);

    ALTER TABLE cohort_attribute ADD CONSTRAINT fpk_ca_value FOREIGN KEY (value_as_concept_id)  REFERENCES concept (concept_id);


    -- ALTER TABLE drug_era ADD CONSTRAINT fpk_drug_era_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE drug_era ADD CONSTRAINT fpk_drug_era_concept FOREIGN KEY (drug_concept_id)  REFERENCES concept (concept_id);


    ALTER TABLE dose_era ADD CONSTRAINT fpk_dose_era_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    ALTER TABLE dose_era ADD CONSTRAINT fpk_dose_era_concept FOREIGN KEY (drug_concept_id)  REFERENCES concept (concept_id);

    ALTER TABLE dose_era ADD CONSTRAINT fpk_dose_era_unit_concept FOREIGN KEY (unit_concept_id)  REFERENCES concept (concept_id);


    -- ALTER TABLE condition_era ADD CONSTRAINT fpk_condition_era_person FOREIGN KEY (person_id)  REFERENCES person (person_id);

    -- ALTER TABLE condition_era ADD CONSTRAINT fpk_condition_era_concept FOREIGN KEY (condition_concept_id)  REFERENCES concept (concept_id);


    /************************
    *************************
    *************************
    *************************
    Unique constraints
    *************************
    *************************
    *************************
    ************************/

    ALTER TABLE concept_synonym ADD CONSTRAINT uq_concept_synonym UNIQUE (concept_id, concept_synonym_name, language_concept_id);
END

GO

