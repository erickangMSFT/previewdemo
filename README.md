# Overview

1. Start Carbon on any OS of your choice. Run it on macOS for the demo. 
2. Demonstrate the portability of user settings.
    ```bash
    ./settings/apply_settings.sh 
    ```
3. Connect Carbon to SQL Server running on any OS using the connection group and dialog.
4. Open a new query editor and write select statement using IntelliSense.
5. Execute the query and view the result. 
6. Open Manage dashboard.
7. Run Backup dialog and backup the database.
    
    7.1. Demonstrate Integrated Terminal: For the backup path input, open Integrated terminal and run:

        ```bash
        docker exec -ti <container_name> /bin/bash
        cd /var/opt/mssql/backup //location of backup files
        readlink -f <backup filename>
        ```
    
    or if using Linux itself
    
        ```bash
        ssh <usernsame>@<your_linux_host>
        cd /var/opt/mssql/backup //location of backup files
        readlink -f <backup filename>
        ```
8. Open Manage dashboard on the server and show Insight widgets. Explain the insight widgets are fully customizable.
    
    8.1 Open user settings and change the insight widget type from count to chart to demonstrate the customizabiity on the fly.
