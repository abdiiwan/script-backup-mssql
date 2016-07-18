echo off
cls
echo -- BACKUP DATABASE --
set DATABASENAME=yourdatabase

SET HOUR=%time:~0,2%
SET dtStamp9=%date:~-4%%date:~4,2%%date:~7,2%_0%time:~1,1%%time:~3,2%%time:~6,2% 
SET dtStamp24=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

if "%HOUR:~0,1%" == " " (SET dtStamp=%dtStamp9%) else (SET dtStamp=%dtStamp24%)

set DATESTAMP=%DATE:~-4%.%DATE:~7,2%.%DATE:~4,2%_0%time:~1,1%%time:~3,2%%time:~6,2%
set BACKUPFILENAME=%CD%\%DATABASENAME%-%dtStamp%.bak
set SERVERNAME=(local)
echo.

sqlcmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE [%DATABASENAME%] TO DISK = N'%BACKUPFILENAME%' WITH INIT , NOUNLOAD , NAME = N'%DATABASENAME% backup', NOSKIP , STATS = 10, NOFORMAT"
echo -- DONE BACKUP DATABASE --

pause