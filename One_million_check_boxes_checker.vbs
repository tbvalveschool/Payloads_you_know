REM_BLOCK Documentation
    Title: OneMillionCheckboxes.com bot
    Author: Korben
    Description: Automatically checks or unchecks boxes at a constant rate slow enough to not get 
    throttled by the server. https://twitter.com/itseieio/status/1805986839058079896
    Tested with chrome on ubuntu. Milage may vary.
    
    Usage: Open https://onemillioncheckboxes.com/, hit tab, press button on your ducky to start or stop the automation
END_REM

ATTACKMODE HID STORAGE
VAR $RUN = FALSE
LED_OFF
BUTTON_DEF
    IF $RUN THEN
        $RUN = FALSE
        LED_R
    ELSE
        $RUN = TRUE
         LED_G
    END_IF
END_BUTTON

WHILE TRUE
    WHILE $RUN
        TAB
        DELAY 100
        SPACE
        DELAY 100
    END_WHILE
    DELAY 100
END_WHILE