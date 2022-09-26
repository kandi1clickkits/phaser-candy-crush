@ECHO OFF
REM This is a sample script
ECHO======================================================================================
ECHO		Kandi kit installation process has begun
ECHO======================================================================================
ECHO 	This kit installer works only on Windows OS
ECHO 	Based on your network speed, the installation may take a while
ECHO======================================================================================
setlocal ENABLEDELAYEDEXPANSION
REM update below path if required
SET NODE_LOCATION="C:\Program Files\nodejs"
SET NODE_PATH="C:\KandiKit\node-v10.24.1-win-x86"
SET NODE_VERSION=10.24.1
SET NODE_DOWNLOAD_URL=https://nodejs.org/dist/v10.24.1/node-v10.24.1-x64.msi
SET NODE_V10_URL=https://nodejs.org/download/release/v10.24.1/node-v10.24.1-win-x86.zip
SET REPO_DOWNLOAD_URL=https://github.com/kandi1clickkits/phaser-candy-crush/releases/download/v1.0.0/candy.zip
SET REPO_NAME=candy.zip
SET EXTRACTED_REPO_DIR=candy
where /q node
IF ERRORLEVEL 1 (
	SET NODE_M_VERSION=10.24.1
	ECHO==========================================================================
    	ECHO Node wasn't found in PATH variable
	ECHO==========================================================================
	IF ERRORLEVEL 1 (
		CALL :Install_node_and_modules
		CALL :Download_repo
	) ELSE (
		CALL :Download_repo
		

	)
) ELSE (
FOR /F %%F IN ('node.exe --version') DO SET NODE_M_VERSION=%%F
			ECHO==========================================================================
			ECHO Nodejs was detected!
			ECHO==========================================================================
			CALL :Download_repo
			
		
		)	
	)
)
SET /P CONFIRM=Would you like to run the kit (Y/N)?
IF /I "%CONFIRM%" NEQ "Y" (
	ECHO 	To run the kit, follow further instructions of the kit in kandi	
	ECHO==========================================================================
) ELSE (
	ECHO 	Extracting the repo ...	
	ECHO==========================================================================
	tar -xvf %REPO_NAME% 
	where /q git
IF ERRORLEVEL 1 (
		REM curl -o Git-2.37.0-64-bit.exe https://github.com/git-for-windows/git/releases/download/v2.37.0.windows.1/Git-2.37.0-64-bit.exe
		bitsadmin /transfer Git_download /download https://github.com/git-for-windows/git/releases/download/v2.37.0.windows.1/Git-2.37.0-64-bit.exe "%cd%\Git-2.37.0-64-bit.exe"
		Git-2.37.0-64-bit.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 TargetDir="C:\Program Files\Git"
		IF ERRORLEVEL 1 (
		START Git-2.37.0-64-bit.exe
		)
		path=path;"C:\Program Files\Git\bin"
)

where /q node
IF ERRORLEVEL 1 (
		%NODE_LOCATION%\npm install
		%NODE_LOCATION%\npm install -g gulp --save
		cd %EXTRACTED_REPO_DIR%
		start http://localhost:3000
		path=path;"C:\Program Files\nodejs"
		%APPDATA%\npm\gulp start
		PAUSE
	)
		
IF %NODE_M_VERSION% EQU v10.24.1 (
	cd %EXTRACTED_REPO_DIR%
	npm install
	npm install -g gulp 
	cd %EXTRACTED_REPO_DIR%
	gulp start
	IF ERRORLEVEL 1 (
		path=path;%NODE_LOCATION%
		%NODE_LOCATION%\npm install
		%NODE_LOCATION%\npm install -g gulp --save
		cd %EXTRACTED_REPO_DIR%
		start http://localhost:3000
		%APPDATA%\npm\gulp start
	)
) ELSE (
		cd %EXTRACTED_REPO_DIR%
		
		cd %EXTRACTED_REPO_DIR%
		IF EXIST %NODE_PATH% (
		ECHO %NODE_PATH%
			%NODE_PATH%\npm install
			cd %EXTRACTED_REPO_DIR%
			%NODE_PATH%\npm install -g gulp --save
			start http://localhost:3000
			%NODE_PATH%\gulp start
			pause
		) ELSE (
		REM curl -o node-v10.24.1-win-x86.zip %NODE_V10_URL%
		bitsadmin /transfer node_download /download %NODE_V10_URL% "%cd%\%EXTRACTED_REPO_DIR%\node-v10.24.1-win-x86.zip"
			tar -xvf node-v10.24.1-win-x86.zip
			mkdir C:\KandiKit\node-v10.24.1-win-x86
			xcopy "node-v10.24.1-win-x86" "C:\KandiKit\node-v10.24.1-win-x86" /s /e /h
			%NODE_PATH%\npm install
			cd %EXTRACTED_REPO_DIR%
			%NODE_PATH%\npm install -g gulp --save
			start http://localhost:3000
			%NODE_PATH%\gulp start
			pause
			)
		)
)
EXIT /B %ERRORLEVEL%

:Download_repo
bitsadmin /transfer repo_download_job /download %REPO_DOWNLOAD_URL% "%cd%\%REPO_NAME%"
ECHO==========================================================================
ECHO 	The Kit has been installed successfully
ECHO==========================================================================
ECHO 	To run the kit, follow further instructions of the kit in kandi	
ECHO==========================================================================
EXIT /B 0

:Install_node_and_modules
set path=%path%;!NODE_LOCATION!
ECHO==========================================================================
ECHO Downloading NodeJS%NODE_VERSION% ... 
ECHO==========================================================================
REM curl -o node-v%NODE_VERSION%-x64.msi %NODE_DOWNLOAD_URL%
bitsadmin /transfer nodeJS_download_job /download %NODE_DOWNLOAD_URL% "%cd%\node-v%NODE_VERSION%-x64.msi"
ECHO Installing node-v%NODE_VERSION% ...
msiexec /i node-v10.24.1-x64.msi TargetDir=%NODE_LOCATION% /qb
ECHO==========================================================================
ECHO Nodejs installed in path : %NODE_LOCATION%
ECHO==========================================================================
IF ERRORLEVEL 1 (
		ECHO==========================================================================
		ECHO There was an error while installing nodeJs!
		ECHO==========================================================================
		msiexec /i "node-v%NODE_VERSION%-x64.msi"
		EXIT /B 1
)
EXIT /B 0

