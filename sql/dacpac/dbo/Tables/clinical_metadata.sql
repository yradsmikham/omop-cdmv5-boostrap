CREATE TABLE [dbo].[clinical_metadata] (
    [timestamp]        VARCHAR (50)  NOT NULL,
    [file_name]        VARCHAR (50)  NOT NULL,
    [file_location]    VARCHAR (50)  NOT NULL,
    [pipeline_name]    VARCHAR (50)  NOT NULL,
    [pipeline_run_id]  VARCHAR (50)  NOT NULL,
    [watermark_table]  VARCHAR (255) NULL,
    [source_rows_read] INT           NOT NULL,
    [sink_rows_copied] INT           NOT NULL
);


GO

