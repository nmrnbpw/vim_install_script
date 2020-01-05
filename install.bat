@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION
PUSHD "%~dp0"

SET VIM_VER=8.2.0083
SET PYTHON_VER=3.8.1
SET LUA_VER=5.3.5
SET CICA_VER=5.0.1

:: 8.2.0083 => 82
SET VIM_SHORT_VER=%VIM_VER:~0,1%%VIM_VER:~2,1%
SET VIM_URL=https://github.com/vim/vim-win32-installer/releases/download/v%VIM_VER%/gvim_%VIM_VER%_x64.zip
SET VIM_RT_URL=https://ftp.nluug.nl/pub/vim/pc/vim%VIM_SHORT_VER%rt.zip

SET PYTHON_URL=https://www.python.org/ftp/python/%PYTHON_VER%/python-%PYTHON_VER%-embed-amd64.zip
SET LUA_VC_VER=15
SET LUA_URL=https://sourceforge.net/projects/luabinaries/files/%LUA_VER%/Windows%%20Libraries/Dynamic/lua-%LUA_VER%_Win64_dll%LUA_VC_VER%_lib.zip/

SET CICA_URL=https://github.com/miiton/Cica/releases/download/v%CICA_VER%/Cica_v%CICA_VER%_with_emoji.zip
:: &: BATCH escape -> ^ , PowerShell escape -> `
REM SET NASU_URL=https://ja.osdn.net/frs/chamber_redir.php?m=iij`^&f=%%2Fusers%%2F7%%2F7587%%2FNasuFont-20141215.zip


rmdir /S /Q vim
mkdir vim
:: download
powershell Invoke-WebRequest -Uri %VIM_URL% -OutFile gvim%VIM_VER%.zip
powershell Invoke-WebRequest -Uri %VIM_RT_URL% -OutFile vim%VIM_SHORT_VER%rt.zip
:: extract
powershell Expand-Archive -Path gvim%VIM_VER%.zip -DestinationPath vim
powershell Expand-Archive -Path vim%VIM_SHORT_VER%rt.zip -DestinationPath vim -Force


:INSTALL_EXLANG
rmdir /S /Q python
mkdir python
:: download
powershell Invoke-WebRequest -Uri %PYTHON_URL% -OutFile python-%PYTHON_VER%-embed-amd64.zip
:: extract
powershell Expand-Archive -Path python-%PYTHON_VER%-embed-amd64.zip -DestinationPath python
SET PYTHON_DLL_VER=%PYTHON_VER:~0,1%%PYTHON_VER:~2,1%
copy python\python%PYTHON_DLL_VER%.dll vim\vim\vim%VIM_SHORT_VER%\
copy python\python%PYTHON_DLL_VER%.zip vim\vim\vim%VIM_SHORT_VER%\

rmdir /S /Q lua
mkdir lua
:: download (UsetAgent for SourceForge)
powershell Invoke-WebRequest -Uri %LUA_URL% -OutFile lua-%LUA_VER%_Win64_dll%LUA_VC_VER%.zip -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer
:: extract
powershell Expand-Archive -Path lua-%LUA_VER%_Win64_dll%LUA_VC_VER%.zip -DestinationPath lua
copy lua\lua53.dll vim\vim\vim%VIM_SHORT_VER%\

:INSTALL_FONT
rmdir /S /Q cica
mkdir cica
:: download
powershell Invoke-WebRequest -Uri !CICA_URL! -OutFile Cica_v%CICA_VER%_with_emoji.zip
:: extract
powershell Expand-Archive -Path Cica_v%CICA_VER%_with_emoji.zip -DestinationPath cica
:: prepare
pushd cica
mkdir fonts
:: install manually
move *.ttf fonts\
REM rmdir /S /Q nasu
REM mkdir nasu
REM :: download
REM powershell Invoke-WebRequest -Uri !NASU_URL! -OutFile NasuFont-20141215.zip -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer
REM :: extract
REM powershell Expand-Archive -Path NasuFont-20141215.zip -DestinationPath nasu
REM :: prepare
REM pushd nasu
REM mkdir fonts
REM :: install manually
REM move NasuFont20141215\*.ttf fonts
echo ********************************************************************************
echo    * Install this ttf fonts *
echo ********************************************************************************
call explorer fonts
popd

:INSTALL_VIM_PLUGIN
pushd vim\vim
mkdir .cache\dein\repos\github.com\Shougo\dein.vim
git clone https://github.com/Shougo/dein.vim .cache\dein\repos\github.com\Shougo\dein.vim
popd

ENDLOCAL
EXIT /B


