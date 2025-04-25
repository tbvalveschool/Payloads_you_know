REM Title: ChromeBook Provisioning
REM Author: Korben / Google
REM Description: https://support.google.com/chrome/a/answer/9412749?hl=en#zippy=
REM modified from source for easier configuration using DuckyScript 3
REM REQUIRES TESTING. This is simply an updated syntax adaptation from the above link.
REM Target: Chromebook
REM Category: General


REM Required configuration
DEFINE #SSID example
DEFINE #WIFI_PASS example
DEFINE #ENROLLMENT_ACCOUNT example
DEFINE #ACCOUNT_PASSWORD example


REM Tweak values below until reliable
DEFINE #BOOT_DELAY 3000
DEFINE #WIFI_CONNECT_DELAY 9000
DEFINE #ENROLLMENT_COMPLETION_DELAY 8000

LED_R

REM Part One: Wifi Setup
DELAY #BOOT_DELAY
TAB
TAB
TAB
TAB
ENTER
DELAY 1000
TAB
TAB
TAB
ENTER
DELAY 500
STRING #SSID
DELAY 500
TAB
DELAY 500
DOWN
DOWN
DELAY 500
TAB
STRING #WIFI_PASS
DELAY 500
ENTER
REM Long Pause while Connection is established.
DELAY #WIFI_CONNECT_DELAY
REM Part One and One half: Go through First run Setup.
TAB
TAB
ENTER
DELAY 500
TAB
TAB
TAB
ENTER
DELAY 500
CTRL ALT e
TAB
TAB
TAB
TAB
TAB
ENTER
REM Part Two: Enrollment (Long Pauses in case it's having issues with wifi or render)
DELAY 4000
STRING #ENROLLMENT_ACCOUNT
ENTER
DELAY 5000
STRING #ACCOUNT_PASSWORD
DELAY 500
ENTER
REM Long Pause while device is enrolled.
DELAY #ENROLLMENT_COMPLETION_DELAY
ENTER


LED_G