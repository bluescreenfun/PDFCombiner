:: Put this in a .bat so you can double click to run a PS script
@echo off
SET "workpath=%~dp0"
SET "file=merge.ps1" :: Script Name
cd "%workpath%"
powershell.exe -file "%workpath%%file%" :: Run Script