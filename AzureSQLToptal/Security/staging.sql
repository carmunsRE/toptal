CREATE SCHEMA [staging]
    AUTHORIZATION [dbo];


GO
GRANT UPDATE
    ON SCHEMA::[staging] TO [adf_user];


GO
GRANT SELECT
    ON SCHEMA::[staging] TO [adf_user];


GO
GRANT INSERT
    ON SCHEMA::[staging] TO [adf_user];


GO
GRANT DELETE
    ON SCHEMA::[staging] TO [adf_user];


GO
GRANT CONTROL
    ON SCHEMA::[staging] TO [adf_user];


GO
GRANT ALTER
    ON SCHEMA::[staging] TO [adf_user];

