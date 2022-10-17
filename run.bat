@ECHO OFF
SET NODE_PATH="C:\KandiKit\node-v10.24.1-win-x86"
FOR /F %%F IN ('node.exe --version') DO SET NODE_M_VERSION=%%F
IF %NODE_M_VERSION% EQU v10.24.1 (
npm install
npm install -g gulp --save
start http://localhost:3000
gulp start

) ELSE (
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
