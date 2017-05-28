#!/bin/bash

echo running mssql-scripter to dump PreviewDemoDB ...
mssql-scripter -S localhost -d PreviewDemoDB -U sa --schema-and-data --script-drop-create > ~/Projects/previewdemo/database_script.sql
echo Successfully dumped PreviewDemoDB to ~/Projecs/previewdemo/database_script.sql