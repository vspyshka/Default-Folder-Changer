#default folders changer v1.0 by vspysh

$user = $env:username
$regpath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
$regpath2 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
$desktop = "Desktop"
$doc = "Personal"
$music = "My Music"
$downloads = "{374DE290-123F-4565-9164-39C4925E467B}"
$pictures = "My Pictures"
$video = "My Video"
$favorites = "Favorites"

function Use-RunAs
{   
    # Check if script is running as Adminstrator and if not use RunAs
    # Use Check Switch to check if admin
    
    param([Switch]$Check)
    
    $IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
        ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
        
    if ($Check) { return $IsAdmin }    

    if ($MyInvocation.ScriptName -ne "")
    { 
        if (-not $IsAdmin) 
        { 
            try
            { 
                $arg = "-ExecutionPolicy Bypass -file `"$($MyInvocation.ScriptName)`""
                Start-Process "$psHome\powershell.exe" -Verb Runas -ArgumentList $arg -ErrorAction 'stop' 
            }
            catch
            {
                Write-Warning "Error - Failed to restart script with runas" 
                break              
            }
            exit # Quit this session of powershell
        } 
    } 
    else 
    { 
        Write-Warning "Error - Script must be saved as a .ps1 file first" 
        break 
    } 
}

Function Main {
$defpath = "NOT SET"
Write-Host "DONT PLACE SLASH (\) AT THE END OF PATH" -Foregroundcolor Red
$defpath = Read-Host "Please insert path for new deafault directories"
$defdir = $defpath+"\"+$user+"\"
write-host "Creating new folders under $defdir path..."

$1 = $defdir+"Desktop"
$2 = $defdir+"Documents"
$3 = $defdir+"Downloads"
$4 = $defdir+"Music"
$5 = $defdir+"Pictures"
$6 = $defdir+"Videos"
$7 = $defdir+"Favorites"

New-Item -ItemType Directory -Path $defdir -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $1 -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $2 -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $3 -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $4 -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $5 -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $6 -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $7 -ErrorAction SilentlyContinue

Write-Host "Completed!" -ForegroundColor Green
Write-Host "Now Changing the paths..." -ForegroundColor Yellow

Set-ItemProperty -path $regpath -name $desktop -value $1
Set-ItemProperty -path $regpath -name $doc -value $2
Set-ItemProperty -path $regpath -name $downloads -value $3
Set-ItemProperty -path $regpath -name $music -value $4
Set-ItemProperty -path $regpath -name $pictures -value $5
Set-ItemProperty -path $regpath -name $video -value $6
Set-ItemProperty -path $regpath -name $favorites -value $7
Set-ItemProperty -path $regpath2 -name $desktop -value $1
Set-ItemProperty -path $regpath2 -name $doc -value $2
Set-ItemProperty -path $regpath2 -name $downloads -value $3
Set-ItemProperty -path $regpath2 -name $music -value $4
Set-ItemProperty -path $regpath2 -name $pictures -value $5
Set-ItemProperty -path $regpath2 -name $video -value $6
Set-ItemProperty -path $regpath2 -name $favorites -value $7


Write-host "Completed!" -ForegroundColor Green
Write-host "Restarting the explorer..."
Stop-Process -ProcessName Explorer -Force
Write-Host "We're done!" -ForegroundColor Green
}


cls
Use-RunAs
Set-ExecutionPolicy -ExecutionPolicy bypass
Write-host "Change default directories Windows 10."
Write-host "                       by vspysh  v1.0"
Write-Host ""
Main
read-host "Press any key to exit..."


