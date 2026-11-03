:dir
cls&@echo off&mode 158,998&color 71
for /f "tokens=2 delims=:" %%a in ('chcp 2^>nul') do for /f "delims= " %%b in ("%%a") do if "%%b" neq "65001" chcp 65001>nul
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v ACP 2^>nul') do set ACP=%%a
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v OEMCP 2^>nul') do set OEMCP=%%a
if "%OEMCP%" neq "437" if "%ACP%" neq "%OEMCP%" reg add "HKLM\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v OEMCP /d 65001 /f>nul 2>&1
if "%ACP%" equ "936" if "%ACP%" neq "%OEMCP%" reg add "HKLM\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v OEMCP /d 936 /f>nul 2>&1
set "rn=%random% %~nx0"
title %rn%
for /f "tokens=9*" %%a in ('tasklist /v /fi "imagename eq cmd.exe" /nh^|find "%rn%"') do for /f "tokens=1 delims=." %%i in ("%%b") do set tn=%%i
for /f "tokens=10*" %%a in ('tasklist /v /fi "imagename eq cmd.exe" /nh^|find "%rn%"') do for /f "tokens=1,2 delims=." %%i in ("%%b") do for /f "tokens=1 delims= " %%i in ("%%j") do set tfn=%tn%.%%i
for /f "tokens=2" %%a in ('tasklist /v /fi "imagename eq cmd.exe" /nh^|find "%tfn%"') do set "cuPID=%%a"
for /f "tokens=2" %%i in ('tasklist /fi "imagename eq cmd.exe" /nh') do if not "%%i" equ "%cuPID%" taskkill /f /pid "%%i" /t >nul 2>&1&title CMD
for %%f in ("%windir%\System32\ntdll.dll") do (if exist "%%f" (for /f "tokens=1,2,3,4,5" %%i in ('dir /ta "%%f" 2^>nul^|find "%%~nxf"') do (for %%d in (%%i %%j %%k %%l %%m) do (echo %%d|find ":" >nul&&if not errorlevel 1 set timepart=%%d)
for %%d in (%%i %%j %%k %%l %%m) do (echo %%d|find "/" >nul&&if not errorlevel 1 set b=%%d&set bootdate=%%d)
if not defined bootdte (for %%d in (%%i %%j %%k %%l %%m) do (echo %%d|find "-" >nul&&if not errorlevel 1 set b=%%d&set "bootdate=%%d"))
goto calweek)))
:calweek
for /f "tokens=1-3 delims=/-." %%d in ("%bootdate%") do (set /a "yy=%%d, mm=100%%e%%100, dd=100%%f%%100")
set /a "a=(14-mm)/12, y=yy-a, m=mm+12*a-2, w=(dd+y+y/4-y/100+y/400+31*m/12)%%7"
if %w% equ 0 set weekday=SUNday
if %w% equ 1 set weekday=MONday
if %w% equ 2 set weekday=TUEsday
if %w% equ 3 set weekday=WEDnesday
if %w% equ 4 set weekday=THUrsday
if %w% equ 5 set weekday=FRIday
if %w% equ 6 set weekday=SATurday
echo.   %b% %timepart% %weekday%
for /f "tokens=1,2" %%a in ('date /t') do (for /f %%h in ('echo %time:~0,2%') do if %%h lss 10 (echo %%a|findstr "[0-9]">nul&&echo.   %%a 0%%h:%time:~3,2% %%b||echo.   %%b 0%%h:%time:~3,2% %%a) else (echo %%a|findstr "[0-9]">nul&&echo    %%a %%h:%time:~3,2% %%b||echo    %%b %%h:%time:~3,2% %%a))
for /f "tokens=4 delims=[] " %%i in ('ver') do set ver=%%i&set seto=0&set set=1&set nt=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion&set lstky=reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /d
for /f "skip=2 tokens=3* delims= " %%i in ('reg query "%nt%" /v BuildBranch 2^>nul') do set b=%%i %%j
for /f "skip=2 tokens=3* delims= " %%i in ('reg query "%nt%" /v CurrentType') do set t=%%i %%j
for /f "skip=2 tokens=3* delims= " %%i in ('reg query "%nt%" /v InstallationType') do set d=%%i %%j
for /f "skip=2 tokens=3* delims= " %%i in ('reg query "%nt%" /v ProductName') do set s=%%i %%j
reg query "%nt%" /v RegisteredOrganization >nul 2>&1
if errorlevel 1 set f=//&goto o
for /f "skip=2 tokens=3* delims= " %%i in ('reg query "%nt%" /v RegisteredOrganization') do (if %%i equ %%i set f=///%%i %%j&goto o)
set f=///&goto o
:o
for /f "skip=2 tokens=3* delims= " %%i in ('reg query "%nt%" /v RegisteredOwner 2^>nul') do set p=%%i %%j
for /f "skip=2 tokens=3* delims= " %%i in ('reg query "%nt%" /v DisplayVersion 2^>nul') do set y=%%i %%j
echo;
echo %f%
echo;%s% %ver%
echo %y%%b%%d%%t%
echo;
echo RegisteredOwner: %p%
ipconfig /flushdns>nul
for /f "skip=2 delims=" %%i in ('reg query HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0 /v ProcessorNameString') do set i=%%i
for /f "tokens=2* delims= " %%i in ("%i%") do set a=%%j
echo %a%
for /f "skip=2 tokens=3 delims= " %%a in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v SelectedUserSID') do for /f "tokens=3 delims=\" %%i in ('reg query "%nt%\ProfileList\%%a" /v ProfileImagePath 2^>nul') do set cid=HKU\%%a&set cu=%%~nxi&for /f "tokens=2 delims=\" %%e in ('whoami') do set we=%%e
if "%cu%" neq "%we%" set rcu=%we%
if "%cu%" equ "%we%" set rcu=I
set hd=\Winlogon\SpecialAccounts\UserList&set rt=/t reg_dword /d
reg query HKU\S-1-5-19\Environment >nul 2>&1
if errorlevel 1 netsh advfirewall set allprofiles state on&goto qdi
if not errorlevel 1 netsh advfirewall set allprofiles state on>nul&taskkill /f /im netsh.exe /t >nul 2>&1&choice /c 0ai /d i /t 2 /n >nul
if errorlevel 3 echo (Run as %rcu%).&echo;&goto qdi
if errorlevel 2 echo;&goto as500
if errorlevel 1 echo;&goto as500
:as500
for /f "skip=1 tokens=2" %%a in ('whoami /user') do for /f "tokens=3 delims=\" %%i in ('reg query "%nt%\ProfileList\%%a" /v ProfileImagePath 2^>nul') do set cu=%%~nxi&set sid=%%a
set cid=HKU\%sid%
:qdi
for /f "skip=6 tokens=*" %%i in ('net localgroup administrators') do if "%%i" neq "The command completed successfully." set acu=%%i&net localgroup administrators "%%i" /delete >nul 2>&1&net localgroup administrators "%%i" /add >nul 2>&1||set scu=%%i&for /f "tokens=3" %%a in ('net user "%%i"^|findstr "active"') do if /i "%%a" equ "no" net user "%%i" /act:y >nul 2>&1
for /f "tokens=1* delims=:" %%i in ('net localgroup administrators^|findstr /n ".*"') do if "%%i" equ "7" if "%%j" neq "%scu%" set acu=%%j
for /f %%a in ('"prompt $h&for %%b in (1) do rem"') do set "st=%%a"
for /l %%i in (1,-1,1) do if "%acu%" neq "%scu%" set /p="con%%i%st%%st%%st%%st%%st%%st%%st%%st%%st%%st%"<nul&timeout /t 1 >nul
reg add "%nt%%hd%" /v "%acu%" %rt% %set% /f>nul
echo --Machine_UUID--
for /f "tokens=2 delims={}" %%i in ('reg query "HKLM\SYSTEM\HardwareConfig" /v LastConfig 2^>nul') do echo %%i
echo;
echo --SQMClient_ID--
for /f "skip=2 tokens=2 delims={}" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\SQMClient" /v MachineId 2^>nul') do echo %%a
echo;
for /f "skip=2 tokens=2 delims=.\" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnSAMUser') do set sn=%%i
echo \\%computername%\%sn%
echo %cu% %cid%
echo -------------------------------------------------------------------------
echo;
echo        aur
echo;
echo        cln
echo;
echo        ipn
echo;
echo        str
echo;
echo        name
echo;
set                               .                  .                   .   =
choice /c aciSnNbqdefFshjklmopPtrRuvwxzgGyQ /d q /cs /t 98 /n >nul
if errorlevel 33 shutdown /l&exit
if errorlevel 32 goto vehicles
if errorlevel 31 gpedit.msc&goto dir
if errorlevel 30 goto getrights
if errorlevel 29 goto ha
if errorlevel 28 goto set
if errorlevel 27 goto wincfg
if errorlevel 26 goto els
if errorlevel 25 goto tri
if errorlevel 24 goto restart
if errorlevel 23 regedit&goto dir
if errorlevel 22 goto toggledsk
if errorlevel 21 goto AlternateShell
if errorlevel 20 goto runtime
if errorlevel 19 goto okinf
if errorlevel 18 goto mac
if errorlevel 17 goto lang
if errorlevel 16 goto krs
if errorlevel 15 goto jobpid
if errorlevel 14 goto memos
if errorlevel 13 goto str
if errorlevel 12 goto fc
if errorlevel 11 goto fs
if errorlevel 10 goto ds
if errorlevel 9 goto display
if errorlevel 8 goto gdi
if errorlevel 7 cls&cmd /t:f1 /k cd /d %~dp0&goto dir
if errorlevel 6 goto HSusr
if errorlevel 5 goto nam
if errorlevel 4 goto secpwpolicy
if errorlevel 3 goto nc
if errorlevel 2 goto cc
if errorlevel 1 goto act
::--------------------------------------------------------------------
:act
cls&color 79
echo [boot system auto demand disabled delayed-auto]
echo;
set a=lanmanworkstation&set b=lanmanserver&set c=srvnet&set d=Spooler&set e=camsvc&set f=MSDTC&set g=TrkWks&set h=SysMain&set i=RmSvc&set j=CDPSvc&set k=BITS&set l=UsoSvc&set m=dmwappushservice
set r=HKLM\SYSTEM\CurrentControlSet\Services
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%a%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %a%^|findstr /i "state"') do set v=%%i
set "a1=%a% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%b%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %b%^|findstr /i "state"') do set v=%%i
set "b1=%b% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%c%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %c%^|findstr /i "state"') do set v=%%i
set "c1=%c% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%d%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %d%^|findstr /i "state"') do set v=%%i
set "d1=%d% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%e%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %e%^|findstr /i "state"') do set v=%%i
set "e1=%e% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%f%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %f%^|findstr /i "state"') do set v=%%i
set "f1=%f% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%g%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %g%^|findstr /i "state"') do set v=%%i
set "g1=%g% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%h%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %h%^|findstr /i "state"') do set v=%%i
set "h1=%h% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%i%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %i%^|findstr /i "state"') do set v=%%i
set "i1=%i% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%j%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %j%^|findstr /i "state"') do set v=%%i
set "j1=%j% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%k%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %k%^|findstr /i "state"') do set v=%%i
set "k1=%k% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%l%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %l%^|findstr /i "state"') do set v=%%i
set "l1=%l% %s%^|%v%"
for /f "eol=E tokens=3 delims= " %%s in ('reg query "%r%\%m%" /v start') do set s=%%s
for /f "tokens=3 delims=: " %%i in ('sc query %m%^|findstr /i "state"') do set v=%%i
set "m1=%m% %s%^|%v%"
echo 1.%a1%   2.%b1%   3.%c1%   4.%d1%   5.%e1%   6.%f1%
echo;
echo 7.%g1%   8.%h1%   9.%i1%   10.%j1%   11.%k1%   12.%l1%   13.%m1%
echo;
set tr=
set /p "tr=^.^"
if "%tr%" equ "1" set tr=lanmanworkstation
if "%tr%" equ "2" set tr=lanmanserver
if "%tr%" equ "3" set tr=srvnet
if "%tr%" equ "4" set tr=Spooler
if "%tr%" equ "5" set tr=camsvc
if "%tr%" equ "6" goto msdtc
if "%tr%" equ "7" set tr=TrkWks
if "%tr%" equ "8" set tr=SysMain
if "%tr%" equ "9" set tr=RmSvc
if "%tr%" equ "10" set tr=CDPSvc
if "%tr%" equ "11" set tr=BITS
if "%tr%" equ "12" set tr=UsoSvc
if "%tr%" equ "13" set tr=dmwappushservice
if "%tr%" equ ".." %lstky% %r%\RpcEptMapper /f>nul&regedit&cls&goto act
for %%i in (a lanmanworkstation b lanmanserver c srvnet d Spooler e camsvc f MSDTC g TrkWks h SysMain i RmSvc j CDPSvc k BITS l UsoSvc m dmwappushservice) do if "%%i" equ "%tr%" goto trigger
if "%tr%" equ "." goto dir
if "%tr%" equ "r" goto dir
if "%tr%" equ "" goto runtime
if "%tr%" equ "bb" cmd /t:f1 /k cd /d %~dp0&goto act
if "%tr%" equ "q" goto gdi
echo error&pause&goto act
:trigger
cls&for /f "skip=2 tokens=3 delims= " %%i in ('reg query %r%\%tr% /v Start') do set sv=%%i
for %%i in (srvnet RmSvc dmwappushservice) do if "%%i" equ "%tr%" echo -Start-  3^|%sv%&goto tog
echo -Start-  2^|%sv%
:tog
sc query %tr%&sc qc %tr%&echo;&for /f "skip=1 tokens=*" %%i in ('sc qprotection %tr%') do echo %%i&echo;
set toggle=
set /p toggle=%tr% cfg:
if "%toggle%" equ "1" set toggle=system
if "%toggle%" equ "2" set toggle=auto
if "%toggle%" equ "3" set toggle=demand
if "%toggle%" equ "4" set toggle=disabled
for %%i in (system auto demand disabled 1 2 3 4) do if "%toggle%" equ "%%i" goto trigger1
if "%toggle%" equ "." cls&goto act
if "%toggle%" equ "r" cls&goto act
if "%toggle%" equ "" goto trigger2
echo error&pause&goto trigger
:trigger1
sc config %tr% start=%toggle%&echo;
:trigger2
set state=
set /p state=%tr% state:
if "%state%" equ "0" set state=stop
if "%state%" equ "1" set state=start
for %%i in (start stop 0 1) do if "%state%" equ "%%i" goto trigger3
if "%state%" equ "." goto trigger
if "%state%" equ "r" goto act
if "%state%" equ "" goto act
echo error&pause&goto trigger2
:trigger3
net %state% %tr%&pause>nul&goto act

:msdtc
cls
for /f "skip=2 tokens=3 delims= " %%i in ('reg query %r%\msdtc /v Start') do echo -Start-  3^|%%i
sc query msdtc&sc qc msdtc&echo;&for /f "skip=1 tokens=*" %%i in ('sc qprotection msdtc') do echo %%i
echo;
set toggle=
set /p toggle=msdtc cfg:
if "%toggle%" equ "3" set toggle=demand
if "%toggle%" equ "4" set toggle=disabled
for %%i in (demand disabled 3 4) do if "%toggle%" equ "%%i" goto msdtc1
if "%toggle%" equ "." cls&goto act
if "%toggle%" equ "r" cls&goto act
if "%toggle%" equ "" goto msdtc2
echo error&pause&goto msdtc
:msdtc1
sc config msdtc start=%toggle%
for /f "skip=2 tokens=3 delims= " %%i in ('reg query %r%\msdtc /v Start') do echo -Start-  3^|%%i
echo;
:msdtc2
set state=
set /p state=msdtc state:
if "%state%" equ "0" set state=stop
if "%state%" equ "1" set state=start
for %%i in (start stop 0 1) do if "%state%" equ "%%i" goto msdtc3
if "%state%" equ "." goto msdtc
if "%state%" equ "r" goto act
if "%state%" equ "" goto sdom
echo error&pause&goto msdtc2
:msdtc3
net %state% msdtc
:sdom
echo;
for /f "skip=2 tokens=3 delims= " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Ole /v EnableDCOM') do set qv=%%i
set a=
set /p a=EnableDCOM %qv%^|
for %%i in (Y N) do if /i "%a%" equ "%%i" goto setdtc
if "%a%" equ "" goto act
if "%a%" equ "." goto msdtc2
if "%a%" equ "r" goto msdtc2
echo error&pause&goto sdom
:setdtc
reg add HKLM\SOFTWARE\Microsoft\Ole /v EnableDCOM /d "%a%" /f>nul
for /f "skip=2 tokens=3 delims= " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Ole /v EnableDCOM') do echo        ^--^> %qv%^|%%i
pause>nul&goto act
::--------------------------------------------------------------------
:cc
cls
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v GlassSessionId
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\DPI 2>nul
reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo 2>nul
:os
set o=
set /p o=^^. 
if "%o%" equ "" goto CUhandler
if "%o%" equ "." goto dir
if "%o%" equ "r" goto dir
if "%o%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto cc
if "%o%" equ " " %lstky% %cid%\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /f>nul&regedit&cls&goto cc
if "%o%" equ ".." %lstky% HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup /f>nul&regedit&cls&goto cc
:CUhandler
cls&echo CU_Handler&echo;
reg query "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr">nul 2>&1&&for /f "skip=1 tokens=1,2,4 delims=: " %%i in ('reg query "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr"^|findstr /n ".*"') do (if "%%i" equ "3" echo   %%~j   %%k)
echo;
reg query "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr\HandlerInstances">nul 2>&1&&for /f "skip=1 tokens=12 delims=\" %%i in ('reg query "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr\HandlerInstances"') do echo %%i
reg query "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr\HandlerInstances\{750FDF10-2A26-11D1-A3EA-080036587F03}">nul 2>&1&&for /f "skip=2 tokens=1,3 delims= " %%i in ('reg query "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr\HandlerInstances\{750FDF10-2A26-11D1-A3EA-080036587F03}"') do (echo   %%i   %%j)
echo;
:sSync
set dw=
set /p dw=a/d.Syn^|^|
if "%dw%" equ "" goto LMhandler
if "%dw%" equ "." goto cc
if "%dw%" equ "r" goto dir
if "%dw%" equ "q" goto gdi
if "%dw%" equ "d" goto delSyncMgrCU
if "%dw%" equ "a" goto recSyncMgrCU
if "%dw%" equ "h" goto noteSyncMgrCU
if "%dw%" equ ".." %lstky% "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr" /f>nul&regedit&cls&goto CUhandler
for /l %%i in (0 1 8) do if "%dw%" equ "%%i" goto SyncMgrCU
echo error&pause&goto CUhandler
:delSyncMgrCU
reg delete "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr" /f>nul
reg add "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr" /v StartAtLogin /t reg_dword /d 0 /f>nul
echo;
echo operation successfully&pause>nul&goto CUhandler
:recSyncMgrCU
reg add "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr" /v StartAtLogin /t reg_dword /d 0 /f>nul
reg add "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr\HandlerInstances\{750FDF10-2A26-11D1-A3EA-080036587F03}" /v SyncTime /t reg_binary /d 0000000000000000 /f>nul
reg add "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr\HandlerInstances\{750FDF10-2A26-11D1-A3EA-080036587F03}" /v Connected /t reg_dword /d 1 /f>nul
reg add "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr\HandlerInstances\{750FDF10-2A26-11D1-A3EA-080036587F03}" /v Enabled /t reg_dword /d 0 /f>nul
goto CUhandler
:SyncMgrCU
reg add "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr" /v StartAtLogin /t reg_dword /d %dw% /f>nul
for /f "eol=H skip=2 tokens=1,3 delims= " %%i in ('reg query "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\SyncMgr"') do echo;&echo   %%i   %%j
echo;
pause>nul&mobsync&goto CUhandler
:noteSyncMgrCU
echo;
echo   HandlerInstances
echo {750FDF10-2A26-11D1-A3EA-080036587F03}
echo;
echo ..&pause>nul&goto CUhandler

:LMhandler
cls&echo LM_Handler&echo;
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr >nul 2>&1&&for /f "skip=1 tokens=1,2,4 delims=: " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr^|findstr /n ".*"') do (if "%%i" equ "3" echo   %%~j   %%k)
echo;
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\HandlerCollections\{00000000-0000-0000-0000-000000000000} >nul 2>&1&&for /f "tokens=1,9 delims=:\" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\HandlerCollections\{00000000-0000-0000-0000-000000000000}^|findstr /n ".*"') do (if "%%i" equ "2" echo %%~j)
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\HandlerCollections\{00000000-0000-0000-0000-000000000000} >nul 2>&1&&for /f "skip=1 tokens=1,4* delims=: " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\HandlerCollections\{00000000-0000-0000-0000-000000000000}^|findstr /n ".*"') do (if "%%i" equ "3" echo   %%~j %%k)
echo;
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03} >nul 2>&1&&for /f "tokens=1,9 delims=:\" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03}^|findstr /n ".*"') do (if "%%i" equ "2" echo %%~j)
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03} >nul 2>&1&&for /f "skip=1 tokens=1,4* delims=: " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03}^|findstr /n ".*"') do (if "%%i" equ "3" echo   %%~j %%k)
echo;
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03}\DefaultIcon >nul 2>&1&&for /f "tokens=1,10 delims=:\" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03}\DefaultIcon^|findstr /n ".*"') do (if "%%i" equ "2" echo %%~j)
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03}\DefaultIcon >nul 2>&1&&for /f "skip=1 tokens=1,4* delims=: " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03}\DefaultIcon^|findstr /n ".*"') do (if "%%i" equ "3" echo   %%~j)
echo;
:sSync
set dw=
set /p dw=a/d.Ins^|^|
if "%dw%" equ "" goto netdisk
if "%dw%" equ "." goto CUhandler
if "%dw%" equ "r" goto CUhandler
if "%dw%" equ "q" goto gdi
if "%dw%" equ "d" goto delSyncMgrLM
if "%dw%" equ "a" goto recSyncMgrLM
if "%dw%" equ "h" goto noteSyncMgrLM
if "%dw%" equ ".." %lstky% HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr /f>nul&regedit&cls&goto LMhandler
for /l %%i in (0 1 8) do if "%dw%" equ "%%i" goto SyncMgrLM
echo error&pause&goto LMhandler
:delSyncMgrLM
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr /v Installed /t reg_dword /d 1 /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers /f>nul&reg delete hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers /ve /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\HandlerCollections\{00000000-0000-0000-0000-000000000000} /ve /d "Sync Center Static Handler Collection" /f>nul
echo;
echo operation successfully&pause>nul&goto LMhandler
:recSyncMgrLM
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr /v Installed /t reg_dword /d 1 /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\HandlerCollections\{00000000-0000-0000-0000-000000000000} /ve /d "Sync Center Static Handler Collection" /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03} /ve /d "Offline Files" /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr\Handlers\{750fdf10-2a26-11d1-a3ea-080036587f03}\DefaultIcon /ve /t reg_expand_sz /d "%%SystemRoot%%\System32\cscui.dll,-1200" /f>nul
goto LMhandler
:SyncMgrLM
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr /v Installed /t reg_dword /d %dw% /f>nul
for /f "eol=H skip=2 tokens=1,3 delims= " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Syncmgr') do echo;&echo   %%i   %%j
echo;
pause>nul&goto LMhandler
:noteSyncMgrLM
echo;
echo   HandlerCollections
echo {00000000-0000-0000-0000-000000000000}
echo;
echo   HandlerInstances
echo {750FDF10-2A26-11D1-A3EA-080036587F03}
echo;
echo ..&pause>nul&goto LMhandler

:netdisk
cls
echo hiveLetter
reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace 2>nul
if errorlevel 1 goto Mui
:Nletter
set dw=
set /p dw=none?.
if "%dw%" equ "" goto Mui
if "%dw%" equ "." goto LMhandler
if "%dw%" equ "r" goto dir
if "%dw%" equ "q" goto gdi
if "%dw%" equ "y" goto delNletter
if "%dw%" equ ".." %lstky% %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace /f>nul&regedit&goto netdisk
echo error&pause&goto netdisk
:delNletter
for /f "eol=E delims=" %%i in ('reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace /f * /k 2^>nul') do reg delete "%%i" /f
goto netdisk

:Mui
cls&color 07
for /f "delims=" %%i in ('dir "%tmp%" /ad /b') do echo %%i 2>nul
echo;
for /f "delims=" %%i in ('dir /ad /b /s "%tmp%"') do echo %%i
echo ---------------------------------------------------------------------------------
for /f "delims=" %%i in ('dir "%tmp%" /b /s /a-d') do echo %%i 2>nul
echo;&echo cls.&pause>nul
for /f "delims=" %%i in ('dir /a /b /s "%tmp%\*"') do attrib -h -r "%%i"&del /f/s/q "%%i"&rd /s/q "%%i" 2>nul
:sui
cls
echo MuiCache
for /f "skip=1 tokens=3 delims= " %%i in ('reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer /v LogonCount') do set /a d=%%i
echo %d%
for /f "skip=2 tokens=1,2,3* delims=." %%i in ('reg query "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" 2^>nul') do echo %%i.%%j
echo;
set s=
set /p s=del^|[]bin:
if "%s%" equ "" goto MRU
if "%s%" equ "." goto netdisk
if "%s%" equ "r" goto dir
if "%s%" equ "q" goto gdi
if "%s%" equ "d" goto delMui
if "%s%" equ " " goto delcyc
if "%s%" equ "n" goto Mui
echo error&pause&goto Mui
:delMui
del "C:\Users\%cu%\AppData\Roaming\Microsoft\Office\Recent\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\Caches\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\History\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\INetCache\*" /f/s/q 2>nul
del C:\Windows\Prefetch\* /f/s/q 2>nul
del C:\Windows\Temp\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCookies\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCache\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\History\* /f/s/q 2>nul
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer /v LogonCount /t reg_dword /d 0 /f>nul
echo ----------------------------
reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths&pause
reg delete "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /va /f>nul 2>&1
reg delete %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths /f 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v GlassSessionId /t reg_dword /d 0 /f>nul
for /r "C:\Users\%cu%\AppData\Roaming\Microsoft\Windows\Recent" %%i in (*) do if /i not "%%~nxi" equ "f01b4d95cf55d32a.automaticDestinations-ms" if /i not "%%~nxi" equ "5f7b5f1e01b83767.automaticDestinations-ms" del "%%i" /f/s/q 2>nul
del %windir%\system32\logfiles\* /f/s/q 2>nul
del "%tmp%\*" /f/s/q 2>nul
:delcyc
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%i: rd %%i:\$Recycle.Bin /s /q >nul 2>&1&start cleanmgr
:MRU
cls&color f8
for /f "tokens=1,3 skip=3 delims=\ " %%i in ('reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU 2^>nul') do if %%i equ MRUList echo %%i %%j&echo;
for /f "eol=M tokens=1,3 skip=2 delims=\ " %%i in ('reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU 2^>nul') do echo  %%i        %%j&echo;
set s=
set /p s=del^|^|[]RMR:
if "%s%" equ "" goto act
if "%s%" equ "." goto Mui
if "%s%" equ "r" goto dir
if "%s%" equ "q" goto gdi
if "%s%" equ "d" goto FeatureCom
if "%s%" equ " " goto dMRU
if "%s%" equ "h" goto dhlp
echo error&pause&goto MRU
:FeatureCom
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32" 2^>nul^|find "ComDlg32"') do reg delete "%%i" /f>nul 2>&1
:dMRU
reg delete %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" 2^>nul^|find "RecentDocs"') do reg delete "%%i" /f>nul 2>&1
for /f "eol=E delims=" %%a in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /s /f "*"^|findstr "Count"') do reg delete %%a /va /f>nul 2>&1
start /min cmd /c for /f "delims=" %%i in ('wevtutil el') do (wevtutil cl "%%i")
goto runtime
:dhlp
echo;
echo d   delete FeatureComDlg and MRU
echo " " delete Explorer\RunMRU histories only
pause>nul&goto MRU

:runtime
cls&color 78
query session 2>nul
echo ---------------------------------------------------------------------------------
echo a. Windows Search
sc query WSearch
echo;
echo b. win Update
sc query wuauserv
echo;
echo c. Telephony(wifi-point)
sc query TapiSrv
echo;
echo d. Remote Desktop
sc query termservice
echo;
echo e. Microsoft Edge(Mobile)
sc query edgeupdatem
echo;
echo f. Microsoft Edge
sc query edgeupdate
echo;
echo g. NetBT
sc query NetBT
echo;
echo h. Connected User Experiences
sc query diagtrack
echo;
:idle
set k=a b c d e f g h
set s=
set /p "s=sc stop code^^"
if "%s%" equ "" taskkill /f /im mmc* /t&goto act
if "%s%" equ "r" goto dir
if "%s%" equ "q" goto gdi
if "%s%" equ "." start taskschd&goto dir
if "%s%" equ "bb" cmd /t:f1 /k cd /d %~dp0&goto runtime
for %%i in (%k%) do (
if %%i equ %s% if "%s%" equ "a" set s=WSearch&goto off
if %%i equ %s% if "%s%" equ "b" set s=wuauserv&goto off
if %%i equ %s% if "%s%" equ "c" set s=TapiSrv&goto off
if %%i equ %s% if "%s%" equ "d" set s=termservice&goto off
if %%i equ %s% if "%s%" equ "e" set s=edgeupdatem&goto off
if %%i equ %s% if "%s%" equ "f" set s=edgeupdate&goto off
if %%i equ %s% if "%s%" equ "g" set s=NetBT&goto off
if %%i equ %s% if "%s%" equ "h" set s=diagtrack&goto off)
echo error&pause&goto idle
:off
net stop %s%&pause>nul&goto runtime
::--------------------------------------------------------------------
:nc
cls
echo        d  dns v4
echo;
echo        a  ip v4
echo;
echo        s  auto v4
echo;
set a=
set /p a=.^|^|
if "%a%" equ "d" goto dns
if "%a%" equ "a" goto ips
if "%a%" equ "s" goto ai
if "%a%" equ "" goto nc6
if "%a%" equ "." goto dir
if "%a%" equ "r" goto dir
if "%a%" equ "n" ncpa.cpl&goto nc
if "%a%" equ "h" netsh i ip sh ro&pause>nul&goto nc
if "%a%" equ "q" goto gdi
if "%a%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /f>nul&regedit&goto nc
echo error&pause&goto nc
::-------------------------------------
:dns
cls
ipconfig /flushdns>nul
set getnic=&(for /f "tokens=1-4* delims= " %%a in ('netsh in ip sh in^|findstr /rc:"\<connected\>"^|findstr /v "4294967295"') do if not defined getnic set "getnic=%%e")&call echo %%getnic%%
echo;
echo                                       6 223.5.5.5
echo;
netsh i ip sh dnsservers "%getnic%"|findstr "DNS"
echo;
for /f "tokens=2" %%s in ('cmd /c^|nslookup^|findstr /i "address"') do echo.                                  --^> %%s
echo;
set d=
set /p d=preferred.^|^|
if "%d%" neq "" set d=%d:~0,15%
if "%d:~0,1%" neq " " if "%d:~6,1%" neq "" if "%d:~15,1%" equ "" goto dn
if "%d%" equ "" goto sl
if "%d%" equ "." goto nc
if "%d%" equ "r" goto nc
if "%d%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto dns
if "%d%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /f>nul&regedit&goto dns
if "%d%" equ " " reg delete HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v EnableAutoDoH /f&timeout /t 1 >nul&goto dns
if "%d%" equ "n" ncpa.cpl&goto dns
if "%d%" equ "h" goto hdns
if "%d%" equ "q" goto gdi
echo invalid&pause&goto dns
:dn
if "%d%" equ "223.5.5.5" netsh dns add encryption server=%d% dothost=dns.alidns.com&reg query HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v EnableAutoDoH 2>nul
if "%d%" equ "223.6.6.6" (netsh dns add encryption server=%d% dohtemplate=https://dns.alidns.com/dns-query) else (
netsh i ip set dns name="%getnic%" source=static addr=%d% primary)
goto dns
:sl
set s=
set /p s=alternate^|^|
if "%s%" neq "" set d=%s:~0,15%
if "%s:~0,1%" neq " " if "%s:~6,1%" neq "" if "%s:~15,1%" equ "" goto ns
if "%s%" equ "" goto ips
if "%s%" equ "." goto dns
if "%s%" equ "r" goto nc
if "%s%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto dns
if "%s%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\DohWellKnownServers /f>nul&regedit&goto dns
if "%s%" equ "h" goto hdns
if "%s%" equ "q" goto gdi
echo invalid&pause&goto sl
:ns
netsh i ip add dns name="%getnic%" addr="%s%"&goto dns
:hdns
echo;
echo curl -v 223.6.6.6:443
echo tracert -d -w 1000 223.5.5.5
echo;&echo ^>(i)
echo win+i Network^&Internet_Ethernet/Wi-Fi_DNS server assignment
echo ----------------------------------------------------------------------
echo;&curl -v 223.5.5.5:853
netsh i ip sh dnsservers&pause>nul&goto dns
:ips
cls&netsh i ipv4 set global randomizeidentifiers=enabled >nul
set getnic=&(for /f "tokens=1-4* delims= " %%a in ('netsh in ip sh in^|findstr /rc:"\<connected\>"^|findstr /v "4294967295"') do if not defined getnic set "getnic=%%e")&call echo %%getnic%%
echo;
set "ip4="&(for /f "tokens=4" %%i in ('route print^|findstr "0.0.0.0"^|findstr /v "127.0.0.1"') do if not defined ip4 set ip4=%%i)&&call echo %%ip4%%||echo no IP address found
echo;
set "mask="&for /f "tokens=1* delims=:" %%a in ('ipconfig^|findstr /c:"Subnet Mask"') do if not defined mask for /f "tokens=* delims= " %%c in ("%%b") do set "mask=%%c"
if not defined mask for /f "tokens=1* delims=:" %%a in ('netsh i ip sh config^|findstr /c:"Subnet Mask"') do if not defined mask for /f "tokens=* delims= " %%c in ("%%b") do set "mask=%%c"
if defined mask (echo %mask%) else echo no subnet mask found
echo;
(for /f "tokens=2 delims=:" %%a in ('netsh i ip sh config name^="%getnic%"^|findstr /c:"Default Gateway"') do for /f "tokens=*" %%b in ("%%a") do set gat=%%b&echo %%b)||echo no gateway found
echo;
for /f "tokens=1* delims=:" %%a in ('netsh wlan sh in 2^>nul^|findstr /i "rate"') do for /f "tokens=* delims= " %%x in ("%%a") do for /f "tokens=* delims= " %%y in ("%%b") do echo %%x : %%y
echo;
set ip=
set /p ip=ip4.^|^|
if "%ip%" neq "" set ip=%ip:~0,15%
if "%ip:~0,1%" neq " " if "%ip:~6,1%" neq "" if "%ip:~15,1%" equ "" goto ip
if "%ip%" equ "" goto dns
if "%ip%" equ "." goto nc
if "%ip%" equ "r" goto dir
if "%ip%" equ "n" ncpa.cpl&goto ips
if "%ip%" equ "h" goto hlpip
if "%ip%" equ "q" goto gdi
if "%ip%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /f>nul&regedit&goto ips
echo invalid&pause&goto ips
:ip
echo netsh i ip set addr name="%getnic%" source=static addr=%ip% mask=%mask% gateway=%gat%
netsh i ip set addr name="%getnic%" source=static addr=%ip% mask=%mask% gateway=%gat%
goto dns
:ai
cls
set getnic=&(for /f "tokens=1-4* delims= " %%a in ('netsh in ip sh in^|findstr /rc:"\<connected\>"^|findstr /v "4294967295"') do if not defined getnic set "getnic=%%e")&call echo %%getnic%%
netsh i ip sh a&echo ..&pause>nul&cls
route print /f&netsh int ip reset&echo ..&pause>nul&cls
netsh i ip set addr name="%getnic%" source=dhcp 2>nul
netsh i ip set dns name="%getnic%" source=dhcp 2>nul
ipconfig /flushdns>nul&netsh in ip reset>nul
echo waiting...
netsh i set i "%getnic%" disabled >nul
netsh i set i "%getnic%" enabled >nul
goto nc
:hlpip
echo;
netsh i ip sh config&pause>nul&goto ips
::-------------------------------------
:nc6
cls
echo        d  dns v6
echo;
echo        a  ip v6
echo;
echo        s  auto v6
echo;
set a=
set /p a=.^|^|
if "%a%" equ "d" goto dns6
if "%a%" equ "a" goto ips6
if "%a%" equ "s" goto ai6
if "%a%" equ "" goto nc
if "%a%" equ "." goto nc
if "%a%" equ "r" goto dir
if "%a%" equ "n" ncpa.cpl&goto nc6
if "%a%" equ "h" goto hwhat6
if "%a%" equ "q" goto gdi
if "%a%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /f>nul&regedit&goto nc6
echo error&pause&goto nc6
::-------------------------------------
:dns6
cls
ipconfig /flushdns>nul
set getnic=&(for /f "tokens=1-4* delims= " %%a in ('netsh in ip sh in^|findstr /rc:"\<connected\>"^|findstr /v "4294967295"') do if not defined getnic set "getnic=%%e")&call echo %%getnic%%
echo;
echo                                       baba 2400:3200::1
echo;
netsh i ipv6 sh dnsservers "%getnic%"|findstr "DNS"
echo;
for /f "tokens=2" %%s in ('cmd /c^|nslookup^|findstr /i "address"') do echo.                                  --^> %%s
echo;
set d=
set /p d=Preferred.a^|^|
if "%d%" equ "" goto sl6
if "%d%" equ "." goto nc6
if "%d%" equ "r" goto nc6
if "%d%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto dns6
if "%d%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\DohWellKnownServers /f>nul&regedit&goto dns6
if "%d%" equ "a" reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v EnableAutoDoH /t reg_dword /d 1 /f&timeout /t 3&goto dns6
if "%d%" equ " " reg delete HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v EnableAutoDoH /f&timeout /t 1 >nul&goto dns6
if "%d%" equ "n" ncpa.cpl&goto dns6
if "%d%" equ "h" goto hdns6
if "%d%" equ "q" goto gdi
if "%d:~6,1%" neq "" goto dn6
echo invalid&pause&goto dns6
:dn6
if "%d%" equ "2400:3200::1" netsh dns add encryption server=%d% dothost=dns.alidns.com
if "%d%" equ "2400:3200:baba::1" (netsh dns add encryption server=%d% dohtemplate=https://dns.alidns.com/dns-query) else (
netsh i ipv6 add dns "%getnic%" %d%)
goto dns6
:sl6
set s=
set /p s=Alternate.^|^|
if "%s%" equ "" goto ips6
if "%s%" equ "." goto dns6
if "%s%" equ "r" goto nc6
if "%s%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto dns6
if "%s%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /f>nul&regedit&goto dns6
if "%s%" equ "h" goto hdns6
if "%s%" equ "q" goto gdi
if "%s:~6,1%" neq "" goto ns6
echo invalid&pause>nul&goto sl6
:ns6
netsh i ipv6 add dns "%getnic%" %s% index=2
goto dns6
:hdns6
echo;
echo curl -v [2400:3200::1]:853
echo tracert -6 -d -w 1000 w3.org
echo;&echo ^>(i)
echo win+i Network^&Internet_Ethernet/Wi-Fi_DNS server assignment
echo ----------------------------------------------------------------------
echo;&curl -v [2400:3200:baba::1]:443
netsh dns sh encryption&pause>nul
netsh i ipv6 sh dnsservers&pause>nul&goto dns6
:ips6
cls
netsh i ipv6 set privacy state=enabled >nul
netsh i ipv6 set global randomizeidentifiers=enabled >nul
set getnic=&(for /f "tokens=1-4* delims= " %%a in ('netsh in ip sh in^|findstr /rc:"\<connected\>"^|findstr /v "4294967295"') do if not defined getnic set "getnic=%%e")&call echo %%getnic%%
echo;
set "ipv6="&for /f "tokens=1* delims=:" %%a in ('ipconfig^|findstr /c:"IPv6 Address"') do if not defined ipv6 for /f "tokens=* delims= " %%c in ("%%b") do set "ipv6=%%c"
if not defined ipv6 for /f "tokens=1* delims=:" %%a in ('netsh i ip sh config^|findstr /c:"IPv6 Address"') do if not defined ipv6 for /f "tokens=* delims= " %%c in ("%%b") do set "ipv6=%%c"
if defined ipv6 (echo %ipv6%) else echo No IPv6 Address
echo;
set "mask="&for /f "tokens=1* delims=:" %%a in ('ipconfig^|findstr /c:"Subnet Mask"') do if not defined mask for /f "tokens=* delims= " %%c in ("%%b") do set "mask=%%c"
if not defined mask for /f "tokens=1* delims=:" %%a in ('netsh i ip sh config^|findstr /c:"Subnet Mask"') do if not defined mask for /f "tokens=* delims= " %%c in ("%%b") do set "mask=%%c"
if defined mask (echo %mask%) else echo No Subnet Mask
echo;
for /f "tokens=1* delims=:" %%a in ('ipconfig /all^|findstr /c:"Default Gateway"') do if "%%b" neq "" for /f "tokens=*" %%c in ("%%b") do if not defined gate if "%%c" neq "" if "%%c" neq "0.0.0.0" set "gate=%%c"
if defined gate (echo %gate%) else echo No Gateway
echo;
for /f "tokens=1* delims=:" %%a in ('netsh wlan sh in 2^>nul^|findstr /i "rate"') do for /f "tokens=* delims= " %%x in ("%%a") do for /f "tokens=* delims= " %%y in ("%%b") do echo %%x : %%y
echo;
:ip6
set ip6=
set /p ip6=ipv6.^|^|
if "%ip6%" equ "" goto ro
if "%ip6%" equ "." goto nc6
if "%ip6%" equ "r" goto nc
if "%ip6%" equ "h" goto hip6
if "%ip6%" equ "n" ncpa.cpl&goto ips6
if "%ip6%" equ "q" goto gdi
if "%ip6%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /f>nul&regedit&goto ips6
if "%ip6:~6,1%" neq "" goto ip6set
echo invalid&pause&goto ips6
:ip6set
for /f "tokens=5 delims=%% " %%a in ('netsh i ipv6 sh addr^|findstr /b /i "Manual"') do netsh i ipv6 delete addr "%getnic%" "%%a"
netsh i ipv6 add addr "%getnic%" "%ip6%"/64
:ro
cls
echo Publish  Type      Met  Prefix                    Idx  Gateway/Interface Name
echo -------  --------  ---  ------------------------  ---  ------------------------
netsh i ipv6 sh ro|find "::/0"
echo;
set ro=
set /p ro=ipv6 gateway^|^|
if "%ro%" equ "" goto dns6
if "%ro%" equ "." goto ips6
if "%ro%" equ "r" goto nc6
if "%ro%" equ "h" goto hro
if "%ro%" equ "q" goto gdi
if "%ro:~6,1%" neq "" goto route
echo invalid&pause&goto ro
:route
for /f "tokens=6 delims= " %%a in ('netsh i ipv6 sh ro^|findstr "::/0"^|findstr /i "Manual"') do netsh i ipv6 delete route ::/0 "%getnic%" "%%a"
netsh i ipv6 add route ::/0 "%getnic%" "%ro%"
timeout /t 3&goto ips6
:hro
echo;
echo netsh i ipv6 sh ro^|find "::/0"
echo route print -6 [-4] [ ]=all
echo;
route print -6
pause>nul&cls&goto ro
:hip6
echo           *: netsh i ipv6 show address level=verbose
echo;
netsh i ipv6 sh addr
pause>nul&goto ips6
:ai6
cls
for /f "tokens=5 delims=%% " %%a in ('netsh i ipv6 sh addr^|findstr /b /i "Manual"') do netsh i ipv6 delete addr "%getnic%" "%%a"
for /f "tokens=6 delims= " %%a in ('netsh i ipv6 sh ro^|findstr "::/0"^|findstr /i "Manual"') do netsh i ipv6 delete route ::/0 "%getnic%" "%%a"
netsh i ipv6 delete destinationcache
netsh i ipv6 set dnsservers "%getnic%" source=dhcp
ipconfig /flushdns>nul&netsh i ipv6 reset>nul
netsh i ipv6 sh a&echo ..&pause>nul&cls
route print -6 /f&netsh int ipv6 reset&echo ..&pause>nul
echo waiting...
netsh i set i "%getnic%" disabled >nul
netsh i set i "%getnic%" enabled >nul
goto nc6
:hwhat6
echo --local addresses,valid only within the local link (fe80–febf)
echo    fe80::1/10 =  fe80:0000:0000:0000:0000:0000:0000:0001 
echo;
echo --Loopback address (local host)
echo    ::1/128    =  0000:0000:0000:0000:0000:0000:0000:0001
echo;
echo --Unique Local Address(ULA),Private local network (fc00–fdff)
echo    fc00::/7   =  fd00:0000:0000:0000:0000:0000:0000:0001
echo;
echo --Unique Pub Global Unicast (2000–3fff)
echo    2000::/3   =  2001:0db8:0000:0000:0000:0000:0000:0001
echo;
pause>nul&goto nc6
::-------------------------------------
:mac
cls&netsh in ip sh in
echo;---------------  ----------------  -----------------  ----------------
:imac
getmac /v&echo;
set getnic=&(for /f "tokens=1-4* delims= " %%a in ('netsh in ip sh in^|findstr /rc:"\<connected\>"^|findstr /v "4294967295"') do if not defined getnic set "getnic=%%e")&call echo %%getnic%% -- ON --
echo;
set a=
set /p "a=mac new.^||"
if "%a%" neq "" set a=%a:~0,18%
if "%a:~0,1%" neq " " if "%a:~11,1%" neq " " if "%a:~11,1%" neq "" if "%a:~17,1%" equ "" goto rma
if "%a%" equ "" goto macview
if "%a%" equ "." goto mac
if "%a%" equ "r" goto nc
if "%a%" equ "n" ncpa.cpl&goto mac
if "%a%" equ "q" goto gdi
if "%a%" equ " " goto recmac
if "%a%" equ "h" goto mactips
if "%a%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto mac
if "%a%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318} /f>nul&regedit&goto mac
echo invalid&pause&goto mac
:recmac
set cuadapter=
set /p cuadapter=AdapterName:
for /f "tokens=7 delims=\" %%m in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Network\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "%cuadapter%"') do (
set c=&for /f "tokens=* delims=\" %%c in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "%%m"^|findstr /r "\\[0-9][0-9][0-9][0-9]$"') do set ed=%%c)
echo %ed%&pause>nul&reg add "%ed%" /v NetworkAddress /d "" /f>nul&goto macview
:rma
for /f "tokens=7 delims=\" %%m in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Network\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "%getnic%"') do (
for /f "tokens=* delims=\" %%c in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "%%m"^|findstr /r "\\[0-9][0-9][0-9][0-9]$"') do echo %%c&timeout /t 1 >nul&reg add "%%c" /v NetworkAddress /d "%a%")
arp /d *>nul
:macview
echo waiting ...
netsh i set i "%getnic%" disabled >nul
netsh i set i "%getnic%" enabled >nul
echo;&echo check network reconnection status,&pause&goto mac
:mactips
echo;
echo BIN(mac=48bit=6bytes):
echo;
echo xX-xx-xx-xx-xx-Xx unicast even number 0 2 4 6 8 A C E    wide unique
echo x1-xx-xx-xx-xx-xx multicast odd number 1 [3 5 7 9 B D F] local unique
echo ff-ff-ff-ff-ff-ff broadcast
echo;
echo xx-xx-xx-  -  -   OUI-CompanyID   https://regauth.standards.ieee.org/standards-ra-web/pub/view.html#registries
echo;
echo HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}
echo;
echo ..&pause>nul&goto mac
::--------------------------------------------------------------------
:str
cls
echo        e       easy cfg
echo;
echo        a       au margin
echo;
echo        s       se border
echo;
echo        c       cons sign
echo;
echo        d       doma shar
echo;
echo        f       file dock
echo;
set d=
set /p d=enter:
if "%d%" equ "" goto dir
if "%d%" equ "." goto dir
if "%d%" equ "r" goto dir
if "%d%" equ "e" goto secpwpolicy
if "%d%" equ "a" goto PMC
if "%d%" equ "s" goto Sockbarr
if "%d%" equ "c" goto Comlogon
if "%d%" equ "d" goto Dolannet
if "%d%" equ "f" goto fs
if "%d%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto str
if "%d%" equ "u" goto tri
if "%d%" equ " " exit
if "%d%" equ "q" goto gdi
pause&goto str

::-------------------------------------
:secpwpolicy
cls
echo ^>psw input rule
echo;
echo [Unicode]>"%~sdp0secpw.inf"
echo Unicode=yes>>"%~sdp0secpw.inf"
echo [System Access]>>"%~sdp0secpw.inf"
echo MinimumPasswordAge = ^0>>"%~sdp0secpw.inf"
echo MaximumPasswordAge = -1>>"%~sdp0secpw.inf"
:spwcomplex
set v=0 1
set d=
set /p d=pwcomplex(0,1)^|n:
if "%d%" equ "." goto cancelcfg
if "%d%" equ "r" goto cancelcfg
if "%d%" equ "" goto spwhisize
if "%d%" equ "n" goto cancelcfg
for %%i in (%v%) do if "%%i" equ "%d%" goto pwcomplex
echo incorrect..&pause>nul&goto spwcomplex
:spwhisize
set off=0
set max=24
set d=
set /p d=pwhistory[0^|~24]:
if "%d%" equ "" goto slogoffexpire
if "%d%" equ "." goto spwcomplex
if "%d%" equ "r" goto spwcomplex
if "%d%" equ "n" goto cancelcfg
set /a p=%d%
if %p% equ %d% if %d% geq %off% if %d% leq %max% goto pwhisize
echo incorrect..&pause>nul&goto spwhisize
:slogoffexpire
set d=
set /p d=hourlogoffexpire [0^|1~6]:
if "%d%" equ "" goto endsec
if "%d%" equ "." goto spwhisize
if "%d%" equ "r" goto spwhisize
if "%d%" equ "n" goto cancelcfg
for /l %%i in (0 1 6) do if %%i equ %d% goto logoffexpire
echo incorrect..&pause>nul&goto slogoffexpire
:pwcomplex
echo PasswordComplexity = "%d%">>"%~sdp0secpw.inf"
goto spwhisize
:pwhisize
echo PasswordHistorySize = "%d%">>"%~sdp0secpw.inf"
goto slogoffexpire
:logoffexpire
echo ForceLogoffWhenHourExpire = "%d%">>"%~sdp0secpw.inf"
:endsec
echo [Version]>>"%~sdp0secpw.inf"
echo signature="$CHICAGO$">>"%~sdp0secpw.inf"
echo Revision=^1>>"%~sdp0secpw.inf"
secedit /configure /db %windir%\security\policy.sdb /cfg "%~sdp0secpw.inf" /areas securitypolicy
:cancelcfg
del "%~sdp0secpw.inf" /f/q

:easysec
cls
echo *below enable to configure more,but LockoutBadCount only gtr n*5 number to take effect&echo;
set d=
set /p d=more secure e/i^|^|
if "%d%" equ "" goto str
if "%d%" equ "." goto str
if "%d%" equ "r" goto dir
if "%d%" equ "e" goto export
if "%d%" equ "i" goto import
if "%d%" equ "h" goto sechelp
echo incorrect..&pause>nul&goto easysec
:export
secedit /export /cfg "%~dp0policy.inf"&explorer.exe "%~dp0policy.inf"
echo;
echo you can to current directory edit policy.inf file
echo ...
echo press anykey import policy.inf file after edited..&pause>nul
:import
secedit /configure /db %windir%\security\policy.sdb /cfg "%~dp0policy.inf" /areas securitypolicy&echo;
set d=
set /p d=save cfg? 
if "%d%" equ "" goto delcfg
if "%d%" equ "." goto easysec
if "%d%" equ "r" goto secpwpolicy
if "%d%" equ "n" goto delcfg
if "%d%" equ "y" goto dir
echo incorrect..&pause
:delcfg
del "%~dp0policy.inf" /f /q 2>nul
goto str
:sechelp
echo;
echo   /areas  Specifies security areas to be applied to system,If not specified that all defined datebase should be applied to system
echo;
echo   /overwrite  refresh early existed policy
echo;
echo   secedit /configure  syntax help
echo;
echo   MaximumPasswordAge -console local:
echo;
echo   [42]default
echo;
echo   0-unlimited (-1 enable take effect to shown 0)
echo;
echo   *otherwise MaximumPasswordAge if ^<=0,occurd import error
echo;
echo   _ _ _ _ _ _
echo   MinimumPasswordAge -local:
echo;
echo   [1]default on domain controllers
echo;
echo   [0]default on stand-alone servers
echo;
echo   if MaximumPasswordAge set to 0,MinimumPasswordAge enable set range:[0~998]days
echo;
pause>nul&goto easysec

::-------------------------------------
:PMC
cls
set d=0 1
for /f "skip=2 tokens=* delims= " %%i in ('reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoPropertiesMyComputer 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto setPMC)
echo %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer&echo;
:setPMC
set dw=
set /p dw=NoPropertiesMyComputer)
if "%dw%" equ "" goto property
if "%dw%" equ "." goto str
if "%dw%" equ "r" goto dir
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto defPMC
for %%i in (%d%) do if "%dw%" equ "%%i" goto regPMC
echo error&pause&goto PMC
:regPMC
reg query HKU\S-1-5-19\Environment >nul 2>&1
if errorlevel 1 echo The requested operation requires elevation to administrator..&pause>nul&goto PMC
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoPropertiesMyComputer /t reg_dword /d %dw% /f>nul
goto PMC
:defPMC
reg query HKU\S-1-5-19\Environment >nul 2>&1
if errorlevel 1 echo The requested operation requires elevation to administrator..&pause>nul&goto PMC
reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoPropertiesMyComputer >nul 2>&1
if errorlevel 1 goto PMC
reg delete %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoPropertiesMyComputer /f>nul
goto PMC
:property
set a=
set /p a=open?
if "%a%" equ "" goto NDTAR
if "%a%" equ "." goto PMC
if "%a%" equ "r" goto str
if "%a%" equ "q" goto gdi
if "%a%" equ "y" sysdm.cpl&goto PMC
if "%a%" equ "n" goto NDTAR
echo error&pause&goto property

:NDTAR
cls
echo ---------------------------------------------
echo unKnow       1            notLetter      2
echo USB/FDD      4            HD             8
echo;
echo netMapped 16{10}          CD          32{20}
echo RAMdrive  64{40}          Reserved   128{80}
echo;
echo input dec:  91  95  145  149  181  223  255
echo shown hex: {5b  5f   91   95   b5   df   ff}
echo _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
echo;
set s=0 1 255
for /f "tokens=3 delims= " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun 2^>nul') do (
for /l %%s in (%s%) do if %%s equ %%i echo %%i   LM
for /l %%s in (%s%) do if %%s gtr 255 echo %%i?  LM
)
for /f "tokens=3 delims= " %%i in ('reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers /v DisableAutoplay 2^>nul') do (
for /l %%s in (%s%) do if %%s equ %%i echo %%i   APlay
for /l %%s in (%s%) do if %%s gtr 255 echo %%i?  APlay
)
echo;
set dw=
set /p dw=(NoDriveTypeAutoRun.^|^|
if "%dw%" equ "" goto wifiMig
if "%dw%" equ "." goto PMC
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptLMndtar
if "%dw%" equ "  " goto eptAPlay
if "%dw%" equ "h" goto hNDTAR
if "%dw%" equ ".." %lstky% %cid%\Software\Microsoft\Windows\CurrentVersion\Policies /f>nul&regedit&cls&goto NDTAR
for /l %%i in (%s%) do if "%dw%" equ "%%i" goto regLMndr
for /l %%i in (%s%) do if "%dw%" equ "0%%i" goto regAPlay
echo error&pause&goto NDTAR
:hNDTAR
echo;
echo Index level 64bit 128bit
echo;
echo 1+16+2+8+64          91  [ cd usb/fdd            ]
echo 1+16+2+8+64+4        95  [ cd                    ]
echo 1+16+128             145 [ cd usb/fdd hd unLetter]
echo 1+16+128+4           149 [ cd         hd unLetter]
echo 1+16+128+4+32        181 [            hd unLetter]
echo 1+16+128+4+2+8+64    223 [ cd                    ]
echo 1+16+128+4+2+8+64+32 255 [     none auto run     ]
echo;
pause>nul&goto NDTAR
:regLMndr
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun /t reg_dword /d %dw% /f>nul
goto NDTAR
:regAPlay
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers /v DisableAutoplay /t reg_dword /d %dw% /f>nul
goto NDTAR
:eptLMndtar
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDriveTypeAutoRun /f>nul
goto NDTAR
:eptAPlay
reg delete %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers /v DisableAutoplay /f>nul
goto NDTAR

:wifiMig
cls
echo wifiMig [316 0]
reg query HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features /s 2>nul
echo;
set v=
set /p v=FeatureStates. 
if "%v%" equ "" goto CA
if "%v%" equ "." goto NDTAR
if "%v%" equ "r" goto str
if "%v%" equ "q" goto gdi
if "%v%" equ " " goto eptwiMig
if "%v%" equ ".." %lstky% HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features /f>nul&regedit&goto wifiMig
for /l %%i in (0 1 316) do if "%%i" equ "%v%" goto regwifiMig
echo error&pause&goto wifiMig
:regwifiMig
for /f %%a in ('reg query "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features"^|find "S-1" 2^>nul') do reg delete %%a /va /f>nul&reg add %%a /v FeatureStates /t reg_dword /d %v% /f>nul
goto wifiMig
:eptwiMig
for /f %%a in ('reg query "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features"^|find "S-1" 2^>nul') do reg delete %%a /va /f>nul
goto wifiMig

:CA
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query %cid%\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios /v Value 2^>nul') do (
if errorlevel 0 echo Radios %%i&echo;&goto setCA)
:setCA
set sz=
set /p sz=activity.Allow Prompt^|raDeny[]
if "%sz%" equ "" goto aps
if "%sz%" equ "." goto wifiMig
if "%sz%" equ "r" goto str
if "%sz%" equ "q" goto gdi
if "%sz%" equ " " set "sz="&goto regRA
if "%sz%" equ ".." %lstky% %cid%\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore /f>nul&regedit&goto CA
for %%i in (Prompt Allow Deny) do if /i "%%i" equ "%sz%" goto regCA
for %%i in (raAllow raDeny) do if /i "%%i" equ "%sz%" set sz=%sz:ra=%&goto regRA
echo error&pause&goto CA
:regCA
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity /v Value /d "%sz%" /f>nul
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity /v Value /d "" /f>nul
goto CA
:regRA
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios /v Value /d "%sz%" /f>nul
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios /v Value /d "%sz%" /f>nul
goto CA
:aps
echo;&set s=
set /p s=LM-Allow Deny.a^|cuAllow cuDeny
if "%s%" equ "" goto PDR
if "%s%" equ "." goto CA
if "%s%" equ "r" goto str
if "%s%" equ "q" goto gdi
if "%s%" equ "a" goto defLMAps
if "%s%" equ ".." %lstky% HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity /f>nul&regedit&goto aps
for %%i in (Allow Deny) do if "%s%" equ "%%i" goto LMAps
for %%i in (cuAllow cuDeny) do if /i "%s%" equ "%%i" set s=%s:cu=%&goto CUps
echo error&pause&goto aps
:LMAps
for /f "eol=E" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore /s /f "Value"^|findstr /r "HKEY"') do if "%%i" neq "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" if "%%i" neq "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" reg add %%i /v Value /d %s% /f>nul 2>&1
goto aps
:CUps
for /f "eol=E" %%i in ('reg query "%cid:HKU=HKEY_USERS%\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore" /s /f "Value"^|findstr /r "HKEY"') do if "%%i" neq "%cid:HKU=HKEY_USERS%\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" if "%%i" neq "%cid:HKU=HKEY_USERS%\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" reg add %%i /v Value /d %s% /f>nul 2>&1
for /f "eol=E" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore /s /f "Value"^|findstr /r "HKEY"') do if "%%i" neq "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" if "%%i" neq "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" reg add %%i /v Value /d %s% /f>nul 2>&1
goto aps
:defLMAps
for /f "eol=E" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore /s /f "Value"^|findstr /r "HKEY"') do if "%%i" neq "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" if "%%i" neq "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" reg add %%i /v Value /d Allow /f>nul
echo;&echo HKLM CapabilityAccess reverted to Allow,CurrentUser GUI dash toggle is enabled&pause>nul&goto aps

:PDR
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto setPDR)
echo [0] HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata&echo;
:setPDR
set dw=
set /p dw=PreventDeviceMetadataFromNetwork:
if "%dw%" equ "" goto AutoNetSet
if "%dw%" equ "." goto CA
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptPDR
for %%i in (0 1) do if "%dw%" equ "%%i" goto regPDR
echo error&pause&goto PDR
:regPDR
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t reg_dword /d %dw% /f>nul
goto PDR
:eptPDR
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /f>nul
goto PDR

:AutoNetSet
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private /v AutoSetup 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sANS)
echo HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private&echo;
:sANS
set dw=
set /p dw=Ncd_AutoSetup)
if "%dw%" equ "" goto DTEL
if "%dw%" equ "." goto PDR
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto dfAANS
for %%i in (0 1 2 3) do if "%dw%" equ "%%i" goto regAutoNetSet
echo error&pause&goto AutoNetSet
:regAutoNetSet
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private /v AutoSetup /t reg_dword /d %dw% /f>nul
goto AutoNetSet
:dfAANS
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private /v AutoSetup /f>nul
goto AutoNetSet

:DTEL
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v LimitDiagnosticLogCollection 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto ATel)
echo LimitDiagnosticLogCollection&echo;
:ATel
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v AllowTelemetry 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto MaxTelemetryAllowed)
echo AllowTelemetry&echo;
:MaxTelemetryAllowed
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v MaxTelemetryAllowed 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sDTEL)
echo MaxTelemetryAllowed&echo;
:sDTEL
set dw=
set /p dw=(DataCollection):
if "%dw%" equ "" goto str
if "%dw%" equ "." goto AutoNetSet
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto emptyMaxTel
for %%i in (0 1 2 3) do if "%dw%" equ "%%i" goto regsTel
echo error&pause&goto DTEL
:regsTel
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v LimitDiagnosticLogCollection /t reg_dword /d %dw% /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v AllowTelemetry /t reg_dword /d 0 /f>nul 2>&1
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v MaxTelemetryAllowed /f>nul 2>&1
goto DTEL
:emptyMaxTel
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v LimitDiagnosticLogCollection /f>nul 2>&1
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v AllowTelemetry /t reg_dword /d 0 /f>nul 2>&1
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v MaxTelemetryAllowed /f>nul 2>&1
goto DTEL
::-------------------------------------
:Sockbarr
cls
echo barriersPol
set Volatile=2
set default=0
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\PolicyApplicationState"
for /f "tokens=3 delims= " %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\PolicyApplicationState"') do (
if %%i equ %Volatile% echo                                Volatile
if %%i equ %default% echo                                 default
)
:ncc
set s=
set /p s=GPLstate.
if "%s%" equ "" goto NCU
if "%s%" equ "." goto DTEL
if "%s%" equ "r" goto str
if "%s%" equ "q" goto gdi
if "%s%" equ ".." %lstky% "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\DataStore" /f>nul&regedit&goto Sockbarr
echo error&pause&goto Sockbarr

:NCU
cls
set d=0 1 2 3
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v NoConnectedUser 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto setNCU)
echo MS Accouts HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System&echo;
:setNCU
set dw=
set /p dw=NoConnectedUser)^|^|
if "%dw%" equ "" goto AIGA
if "%dw%" equ "." goto Sockbarr
if "%dw%" equ "r" goto str
if "%dw%" equ "h" goto hNCU
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto defload
for %%i in (%d%) do if "%dw%" equ "%%i" goto regNCU
echo error&pause&goto NCU
:regNCU
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v NoConnectedUser /t reg_dword /d %dw% /f>nul
goto NCU
:defload
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v NoConnectedUser /f>nul
goto NCU
:hNCU
echo;
echo []0 allow Behavior   1 backbypass   3 enable idle   2 develop
pause>nul&goto NCU

:AIGA
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation /v AllowInsecureGuestAuth 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto setAIGA)
echo HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation&echo;
:setAIGA
set dw=
set /p dw=AllowInsecureGuestAuth).
if "%dw%" equ "" goto alsoAIGA
if "%dw%" equ "." goto NCU
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto defregAIGA
if "%dw%" equ ".." %lstky% HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation /f>nul&regedit&goto AIGA
for %%i in (0 1) do if "%dw%" equ "%%i" goto regAIGA
echo error&pause&goto AIGA
:regAIGA
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation /v AllowInsecureGuestAuth /t reg_dword /d %dw% /f>nul
goto AIGA
:defregAIGA
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation /v AllowInsecureGuestAuth /f>nul
goto AIGA
:alsoAIGA
set s=
set /p s=also gpedt?^|^|
if "%s%" equ "" goto NC_PFC
if "%s%" equ "." goto AIGA
if "%s%" equ "r" goto str
if "%s%" equ "y" gpedit&goto AIGA
if "%s%" equ "n" goto AIGA
if "%s%" equ "h" goto hAIGA
echo error&pause&goto alsoAIGA
:hAIGA
echo;
echo gpedit.msc_administrativetemplates_network_lanmanworkstation
pause>nul&goto AIGA

:NC_PFC
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Network Connections" /v NC_PersonalFirewallConfig 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto setNC)
echo NC_PersonalFirewallConfig HKLM\SOFTWARE\Policies\Microsoft\Windows\Network Connections&echo;
:setNC
set dw=
set /p dw=NC_PersonalFirewallConfig^|^|
if "%dw%" equ "" goto EC
if "%dw%" equ "." goto AIGA
if "%dw%" equ "r" goto str 
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptNC_PFC
if "%dw%" equ "h" goto hlpNC_P
for %%i in (0 1 2) do if "%dw%" equ "%%i" goto regNC_PFC
echo error&pause&goto NC_PFC
:regNC_PFC
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Network Connections" /v NC_PersonalFirewallConfig /t reg_dword /d %dw% /f>nul
goto NC_PFC
:eptNC_PFC
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Network Connections" /v NC_PersonalFirewallConfig /f>nul
goto NC_PFC
:hlpNC_P
echo;
echo [0] disable    1 enable
pause>nul&goto NC_PFC

:EC
cls
set m=0
set d=0 1 2 3
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\System /v EnableCdp 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto setEC)
echo HKLM\SOFTWARE\Policies\Microsoft\Windows\System&echo;
:setEC
set dw=
set /p dw=EnableCdp).^|^|
if "%dw%" equ "" goto AU
if "%dw%" equ "." goto NC_PFC
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto defEC
if "%dw%" equ "h" goto hlpEC
if "%dw%" equ ".." %lstky% HKLM\SOFTWARE\Policies\Microsoft\Windows\System /f>nul&regedit&goto EC
for %%i in (%d%) do if "%dw%" equ "%%i" goto regEC
echo error&pause&goto EC
:regEC
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\System /v EnableCdp /t reg_dword /d %dw% /f>nul&goto EC
:defEC
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\System /v EnableCdp /f>nul
goto EC
:hlpEC
echo;
echo []1 enabled   0 backbypass   3 enable idle
pause>nul&goto EC

:AU
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings /v DownloadMode') do (
if errorlevel 0 echo %%i&echo;&goto sAU)
echo HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings&echo;
:sAU
set dw=
set /p dw=DownloadMode):
if "%dw%" equ "" goto str
if "%dw%" equ "." goto EC
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto defAU
for %%i in (0 1) do if "%dw%" equ "%%i" goto regAU
echo error&pause&goto AU
:regAU
reg add HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings /v DownloadMode /t reg_dword /d %dw% /f>nul
goto AU
:defAU
reg delete HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings /v DownloadMode /f>nul
goto AU

::-------------------------------------
:Comlogon
cls
echo NTlogon&lusrmgr 2>nul
echo;
:signon
for /f "tokens=7 delims=\" %%i in ('reg query "%nt%\ProfileList" 2^>nul') do echo %%i
echo;
echo %nt%\ProfileList
echo;
set h=
set /p h=PolicyList.^^
if "%h%" equ "" goto ALS
if "%h%" equ "." goto AU
if "%h%" equ "r" goto str
if "%h%" equ "q" goto gdi
if "%h%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto Comlogon
if "%h%" equ ".." %lstky% "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy" /f>nul&regedit&cls&goto signon
echo error&pause&cls&goto Comlogon

:ALS
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "%nt%\Winlogon" /v AutoLogonSID 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sHiber)
echo sid %nt%\Winlogon&echo;
:sHiber
set sz=
set /p sz=AutoLogonSID).
if "%sz%" equ "" goto CLC
if "%sz%" equ "." goto Comlogon
if "%sz%" equ "r" goto str
if "%sz%" equ "q" goto gdi
if "%sz%" equ " " goto emptyALS
if "%sz%" equ ".." %lstky% "%nt%\Winlogon" /f>nul&regedit&cls&goto ALS
if "%sz:~0,8%" equ "S-1-5-21" if "%sz:~44,1%" equ "" goto regALS
echo nopro&pause&goto ALS
:regALS
reg add "%nt%\Winlogon" /v AutoLogonSID /d "%sz%" /f>nul
goto ALS
:emptyALS
reg delete "%nt%\Winlogon" /v AutoLogonSID /f>nul
goto ALS

:CLC
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "%nt%\Winlogon" /v CachedLogonsCount 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sCLC)
echo 10 %nt%\Winlogon&echo;
:sCLC
set sz=
set /p sz=CachedLogonsCount.
if "%sz%" equ "" goto DefU
if "%sz%" equ "." goto ALS
if "%sz%" equ "r" goto str
if "%sz%" equ "q" goto gdi
if "%sz%" equ " " goto empCLC
if "%sz%" equ ".." %lstky% "%nt%\Winlogon" /f>nul&regedit&cls&goto CLC
for /l %%i in (0 1 10) do if "%%i" equ "%sz%" goto regCLC
echo error&pause&goto CLC
:regCLC
reg add "%nt%\Winlogon" /v CachedLogonsCount /d "%sz%" /f>nul
goto CLC
:empCLC
reg delete "%nt%\Winlogon" /v CachedLogonsCount /f>nul
goto  CLC

:DefU
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "%nt%\Winlogon" /v DefaultUserName 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sDefU)
echo /Windows %nt%\Winlogon&echo;
:sDefU
set sz=
set /p sz=DefaultUserName).
if "%sz%" equ "" goto DLW
if "%sz%" equ "." goto CLC
if "%sz%" equ "r" goto str
if "%sz%" equ "q" goto gdi
if "%sz%" equ " " goto emptyDefU
if "%sz%" equ ".." %lstky% "%nt%\Winlogon" /f>nul&regedit&cls&goto DefU
for /f "delims=\/[]:|<>+=;,?*@" %%i in ("%sz%") do set DefU=%%~i
if "%DefU:~0,1%" neq " " if "%DefU:~20,1%" equ "" for /f "tokens=* delims= " %%i in ("%DefU%") do set lu=%%~nxi&goto regDefU
echo error&pause&goto DefU
:regDefU
reg add "%nt%\Winlogon" /v DefaultUserName /d "%lu:"=%" /f>nul
reg add "%nt%\Winlogon" /v DefaultUserName /d "%lu:"=%" /f>nul
goto DefU
:emptyDefU
reg delete "%nt%\Winlogon" /v DefaultUserName /f>nul
goto DefU

:DLW
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "%nt%\Winlogon" /v DisableLockWorkstation 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sDLW)
echo /[] %nt%\Winlogon&echo;
:sDLW
set dw=
set /p dw=DisableLockWorkstation.
if "%dw%" equ "" goto LUU
if "%dw%" equ "." goto DefU
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto emptyDLW
if "%dw%" equ ".." %lstky% "%nt%\Winlogon" /f>nul&regedit&cls&goto DLW
for %%i in (0 1) do if "%%i" equ "%dw%" goto regDLW
echo error&pause&goto DLW
:regDLW
reg add "%nt%\Winlogon" /v DisableLockWorkstation /t reg_dword /d %dw% /f>nul
goto DLW
:emptyDLW
reg delete "%nt%\Winlogon" /v DisableLockWorkstation /f>nul
goto DLW

:LUU
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "%nt%\Winlogon" /v LastUsedUsername 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sLUU)
echo /Windows %nt%\Winlogon&echo;
:sLUU
set sz=
set /p sz=LastUsedUsername).
if "%sz%" equ "" goto PEW
if "%sz%" equ "." goto DLW
if "%sz%" equ "r" goto str
if "%sz%" equ "q" goto gdi
if "%sz%" equ " " goto emptyLUU
if "%sz%" equ ".." %lstky% "%nt%\Winlogon" /f>nul&regedit&cls&goto LUU
for /f "delims=\/[]:|<>+=;,?*@" %%i in ("%sz%") do set luu=%%~i
if "%luu:~0,1%" neq " " if "%luu:~20,1%" equ "" for /f "tokens=* delims= " %%i in ("%luu%") do set lu=%%~nxi&goto regLUU
echo error&pause&goto LUU
:regLUU
reg add "%nt%\Winlogon" /v LastUsedUsername /d "%lu:"=%" /f>nul
goto LUU
:emptyLUU
reg delete "%nt%\Winlogon" /v LastUsedUsername /f>nul
goto LUU

:PEW
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "%nt%\Winlogon" /v PasswordExpiryWarning 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sPEW)
echo %nt%\Winlogon&echo;
:sPEW
set dw=
set /p dw=PasswordExpiryWarning.^|^|
if "%dw%" equ "" goto PCKF
if "%dw%" equ "." goto LUU
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptPEW
if "%dw%" equ "h" goto hlpPEW
if "%dw%" equ ".." %lstky% "%nt%\Winlogon" /f>nul&regedit&cls&goto PEW
for /l %%i in (0 1 35) do if "%%i" equ "%dw%" goto regPEW
echo error&pause&goto PEW
:regPEW
reg add "%nt%\Winlogon" /v PasswordExpiryWarning /t reg_dword /d %dw% /f>nul
goto PEW
:eptPEW
reg delete "%nt%\Winlogon" /v PasswordExpiryWarning /f>nul
goto PEW
:hlpPEW
echo;
echo   determines local user receives warning before password expiration
echo;
echo   [5] default days,prompt before expiration
echo   [0] no prompt
echo;
echo   Domain policy precedence over local policy
echo;
pause>nul&goto PEW

:PCKF
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "%nt%\Winlogon" /v PreCreateKnownFolders 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sPCKF)
echo %nt%\Winlogon&echo;
:sPCKF
set sz=
set /p sz=PreCreate(Libraries) d^|a.^|^|
if "%sz%" equ "" goto WSD
if "%sz%" equ "." goto PEW
if "%sz%" equ "r" goto str
if "%sz%" equ "q" goto gdi
if "%sz%" equ " " goto eptPCKF
if "%sz%" equ "d" goto delPCKF
if "%sz%" equ "a" goto recPCKF
if "%sz%" equ "h" goto notePCKF
if "%sz%" equ ".." %lstky% "%nt%\Winlogon" /f>nul&regedit&cls&goto PCKF
echo error&pause&goto PCKF
:delPCKF
reg add "%nt%\Winlogon" /v PreCreateKnownFolders /d "" /f>nul
reg add %cid%\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f>nul
goto PCKF
:recPCKF
reg add %cid%\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 1 /f>nul
reg add "%nt%\Winlogon" /v PreCreateKnownFolders /d "{A520A1A4-1780-4FF6-BD18-167343C5AF16}" /f>nul
goto PCKF
:eptPCKF
reg delete %cid%\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5} /v System.IsPinnedToNameSpaceTree /f>nul
reg delete "%nt%\Winlogon" /v PreCreateKnownFolders /f>nul
goto PCKF
:notePCKF
echo;
echo also do this:
echo Pin UsersLibraries.{031E4825-7B94-4dc3-B131-E946B44C8DD5} to HKCU NameSpace Tree
pause>nul&goto PCKF

:WSD
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query "%nt%\Winlogon" /v WinStationsDisabled 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sWSD)
echo 0# %nt%\Winlogon&echo;
:sWSD
set sz=
set /p sz=WinStationsDisabled.(Pinned_Pic)^^^|^|
if "%sz%" equ "" goto str
if "%sz%" equ "." goto PCKF
if "%sz%" equ "r" goto str
if "%sz%" equ "q" goto gdi
if "%sz%" equ " " goto eptWSD
if "%sz%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto WSD
if "%sz%" equ ".." %lstky% "%nt%\Winlogon" /f>nul&regedit&cls&goto wsd
if "%sz%" equ "0" goto regWSD
if "%sz%" equ "00" goto disHom
if "%sz%" equ "1" reg add %cid%\Software\Classes\CLSID\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 1 /f>nul&goto WSD
if "%sz%" equ "2" reg add %cid%\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 1 /f>nul&goto WSD
if "%sz%" equ "3" goto regrev
if "%sz%" equ "h" goto reghel
echo error&pause&goto WSD
:regWSD
for /f "eol=E delims=" %%i in ('reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace /f * /k 2^>nul') do reg delete "%%i" /f>nul 2>&1
reg add %cid%\Software\Classes\CLSID\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f>nul
reg add %cid%\Software\Classes\CLSID\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 1 /f>nul
reg add %cid%\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f>nul
:regrev
reg add %cid%\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 1 /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5} /ve /d "UsersLibraries" /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA} /ve /d "CLSID_ThisPCMyPicturesRegFolder" /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641} /ve /d "Desktop" /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C} /ve /d "Computers and Devices" /f>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903} /ve /d "CLSID_MSGraphHomeFolder" /f>nul
reg add "%nt%\Winlogon" /v WinStationsDisabled /d "%sz%" /f>nul
goto WSD
:disHom
reg add %cid%\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903} /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f>nul
reg add "%nt%\Winlogon" /v WinStationsDisabled /d "%sz%" /f>nul
goto WSD
:eptWSD
for /f "eol=E delims=" %%i in ('reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace /f * /k 2^>nul') do reg delete "%%i" /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace /f * /k 2^>nul') do reg delete "%%i" /f>nul 2>&1
reg delete "%nt%\Winlogon" /v WinStationsDisabled /f>nul
goto WSD
:reghel
echo;
echo 0-home,desk   00-hide home   3-revert home
echo 1-PicFolder   2-networkAccess
pause>nul&goto WSD
::-------------------------------------
:Dolannet
cls
echo LsaTakeover&echo;
:ddc
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v disabledomaincreds 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sddc)
echo HKLM\SYSTEM\CurrentControlSet\Control\Lsa&echo;
:sddc
set dw=
set /p dw=disabledomaincreds.^|^|
if "%dw%" equ "" goto fg
if "%dw%" equ "." goto WSD
if "%dw%" equ "r" goto str
if "%dw%" equ "h" goto hddc
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptddc
if "%dw%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Control\Lsa /f>nul&regedit&cls&goto Dolannet
for %%i in (0 1) do if "%dw%" equ "%%i" goto regddc
echo error&pause&goto Dolannet
:regddc
reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v disabledomaincreds /t reg_dword /d %dw% /f>nul
echo restart computer for the new setting to take effect,restart now?&goto effdocreds
:eptddc
reg delete HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v disabledomaincreds /f>nul
goto Dolannet
:hddc
echo;
echo %nt%\SecEdit\Reg Values&pause>nul&goto Dolannet
:effdocreds
set a=
set /p a=restart?
if "%a%" equ "y" goto restart
if "%a%" equ "n" goto fg
if "%a%" equ "" goto fg
if "%a%" equ "." goto Dolannet
if "%a%" equ "r" goto str
echo error&pause&goto effdocreds

:fg
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v forceguest 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sfg)
echo HKLM\SYSTEM\CurrentControlSet\Control\Lsa&echo;
:sfg
set dw=
set /p dw=forceguest.
if "%dw%" equ "" goto anony
if "%dw%" equ "." goto Dolannet
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptfg
if "%dw%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Control\Lsa /f>nul&regedit&cls&goto fg
for %%i in (0 1) do if "%dw%" equ "%%i" goto regfg
echo error&pause&goto fg
:regfg
reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v forceguest /t reg_dword /d %dw% /f>nul
goto fg
:eptfg
reg delete HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v forceguest /f>nul
goto fg

:anony
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v restrictanonymous 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sanony)
echo HKLM\SYSTEM\CurrentControlSet\Control\Lsa&echo;
:sanony
set dw=
set /p dw=restrictanonymous.
if "%dw%" equ "" goto RAS
if "%dw%" equ "." goto fg
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptanony
if "%dw%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Control\Lsa /f>nul&regedit&cls&goto anony
for %%i in (0 1) do if "%dw%" equ "%%i" goto reganony
echo error&pause&goto anony
:reganony
reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v restrictanonymous /t reg_dword /d %dw% /f>nul
goto anony
:eptanony
reg delete HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v restrictanonymous /f>nul
goto anony

:RAS
cls
echo Remote Assistance
echo;
for /f "skip=2 tokens=* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto qfaC)
echo HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance&echo;
:qfaC
for /f "skip=2 tokens=* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowFullControl 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto qfaCc)
echo []fAllowFullControl HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance&echo;
:qfaCc
for /f "skip=2 tokens=* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fEnableChatControl 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sAssisHelp)
echo []fEnableChatControl HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance&echo;
:sAssisHelp
set dw=
set /p dw=fAllowToGetHelp.^^^|^|
if "%dw%" equ "" goto sFullCtrl
if "%dw%" equ "." goto anony
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptRAS
if "%dw%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto RAS
if "%dw%" equ ".." %lstky% "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /f>nul&regedit&goto RAS
for %%i in (0 1) do if "%dw%" equ "%%i" goto regGetHelp
if "%dw%" equ "h" goto hlpRAS
echo error&pause&goto RAS
:sFullCtrl
set dw=
set /p dw=fAllowFullControl.^^^|^|
if "%dw%" equ "" goto TSC
if "%dw%" equ "." goto RAS
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptRAS
if "%dw%" equ "h" goto hlpRAS
if "%dw%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto RAS
if "%dw%" equ ".." %lstky% "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /f>nul&regedit&goto RAS
for %%i in (0 1) do if "%dw%" equ "%%i" goto regFullCtrl
if "%dw%" equ "h" goto hlpRAS
echo error&pause&goto RAS
:regGetHelp
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t reg_dword /d %dw% /f>nul
goto RAS
:regFullCtrl
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowFullControl /t reg_dword /d %dw% /f>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fEnableChatControl /t reg_dword /d %dw% /f>nul
goto RAS
:eptRAS
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowFullControl /f>nul
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fEnableChatControl /f>nul
goto RAS
:eptGetH
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /f>nul
goto RAS
:hlpRAS
echo;&echo;
echo default duration [6 h]
echo;
echo reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v MaxTicketExpiry /t reg_dword /d 15 /f
echo;
echo reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v MaxTicketExpiryUnits /t reg_dword /d 0 /f
echo;
echo [0-m 1-h 2-d]&pause>nul&goto RAS

:TSC
cls
echo Terminal TS-3389&echo;
for /f "skip=2 tokens=* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto qDenyTS)
echo HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server&echo;
:qDenyTS
for /f "skip=2 tokens=* delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sTSkey)
echo HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp&echo;
:sTSkey
set dw=
set /p dw=fDenyTSConnections.
if "%dw%" equ "" goto sUserAuth
if "%dw%" equ "." goto RAS
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptTSC
if "%dw%" equ ".." %lstky% "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /f>nul&regedit&goto TSC
for %%i in (0 1) do if "%dw%" equ "%%i" goto regTSkey
echo error&pause&goto TSC
:sUserAuth
set dw=
set /p dw=UserAuthentication.
if "%dw%" equ "" goto LsaLogonIO
if "%dw%" equ "." goto TSC
if "%dw%" equ "r" goto RAS
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptTSC
if "%dw%" equ ".." %lstky% "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /f>nul&regedit&goto TSC
for %%i in (0 1) do if "%dw%" equ "%%i" goto UserAuth
echo error&pause&goto TSC
:regTSkey
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t reg_dword /d %dw% /f>nul
goto TSC
:UserAuth
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t reg_dword /d %dw% /f>nul
goto TSC
:eptTSC
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication >nul 2>&1
if errorlevel 1 goto eptDenyTS
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /f>nul
:eptDenyTS
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections >nul 2>&1
if errorlevel 1 goto TSC
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /f>nul
goto TSC

::-------------------------------------
:LsaLogonIO
cls
echo MSshare lanmanserver
echo;
:ADc
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoDisconnect 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sADc)
echo []^< HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters&echo;
:sADc
set dw=
set /p dw=AutoDisconnect.^|^|
if "%dw%" equ "" goto hid
if "%dw%" equ "." goto TSC
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptADc
if "%dw%" equ "h" goto hlpADc
if "%dw%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f>nul&regedit&cls&goto LsaLogonIO
for /l %%i in (0 1 300) do if "%dw%" equ "%%i" goto regADc
echo error&pause&goto LsaLogonIO
:regADc
reg add HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoDisconnect /t reg_dword /d %dw% /f>nul
goto LsaLogonIO
:eptADc
reg delete HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoDisconnect /f>nul 2>&1
goto LsaLogonIO
:hlpADc
echo;
echo   [0xf] 15minutes for servers(for all versions)
echo   [] workstaton undefined(Recommended)
echo   [0] as quickly as or more reconnections
pause>nul&goto LsaLogonIO

:hid
cls
set d=1
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v hidden 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sHid)
echo HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters&echo;
:sHid
set dw=
set /p dw=hidden).
if "%dw%" equ "" goto AuShWks
if "%dw%" equ "." goto LsaLogonIO
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto defhid
if "%dw%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f>nul&regedit&cls&goto hid
for %%i in (%d%) do if "%dw%" equ "%%i" goto reghid
echo error&pause&goto hid
:reghid
reg add HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v hidden /t reg_dword /d %dw% /f>nul
goto hid
:defhid
reg delete HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v hidden /f>nul
goto hid

:AuShWks
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoShareWks 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sAuShWks)
echo HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters&echo;
:sAuShWks
set dw=
set /p dw=AutoShareWks).
if "%dw%" equ "" goto str
if "%dw%" equ "." goto hid
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptAuShWks
if "%dw%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f>nul&regedit&cls&goto AuShWks
for %%i in (0 1) do if "%dw%" equ "%%i" goto regAuShWks
echo error&pause&goto AuShWks
:regAuShWks
reg add HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoShareWks /t reg_dword /d %dw% /f>nul
goto AuShWks
:eptAuShWks
reg delete HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoShareWks /f>nul
goto AuShWks

:DPC
cls
echo netLonon
echo;
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v DisablePasswordChange 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sDPC)
echo [0] HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters&echo;
:sDPC
set dw=
set /p dw=DisablePasswordChange.
if "%dw%" equ "" goto MPA
if "%dw%" equ "." goto AuShWks
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ " " goto eptDPC
if "%dw%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /f>nul&regedit&cls&goto dpc
for %%i in (0 1) do if "%dw%" equ "%%i" goto regDPC
echo error&pause&goto DPC
:regDPC
reg add HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v DisablePasswordChange /t reg_dword /d %dw% /f>nul
goto DPC
:eptDPC
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v DisablePasswordChange /f>nul
goto DPC

:MPA
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v MaximumPasswordAge 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sMPA)
echo HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters&echo;
:sMPA
set dw=
set /p dw=MaximumPasswordAge.^|^|
if "%dw%" equ "." goto DPC
if "%dw%" equ "r" goto str
if "%dw%" equ "q" goto gdi
if "%dw%" equ "" goto Upd
if "%dw%" equ " " goto eptMPA
if "%dw%" equ "h" goto hlpMPA
if "%dw%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /f>nul&regedit&cls&goto MPA
for /l %%i in (0 1 105) do if "%dw%" equ "%%i" goto regMPA
echo error&pause&goto MPA
:regMPA
reg add HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v MaximumPasswordAge /t reg_dword /d %dw% /f>nul
goto MPA
:eptMPA
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v MaximumPasswordAge /f>nul
goto MPA
:hlpMPA
echo;
echo   domain member Machine account password period of time(automated updates)
echo;
echo   determines how often a Domain member change its computer account password (Win2000 N/A)
echo;
echo   0^<[]   0x1e[30] default   [0] unlimited
echo;
pause>nul&goto MPA

:Upd
cls
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v Update 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sUpd)
echo HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters&echo;
:sUpd
set sz=
set /p sz=Update.
if "%sz%" equ "." goto MPA
if "%sz%" equ "r" goto str
if "%sz%" equ "q" goto gdi
if "%sz%" equ "" goto wdf
if "%sz%" equ " " goto eptUpd
if "%sz%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /f>nul&regedit&cls&goto Upd
for %%i in (yes no) do if "%%i" equ "%sz%" goto regUpd
echo error&pause&goto Upd
:regUpd
reg add HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v Update /d "%sz%" /f>nul
goto Upd
:eptUpd
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters /v Update /f>nul
goto Upd

::--------------------------------------------------------------------
:fs
cls
echo Fsmgmt
echo;
set fp=
set /p fp=path^^.v^|d:
if %fp:""% equ "" goto wdf
set fp=%fp:"=%
if "%fp%" equ "d" goto sdsf
if "%fp%" equ "v" goto vsf
if "%fp%" equ "." goto DPC
if "%fp%" equ "r" goto dir
if "%fp%" equ "q" goto gdi
if "%fp%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto fs
if "%fp%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f>nul&regedit&cls&goto fs
for /f "delims=" %%i in ("%fp:"=%") do if exist "%%i" set fnn=%%~ni&goto att
echo error&pause&goto fs
:att
for %%i in ("%fp:"=%") do set a=%%~ai
if %a:~0,1% equ d goto fsn
echo invalid path..&pause>nul&goto fs
:fsn
echo %fnn%
set fsn=
set /p fsn=name(keep):
if "%fsn%" equ "." goto fs
if "%fsn%" equ "r" goto fs
if "%fsn%" equ "q" goto gdi
if "%fsn%" equ "" goto userlevel
if "%fsn:~0,1%" neq " " if "%fsn:~80,1%" equ "" for /f "tokens=* delims= " %%i in ("%fsn%") do set fnn=%%~ni&goto userlevel
echo no more than characters 80bytes..&pause>nul&goto fsn
:userlevel
set ulv=
set /p ulv=with(everyone):
if "%ulv%" equ "." goto fsn
if "%ulv%" equ "r" goto fsn
if "%ulv%" equ "q" goto gdi
if "%ulv%" equ "" goto dsf
if "%ulv%" neq "" if "%ulv:~0,1%" neq " " goto grant
echo [everyone administrators users domain\user user guest]&pause>nul&goto userlevel
:grant
set gra=
set /p gra=permission(read):
if "%gra%" equ "." goto userlevel
if "%gra%" equ "r" goto userlevel
if "%gra%" equ "q" goto gdi
if "%gra%" equ "" set "gra=read"&goto afs
for %%i in (read change full) do if "%%i" equ "%gra%" goto afs
echo [read change full]..&pause>nul&goto grant
:dsf
net share "%fnn%"="%fp%"&echo %fnn%=%fp%
echo ..&pause>nul&goto fs
:afs
net share "%fnn%"="%fp%" /grant:"%ulv%",%gra%&echo %fnn%=%fp%
echo ..&pause>nul&goto fs
:vsf
net share
echo ---------------------------------------------------------------------------------
query session 2>nul
echo ..&pause>nul&goto fs
:sdsf
cls
net share
set dsf=
set /p dsf=path^|na^^[]
if "%dsf%" equ "" goto fs
set dsf=%dsf:"=%
if "%dsf%" equ "." goto fs
if "%dsf%" equ "r" goto str
if "%dsf%" equ "q" goto gdi
if "%dsf%" equ " " goto adsf
if "%dsf%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto sdsf
for /f "delims=" %%i in ("%dsf:"=%") do if exist "%%i" goto att
echo error&pause&goto sdsf
:att
for %%i in ("%dsf:"=%") do set a=%%~ai
if %a:~0,1% equ d goto dsf
echo invalid path..&pause>nul&goto sdsf
:dsf
net share "%dsf%" /delete
net session /del /y 2>nul&pause>nul&goto sdsf
:adsf
for /f "tokens=2 delims=:" %%i in ('net share') do for %%l in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%l: for %%i in ("%%l:%%i") do if exist "%%~si" echo "%%~si"&net share "%%~si" /delete >nul
net session /del /y 2>nul&pause>nul&goto sdsf

:wdf
cls
echo AdvShare^|firewall
echo;
echo re -- Reset all Sharing to default settings 
echo;
echo yes,no -- each applies to Private and Guest Pub
echo;
echo what's Private Network? -- defined as safe,but not using the Guest account
echo;&echo;
set dfw=
set /p dfw=wf off/on^^^|^|yes/no^|re "":
if "%dfw%" equ "" ncpa.cpl&goto wdf
if "%dfw%" equ "." goto str
if "%dfw%" equ "r" goto dir
if "%dfw%" equ "q" goto gdi
if "%dfw%" equ "n" goto dir
if "%dfw%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto wdf
if "%dfw%" equ "h" goto helpsh
if /i "%dfw%" equ "re" netsh advfirewall reset&goto wdf
for %%i in (On Off) do if /i "%%i" equ "%dfw%" goto wf
for %%i in (Yes No) do if /i "%%i" equ "%dfw%" goto PrGueSh
echo Invalid..&pause>nul&goto wdf
:wf
netsh advfirewall set allprofiles state %dfw%&goto wdf
:PrGueSh
netsh advfirewall firewall set rule group="Network Discovery" new enable=%dfw%
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=%dfw%
goto wdf
:helpSh
echo;&echo;
echo -Advanced share Settings-
echo;&echo;
echo yes^|no Each applies to two settings:
echo;
echo [Network Discovery]       --^>   -Private Network-   -Guest or Public-
echo;
echo [File and Printer Sharing] --^>   -Private Network-   -Guest or Public-
echo;&echo;
echo Personal Safest optimized:
echo;
echo netsh advfirewall firewall set rule group="Network Discovery" new enable=no
echo;
echo netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=no
echo;
echo *If an error occurs, rename "Network Discovery" to "WangLuoFaXian" in chinese
echo;&echo;
echo via "re" enable fast Recvery to default settings:
echo;
echo default settings:
echo -Private Network- [Network Discovery]= yes   File and Printer Sharing= no
echo -Guest or Public-                    = no                            = no                     
echo;
pause>nul&goto wdf
::--------------------------------------------------------------------
:nam
cls
echo        c        computer
echo;
echo        u          user
echo;
echo        w       workstation
echo;
set a=
set /p a=cho^^.
if "%a%" equ "c" goto pc
if "%a%" equ "u" goto user
if "%a%" equ "w" goto wgroup
if "%a%" equ "." goto dir
if "%a%" equ "r" goto dir
if "%a%" equ "" goto dir
if "%a%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto nam
if "%a%" equ ".." %lstky% HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /f>nul&regedit&cls&goto nam
if "%a%" equ " " exit
if "%a%" equ "q" goto gdi
echo error&pause&goto nam
::-------------------------------------
:PC
cls&echo power\\ %computername%&echo;
for /f "tokens=3* delims= " %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /ve') do if "%%i %%j" neq "(value not set)" echo %%i %%j&%lstky% "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /f>nul&regedit&pause&goto PC
for /f "tokens=3* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /ve') do if "%%i %%j" neq "(value not set)" echo %%i %%j
set an=&for /f "tokens=3* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /s^|find /i "ComputerName" 2^>nul') do if not exist %%i set an=%%i&goto show
for /f "tokens=3* delims= " %%l in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /s^|find /i "computername" 2^>nul') do if not exist %%l goto show
echo Regentc!            -!-&goto effpcname
:show
for /f "tokens=3* delims= " %%c in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /s^|find /i "computername" 2^>nul') do if not exist %%c set ln=%%c&goto shown
echo -Regentc!-  ephameral: -%an%-&goto sPC
:shown
if "%an%" neq "%ln%" echo %ln%      =\=      %an%
if "%an%" equ "%ln%" echo %ln%      ===      %an%
:sPC
echo;
set pln=
set /p pln=PC.[-n ] 
if "%pln%" equ "" goto asPC
if "%pln%" equ "." goto nam
if "%pln%" equ "r" goto dir
if "%pln%" equ "q" goto gdi
if "%pln%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /f>nul&regedit&cls&goto PC
if "%pln%" equ " " echo;&echo ^(:the hive will be loaded like F4&timeout /t 3 /nobreak>nul&goto pauseuserPC
for /f "delims=/\[]:|<>+=;,?*@%%" %%i in ("%pln%") do set pcn=%%~i
if "%pcn:~0,1%" neq " " if "%pcn:~15,1%" equ "" for /f "tokens=1 delims= " %%i in ("%pcn%") do set pac=%%i&goto namepc
echo can't contain only numbers,no more than 15 bytes&pause
goto PC
:namepc
reg add HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /d "%pac%" /f>nul
goto PC
:pauseuserPC
reg add HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /d "" /f>nul
reg add HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /v ComputerName /d "" /f>nul
goto PC
:effpcname
echo;
set a=
set /p "a=reboot^.?"
if "%a%" equ "y" goto restart
if "%a%" equ "n" goto sPC
if "%a%" equ "" goto PCf
if "%a%" equ "." goto sPC
if "%a%" equ "r" goto nam
if "%a%" equ "q" goto gdi
if "%a%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto effpcname
if "%a%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Control\ComputerName /f>nul&regedit&cls&goto effpcname
echo error&pause&goto effpcname
:asPC
echo;
set pnn=
set /p pnn=Act. [-n-] 
if "%pnn%" equ "" goto PCf
if "%pnn%" equ "." goto PC
if "%pnn%" equ "r" goto nam
if "%pnn%" equ "q" goto gdi
if "%pnn%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /f>nul&regedit&cls&goto asPC
if "%pnn%" equ " " echo;&echo Restricted Workstation&timeout /t 3 >nul&goto offlinePC
for /f "delims=/\[]:|<>+=;,?*@%%" %%i in ("%pnn%") do set cnp=%%~i
if "%cnp:~0,1%" neq " " if "%cnp:~15,1%" equ "" for /f "tokens=1 delims= " %%i in ("%cnp%") do set pca=%%i&goto asnamepc
echo can't contain only numbers,no more than 15 bytes&pause>nul&goto pc
:asnamepc
reg add HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /v ComputerName /d "%pca%" /f>nul
goto pc
:offlinePC
reg add HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /v ComputerName /d "" /f>nul
goto pc

:PCf
cls&reg query HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnableICMPRedirect 2>nul||reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnableICMPRedirect /t reg_dword /d 0 /f>nul
for /f "skip=2 tokens=3* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Hostname') do (
set hn=%%i
if %%i equ %%i echo [epha]  Host      %%i&goto nv)
echo [epha]  Host      ~/
:nv
echo;
for /f "skip=2 tokens=4* delims= " %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v "NV Hostname"') do (
if %%i equ %%i echo [stuff] vHost      %%i&goto sPCf)
echo [stuff] vHost      /~
:sPCf
echo;
set pnn=
set /p pnn=present.[~n ] 
if "%pnn%" neq "" set pnn=%pnn:~0,256%
if "%pnn%" equ "" goto asPCf
if "%pnn%" equ "." goto pc
if "%pnn%" equ "r" goto nam
if "%pnn%" equ "q" goto gdi
if "%pnn%" equ " " echo;&echo app host will stop..&timeout /t 3 >nul&goto offPCf
if "%pnn%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /f>nul&regedit&cls&goto PCf
for /f "delims=/\[]:|<>+=;,?*@%%" %%i in ("%pnn%") do set pcf=%%~i
if "%pcf:~0,1%" neq " " if "%pcf:~256,1%" equ "" for /f "tokens=1 delims= " %%i in ("%pcf%") do set fn=%%i&goto PCfa
echo maximum full computername length 256bytes&pause>nul&goto PCf
:PCfa
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Hostname /d %fn% /f>nul
goto PCf
:offPCf
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Hostname /d "" /f>nul
goto PCf
:asPCf
echo;
set pnnv=
set /p pnnv=Pinned. [~n~] 
if "%pnnv%" neq "" set pnnv=%pnnv:~0,256%
if "%pnnv%" equ "" goto srvc
if "%pnnv%" equ "." goto PCf
if "%pnnv%" equ "r" goto PC
if "%pnnv%" equ "q" goto gdi
if "%pnnv%" equ " " echo;&echo station host will stop..&timeout /t 3 >nul&goto offPCfv
if "%pnnv%" equ ".." %lstky% HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /f>nul&regedit&cls&goto asPCf
for /f "delims=/\[]:|<>+=;,?*@%%" %%i in ("%pnnv%") do set pcfv=%%~i
if "%pcfv:~0,1%" neq " " if "%pcfv:~256,1%" equ "" for /f "tokens=1 delims= " %%i in ("%pcfv%") do set fnv=%%i&goto asPCfv
echo maximum full computername length 256bytes&pause>nul&goto PCf
:asPCfv
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v "NV Hostname" /d %fnv% /f>nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Hostname /d %fnv% /f>nul
goto PCf
:offPCfv
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v "NV Hostname" /d "" /f>nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Hostname /d "" /f>nul
goto PCf

:srvc
cls
reg query HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\Parameters /v srvcomment >nul 2>&1
if errorlevel 1 goto ssrvc
for /f "tokens=2* delims=_" %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v srvcomment^|find "comment" 2^>nul') do set a=%%i
echo hostComment:"%a:~6,256%"
echo;
:ssrvc
set srvc=
set /p srvc=comment ^|^|[][]:
if "%srvc%" neq "" set srvc=%srvc:~0,256%
if "%srvc%" equ "" goto user
if "%srvc%" equ "  " goto baksrvc
if "%srvc%" equ "h" goto srvchelp
if "%srvc%" equ " " goto delsrvc
if "%srvc%" equ "." goto nam
if "%srvc%" equ "r" goto dir
if "%srvc%" equ "q" goto gdi
if "%srvc:~0,1%" neq " " if "%srvc:~1,1%" neq " " goto setsrvc
echo error&pause&goto srvc
:setsrvc
reg add HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\Parameters /v srvcomment /d "%srvc%" /f>nul
for /f "tokens=2* delims=_" %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v srvcomment^|find "comment" 2^>nul') do set a=%%i
echo new Comment:"%a:~6,256%"&pause>nul&goto srvc
:baksrvc
reg add HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\Parameters /v srvcomment /d "%srvc%" /f>nul
for /f "tokens=2* delims=_" %%i in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v srvcomment^|find "comment" 2^>nul') do set a=%%i
echo;
echo new Comment:"%a:~6,256%"&pause>nul&goto srvc
:delsrvc
reg add HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\Parameters /v srvcomment /d "" /f>nul
echo;
echo del Comment..&pause>nul&goto srvc
:srvchelp
echo;
echo  " " del srvcomment (computer or host discription)
echo  "  " setting space to the srvcomment and look like is nothing
echo  inputting more than 256 bytes invalid
pause>nul&goto srvc

:user
cls
echo \\%computername%\%sn%
echo.&echo       %cu% %cid%
echo.
set ren=
set /p ren=new.^^^|
if "%ren%" equ "" goto useralias
if "%ren%" equ "." goto nam
if "%ren%" equ "r" goto dir
if "%ren%" equ "q" goto gdi
if "%ren%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto user
if "%ren%" equ ".." %lstky% "%nt%\ProfileList" /f>nul&regedit&cls&goto user
for /f "delims=\/[]:|<>+=;,?*@" %%i in ("%ren%") do set usrn=%%~i
if "%usrn:~0,1%" neq "" if "%usrn:~20,1%" equ "" for /f "tokens=* delims= " %%i in ("%usrn%") do set usr=%%~nxi&goto nname
echo Username are limited to 20 characters..&pause>nul&goto user
:nname
reg add "%nt%\ProfileList\%cid:HKU\=%" /v ProfileImagePath /t REG_EXPAND_SZ /d "C:\Users\%usr%" /f
for /f "tokens=4" %%i in ('reagentc /info^|find "status"') do if "%%i" equ "Enabled" goto effusrn
reagentc /info
:effusrn
set a=
set /p a=s.
if "%a%" equ "." goto user
if "%a%" equ "r" goto user
if "%a%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto effusrn
if "%a%" equ "s" echo;&echo ren C:\Users\%cu% to %ren%&echo;&echo anykey into wpeutil reboot..&pause>nul&goto AlternateShell
if "%a%" equ ".." %lstky% "%nt%\ProfileList\%cid:HKU\=%" /f>nul&regedit&goto effusrn
echo error&pause&goto effusrn

:useralias
cls
echo \\%computername%\%sn%
echo;
set newalias=
set /p newalias=alias [ ]^|n:
if "%newalias%" neq "" set newalias=%newalias:~0,1021%
if "%newalias%" equ " " goto spacefullname
if "%newalias%" equ "n" goto undoalias
if "%newalias%" equ "" goto wgroup
if "%newalias%" equ "." goto user
if "%newalias%" equ "r" goto dir
if "%newalias%" equ "q" goto gdi
if "%newalias%" neq "" if "%newalias:~0,1%" neq " " goto sUseralias
echo invalid..&pause>nul&goto useralias
:sUseralias
net user "%sn%" /fullname:"%newalias%"
echo;
echo Not ConnectedUser signIn alias&pause>nul&goto nam
:undoalias
net user "%sn%" /fullname:""
echo;
echo default username show&pause>nul&goto nam
:spacefullname
net user "%sn%" /fullname:" "
echo;
echo Not ConnectedUser blank signIn alias&pause>nul&goto nam

:wgroup
cls
sc query LanmanWorkstation|findstr "RUNNING">nul&&(for /f "tokens=3" %%i in ('net config lanmanworkstation^|findstr /b /c:"Workstation domain"') do echo Domain:                      %%i)||net config lanmanworkstation
echo;
set wgroup=
set /p "wgroup=compliance input&into GUI^^||"
if "%wgroup%" equ "" goto nam
if "%wgroup%" equ "." goto useralias
if "%wgroup%" equ "r" goto dir
if "%wgroup%" equ "q" goto gdi
if "%wgroup%" equ "h" goto helcfg
if "%wgroup%" equ "bb" cmd /t:f1 /k cd /d %~dp0&goto wgroup
for /f "delims=/\[]:|<>+=;,?*@%%" %%i in ("%wgroup%") do set group=%%~i
if "%group:~0,1%" neq " " if "%group:~15,1%" equ "" for /f "tokens=1 delims= " %%i in ("%group%") do set wkdomain=%%i&goto rwgroup
echo workdomain name maximum length 15bytes..&pause>nul&goto wgroup
:rwgroup
sysdm.cpl&pause>nul
echo;
net config workstation&pause>nul&goto wgroup
:helcfg
echo;
echo sysdm.cpl
echo net config lanmanworkstation&pause>nul&goto wgroup
::--------------------------------------------------------------------
:tri
cls
echo        v           vol
echo;
echo        t          times
echo;
echo        s           sbt
echo;
echo        g          guest
echo;
echo        w          wihot 
echo;
set a=
set /p a=cho:
if "%a%" equ "v" goto setletter
if "%a%" equ "t" goto timex
if "%a%" equ "s" goto sbt
if "%a%" equ "g" goto aguest
if "%a%" equ "w" goto wificfg
if "%a%" equ "." goto dir
if "%a%" equ "r" goto dir
if "%a%" equ "" goto dir
if "%a%" equ " " exit
if "%a%" equ "q" goto gdi
echo error&pause&goto tri
::-------------------------------------
:setletter
cls
for /f "delims=" %%i in ('fsutil fsinfo drives^|more +1') do set d=%%i
for /f "tokens=2* delims= " %%i in ("%d%") do set h=%%i %%j
set l=%h::\=%
echo %l%
echo;
set hletter=
set /p hletter=Code.^|^|
if "%hletter%" equ "" goto tri
if "%hletter%" equ "." goto tri
if "%hletter%" equ "r" goto dir
if "%hletter%" equ "h" goto hlet
if "%hletter%" equ " " goto nohidletter
if "%hletter%" equ "c" calc.exe&goto setletter
if "%hletter%" equ ".." %lstky% %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /f>nul&regedit&goto setletter
if "%hletter%" equ "q" goto gdi
set /a y=%hletter%
if %y% equ %hletter% if %y% geq 1 goto dohidletter
echo invalid..&pause>nul&goto setletter
:dohidletter
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDrives /t reg_dword /d %hletter% /f>nul
taskkill /f /im exp* >nul&shutdown /l&exit
:nohidletter
reg query %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDrives >nul 2>&1
if errorlevel 1 goto setletter
reg delete %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDrives /f>nul
taskkill /f /im exp* >nul&shutdown /l&exit
:hlet
echo A        B        C        D        E        F        G        H        I
echo 1        2        4        8        16       32       64       128      256
echo J        K        L        M        N        O        P        Q        R
echo 512      1024     2048     4096     8192     16384    32768    65536    131072
echo S        T        U        V        W        X        Y        Z        all
echo 262144   524288   1048576  2097152  4194304  8388608  16777216 33554432 67108863
pause>nul&goto setletter

::-------------------------------------
:timex
cls
for /f "tokens=1 delims=" %%i in ('whoami 2^>nul') do echo \\%%i
echo ---------------------------------------------------------------------------------
for /f "skip=4 delims=" %%i in ('net user 2^>nul') do echo %%i
echo;
set u=
set /p u=select user:
if "%u%" equ "r" goto dir
if "%u%" equ "." goto tri
if "%u%" equ "q" goto gdi
if "%u%" neq "" goto stimes
echo error&pause&goto timex
:stimes
echo all [m-su,0-0]
echo m t w th f s su
set t=
set /p t=times:
if "%t%" equ "" goto tri
if "%t%" equ "." goto timex
if "%t%" equ "r" goto tri
if "%t%" equ "q" goto gdi
net user "%u%" /t:%t%&pause>nul&goto tri
::-------------------------------------
:sbt
cls
set a=
set /p a=psw:
set c= $[gd1d+a8($_$)~r[8#fab"ci1st"os i am]^|@!hk!%np^a12oks*t"d." by -Ge- 
if "%a%" equ "%c:~16,1%%c:~49,1%%c:~36,1%%c:~56,1%%c:~66,1%" cls&goto uset
if "%a%" equ "" goto writeo
echo error&pause&goto sbt
:uset
set t=3
reg add HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR /v Start /t reg_dword /d %t% /f>nul
echo read only..&pause
:writeo
cls
set b=
set c="(~3ccrxz15(+=$)+[0#fc33ajobac ms]^|@!hi!(%np^)qys.*(t"=run "|" )
set /p b=psw:
if "%b%" equ "%c:~6,1%%c:~28,1%%c:~31,1%%c:~49,1%%c:~58,1%" cls&goto udst
if "%b%" equ "" goto disboth
echo error&pause&goto writeo
:udst
set t=3
set z=0
reg add HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR /v Start /t reg_dword /d %t% /f>nul
reg add HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies /v WriteProtect /t reg_dword /d %z% /f>nul
echo send to..&timeout /t 30
:disboth
reg add HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR /v Start /t reg_dword /d 4 /f>nul
reg add HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies /v WriteProtect /t reg_dword /d 1 /f>nul
goto dir
::-------------------------------------
:aguest
cls
set s=
set /p s=enableGuest y^|n"":
if "%s%" equ "y" goto actguest
if "%s%" equ "n" goto disguest
if "%s%" equ "" goto gstate
if "%s%" equ "." goto tri
if "%s%" equ "r" goto dir
if "%s%" equ "q" goto gdi
if "%s%" equ " " exit
echo error&pause&goto aguest
:actguest
cls
net user guest /act:y
net user guest
echo refer to share dialogbox turn on/of psw protected public sharing&pause>nul&goto tri
:disguest
cls
net user guest /act:n
net user guest&pause>nul&goto tri
:gstate
echo;
net user guest&pause>nul&goto aguest
::-------------------------------------
:wificfg
cls
set mode=
set /p mode=wifi-hot launch:
if "%mode%" equ "allow" goto ssidset
if "%mode%" equ "disallow" goto dishot
if "%mode%" equ "" goto tri
if "%mode%" equ "." goto tri
if "%mode%" equ "r" goto dir
if "%mode%" equ "q" goto gdi
echo error&pause&goto wificfg
:ssidset
set ssid=
set /p ssid=wifi-hot name:
if "%ssid%" neq "" set ssid=%ssid:~0,33%
if "%ssid%" equ "" goto wificfg
if "%ssid%" equ "r" goto wificfg
if "%ssid:~0,1%" neq " " if "%ssid:~32,1%" equ "" goto wifipsw
echo error&pause&goto ssidset
:wifipsw
set psw=
set /p psw=cfgpsw:
if "%psw%" equ "r" goto ssidset
if "%psw:~0,1%" neq " " if "%psw:~7,1%" neq "" if "%psw:~63,1%" equ "" goto wfhot
echo error&pause&goto wifipsw
:wfhot
reg query HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv /v Start
sc query tapisrv
net start tapisrv
netsh wlan set hostednetwork mode="%mode%" ssid="%ssid%" key="%psw%"
set hostednetwork key=passphrase keyUsage=temporary
netsh wlan start hostednetwork
echo done&pause>nul&goto tri
:dishot
reg query HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv /v Start
sc query tapisrv
netsh wlan set hostednetwork mode=disallow >nul
net stop tapisrv
echo;
:effhotend
set a=
set /p a=restart computer for settings to take effect?
if "%a%" equ "y" goto restart
if "%a%" equ "n" goto wificfg
if "%a%" equ "" goto tri
if "%a%" equ "." goto tri
if "%a%" equ "r" goto dir
echo error&pause&goto effhotend
::-------------------------------------
:lang
cls
set utf=65001
set cn=936
set v=950 437 936 65001
for /f "skip=2 tokens=1,3 delims= " %%i in ('reg query %cid%\Console\^^%%SystemRoot^^%%_system32_cmd.exe 2^>nul') do (
if errorlevel 0 echo %%i     %%j&echo;&goto sLangID)
echo sys[] %cid%\Console\%%SystemRoot%%_system32_cmd.exe&echo;
:sLangID
set lang=
set /p lang=LangCode^|^|
if "%lang%" equ "." goto dir
if "%lang%" equ "r" goto dir
if "%lang%" equ "" goto std
if "%lang%" equ " " goto defLang
if "%lang%" equ "h" goto langhlp
for %%i in (%v%) do if "%lang%" equ "%%i" goto reglang
if "%lang%" equ "q" goto gdi
echo error&pause&goto lang
:reglang
reg add %cid%\Console\%%SystemRoot%%_system32_cmd.exe /v CodePage /t reg_dword /d %lang% /f>nul
goto lang
:defLang
reg delete %cid%\Console\%%SystemRoot%%_system32_cmd.exe /v CodePage /f>nul
goto lang
:langhlp
echo;
echo UTF-8[65001] 0xfde9
echo;
echo cnGBK[936] 0x3a8
echo;
echo twBIG5[950] 0x3b6
echo;
echo sys[]=en[437] 0x1b5
echo;
pause>nul&goto lang

:std
cls
echo date Tip
echo;
set s=
set /p s=tipText s^|n:
if "%s%" equ "s" goto idt
if "%s%" equ "n" reg add "%cid%\Control Panel\International" /v sShortDate /d "ddd M/d/yyyy" /f>nul&goto td
if "%s%" equ "" goto dde
if "%s%" equ "." goto lang
if "%s%" equ "r" goto dir
echo error&pause&goto std

:idt
set s=
set /p s=tip:
if "%s%" equ "." goto std
if "%s%" equ "r" goto lang
if "%s%" equ "" goto td
set /a c=%s%
if "%s%" neq "%c%" reg add "%cid%\Control Panel\International" /v sShortDate /d "ddd M/d/yyyy %s%" /f>nul&reg query "%cid%\Control Panel\International" /v sShortDate&pause>nul&goto td
echo invalid input&goto idt
:td
timedate.cpl&goto std

:dde
cls
echo []0 default behavior   4 Shortcut   1 bothCopy   2,3 bothMove
echo;
set v=0 1 2 3 4
for /f "skip=2 tokens=* delims= " %%i in ('reg query HKCR\AllFilesystemObjects /v DefaultDropEffect 2^>nul') do (
if errorlevel 0 echo %%i&echo;&goto sdde)
echo HKCR\AllFilesystemObjects&echo;
:sdde
set d=
set /p d=DefaultDropEffect:
if "%d%" equ "r" goto lang
if "%d%" equ "." goto std
if "%d%" equ "" goto osk
if "%d%" equ " " goto defdde
for %%i in (%v%) do if "%d%" equ "%%i" goto regdde
if "%d%" equ "q" goto gdi
echo error&pause&goto dde
:regdde
reg add HKCR\AllFilesystemObjects /v DefaultDropEffect /t reg_dword /d %d% /f>nul
goto dde
:defdde
reg delete HKCR\AllFilesystemObjects /v DefaultDropEffect /f>nul
goto dde

:osk
echo *switch numlock to startup led
start osk&goto tri
::-------------------------------------
:display
cls
echo move on..
for /l %%i in (0 1 3) do desk.cpl ,%%i&pause>nul
inetcpl.cpl ,5&pause>nul&appwiz.cpl ,1&goto dir

:ha
cls
set hsh=
set /p hsh=^|
set a=%hsh:"=%
if %hsh:""% equ "" goto dir
if "%a%" equ "." goto dir
if "%a%" equ "r" goto dir
if "%a%" equ "q" goto gdi
if "%a%" equ " " exit
for /f "delims=" %%i in ("%hsh:"=%") do if exist "%%i" goto att
echo error&pause&goto ha
:att
for %%i in ("%hsh:"=%") do set a=%%~ai
if %a:~2,1% equ a goto hash
echo invalid path..&pause>nul&goto ha
:hash
for /f "tokens=1* delims=:" %%i in ('certutil /hashfile "%hsh:"=%"^|findstr /n ".*" 2^>nul') do if "%%i" equ "1" set s=%%j
echo;
for /f "tokens=1 delims= " %%i in ("%s%") do echo %%i
for /f "tokens=1* delims=:" %%i in ('certutil /hashfile "%hsh:"=%"^|findstr /n ".*" 2^>nul') do if "%%i" equ "2" echo %%j
echo;
for /f "tokens=1* delims=:" %%i in ('certutil /hashfile "%hsh:"=%" md5^|findstr /n ".*" 2^>nul') do if "%%i" equ "1" set s=%%j
for /f "tokens=1 delims= " %%i in ("%s%") do echo %%i
for /f "tokens=1* delims=:" %%i in ('certutil /hashfile "%hsh:"=%" md5^|findstr /n ".*" 2^>nul') do if "%%i" equ "2" echo %%j
echo;
echo tapping..&pause>nul&goto ha

:toggledsk
cls&net localgroup administrators&echo;&echo;
explorer "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"
echo customize
echo C:\Users\%cu%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
echo C:\Users\%cu%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\**
echo;
echo C:\ProgramData\Microsoft\Windows\Start Menu\Programs
echo note:Reboot twice to reactivate shortcuts after cleaned caches
echo;&echo;
echo SildebarPin^&Favorites:
echo C:\Users\%cu%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations
echo;&pause>nul&goto dir

:restart
cls
echo BootId
echo;
set /a d=1
for /f "skip=2 tokens=3 delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v BootId 2^>nul') do (
set /a q=%%i)
if %q% equ %d% echo %q%
if %q% neq %d% echo -%q%-
set dw=
set /p dw=value:
if "%dw%" equ "." goto dir
if "%dw%" equ "r" goto dir
if "%dw%" equ "q" goto gdi
if "%dw%" equ "" goto reboot
if "%dw%" equ " " goto eptBootId
set /a b=%dw%
if %b% equ %dw% if %b% geq %d% goto resBootId
echo error&pause&goto restart
:resBootId
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v BootId /t reg_dword /d %dw% /f>nul
if errorlevel 1 echo ..&pause>nul&goto restart
for /f "skip=2 tokens=3 delims= " %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v BootId 2^>nul') do (
set /a q=%%i)
if %q% equ %d% echo %q%
if %q% neq %d% echo -%q%-
pause>nul&goto reboot
:eptBootId
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v BootId /f>nul
echo ..&pause>nul&goto reboot
:reboot
shutdown /r /t 0&exit

:AlternateShell
bcdboot /bcdclean full&pause>nul&shutdown /o /r /t 0
pause>nul&cls&cmd.exe /k&goto dir

:fc
cls
echo @echo off^&color 71^&title GE^&mode 198,98^&chcp 65001^>nul
echo ipconfig /flushdns^>nul
echo for /f "skip=2 tokens=3 delims= " %%%%a in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v SelectedUserSID') do for /f "tokens=3 delims=\" %%%%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\%%%%a" /v ProfileImagePath 2^^^>nul') do set cid=HKU\%%%%a^&set cu=%%%%~nxi^&for /f "tokens=2 delims=\" %%%%e in ('whoami') do set we=%%%%e
echo if "%%cu%%" neq "%%we%%" set rcu=%%we%%
echo if "%%cu%%" equ "%%we%%" set rcu=I
echo reg query HKU\S-1-5-19\Environment ^>nul 2^>^&1
echo if errorlevel 1 netsh advfirewall set allprofiles state on^&goto nai
echo if not errorlevel 1 netsh advfirewall set allprofiles state on^>nul^&taskkill /f /im netsh.exe /t ^>nul 2^>^&1^&choice /c 0ai /d i /t 3 /n ^>nul
echo if errorlevel 3 echo (Run as %%rcu%%).^&goto nai
echo if errorlevel 2 echo;^&goto as500
echo if errorlevel 1 echo;^&goto as500
echo :as500
echo for /f "skip=1 tokens=2" %%%%a in ('whoami /user') do for /f "tokens=3 delims=\" %%%%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\%%%%a" /v ProfileImagePath 2^^^>nul') do set cu=%%%%~nxi^&set sid=%%%%a
echo set cid=HKU\%%sid%%
echo :nai
echo echo %%cid%%^&echo;^&for /f %%%%a in ('"prompt $h&for %%%%b in (1) do rem"') do set "st=%%%%a"
echo for /l %%%%i in (3,-1,1) do set /p="Start %%%%i%%st%%%%st%%%%st%%%%st%%%%st%%%%st%%%%st%%%%st%%%%st%%%%st%%"^<nul^&timeout /t 1 ^>nul
echo setlocal enabledelayedexpansion^&set /a n=0
rem
echo :0
echo cls
echo set a=%%cid%%\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\ShellRefresh
echo if "%%i%%" equ " " reg delete "%%a%%" /ve /f^>nul 2^>nul
echo if "%%i%%" neq "" if "%%i%%" neq " " if "%%i%%" neq "." if "%%i%%" neq "r" if "%%i%%" neq ".." if "%%i%%" neq "h" reg add "%%a%%" /v "" /d "%%i%%" /f^>nul
echo for /f "skip=2 tokens=* delims= " %%%%i in ('reg query "%%a%%" /ve') do echo ^^^<%%a%%^&echo;^&echo %%%%i^&goto i
echo echo ^^^<%%a%%^&echo;^&goto i
echo :1
echo cls
echo set a=HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\DeliveryOptimization
echo if "%%i%%" equ " " reg delete "%%a%%" /v DODownloadMode /f^>nul 2^>nul
echo if "%%i%%" neq "" if "%%i%%" neq " " if "%%i%%" neq "." if "%%i%%" neq "r" if "%%i%%" neq ".." if "%%i%%" neq "h" reg add "%%a%%" /v DODownloadMode /t reg_dword /d "%%i%%" /f^>nul
echo for /f "skip=2 tokens=* delims= " %%%%i in ('reg query "%%a%%" /v DODownloadMode') do echo %%a%%^&echo;^&echo %%%%i^&goto i
echo echo %%a%%^&echo;^&goto i
echo :2
echo cls
echo echo Copyright (C) GE. All rights reserved.
echo echo;
echo :i
echo set i=
echo set /p i=.
echo if "%%i%%" equ "h" goto hp
echo if "%%i%%" equ "r" set /a n-=1^&goto ^!n^!
echo if "%%i%%" equ "." set /a n-=1^&goto ^!n^!
echo if "%%i%%" equ "" set /a n+=1^&goto ^!n^!
echo if "%%i%%" equ " " set /a n+=0^&goto ^!n^!
echo if "%%i%%" equ ".." set /a n+=0^&cmd /t:f1 /k prompt %%cd^>%%^&goto ^!n^!
echo if "%%i%%" equ "  " exit
echo set /a n+=0^&goto ^!n^!
echo :hp
echo echo;
echo echo    .    back
echo echo    ..   prompt
echo echo   " "  delete
echo echo;^&pause^>nul^&goto ^!n^!
echo -------------------------------------------------------------------------
echo;
echo @echo off
echo echo scrnsave.scr [powercfg -restoredefaultschemes]
echo echo Computer.._Administrative.._System_Power Management_Video and Display Settings_Turn off the display (plugged in) [Not Configured]
echo powercfg /setacvalueindex scheme_current sub_video videoidle 1^&powercfg /setactive scheme_current^&timeout /t 3 ^>nul
echo powercfg /setacvalueindex scheme_current sub_video videoidle 300^&powercfg /setactive scheme_current
echo;&echo;
echo @echo off^&chcp 65001^>nul^&title ^&net session /del /y^&for %%%%l in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%%%l: for /f "tokens=1,* delims=: " %%%%i in ('manage-bde -protectors -get %%%%l:^^^|findstr /n ".*"') do if "%%%%i" equ "7" if "%%%%j" equ "Password:" for /f "tokens=1,* delims=: " %%%%i in ('manage-bde -protectors -get %%%%l:^^^|findstr /n ".*"') do if "%%%%i" equ "4" for /f "tokens=2 delims= " %%%%i in ("%%%%j") do echo;^&echo %%%%i^&manage-bde -lock %%%%i -fd
echo;&echo;
echo @echo off^&title ^&color f8^&chcp 65001^>nul
echo if "%%1" neq "min" (start "" /min "%%~f0" min^&exit)
echo taskkill /f /im r.exe /t /im explorer*^>nul 2^>^&1^&start explorer.exe^&exit
echo;
timeout /t 30>nul&cls
echo @echo off^&title com^&color 1a^&mode 16,1
echo if "%%1" neq "min" (start "" /min "%%~f0" min^&exit)
echo r mount izd: z: ^^
echo --log-file idz.log ^^
echo --volname idz ^^
echo --vfs-disk-space-total-size 1T ^^
echo --vfs-cache-mode full ^^
echo --links ^^
echo --vfs-read-ahead 16M ^^
echo --vfs-read-chunk-size 16M ^^
echo --vfs-read-chunk-size-limit 32M ^^
echo --vfs-cache-max-size 10G ^^
echo --vfs-cache-max-age 168h ^^
echo --dir-cache-time 30m ^^
echo --buffer-size 16M ^^
echo --poll-interval 1m ^^
echo --checksum ^^
echo --vfs-write-back 10s ^^
echo --vfs-fast-fingerprint ^^
echo --log-level notice
echo;&echo;&echo;
echo :: --vfs-cache-mode writes (standby)
echo :: --network-mode (network letter)
echo :: --log-level info (log sync,for the same this bat dir)
echo :: --poll-interval 1m (default value,need netdisk support,webDAV/FTP no support)
echo :: -------------------------------------------------------------------------
echo :: rc listremotes (enum rcnames in def conf)
echo :: rclone config file (show cur preset conf)
echo :: rclone config (configure the def conf)
echo :: or (query defined conf and customize)
echo :: rclone listremotes --config "s:\urclone.conf"
echo :: rclone --config "s:\urclone.conf" config
echo :: rclone config password udn (open web to do that)
echo :: set default
echo :: setx rclone_config x:\urclone.conf (change to preset def conf)
echo :: reclone_config is default path hard var name
echo :: load drive
echo :: rclone --config "s:\urclone.conf" mount udn: Z: (Invoke via specified conf)
echo;&echo;&echo;
echo basic operations
echo curl -u "user:pass" -O "https://remote_file"                                          # download (GET,Current dir)
echo curl -u "user:pass" -o "localpath\filename.ext" "https://remote_file"                 # download (GET,defined dir)
echo curl -u "user:pass" -T "local_file" "https://remote_file"                             # upload (PUT,overwrites by default)
echo;
echo webdav^&other operations
echo curl -u "user:pass" -X DELETE   "https://remote_file"                                 # delete
echo curl -u "user:pass" -X MKCOL    "https://remote_dir/"                                 # make directory
echo curl -u "user:pass" -X PROPFIND -H Depth:1 "https://remote_file"                      # list files
echo curl -u "user:pass" -X MOVE --header "Destination:https://path" "https://existpath"   # move or rename (add --header Overwrite:T if needed)
echo;
echo parameters
echo -u  auth (user:pass)
echo -X  request method (GET/POST/PUT/DELETE/MOVE/MKCOL)
echo -L  follow HTTP redirects when needed
echo -v  verbose mode (debug)
echo;
echo core logic
echo -X is the "commander",-OtherPar is the "mover"
echo --netrc-file authlogincfg (replace cleartext user:pass)
echo;
echo logincfg content format:
echo machine example.com login LoginName password LoginPsw
echo or
echo machine example.com
echo login LoginName
echo password LoginPsw
echo;&pause>nul&goto dir

:wincfg
msconfig
start securityhealthsystray
cls&goto dir

:ds
cls
set pa=
set /p pa=suf path:
set a=%pa:"=%
if %pa:""% equ "" goto drd
if "%a%" equ "r" goto dir
if "%a%" equ "." goto dir
if "%a%" equ "q" goto gdi
for /f "delims=" %%i in ("%pa:"=%") do if exist "%%i" goto att
echo error&pause&goto ds
:att
for %%i in ("%pa:"=%") do set a=%%~ai
if %a:~0,1% equ d goto dss
echo invalid path..&pause>nul&goto ds
:dss
set dss=
set /p dss=suffix[*]:
if "%dss%" equ "" goto drd
if "%dss%" equ "r" goto ds
if "%dss%" equ "." goto ds
if "%dss%" equ "q" goto gdi
if "%dss%" equ "*" goto delss
if "%dss:~0,1%" neq " " if "%dss:~1,1%" neq "" if "%dss:~2,1%" neq "" if "%dss:~3,1%" equ "" goto delss
echo error&pause&goto dss
:delss
for /r "%pa:"=%" %%i in ("*.%dss%") do del "%%i" /f/s/q 2>nul
echo ..&pause>nul&goto drd

:drd
cls
echo a b c d e f g h i j k l m n o p q r s t u v w x y z
echo;
set d=
set /p d=rd folders letter^|err"":
if "%d%" equ "r" goto dir
if "%d%" equ "." goto ds
if "%d%" equ "" goto errcl
if "%d%" equ "q" goto gdi
for %%i in (%d%) do if exist %%i: if "%d:c=%" equ "%d%" goto rdnc
for %%i in (%d%) do if exist %%i: if "%d:c=%" neq "%d%" goto rdcset
echo error&pause&goto drd
:rdcset
cls
set c=
set /p c=rd include C? y^|""
if "%c%" equ "." goto ds
if "%c%" equ "r" goto dir
if "%c%" equ "y" goto rdc
if "%c%" equ "n" goto rdnc
if "%c%" equ "" goto rdnc
echo error&pause&goto rdcset
:rdc
echo Scan empty folders,please waiting...
for %%i in (%d%) do if exist "%%i:\" for /f "delims=" %%a in ('dir "%%i:\" /ad /b /s 2^>nul^|sort /R') do (dir "%%a" /a-d /b /a 2>nul|findstr "^" >nul||(ren "%%a" "%%~ni">nul 2>&1&&echo %%a&&pause>nul&&rd "%%a"2>nul))
md "C:\Users\%cu%\AppData\Local\Temp"2>nul&goto dir
:rdnc
echo scan empty folders,please waiting...
for %%i in (%d:c=%) do if exist "%%i:\" for /f "delims=" %%a in ('dir "%%i:\" /ad /b /s 2^>nul^|sort /R') do (dir "%%a" /a-d /b /a 2>nul|findstr "^" >nul||(ren "%%a" "%%~ni">nul 2>&1&&echo %%a&&pause>nul&&rd "%%a"2>nul))
:errcl
start /min cmd /c for /f "delims=" %%i in ('wevtutil el') do (wevtutil cl "%%i")
goto dir

:jobpid
cls
set pid=
set /p pid=pid^|Match^^^|^|
if "%pid%" equ "q" goto gdi
if "%pid%" equ "" goto dir
if "%pid%" equ "r" goto dir
if "%pid%" equ "." goto dir
if "%pid%" equ "h" start taskmgr&goto jobpid
if "%pid%" equ "b" cmd /t:f1 /k cd /d %~dp0&goto jobpid
echo %pid%|findstr /r "^[0-9][0-9]*$">nul&&goto kid
if "%pid:~2,1%" neq "" goto fkp
echo error&pause>nul&goto jobpid
:fkp
for /f "tokens=1,2* delims=." %%a in ('tasklist /FI "USERNAME ne NT AUTHORITY\SYSTEM"^|findstr /i "%pid%"') do for /f "tokens=1* delims=." %%c in ("%%b") do for /f "tokens=1,4,5,6* delims= " %%d in ("%%b") do echo;&echo %%a.%%d        %%e        %%f %%g&echo;&pause&taskkill /f /im "%%a*" /t >nul&timeout /t 3 >nul&goto jobpid
echo;&echo no tasks matched the specified criteria&echo;&pause&goto jobpid
:kid
for /f "tokens=1,2* delims=." %%a in ('tasklist /FI "USERNAME ne NT AUTHORITY\SYSTEM" /nh /fi "pid eq %pid%"') do for /f "tokens=1* delims=." %%c in ("%%b") do for /f "tokens=1,4,5,6* delims= " %%d in ("%%b") do echo;&echo %%a.%%d        %%e        %%f %%g&echo;&pause&taskkill /f /pid "%%a*" /t >nul&timeout /t 3 >nul&goto jobpid
echo;&echo no tasks matched the specified criteria&echo;&pause&goto jobpid

:els
cls
set el=
set /p "el=bde..^|||| "
set l=a b c d e f g h i j k l m n o p q r s t u v w x y z
set hu=%nt%\Winlogon
set bt=/t reg_dword&set hdu=0
if "%el%" equ "" goto elf
if "%el%" equ " " goto elv
if "%el%" equ "." goto elx
if "%el%" equ "rr" goto dir
if "%el%" equ "hh" goto bdetips
if "%el%" equ "bb" cmd /t:f1 /k cd /d %~dp0&goto els
if "%el%" equ ".." %lstky% HKLM\SOFTWARE\Policies\Microsoft\FVE /f>nul&regedit&cls&goto els
for /l %%l in (1 1 99) do if "%%l#" equ "%el%" goto bitComplexity
for %%i in (%el%) do if exist %%i: goto elm
for %%i in (%el%) do if not exist %%i: echo invalid..&pause>nul
goto els
:elf
for /f "delims=" %%a in ('type "%~sdp0letter.txt" 2^>nul') do if %%a equ %%a set rletter=%%a&goto ela
goto elb
:ela
for %%i in (%rletter%) do if exist %%i: if /i %%i: equ %~d0 goto eld
goto ele
:elb
cls
set fletter=
set /p fletter=fixLetter:
for %%i in ("%fletter%") do if not exist %%i: echo invalid&pause>nul&goto elb
>"%~sdp0letter.txt" echo %fletter%
goto els
:eld
reg add "%hu%\SpecialAccounts\UserList" /v "%acu%" %bt% /d %hdu% /f>nul&manage-bde -lock %rletter%: -fd||timeout /t 1&goto els
timeout /t 3&goto gdi
:ele
echo not the current drive!&pause>nul&goto els
:elm
reg add "%hu%\SpecialAccounts\UserList" /v "%acu%" %bt% /d %hdu% /f>nul&manage-bde -lock %el%: -fd||timeout /t 1&goto els
timeout /t 3&goto gdi
:elx
net session /del /y 2>nul
reg add "%hu%\SpecialAccounts\UserList" /v "%acu%" %bt% /d %hdu% /f>nul&for %%l in (%l%) do if exist %%l: for /f "tokens=1* delims=: " %%i in ('manage-bde -protectors -get %%l:^|findstr /n ".*"') do if "%%i" equ "7" if "%%j" equ "Password:" for /f "tokens=1* delims=: " %%i in ('manage-bde -protectors -get %%l:^|findstr /n ".*"') do if "%%i" equ "4" for /f "tokens=2 delims= " %%i in ("%%j") do manage-bde -lock %%i -fd
timeout /t 3&goto gdi
:elv
cls&manage-bde -status&pause>nul&goto els
echo;
set a=
set /p a=delLetter? n^|"" 
if "%a%" equ "y" goto epts
if "%a%" equ "n" goto els
if "%a%" equ "." goto els
if "%a%" equ "r" goto els
if "%a%" equ "" goto epts
echo error..&pause>nul
:epts
del "%~sdp0letter.txt" /f/q&goto els
:bitComplexity
reg add HKLM\SOFTWARE\Policies\Microsoft\FVE /v "FDVPassphrase" /t reg_dword /d 1 /f>nul
reg add HKLM\SOFTWARE\Policies\Microsoft\FVE /v "FDVPassphraseLength" /t reg_dword /d %el:#=% /f
pause>nul&goto els
:bdetips
echo;
echo input "." except c enable lock all partitions
echo;
echo manage-bde
echo;
echo manage-bde -on -pw e: [-used] (initialize deployment)
echo;
echo manage-bde -status [e:]
echo;
echo manage-bde -pause [resume] e:
echo;
echo manage-bde -lock e: -fd
echo;
echo unlock:
echo manage-bde -unlock e: -pw
echo;
echo disable:
echo manage-bde -protectors -disable [enable] e:
echo;
echo off-on:
echo manage-bde -off [on] e:
echo;
echo change pw:
echo manage-bde -changepassword e:
echo;
echo add pw key(post-initialization):
echo manage-bde -protectors -add -pw e:
echo;
echo manage-bde -protectors -add[delete] -?
echo;
echo manage-bde -protectors UlkedLtr: -get (via GUI Encrypted,the 48-digit recovery key will appear)
echo;
echo If encryption is in progress enable use manage-bde -pause[resume] e:
echo If an exclamation "!" appears on the drive letter --^> revert to normal after completion
echo;
echo more options:
echo manage-bde -unlock c: -RecoveryKey f:\...E151C1.bek [recoverykey path]
echo manage-bde -unlock c: -RecoveryKey 067A58... [48-digit recoverykey]
echo;
echo FVE - Full Volume Encryption
echo RDV - Removable Data Volume
echo;
echo HKLM\SOFTWARE\Policies\Microsoft\FVE\RDV (default none)
echo;
echo ComputerConfiguration_AdministrativeTemplates_WinComponents_BitLockerDriveEncryption_FixedDataDrives -Configure use of passwords for fixed data drives-
echo;
echo tpm.msc (bios support)
echo;
echo number# enable setting the minimum password length (min 8 chars)
echo -------------------------------------------------------------------------
echo LocalUser account password:
echo;
echo HKLM\SECURITY\Policy\PolPwdComplx (Protected)
echo secedit /configure /db %windir%\security\policy.sdb (press S enter settings - enable immediate effect)
echo Computer.._Windows.._Security.._Account.._Password must meet complexity requirements (Change may take effect in 5 minutes)
echo;&echo;
echo PIN Code [default Registry key none,GPO un-configure,default 4 characters]:
echo reg add HKLM\SOFTWARE\Policies\Microsoft\PassportForwork\PINComplexity /v MinimumPINLength /t reg_dword /d 0 /f
echo Computer.._Administrative.._System_PIN Complexity
echo;&echo;
echo devicelock[1]:
echo reg add HKLM\SOFTWARE\Microsoft\PolicyManager\default\DeviceLock\MinDevicePasswordComplexCharacters /v value /t reg_dword /d 0 /f
echo device lock policy -- for Mobile tablet (MDM Configuration Write, *no GPO Settins options)
echo;&echo;
echo Domain member registry:
echo HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\PasswordComplexity (domain policy)
echo Computer.._Windows.._Security.._Local.._Security (*only exist other mate option)
echo domain-joined password policy -- automatic dictates enforced member self-renewal
echo;&echo;
echo accounts login UI lockout:
echo net accounts /lockoutthreshold:0
echo Computer.._Windows.._Security.._Account Policies.._Account Lockout Policy (Account lockout threshold [0])
echo policy.inf - LockoutBadCount = 0
echo;
echo -------------------------------------------------------------------------
echo hel cre vdi
echo cre vdi file=e:\vst.vhdx maximum=1000 type=expandable
echo sel vdi file=e:\vst.vhdx (auto selected after created)
echo attach vdi^|detach vdi
echo cre par pri
echo;
echo https://amiunique.org&pause>nul
cls&cmd /c color 78&echo WY7SI-68185-87BDW-W0T7J&echo old computer broken,pleae reset activation&echo 35d317e3840d9285c2673cdb-6560b3167377fe3f30e0cc8c5e6e602da
timeout /t 1&goto els

:KRS
cls
rundll32 keymgr.dll,KRShowKeyMgr
echo ..
set km=
set /p km=KRShow r^|":
if "%km%" equ "" netplwiz&certmgr.msc&goto dir
if "%km%" equ "r" goto dir
if "%km%" equ "." goto dir
if "%km%" equ "q" goto gdi
echo error..&pause>nul&goto KRS

:HSusr
cls
set hbu=
set /p hbu=dh*%acu%.
if "%hbu%" equ "" goto gdi
if "%hbu%" equ ".." %lstky% "%nt%%hd%" /f>nul&regedit&cls&goto HSusr
set /a d=%hbu:~-1%
if %d% geq 0 if %d% leq 1 (net user "%hbu:~0,-1%">nul 2>&1&&(reg add "%nt%%hd%" /v %hbu:~0,-1% /t reg_dword /d %d% /f>nul&exit)||echo;&echo user name error..&pause>nul&goto HSusr)
echo;&echo switch code error..&pause>nul&goto HSusr
:okinf
cls
echo [InternetShortcut]>"C:\Users\%cu%\Documents\$pubsh.url"2>nul
echo url=file://C:/Users/Public/documents>>"C:\users\%cu%\documents\$pubsh.url"2>nul
echo [Version]>"C:\Users\%cu%\Documents\on.inf"
attrib "%public%\Documents" +h +i
echo Signature=$Windows NT$>>"C:\Users\%cu%\Documents\on.inf"
echo [DefaultInstall]>>"C:\Users\%cu%\Documents\on.inf"
echo delReg=prim>>"C:\Users\%cu%\Documents\on.inf"
echo [prim]>>"C:\Users\%cu%\Documents\on.inf"
echo HKU,%cid:~4,48%\Software\Microsoft\Windows\CurrentVersion\Policies\System,DisableRegistryTools,0x00010001,^0>>"C:\Users\%cu%\Documents\on.inf"
echo HKU,%cid:~4,48%\Software\Microsoft\Windows\CurrentVersion\Policies\System>>"C:\Users\%cu%\Documents\on.inf"
echo HKU,%cid:~4,48%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer>>"C:\Users\%cu%\Documents\on.inf"
echo HKU,%cid:~4,48%\Software\Policies\Microsoft\Windows\System,DisableCMD,0x00010001,^0>>"C:\Users\%cu%\Documents\on.inf"
echo on.inf ok..&explorer.exe "C:\Users\%cu%\Documents"&timeout /t 30
del "C:\Users\%cu%\Documents\on.inf" /f/q>nul&goto dir

:getrights
cls
>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc [1 17]
regini "%~sdp0permissions.txt"
if errorlevel 1 del "%~sdp0permissions.txt"&regedit
:S-1-5-32-544
cls
echo access this computer form the network
echo;
echo S-1-5-32-544 Admin
reg query HKLM\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc
for /f "tokens=3 delims= " %%i in ('reg query HKLM\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc') do (
if %%i equ 07040000 echo                                 Allow
if %%i equ 05040000 echo                              disAllow
)
set dadm=
set /p dadm=[7,5]:
if "%dadm%" equ "" goto S-1-1-0
if "%dadm%" equ "." goto delregdo
if "%dadm%" equ "r" goto delregdo
if "%dadm%" equ "q" goto delregdo
for %%i in (7 5) do if "%%i" equ "%dadm%" goto regadm
echo incorrect..&pause>nul&goto S-1-5-32-544
:regadm
>"%~sdp0assrights.reg" echo Windows Registry Editor Version 5.00
>>"%~sdp0assrights.reg" echo;
>>"%~sdp0assrights.reg" echo [HKEY_LOCAL_MACHINE\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc]
>>"%~sdp0assrights.reg" echo @=hex(0):0%dadm%,04,00,00
reg import "%~sdp0assrights.reg"&del "%~sdp0assrights.reg" /f /q 2>nul&goto S-1-5-32-544
:S-1-1-0
cls
>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc [1 17]
regini "%~sdp0permissions.txt"
echo deny access to this computer form the network
echo;
echo S-1-1-0 Everyone
reg query HKLM\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc
for /f "tokens=3 delims= " %%i in ('reg query HKLM\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc') do (
if %%i equ 02000000 echo                               noDeny
if %%i equ 82000000 echo                                  Deny
)
set dever=
set /p dever=[0,8]:
if "%dever%" equ "" goto delregdo
if "%dever%" equ "." goto S-1-5-32-544
if "%dever%" equ "r" goto delregdo
if "%dever%" equ "q" goto delregdo
for %%i in (0 8) do if "%%i" equ "%dever%" goto regevery
echo incorrect..&pause>nul&goto S-1-1-0
:regevery
>"%~sdp0assrights.reg" echo Windows Registry Editor Version 5.00
>>"%~sdp0assrights.reg" echo;
>>"%~sdp0assrights.reg" echo [HKEY_LOCAL_MACHINE\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc]
>>"%~sdp0assrights.reg" echo @=hex(0):%dever%2,00,00,00
reg import "%~sdp0assrights.reg"&del "%~sdp0assrights.reg" /f /q 2>nul&goto S-1-1-0
:delregdo
>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc [17]
>>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc [17]
regini "%~sdp0permissions.txt"&del "%~sdp0permissions.txt" /f/q&goto dir
::-------------------------------------------------------------------------------------
:vehicles
choice /c as /d s /cs /t 3 /n /m :)
if errorlevel 2 goto asset
if errorlevel 1 goto assex
:asset
cls&netsh wlan set hostednetwork mode=disallow >nul
::[Advertising]
for /f "skip=2 eol=E tokens=1 delims= " %%i in ('reg query %cid%\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v "SubscribedContent*"2^>nul') do reg add %cid%\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v "%%i" /t reg_dword /d 0 /f>nul 2>&1
:policy
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t reg_dword /d 1 /f>nul
:net
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private /v AutoSetup /t reg_dword /d 0 /f>nul
:aSrv
reg add HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoShareWks /t reg_dword /d 0 /f>nul
:access
>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc [1 17]
>>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc [1 17]
regini "%~sdp0permissions.txt"
>"%~sdp0assrights.reg" echo Windows Registry Editor Version 5.00
>>"%~sdp0assrights.reg" echo;
>>"%~sdp0assrights.reg" echo [HKEY_LOCAL_MACHINE\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc]
>>"%~sdp0assrights.reg" echo @=hex(0):82,00,00,00
>>"%~sdp0assrights.reg" echo [HKEY_LOCAL_MACHINE\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc]
>>"%~sdp0assrights.reg" echo @=hex(0):05,04,00,00
reg import "%~sdp0assrights.reg"&del "%~sdp0assrights.reg" /f/q 2>nul
>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc [17]
>>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc [17]
regini "%~sdp0permissions.txt"&del "%~sdp0permissions.txt" /f/q 2>nul
:c
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers /v "" /d 2 /f>nul
for /f "delims=" %%i in ('dir /a /b /s "%tmp%\*"') do attrib -h -r "%%i"&del /f/s/q "%%i"&rd /s/q "%%i" 2>nul
del "C:\Users\%cu%\AppData\Roaming\Microsoft\Office\Recent\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\Caches\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\History\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\INetCache\*" /f/s/q 2>nul
del C:\Windows\Prefetch\* /f/s/q 2>nul
del C:\Windows\SoftwareDistribution\Download\* /f/s/q 2>nul
del C:\Windows\Temp\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCookies\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCache\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\History\* /f/s/q 2>nul
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer /v LogonCount /t reg_dword /d 0 /f>nul
reg delete "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell" /f>nul
reg delete %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths /f 2>nul
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32" 2^>nul^|find "ComDlg32"') do reg delete "%%i" /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage" /k /s /f "*" 2^>nul') do reg delete "%%i" /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer" /f "mru" /v /s /k^|findstr /b "HKEY"') do reg delete %%i /f>nul 2>&1
for /f "eol=E delims=" %%a in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /s /f "*"^|findstr "Count"') do reg delete %%a /va /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" 2^>nul^|find "RecentDocs"') do reg delete "%%i" /f>nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v GlassSessionId /f>nul 2>&1
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%i: rd %%i:\$Recycle.Bin /s /q 2>nul
start /min cmd /c for /f "delims=" %%i in ('wevtutil el') do (wevtutil cl "%%i")
for /r "C:\Users\%cu%\AppData\Roaming\Microsoft\Windows\Recent" %%i in (*) do if /i not "%%~nxi" equ "5f7b5f1e01b83767.automaticDestinations-ms" if /i not "%%~nxi" equ "f01b4d95cf55d32a.automaticDestinations-ms" del "%%i" /f/s/q 2>nul
del %windir%\system32\logfiles\* /f/s/q 2>nul
del "%tmp%\*" /f/s/q 2>nul
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDrives /t reg_dword /d 4 /f>nul 2>&1
echo restart computer for settings to take effect.&gpupdate /force&goto restart
::-------------------------------------------------------------------------------------
:assex
cls&netsh wlan set hostednetwork mode=disallow >nul
:xpolicies
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t reg_dword /d 1 /f>nul
:xnet
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private /v AutoSetup /f>nul 2>&1
:xSrv
reg delete HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v AutoShareWks /f>nul 2>&1
:xaccess
>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc [1 17]
>>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc [1 17]
regini "%~sdp0permissions.txt"
>"%~sdp0assrights.reg" echo Windows Registry Editor Version 5.00
>>"%~sdp0assrights.reg" echo;
>>"%~sdp0assrights.reg" echo [HKEY_LOCAL_MACHINE\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc]
>>"%~sdp0assrights.reg" echo @=hex(0):02,00,00,00
>>"%~sdp0assrights.reg" echo [HKEY_LOCAL_MACHINE\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc]
>>"%~sdp0assrights.reg" echo @=hex(0):07,04,00,00
reg import "%~sdp0assrights.reg"&del "%~sdp0assrights.reg" /f/q 2>nul
>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-5-32-544\ActSysAc [17]
>>"%~sdp0permissions.txt" echo HKLM\SECURITY\Policy\Accounts\S-1-1-0\ActSysAc [17]
regini "%~sdp0permissions.txt"&del "%~sdp0permissions.txt" /f/q 2>nul
:xc
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers /v "" /d 1 /f>nul
for /f "delims=" %%i in ('dir /a /b /s "%tmp%\*"') do attrib -h -r "%%i"&del /f/s/q "%%i"&rd /s/q "%%i" 2>nul
del "C:\Users\%cu%\AppData\Roaming\Microsoft\Office\Recent\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\Caches\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\History\*" /f/s/q 2>nul
del "C:\Users\%cu%\AppData\Local\Microsoft\Windows\INetCache\*" /f/s/q 2>nul
del C:\Windows\Prefetch\* /f/s/q 2>nul
del C:\Windows\SoftwareDistribution\Download\* /f/s/q 2>nul
del C:\Windows\Temp\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCookies\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\INetCache\* /f/s/q 2>nul
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\History\* /f/s/q 2>nul
reg add %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer /v LogonCount /t reg_dword /d 0 /f>nul
reg delete "%cid%\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell" /f>nul
reg delete %cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths /f 2>nul
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo" 2^>nul^|find "SessionInfo"') do reg delete "%%i" /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows NT\CurrentVersion\HostActivityManager" /k /s /f "*" 2^>nul^|find "HostActivityManager"') do reg delete "%%i" /f>nul
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32" 2^>nul^|find "ComDlg32"') do reg delete "%%i" /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage" 2^>nul^|find "FeatureUsage"') do reg delete "%%i" /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer" /f "mru" /v /s /k^|findstr /b "HKEY"') do reg delete %%i /f>nul 2>&1
for /f "eol=E delims=" %%a in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /s /f "*"^|findstr "Count"') do reg delete %%a /va /f>nul 2>&1
for /f "eol=E delims=" %%i in ('reg query "%cid%\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" 2^>nul^|find "RecentDocs"') do reg delete "%%i" /f>nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v GlassSessionId /f>nul 2>&1
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%i: rd %%i:\$Recycle.Bin /s /q 2>nul
start /min cmd /c for /f "delims=" %%i in ('wevtutil el') do (wevtutil cl "%%i")
for /r "C:\Users\%cu%\AppData\Roaming\Microsoft\Windows\Recent" %%i in (*) do if /i not "%%~nxi" equ "f01b4d95cf55d32a.automaticDestinations-ms" del "%%i" /f/s/q 2>nul
del %windir%\system32\logfiles\* /f/s/q 2>nul
del "%tmp%\*" /f/s/q 2>nul
reg delete %cid%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDrives /f>nul 2>&1
echo restart computer for settings to take effect.&gpupdate /force&goto restart
::-------------------------------------------------------------------------------------
:gdi
net localgroup administrators "%acu%" /delete>nul 2>&1&reg add "%nt%%hd%" /v "%acu%" %rt% %seto% /f>nul
:aucon
cls&for /f %%a in ('"prompt $h&for %%b in (1) do break"') do set "st=%%a"
for /l %%i in (60,-1,1) do set /p="MonitorTimer %%i %st%%st%%st%%st%%st%%st%%st%%st%%st%%st%%st%%st%%st%%st%%st%"<nul&timeout /t 1 >nul&title ON&mode 16,2&color 71
choice /c acr /d a /cs /t 60 /n
if errorlevel 3 goto dir
if errorlevel 2 goto cc
if errorlevel 1 goto aucon

:set
if exist "%~dsp08 .bat" cls&cmd /c "%~dsp08 .bat"&goto dir
(echo -----BEGIN CERTIFICATE-----
echo QGVjaG8gb2ZmDQpjb2xvciBmYSZ0aXRsZSBgXnxgJmNoY3AgNjUwMDE+bnVsDQpl
echo Y2hvIGFkbWluIEVudGl0bGVtZW50LiZlY2hvOw0KOnN1Yg0KZm9yIC9mICJkZWxp
echo bXM9IiAlJWkgaW4gKCdmc3V0aWwgZnNpbmZvIGRyaXZlc158bW9yZSArMScpIGRv
echo IHNldCBkPSUlaQ0KZm9yIC9mICJ0b2tlbnM9MiwqIGRlbGltcz0gIiAlJWkgaW4g
echo KCIlZCUiKSBkbyBzZXQgaD0lJWkgJSVqDQpzZXQgbD0laDo6XD0lDQplY2hvICVs
echo JSZlY2hvOyZzZXRsb2NhbCBlbmFibGVkZWxheWVkZXhwYW5zaW9uDQo6dHlwZQ0K
echo c2V0IG9mbj0NCnNldCAvcCBvZm49Zm54Og0KaWYgIiVvZm4lIiBlcXUgIiIgZW5k
echo bG9jYWwmZXhpdA0KZWNobzsNCjpzcA0Kc2V0IHNwPQ0Kc2V0IC9wIHNwPXBhdGg6
echo DQpzZXQgYT0lc3A6Ij0lDQppZiAlc3A6IiIlIGVxdSAiIiBnb3RvIGluaGVyaXQN
echo CmlmICIlYSUiIGVxdSAiLiIgZ290byB0eXBlDQppZiAiJWElIiBlcXUgInIiIGdv
echo dG8gdHlwZQ0KaWYgIiVhJSIgZXF1ICIuLiIgY2xzJmdvdG8gc3ViDQppZiAiJWEl
echo IiBlcXUgIiAgIiBjbHMmZ290byBzdWINCmlmICIlYSUiIGVxdSAicSIgZXhpdA0K
echo aWYgIiVhJSIgZXF1ICIgIiBleGl0DQpmb3IgL2YgInRva2Vucz0qIGRlbGltcz0i
echo ICUlaSBpbiAoIiVzcDoiPSUiKSBkbyBpZiBub3QgZXhpc3QgIiUlaSIgZWNobyBp
echo bnZhbGlkIHBhdGgmcGF1c2UmZ290byBzcA0KZm9yICUlaSBpbiAoIiVzcDoiPSUi
echo KSBkbyBzZXQgYT0lJX5haQ0KaWYgJWE6fjAsMSUgZXF1IGQgZ290byBzaG93DQpl
echo Y2hvIGludmFsaWQgZGlyZWN0b3J5Li4mcGF1c2U+bnVsJmdvdG8gc3ANCjppbmhl
echo cml0DQpmb3IgL2YgInRva2Vucz0xIGRlbGltcz06IiAlJWkgaW4gKCIlfmRwMCIp
echo IGRvIHNldCBzcD0lJWk6XA0KOnNob3cNCmNkIC9kICVzcCVcDQplY2hvIF8gXyBf
echo IF8gXyBfd2FpdGluZy4uXyBfIF8gXyBfIF8mZWNobzsNCmZvciAvciAlJWkgaW4g
echo KCIlb2ZuJSIpIGRvICgNCnNldCAvYSBuKz0xDQpzZXQgcz0lJX5maSZzZXQgcz0h
echo czoiPSENCmlmIGV4aXN0ICFzISBlY2hvICFzISZlY2hvOyZzZXQgcnM9JSV+Zm54
echo aSZzZXQgcnM9IXJzOiI9IQ0KKQ0KOnNhDQpzZXQgc2FuPQ0Kc2V0IC9wIHNhbj1y
echo ZW46DQppZiAiJXNhbiUiIGVxdSAiIiBnb3RvIHNwDQppZiAiJXNhbiUiIGVxdSAi
echo ciIgZ290byBzcA0KaWYgIiVzYW4lIiBlcXUgIiAgIiBjbHMmZ290byBzdWINCmlm
echo ICIlc2FuJSIgZXF1ICIuLiIgY2xzJmdvdG8gc3ViDQppZiAiJXNhbiUiIGVxdSAi
echo cSIgZXhpdA0KaWYgIiVzYW4lIiBlcXUgIiAiIGV4aXQNCjphY24NCnJlbiAiIXJz
echo ISIgIiVzYW4lIiZlY2hvOyZlY2hvIHJlbiAiIXJzISIgIiVzYW4lIiZlY2hvOw0K
echo ZWNobyAtIC0gLSAtIC0gLSAtIG9rISAtIC0gLSAtIC0gLSAtJnBhdXNlPm51bCZj
echo bHMmZ290byBzdWINCg==
echo -----END CERTIFICATE-----)>"%~dsp0f"
certutil -decode "%~dsp0f" "%~dsp08 .bat"&del "%~dsp0f"&cls&cmd /c "%~dsp08 .bat"&goto dir

:memos
cls&echo scheduler
echo @schtasks /create /tn at1 /sc weekly /d mon,tue,wed,thu,fri,sat /st 01:01 /tr "'C:\fullPath.bat'" /rl limited /it /f^>nul
timeout /t 3 >nul
echo;
echo @echo off^&title i^&color f8^&chcp 65001^>nul
echo if "%%1" neq "min" (start "" /min "%%~f0" min^&exit)
echo runas /user:administrator "path .bat"^&exit
echo;&echo;
echo :cleanMode:
echo edge  -inprivate
echo google/brave --incognito
echo firefox -private-window
echo;
:ECH
echo protect server name indication(SNI),add Par to browser icon
echo --enable-features=EncryptedClientHello
echo;
:DNS
echo DoH config (enable secure DNS in browser settings,select DNS provider):
echo edge://settings/privacy
echo chrome://settings/security
echo about:preferences#privacy
echo brave://settings/security
echo;
echo In browser input:
echo https://dns.google/dns-query
echo https://cloudflare-dns.com/dns-query
echo https://dns.alidns.com/dns-query
echo;
echo mobile UI input:
echo dns.google^|one.one.one.one^|dns.alidns.com
echo;&echo;

echo install
echo winget search app
echo winget show app
echo winget install id [-s msstore]
echo;
echo winget search office
echo winget install [--id] id -s winget
echo;&echo source
echo winget source reset [--force]
echo winget source update
echo;&echo Repair
echo winget source remove winget
echo winget source remove msstore
echo winget source update
echo;&echo upgrade
echo winget upgrade app
echo winget upgrade  --all [--include-unknown]
echo;&echo;
echo takeown reserved space
echo dism /online /set-reservedstoragestate /state:disabled [enabled]
echo;&echo;
echo bcdedit^|findstr hypervisor
echo bcdedit /set hypervisorlaunchtype off^|auto-[]
timeout /t 8 >nul&echo;

:varpath
cls&echo;
echo     0 = f0
echo %%~0           C:\users\dh\Desktop\New folder\New Text Document.txt
echo %%~f0          C:\users\dh\Desktop\New folder\New Text Document.txt
echo;
echo %%~d0  =       C:
echo %%~p0  =         \Users\dh\Desktop\New folder\
echo %%~n0  =                                      New Text Document
echo %%~x0  =                                                       .txt
echo;
echo;
echo;
echo     8.3 file name (12 bytes abbreviation expressions)
echo;
echo %%~s0  =       C:\Users\dh\Desktop\NEWFOL~1\NEWTEX~1.txt
echo;
echo %%~sd0 =       C:
echo %%~sp0 =         \Users\dh\Desktop\NEWFOL~1\
echo %%~sn0 =                                    NEWFOL~1
echo %%~sx0 =                                            .txt
echo;
echo     fix
echo %%cd%% = C:\users\user\desktop (only boot directory:\)
echo %%cd%% = %windir%\system32 (echo run directory - Run as administrator)
timeout /t 10>nul
::--------------------------------------------------------------------
:row
echo;&echo echo Print
echo setlocal enabledelayedexpansion
echo set 1=%%%%i
echo set /p 1= !1! ^<nul
echo;
:replace
echo substitution
echo set ID=00-00-00-00-00-00
echo for /f "delims=" %%%%a in ('getmac') do (
echo setlocal enabledelayedexpansion
echo set dat=%%%%a
echo set dat=!dat:xx-xx-xx-xx-xx-xx=%%ID%%!
echo echo !dat!^>^> "%%~dp0acmacdat.txt"
echo endlocal
echo )
timeout /t 5 >nul&echo;
::--------------------------------------------------------------------
:menu
cls
echo ctrl+shift+n
echo;
echo mstsc.{241D7C96-F8BF-4F85-B01F-E2B043341A4B}
echo;
echo PubShare.{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}
echo;
echo Share(Me).{208D2C60-3AEA-1069-A2D7-08002B30309D}
echo;
echo credentials.{1206F5F1-0569-412C-8FEC-3204630DFB70}
echo;
echo QuickAccess.{679f85cb-0220-4080-b29b-5540cc05aab6}
echo;
echo UsrLibraries.{031E4825-7B94-4dc3-B131-E946B44C8DD5}
echo;
echo OneDrive.{018D5C66-4533-4307-9B53-224DE2ED1FE6}
echo;
echo Finder.{9343812e-1c37-4a49-a12e-4b2d810d956b}
echo;
echo bluetooth.{28803F59-3A75-4058-995F-4EE5503B023C}
echo;
echo recycleBin.{645ff040-5081-101b-9f08-00aa002f954e}
echo;
echo defaultapp.{17cd9488-1228-4b2f-88ce-4298e93e0966}
echo;
echo allsetting.{ED7BA470-8E54-465E-825C-99712043E01C}
echo;
echo Diskmirror.{F942C606-0914-47AB-BE56-1321B8035096}
echo;
echo -Powercfg-.{025A5937-A6BE-4686-A844-36FE4BEC8B6D}
echo;
echo -runshorcut- explorer shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}
echo;&echo;
echo shortcut arrow(real administrator run)
echo reg delete HKCR\lnkfile /v IsShortcut /f^&shutdown /l
echo reg add HKCR\lnkfile /v IsShortcut /d "" /f^&shutdown /l
timeout /t 30>nul
::--------------------------------------------------------------------
:pwsh
cls
reg add HKCR\DesktopBackground\Shell\RestartExplorer /ve /d "shutdown" /f>nul 2>&1
reg add HKCR\DesktopBackground\Shell\RestartExplorer\command /ve /d "shutdown /s /hybrid /t 0" /f>nul 2>&1
reg add HKCR\Directory\Background\Shell\RestartExplorer /ve /d "shutdown" /f>nul 2>&1
reg add HKCR\Directory\Background\Shell\RestartExplorer /v position /d "bottom" /f>nul 2>&1
reg add HKCR\Directory\Background\Shell\RestartExplorer\command /ve /d "shutdown /s /hybrid /t 0" /f>nul 2>&1
reg add HKLM\SOFTWARE\Policies\Microsoft\Edge /v StartupBoostEnabled /t reg_dword /d 0 /f>nul 2>&1
echo rename-localuser -name netsh -newname netdom
echo;
echo fqdn- fullyQualifiedDomainName
echo fsmo- flexible single master operations
echo;
echo query:
echo netdom query dc (Eum domain contrller)
echo netdom query fsmo (Manage fsmo)
echo;
echo pw update:
echo net user mumber * /domain (for mumber)
echo;
echo join:
echo netdom join pc1(mumber) /domain:corp.group(domain or ip) /usero:admin /passwordo:*
echo   +
echo netdom join pc1(mumber) /domain:corp.group(domain or ip) /userD:Admin /passwordd:*
echo   =
echo netdom join pc1(mumber) /domain:corp.group(domain or ip) /usero:admin /passwordo:* /userD:Admin /passwordd:*
echo;
echo;
echo Repair trust:
echo netdom resetpwd /server:DC1 /userD:Admin /passwordd:*
echo;
echo Verify trust:
echo netdom trust domainA.com /domain:domainB.com /verify
echo;
echo remove trust:
echo netdom trust A.com /domain:B.com /remove
echo;
echo Create trust:
echo  A--^>B
echo netdom trust A /domain:B /add /userD:B\Adm /passwordD:* /usero:A\adm /passwordO:* /oneway:trusting
echo;
echo  B--^>A
echo netdom trust B /domain:A /add /userD:A\Adm /passwordD:* /usero:B\adm /passwordO:* /oneway:trusted
echo;
echo  A^<-^>B
echo netdom trust A /domain:B /add /userD:B\Adm /passwordD:* /usero:A\adm /passwordO:* /twoway
echo;
echo external trust:
echo netdom trust A /domain:B /add /external /userD:B\Adm /passwordD:* /usero:A\adm /passwordO:* /twoway
echo;
echo forest trust:(domain between)
echo netdom trust forestA /domain:forestB /add /forest /userD:forestB\Adm /passwordD:* /usero:forestA\adm /passwordO:* /twoway
echo;
echo ctrl+, curl (win) all rights reserved.
echo;&timeout /t 180>nul&goto gdi