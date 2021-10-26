CREATE TABLE [dbo].[condition_era] (
    [condition_era_id]           INT  NOT NULL,
    [person_id]                  INT  NOT NULL,
    [condition_concept_id]       INT  NOT NULL,
    [condition_era_start_date]   DATE NOT NULL,
    [condition_era_end_date]     DATE NOT NULL,
    [condition_occurrence_count] INT  NULL,
    CONSTRAINT [xpk_condition_era] PRIMARY KEY NONCLUSTERED ([condition_era_id] ASC)
);


GO

CREATE CLUSTERED INDEX [idx_condition_era_person_id]
    ON [dbo].[condition_era]([person_id] ASC);


GO

CREATE NONCLUSTERED INDEX [idx_condition_era_concept_id]
    ON [dbo].[condition_era]([condition_concept_id] ASC);


GO
