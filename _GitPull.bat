@echo off
REM Author: HMH (whalebeat@gmail.com)
REM How to use _GitPull.bat
REM 1. Place _GitPull.bat and _GitList.txt in the destination folder. 1st run will create _GitList.txt
REM 2. Fill in _GitList.txt with the following format:
REM 	<Parent folder name>@<Git project link without ending ".git">
REM 	E.g. YourName@https://github.com/Account/Project
REM 3. Run _GitPull.bat
REM 	- It will create the folder and clone repository or execute a pull command if it's already exist
REM 	- Check the output for error (if any)
if not exist _GitList.txt (
	echo [101;93m MISSING _GitList.txt [0m
	echo [92m Creating a new one ... [0m
	(
		echo ^<Parent folder name^>@^<Git project link without ending ".git"^>
		echo ^<Parent folder name^>@^<Git project link without ending ".git"^>
	) > _GitList.txt
	start _GitList.txt
	goto :EOF
)
set "Count=1"
for /f "tokens=1,2 delims=@ " %%A in (_GitList.txt) do (
    set link=%%B
	if not exist %%A (
		mkdir %%A
	)
	pushd %%A
	echo PROCESSING %%A ...
	call :checkout
	popd
	set /a "Count+=1"
)
pause
goto :EOF

:checkout
if "%link%"=="" (
	echo [101;93m MISSING GIT LINK [0m
	echo ==============================
	goto :EOF
)
echo CHECKING OUT %link% ...
set link=%link%
for /f "tokens=4 delims=/ " %%A in ("%link%") do (
	set folder=%%A
)
if exist %folder% (
	pushd %folder%
	git pull
	popd
) else (
	git clone %link%
)
if not %ERRORLEVEL%==0 (
	echo [101;93m ERROR [0m
) else echo [92m DONE [0m
echo ==============================
goto :EOF