

@echo off & setlocal EnableDelayedExpansion
color 0e & title Win7�����ȵ�ͻ��˹������
rem �����ȵ�ͻ��˲鿴����
rem �汾 0.2 Beta
(
set "ismode=" &rem �����ȵ�ģʽ�Ƿ�����
set "isstart=" &rem �����ȵ�״̬�Ƿ���
set "isap=" &rem �Ƿ��ҵ�ap��Ϣ
set "apssid=" &rem �����ȵ��ssid
set "apmac=" &rem �����ȵ�������ַ
set "apip=" &rem �����ȵ��IP��ַ
set "sumclient=" &rem ���ӵ������ȵ�Ŀͻ�������
set "clientip=" &rem �ͻ���ip
set "clientmac=" &rem �ͻ���mac
set "clientstate=" &rem �ͻ�����֤״̬
set "ipclass=" &rem �ͻ���ip����
set "n=" &rem ��ʱ����
)

:Begin
cls
echo �����ȵ���Ϣ:
rem ��ȡ�����ȵ�ģʽ��Ϣ
for /f "skip=3 tokens=2 usebackq delims=:" %%i in (`netsh wlan show hostednetwork`) do (
 if "!ismode!"=="" (
  if "%%i"==" ������" (set "ismode=true") else (set "ismode=false") 
  if "%%i"=="" (echo �����ȵ�ģʽ��������) else echo �����ȵ�ģʽ��%%i 
 )
)
rem ��ȡ�����ȵ�״̬��Ϣ
for /f "skip=11 tokens=2 usebackq delims=:" %%i in (`netsh wlan show hostednetwork`) do (
 if "!isstart!"=="" (
  if "%%i"==" ������" (set "isstart=true") else (set "isstart=false")
  if "%%i"=="" (echo �����ȵ�״̬��������) else echo �����ȵ�״̬��%%i
 )
)
rem ��ȡ�����ȵ��SSID��MAC��IP
if /i "!isstart!"=="true" (
 for /f "skip=4 tokens=1* usebackq delims=:" %%i in (`netsh wlan show hostednetwork`) do if "!apssid!"=="" set "apssid=%%j"  echo �����ȵ��SSID��!apssid!
 for /f "skip=12 tokens=1* usebackq delims=:" %%i in (`netsh wlan show hostednetwork`) do if "!apmac!"=="" set "apmac=%%j"  set "apmac=!apmac::=-!" &rem ��:ת��Ϊ-
 echo �����ȵ�������ַ��!apmac!
 for /f "tokens=1* usebackq delims=:" %%i in (`ipconfig /all`) do (
  if /i "%%j"==" !apmac!" set "isap=true" &rem �ѽ���ap��Ϣ
  if /i "!isap!"=="true" (
   set "n=%%i"
   if /i "!n:~0,7!"==" IPv4" (
    set "apip=%%j"
    set "isap=false" &rem ���뿪ap��Ϣ
   )
  )
 )
 for /f "delims=(" %%i in ("!apip!") do set "apip=%%i" &rem �����ip��ַ
 echo �����ȵ��IP��ַ��!apip!
) else echo δ���������ȵ㣬SSID������ & echo δ���������ȵ㣬IP�������ַ������
echo - - - - - - echo;

if /i not "!isstart!"=="true" (echo δ���������ȵ㣬�ͻ�����Ϣ������) else (
 echo ���ӵ������ȵ��ϵĿͻ�����Ϣ��
 rem ��ȡ�ͻ�������
 for /f "skip=15 tokens=2 usebackq delims=:" %%i in (`netsh wlan show hostednetwork`) do (
  if "!sumclient!"=="" (
   set "sumclient=%%i"
   echo ���ӵ������ȵ�Ŀͻ���������!sumclient!
  )
 )
 if !sumclient! gtr 0 (
  echo ��� ���� ��֤״̬ �����ַ IP��ַ
  set "n=1"
  for /f "skip=16 tokens=1,2 usebackq delims= " %%i in (`netsh wlan show hostednetwork`) do (
   set "clientmac=%%i"
   set "clientmac=!clientmac::=-!" &rem ��:ת��Ϊ-
   set "clientstate=%%j"
   for /f "tokens=1,3 usebackq delims= " %%l in (`arp -a -n %apip% ^| find /i "!clientmac!"`) do (
    set "clientip=%%l"
    set "ipclass=%%m"
   )
   echo !n! !ipclass! !clientstate! !clientmac! !clientip!
   set /a n+=1
  )
 ) else echo ��ǰû�пͻ������ӵ������ȵ���
)
echo - - - - - -
:return
@echo off
@echo ___________________________________
@echo +++++++++++����ѡ��++++++++++++++++
@echo + 1.�������߹��� +
@echo + 2.�������߹��� +
@echo + 3.����SSID��KEY+
@echo + 4.�޸�����KEY +
@echo + 5.��ʾ�ȵ���Ϣ +
@echo + 6.�˳����򲢹ر�WIFI +
@echo +++++++++++++++++++++++++++++++++++
set /p choice=��ѡ������
if %choice%==1 goto a
if %choice%==2 goto b
if %choice%==3 goto c
if %choice%==4 goto d
if %choice%==5 goto Begin
if %choice%==6 goto exit
cls
@echo -_-��sorry�����������������Ч����!
goto return
:a
netsh wlan stop hostednetwork
cscript /nologo ics.vbs "!apssid!" "������������" "off"
cscript /nologo ics.vbs "!apssid!" "��������" "on"
netsh wlan start hostednetwork
goto :end
:b
netsh wlan stop hostednetwork
cscript /nologo ics.vbs "!apssid!" "��������" "off"
cscript /nologo ics.vbs "!apssid!" "������������" "on"
netsh wlan start hostednetwork
goto :end
:c
@echo ��_��
@echo ���棺����Windows 7����������Ҫ����ԱȨ��
@echo ��ȷ�����Թ���Ա��ݵ�¼Windows������
@echo ����Ϊ������Windows 7��������
@echo ���μ��������������������(ssid)�Լ�������������(key)!!!
@pause
@echo off
echo ������������SSID������KEY
echo �����빲������������SSID��Enterȷ�ϣ���
set/p SSID=
echo ����������KEY(���Ȳ�����8λ������8λ������ʧ�ܣ�Enterȷ�ϣ���
set/p Password=
netsh wlan set hostednetwork mode=allow ssid=%SSID% key=%Password%
netsh wlan start hostednetwork
@echo ����OK��
cls
goto return
:d
@echo ���棺���μ��������������������(KEY)!!!
@echo off
echo ������������(���Ȳ�������8λ������8λ������ʧ�ܣ�Enterȷ�ϣ���
:PW2
set/p Password=

netsh wlan set hostednetwork mode=allow key=%Password%
netsh wlan start hostednetwork
cls
goto return
:end
rem cls
goto return
pause

:exit
cls
netsh wlan stop hostednetwork
@echo 3�������Զ��ر�
ping /n 1 /w 3000 1.0.0.1>nul
exit

rem
(
pause
set "apn=%%i"
set /p choice=ѡ��
if %choice%==Y goto l
if %choice%==y goto l
if %choice%==Y goto m
if %choice%==n goto m
for /f "usebackq tokens=2 delims= " %%i in (`ipconfig /all^|find "���߾�����������"`) do (
echo %%i

pause
netsh interface set interface name=!apn! newname=��������2
)
��