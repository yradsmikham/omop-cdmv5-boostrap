# OMOP CDM v5 Bootstrap

This will help you get a simple OMOP CDM v5 up and running using Azure SQL Server. The Terraform files will automate the creation of necessary resources (i.e. SQL Server, SQL database) and also execute OHDSI OMOP CDM v5 vocabulary and data import to get you started.

## Prerequisites:

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
5. [Optional] If you would like to install the OMOP CDM with sample data from SynPuf, then unzip the `/synpuf_data/synpuf1k_omop_cdm_5.x.x.zip` and make sure the `synpuf_data_import.sh` in the `scripts/` directory is pointing to the unzipped version.

## Run Terraform:

1. `terraform init`
2. `terraform plan`
    - Provide a password for SQL Server `omop_admin`. (Must contain uppercase, lowercase, and special character.)
    - Provide a prefix name. For example "yvonne". (**Note**: this is not the same as environment name (i.e. `dev`)).
3. `terraform plan`
    - Provide similar input for `terraform plan`.

## Footnotes:

- [ ] Package WebAPI, Atlas, R, and Achilles
- [ ] Implementation in Azure DevOps pipelines
- [ ] ETL
