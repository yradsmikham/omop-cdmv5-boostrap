CREATE TABLE [dbo].[staging_concept_synonym] (
    [concept_id]           INT            NOT NULL,
    [concept_synonym_name] VARCHAR (1000) NOT NULL,
    [language_concept_id]  INT            NOT NULL,
);
