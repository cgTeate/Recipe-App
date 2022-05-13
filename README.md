#In order to run the database and application you will first need to download and install a few programs.
==========================================================================================================

1. Download and install SQL Server 2019 Express, this is framework for the project database and SQL queries.

2. Download and install the newest version SQL Server Management Studio for a graphical interface for SQL Server.

============================================================================
1. After connecting to SSMS using default windows authentication, go to the Object Explorer, open the security folder,
   then open logins, and finally you should see all the different logins.

2. Right click on logins folder and create a new login. Once dialog box opens, select the SQL Server authentication button.
   From here uncheck the enforced password policy box.  Create login credentials in the corresponding spaces.

3. Click on the Server roles properties tab.  Check the SYS Admin box, then click on the User Mapping tab.
   Check all the boxes for the desired database(s).  Then check DB_Owner box under the Database role membership area for the desired database(s).

4. Click on the Status tab in the same window.  Make sure the Grant and Enabled are selected for connection to database engine and login.

5. Press the OK button to submit all changes.

6. Right click on Security folder and refresh. Then you will see in the Login folder the new SYS Admin login.

7. Right click the master server in the Object Explorer, (eg. 'YOURPC/SQLEXPRESS(SQLSERVER)'), then click properties.
   Once dialog box opens select Security tab and then choose SQL Server and Windows Authentication mode. Press okay.

8. Right click the master server in the Object Explorer, (eg. 'YOURPC/SQLEXPRESS(SQLSERVER)'), then click restart.

9. After restart, click on the Disconnect button in the Object Explorer. Then click the Connect button in the Object Explorer.
    Once the Server Connection dialog box opens, select the SQL Server Authentication for the Authentication label, type in credentials and connect.

===========================================================================

1. Access the Project folder and right click MainFrm.resx and go to properties, then check the "Unblock" box.

2. Open the SQL Project script and then execute.

3. Right click on Databases folder in the Object Explorer and click refresh. Drop down and open up the Databases folder to see the newly creaeted database.

4. Download the newest version of Visual Studioes. During installation, select the .NET desktop development kit for Windows Application forms.
   
5. After installation, open the solution file that was given. (RecipeApp.sln)

6. Use 'ctrl-alt-s' to open up the Server Explorer sidebar. Then click on the Connect to Database button.

7. Select Microsoft SQL Server for the datasource and select .NET Framework Data Provider for SQL Server.
   Install any necessary data source packages or extensions. Repeat step 5 and 6.

8. Go back to SSMS and execute the following query "SELECT @@SERVERNAME" to get the server name.

9. Copy and paste the server name into the Server Name bar for the Add Connection dialog box.

10. Select the SQL Server Authentication for the Authentication label, type in credentials.

11. Click the drop down menu for the "Select or enter a database name" option and select the desired database. (RecipeApp)
    Press OK to connect.

12. Make sure that you close out of both SSMS and Visual Studioes then reopen both SSMS and RecipeApp.sln.

13. Right click the server and select refresh on the Visual Studio Server Explorer to reconnect to SSMS.

14. Press start to run the application.

================================= #SIDE NOTE (If Error 26 occurs)

1a). Type in 'Run' to your taskbar to launch Run. Then type in 'services.msc' into the bar and run.

2a). Scroll down in dialog box and find 'SQL Server(SQLEXPRESS)' or SQL Server(Server_Name), depending on SQL Server version.

3a). Once you selected the previously stated option then, in the left tab, select 'Restart' then select 'Stop' and finally select 'Start'.

4a). If open, close out of SSMS and then reopen it.  Go to Visual Studios and refresh the database server connection in the Server Explorer panel.

5a). Start the project.

1b). If problems persist further, open this link and follow instructions given: https://www.sqlserverlogexplorer.com/fix-error-code-26/

