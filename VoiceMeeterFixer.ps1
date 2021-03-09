##########################################
# Empire Démocratique du Poulpe
# 2021
##########################################
#
# Before launching this script, you need to use this command in an administrator Powershell:
# > Set-ExecutionPolicy Unrestricted
# You can undo the change after the script execution using:
# > Set-ExecutionPolicy AllSigned

##########################################
# Consts
##########################################

$priorities = @{
    "Realtime" = 256;
    "High" = 128;
    "Above normal" = 32768;
    "Normal" = 32;
    "Below normal" = 16384;
    "Low" = 64;
}

$cores = @{
    "Core1" = 1;
    "Core2" = 2;
    "Core3" = 4;
    "Core4" = 8;
    "Core5" = 16;
    "Core6" = 32;
    "Core7" = 64;
    "Core8" = 128;
}

$processName = "audiodg"
$processExt = ".exe"
$processPriority = "High"
$processAffinity = $cores["Core1"]

##########################################
# Function
##########################################

# See: https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/waiting-for-process-launch#:~:text=PowerShell%20has%20a%20built-in,%3A%20simply%20use%20Wait-Process.&text=When%20you%20omit%20-IgnoreAlreadyRunningProcesses%2C%20then,instance%20of%20Notepad%20already%20running.
#requires -Version 1
function Wait-ForProcess
{
    param
    (
        $Name,
        [Switch] $IgnoreAlreadyRunningProcesses
    )

    if ($IgnoreAlreadyRunningProcesses) {
        $NumberOfProcesses = (Get-Process -Name $Name -ErrorAction SilentlyContinue).Count
    } else {
        $NumberOfProcesses = 0
    }


    Write-Host "Waiting for $Name" -NoNewline
    while ((Get-Process -Name $Name -ErrorAction SilentlyContinue).Count -eq $NumberOfProcesses)
    {
        Write-Host '.' -NoNewline
        Start-Sleep -Milliseconds 400
    }

    Write-Host ''
}

##########################################
# Script
##########################################

# Wait for "audiodg.exe" process
Wait-ForProcess -Name $processName


# Get the "audiodg.exe" process
Write-Host "Getting " -NoNewline
Write-Host ("`"{0}{1}`"" -f $processName, $processExt) -NoNewline -ForegroundColor Yellow
Write-Host " process."
$process = Get-WmiObject -Class win32_process -Filter ("name='{0}{1}'" -f $processName, $processExt);
$pHandle = "win32_process.handle=" + $process.handle;

# Set the priority
Write-Host ("Changing priority to {0} ({1})." -f $processPriority, $priorities[$processPriority])
$result = ([wmi] $pHandle).setPriority($priorities[$processPriority]);

if ($result.ReturnValue -ne 0) {
    Write-Host ""
    Write-Host ("Error while changing `"{0}{1}`" priority." -f $processName, $processExt) -ForegroundColor Red
    Write-Host "Try to re-run the script as admin." -ForegroundColor Red
    pause
    exit
}

# Get the process with another method
Write-Host "Setting process affinity to use only one core."
$process = Get-Process -Name $processName

if ($process -eq $null) {
    Write-Host ""
    Write-Host ("Error while changing `"{0}{1}`" affinity." -f $processName, $processExt) -ForegroundColor Red
    Write-Host "Try to re-run the script as admin." -ForegroundColor Red
    pause
    exit
}

# Change processor affinity
$process.ProcessorAffinity = $processAffinity

if ($processAffinity -ne $process.ProcessorAffinity) {
Write-Host ""
    Write-Host ("Error while changing `"{0}{1}`" affinity." -f $processName, $processExt) -ForegroundColor Red
    Write-Host "Try to re-run the script as admin." -ForegroundColor Red
    pause
    exit
}

Write-Host "VoiceMeeter is now (partially) debugged."