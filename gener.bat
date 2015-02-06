@echo off
REM ******************************************************************************
REM * GENER.BAT - Written by OurLink Technologies, January 19, 2012              *
REM * This batch file is used to create an archive of a file passed to the batch *
REM * the archived file is placed in a subfolder called ARCHIVE and the number   *
REM * of GENERATIONS passed in the command specify the number of copies to keep  *
REM * of the input file.                                                         *
REM *    Usage Example:                                                          *
REM *      GENER.BAT "test.log" 7                                                 *
REM *                                                                            *
REM *  The above example will archive the test.log file into the ARCHIVE sub     *
REM *  and keep 7 instances of the file with the format test.log.xxx.            *
REM ******************************************************************************
REM Get the date information for the archive file
   for /f "tokens=1,2,3,4 delims=/ " %%a in ("%date%") do set month=%%b&set day=%%c&set year=%%d
REM Get the time information for the archive file
   set hours=%Time:~0,2%
   set minutes=%Time:~3,2%
   set seconds=%Time:~6,2%
REM echo Hour= %hours%
REM echo Minute= %minutes%
REM echo Seconds= %seconds%
REM Create the file date header based on captured date and time
   set filedate=%year%%month%%day%-%hours%%minutes%%seconds%
REM echo %filedate% 
REM Begin archiving of matching files provided on command line
   MOVE /Y *%1 .\ARCHIVE\%filedate%-%1
   ECHO ----------NEW LOG STARTED @ %filedate%----------- > %1
REM Clean up old log files that we no longer want
   SET x=0
   FOR /F "tokens=1,2 delims= " %%a IN ('DIR .\ARCHIVE\*%1 /B/O-D/TW') DO (
REM     echo file= %%a 
REM     echo Logs= !x!
   IF /I !x! GEQ %2 DEL /Q .\ARCHIVE\%%a
     SET /A x=!x!+1
   )
   SET x=
REM pause
REM DONE!!

