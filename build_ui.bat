@ECHO off

REM ui�t�@�C����py�t�@�C���ɕϊ�

IF "%1"=="" (GOTO usage)
IF "%1"=="/?" (GOTO usage)
IF "%1"=="-h" (GOTO usage)
IF "%1"=="--help" (GOTO usage)

SET VENV=%USERPROFILE%\venv_pyside
IF NOT "%2"=="" (
	SET VENV=%2
)

SET PYSIDE_COMPILER=%VENV%\Scripts\pyside-uic.exe
SET PYSIDE_RESOURCE=%VENV%\Lib\site-packages\PySide\pyside-rcc.exe
SET PYSIDE_SUBDIR=PySide

SET PYSIDE2_COMPILER=%VENV%\Scripts\pyside2-uic.exe
SET PYSIDE2_RESOURCE=%VENV%\Lib\site-packages\PySide2\pyside2-rcc.exe
SET PYSIDE2_SUBDIR=PySide2

SET UI_FILEPATH=%1
SET UI_DIRPATH=%~dp1
SET UI_FILENAME=%~nx1
SET UI_FILEHEAD=%~n1
SET QRC_FILENAME=%UI_FILEHEAD%.qrc


ECHO PUSHD %UI_DIRPATH%
PUSHD %UI_DIRPATH%

REM .ui
ECHO %PYSIDE_COMPILER% %UI_FILENAME% -o %PYSIDE_SUBDIR%\%UI_FILEHEAD%.py
%PYSIDE_COMPILER% %UI_FILENAME% -o %PYSIDE_SUBDIR%\%UI_FILEHEAD%.py
ECHO %PYSIDE2_COMPILER% %UI_FILENAME% -o %PYSIDE2_SUBDIR%\%UI_FILEHEAD%.py
%PYSIDE2_COMPILER% %UI_FILENAME% -o %PYSIDE2_SUBDIR%\%UI_FILEHEAD%.py

REM .qrc
IF EXIST %QRC_FILENAME% (
	ECHO %PYSIDE_RESOURCE% %QRC_FILENAME% -o %PYSIDE_SUBDIR%\%UI_FILEHEAD%_rc.py
	%PYSIDE_RESOURCE% %QRC_FILENAME% -o %PYSIDE_SUBDIR%\%UI_FILEHEAD%_rc.py
	ECHO %PYSIDE2_RESOURCE% %QRC_FILENAME% -o %PYSIDE2_SUBDIR%\%UI_FILEHEAD%_rc.py
	%PYSIDE2_RESOURCE% %QRC_FILENAME% -o %PYSIDE2_SUBDIR%\%UI_FILEHEAD%_rc.py
)

ECHO POPD
POPD


GOTO end

:usage
	ECHO;
	ECHO PySide��PySide2��ui-compiler��ui�t�@�C����py�t�@�C���ɕϊ����܂��B
	ECHO �o�͐�͎w�肵��.ui�t�@�C������̑��΃p�X��PySide/��PySide2/�f�B���N�g���ł��B
	ECHO �܂��A������.qrc�t�@�C�������݂���ꍇ��_rc.py�t�@�C���ւ̕ϊ����s���܂��B
	ECHO;
	ECHO USAGE: %~nx0 ui-filename [virtualenv-path]
	GOTO end

:error

:end
