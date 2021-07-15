# OMOP CDM v5 Bootstrap

This will help you get a simple OMOP CDM v5 up and running using Azure SQL Server. The Terraform files will automate the creation of necessary resources (i.e. SQL Server, SQL database) and also execute OHDSI OMOP CDM v5 vocabulary and data import to get you started.

## Prerequisites

1. Install `sqlcmd`:
    - If on Mac:
    ```
    brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
    brew update
    brew install mssql-tools
    ```
    You can also visit [here](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver15#macos)
    - If on Windows, visit [here](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15)
2. Install `bcp`. If you followed the instructions from Step 1, you may skip this step.
3. Clone this repository.
4. Download the CMD Vocabulary and move them into the `vocab/` directory of this repo. You can do this by visiting [Athena](https://athena.ohdsi.org/)
5. If you would like to install the OMOP CDM with sample data from SynPuf, then unzip the `/synpuf_data/synpuf1k_omop_cdm_5.x.x.zip` and make sure the `synpuf_data_import.sh` in the `scripts/` directory is pointing to the unzipped version.

## Run Terraform

1. `terraform init`
2. `terraform plan`
    - Provide a password for SQL Server `omop_admin`. (Must contain uppercase, lowercase, and special character.)
    - Provide a prefix name. For example "yvonne". (**Note**: this is not the same as environment name (i.e. `dev`)).
3. `terraform apply`
    - Provide similar input for `terraform plan`.
    The execution of `terraform apply` can take about 30-40 minutes.

## Troubleshooting

### Error: Error running command '../scripts/synpuf_data_import.sh test-dev-omop-sql-server.database.windows.net test-dev-omop-db omop_admin omop_password': exit status 126. Output: /bin/sh: ../scripts/synpuf_data_import.sh: Permission denied

This could mean that the script has restricted access. You can change permissions by running:

```
chmod +x /scripts/synpuf_data_import.sh
```

You may be required to change permissions for the file `vocab_import.sh` as well.

### Error: Msg 40544, Level 17, State 12, Line 1 The database 'test-dev-omop-db' has reached its size quota. Partition or delete data, drop indexes, or consult the documentation for possible resolutions.

This message is in regards to the `omop_db_size`. If you are having problems with performing SQL queries, you may need to increase the SQL database maximum storage size.

## Footnotes

- [ ] Package Tomcat Server, WebAPI, Atlas, R, and Achilles
- [ ] Implementation in Azure DevOps pipelines
- [ ] ETL
