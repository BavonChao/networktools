chcp 936 &gt;nul
@echo off
mode con lines=30 cols=60
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
:main
cls
color 2f
echo   $       $              **********$****
echo **$**   **$**               $****$ $
echo   $   $   $                 $****$ $
echo   *$**$**$*              **********$****
echo ***$**$**$***               $****$ $
echo   *$**$**$*                 $****$ $
echo ******$******                    * $
echo       $                           *$
echo.----------------------------------------------------------- 
color 2e
echo.-----------------------------------------------------------
echo.ݔ��ָ�
echo.
echo. 1.���Qhosts��������ݔ��1��
echo.
echo. 2.�֏�hosts��������ݔ��2��
echo.-----------------------------------------------------------

if exist "%SystemRoot%\System32\choice.exe" goto Win7Choice

set /p choice=ݔ�딵��ָ��K��Enter�_�J:

echo.
if %choice%==1 goto host DNS
if %choice%==2 goto CL
cls
"set choice="
echo ݔ�����`��Ո�����x��
ping 127.0.1 -n "2">nul
goto main

:Win7Choice
choice /c 12 /n /m "ݔ�댦�����֣�"
if errorlevel 2 goto CL
if errorlevel 1 goto host DNS
cls
goto main

:host DNS
cls
color 2f
copy /y "hosts" "%SystemRoot%\System32\drivers\etc\hosts"
ipconfig /flushdns
echo.-----------------------------------------------------------
echo.
echo ���QHOSTS�ļ��ɹ���
goto end

:CL
cls
color 2f
@echo 127.0.0.1 localhost > %SystemRoot%\System32\drivers\etc\hosts
echo �֏�HOSTS�ļ��ɹ���
echo.
goto end

:end
echo �������I�˳�
@Pause>nul