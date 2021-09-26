@Echo OFF
type C:\iisdeploy\keith.txt
echo.
:top
echo.
echo.
echo checking updates please wait
(Call :notEmpty C:\iisdeploy\hasnewpush.txt && (
	cd c://yourdailystore
	set HOME=%USERPROFILE%
	git reset --hard HEAD && git pull
	taskkill /f /t /im git.exe
   	break > C:\iisdeploy\hasnewpush.txt

)) || (
    echo no updates
)
timeout /t 10 /nobreak > NUL
goto top

::subroutine
:notEmpty
If %~z1 EQU 0 (Exit /B 1) Else (Exit /B 0)