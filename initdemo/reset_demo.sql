-- Drop the database 'CarbonDemoDB'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use. 
ALTER DATABASE CarbonDemoDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
IF EXISTS (
  SELECT name
   FROM sys.databases
   WHERE name = N'CarbonDemoDB'
)
DROP DATABASE CarbonDemoDB
GO

-- Get a list of databases
SELECT name FROM sys.databases
GO