CREATE TABLE [dbo].[payer_plan_period] (
    [payer_plan_period_id]         INT          NOT NULL,
    [person_id]                    INT          NOT NULL,
    [payer_plan_period_start_date] DATE         NOT NULL,
    [payer_plan_period_end_date]   DATE         NOT NULL,
    [payer_source_value]           VARCHAR (50) NULL,
    [plan_source_value]            VARCHAR (50) NULL,
    [family_source_value]          VARCHAR (50) NULL,
    CONSTRAINT [xpk_payer_plan_period] PRIMARY KEY NONCLUSTERED ([payer_plan_period_id] ASC)
);


GO

CREATE CLUSTERED INDEX [idx_period_person_id]
    ON [dbo].[payer_plan_period]([person_id] ASC);


GO

