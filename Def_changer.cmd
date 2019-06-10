#Command File to call the Default Folders Changer
#Krysanov Alexander June 2019
Echo off
cls

if exist .\Defaults_changer.ps1 (

	%windir%\system32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File .\Defaults_changer.ps1

	) Else (

	Echo .
	Echo run this command file from the folder - directory - where Defaults_changer.ps1 resides
	Echo .
	Pause
	)

