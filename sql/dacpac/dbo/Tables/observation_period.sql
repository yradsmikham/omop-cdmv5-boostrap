CREATE TABLE [dbo].[observation_period] (
    [observation_period_id]         INT  NOT NULL,
    [person_id]                     INT  NOT NULL,
    [observation_period_start_date] DATE NOT NULL,
    [observation_period_end_date]   DATE NOT NULL,
    [period_type_concept_id]        INT  NOT NULL,
    CONSTRAINT [xpk_observation_period] PRIMARY KEY NONCLUSTERED ([observation_period_id] ASC)
);


GO

CREATE CLUSTERED INDEX [idx_observation_period_id]
    ON [dbo].[observation_period]([person_id] ASC);


GO
