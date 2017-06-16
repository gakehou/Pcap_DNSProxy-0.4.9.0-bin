:: Pcap_DNSProxy routing list update batch
:: Pcap_DNSProxy, a local DNS server based on WinPcap and LibPcap
:: Author: muink, Chengr28


@echo off&title ���Ѫ�@���s
mode con: cols=80 lines=28

:: Go to batch dir.
cd /D "%~dp0"

:[inte]
:: ���������
md latest\ipv4>nul 2>nul
md latest\ipv6>nul 2>nul
:: �ˬdbin�{�ǲէ����
..\Support\md5 -c609F46A341FEDEAEEC18ABF9FB7C9647 ..\Support\md5.exe 2>nul||echo.�̿�{�Ǧ��G�Q�}�a�F, ���s�w�ˤ@���ո�?&&ping -n 5 127.0.0.1>nul&&goto END
..\Support\md5 -cA0BAC06597560FFDE52C225659F2BF3A ..\Support\curl.exe 2>nul||echo.�̿�{�Ǧ��G�Q�}�a�F, ���s�w�ˤ@���ո�?&&ping -n 5 127.0.0.1>nul&&goto END
..\Support\md5 -cC95C0A045697BE8F782C71BD46958D73 ..\Support\sed.exe 2>nul||echo.�̿�{�Ǧ��G�Q�}�a�F, ���s�w�ˤ@���ո�?&&ping -n 5 127.0.0.1>nul&&goto END
..\Support\md5 -c9A5E35DCB4B35A2350E6FDF4620743B6 ..\Support\CCase.exe 2>nul||echo.�̿�{�Ǧ��G�Q�}�a�F, ���s�w�ˤ@���ո�?&&ping -n 5 127.0.0.1>nul&&goto END

if not "%~1" == "" (
	if "%~1" == "-LOCAL" (set ST=%~1) else goto %~1
)

:[main]
:: �Ԩ�FTP�ƾ�
title ���Ѫ�@���s: �Ԩ��ƾڤ�...
call:[DownloadData]

:: ���ҷs��LIST���MD5
title ���Ѫ�@���s: ���Ҽƾڤ�...
call:[Hash_DAL]

:: �Y����s,�q���a�w�s���ؼƾکΨ�����s
:RebuildDAL
setlocal enabledelayedexpansion
cls
if defined DALmd5_lab (
	set ny=y&set /p ny=���ݼƾڥ���s,�q���a���ؤ@�����Ѫ�?[Y/N]
	if "!ny!" == "y" endlocal&goto BuildCNIP
	if "!ny!" == "n" exit
	endlocal&goto RebuildDAL
)
endlocal

:: ����CN�a��IP�ƾ�
:BuildCNIP
call:[ExtractCNIPList] 4
call:[ExtractCNIPList] 6

:: ���ҷs��IP�ƾ�MD5
call:[Hash_CNIPList] 4
call:[Hash_CNIPList] 6
:: �p�Gcnip�C����s,�h�������cnip���Ѫ�w�s���ةΪ������ظ��Ѫ�
if defined IPV4md5_lab if exist #Routingipv4# set IPV4RoutCache=EXIST
if defined IPV6md5_lab if exist #Routingipv6# set IPV6RoutCache=EXIST

:: �зǤƭ�l�ƾ�
:FormatIPList
title ���Ѫ�@���s: ��z�ƾڤ�...
del /s/q "%temp%\#ipv4listLab#" >nul 2>nul
del /s/q "%temp%\#ipv6listLab#" >nul 2>nul
if not defined IPV4RoutCache null>"%temp%\#ipv4listLab#" 2>nul&start /min "���Ѫ�@���s: �ͦ�ipv4���Ѫ�..." "%~f0" [FormatIPV4List]S
if not defined IPV6RoutCache null>"%temp%\#ipv6listLab#" 2>nul&start /min "���Ѫ�@���s: �ͦ�ipv6���Ѫ�..." "%~f0" [FormatIPV6List]S
:FormatIPList_DetectLabel
:: �˴��������ݼлx
if exist "%temp%\#ipv4listLab#" ping /n 3 127.0.0.1>nul&goto FormatIPList_DetectLabel
if exist "%temp%\#ipv6listLab#" ping /n 3 127.0.0.1>nul&goto FormatIPList_DetectLabel

:WriteFile
:: �X�־�X�ƾ�
(echo.[Local Routing]
echo.## China mainland routing blocks
echo.## Source: https://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest
echo.## Last update: %date:~0,4%-%date:~5,2%-%date:~8,2%)>Routing.txt
:: �ЫئC���Y���
call:[WriteIPHead] 4
call:[WriteIPHead] 6
:: ��X�ƾ�
copy /y/b Routing.txt+"%temp%\IPv4ListHead"+#Routingipv4#+"%temp%\IPv6ListHead"+#Routingipv6# Routing.txt
goto END

:[DownloadData]
copy /b/y ..\Support\curl.exe %temp% >nul
cd /D %temp%
if not "%ST%" == "LOCAL" (
	curl "https://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest" -o "delegated-apnic-latest"
	del /F /Q curl.exe
	cd /D "%~dp0"
	copy /b/y "%temp%\delegated-apnic-latest" .\delegated-apnic-latest >nul
) else (
	curl "file://%~dp0delegated-apnic-latest" -o "delegated-apnic-latest" 2>nul||del /F /Q curl.exe&&echo.���s�b���a���..&&ping /n 2 127.0.0.1>nul&&goto END
	del /F /Q curl.exe
	cd /D "%~dp0"
)
goto :eof

:[Hash_DAL]
setlocal enabledelayedexpansion
:: ����s���MD5
for /f "delims=" %%i in ('..\Support\md5 -n "%temp%\delegated-apnic-latest"') do set DAL_newmd5=%%i
:: ����̫�@����s�ɪ�MD5
for /f "delims=." %%i in ('dir /a:-d/b ".\latest\*.md5" 2^>nul') do set DAL_oldmd5=%%i
if not defined DAL_oldmd5 set DAL_oldmd5=00000000000000000000000000000000
:: �ƾڼh�����t�O����
if "%DAL_oldmd5%" == "%DAL_newmd5%" (
	:: �ƾڥ���s,�лx�챾�_
	set DALmd5_lab=EQUAL
) else (
	:: �ƾڤw��s,��s���a�w�s
	copy /b/y "%temp%\delegated-apnic-latest" ".\latest\%DAL_oldmd5%.md5" >nul
	ren ".\latest\%DAL_oldmd5%.md5" "%DAL_newmd5%.md5" >nul 2>nul
)
del /s/q "%temp%\delegated-apnic-latest" >nul 2>nul
for /f "tokens=1-2 delims=|" %%i in ("%DAL_newmd5%|%DALmd5_lab%") do endlocal&set DALmd5=%%i&set DALmd5_lab=%%j
goto :eof

:[ExtractCNIPList]
:: ����cnip�C��
type ".\latest\%DALmd5%.md5"|findstr ipv%1|findstr CN>"%temp%\#listipv%1#"
goto :eof

:[Hash_CNIPList]
setlocal enabledelayedexpansion
:: ����s���MD5
for /f "delims=" %%i in ('..\Support\md5 -n "%temp%\#listipv%1#"') do set IPV%1_newmd5=%%i
:: ����̫�@����s�ɪ�MD5
for /f "delims=." %%i in ('dir /a:-d/b ".\latest\ipv%1\*.md5" 2^>nul') do set IPV%1_oldmd5=%%i
if not defined IPV%1_oldmd5 set IPV%1_oldmd5=00000000000000000000000000000000
:: �ƾڼh�����t�O����
if "!IPV%1_oldmd5!" == "!IPV%1_newmd5!" (
	:: �ƾڥ���s,�лx�챾�_
	set IPV%1md5_lab=EQUAL
) else (
	:: �ƾڤw��s,��s���a�w�s
	copy /b/y "%temp%\#listipv%1#" ".\latest\ipv%1\!IPV%1_oldmd5!.md5" >nul
	ren ".\latest\ipv%1\!IPV%1_oldmd5!.md5" "!IPV%1_newmd5!.md5" >nul 2>nul
)
del /s/q "%temp%\#listipv%1#" >nul 2>nul
for /f "tokens=1-2 delims=|" %%i in ("!IPV%1_newmd5!|!IPV%1md5_lab!") do endlocal&set IPV%1md5=%%i&set IPV%1md5_lab=%%j
goto :eof

:[FormatIPV6List]S
:: �зǤ�ipv6�C��
@echo off&title ���Ѫ�@���s: �ͦ�ipv6���Ѫ�...
(for /f "tokens=4-5 delims=|" %%i in ('type ".\latest\ipv6\%IPV6md5%.md5"') do echo %%i/%%j|..\Support\ccase)>#Routingipv6#
:: �R���������ݼлx
del /s/q "%temp%\#ipv6listLab#" >nul 2>nul
exit

:[FormatIPV4List]S
:: �зǤ�ipv4�C��
@echo off&title ���Ѫ�@���s: �ͦ�ipv4���Ѫ�...
(for /f "tokens=4-5 delims=|" %%i in ('type ".\latest\ipv4\%IPV4md5%.md5"') do echo.%%i/%%j#)>#Routingipv4#
set /a index=1,indexx=2,index_out=0
set str=*&set lop=0
:[FormatIPV4List]S_LOOP
if %lop% geq 32 start /w "���Ѫ�@���s: �ͦ�ipv4���Ѫ�o�Ϳ��~..." "%~f0" [FormatIPV4List]S_ERROR&goto END
for /f "tokens=1-2 delims=/#" %%i in ('findstr /v "%str%" #Routingipv4#') do (
	set address=%%i&set /a value_mi=%%j
	call:[SearchLIB]
	set /a lop+=1
	goto [FormatIPV4List]S_LOOP
)
..\Support\sed -i "s/#//g" #Routingipv4#
goto [FormatIPV4List]S_END
:[FormatIPV4List]S_ERROR
echo.�C��s�b�������~,�Y�N�h�X...
ping /n 3 127.0.0.1>nul
:[FormatIPV4List]S_END
:: �R���������ݼлx
del /s/q "%temp%\#ipv4listLab#" >nul 2>nul
exit

:[SearchLIB]
for /f "tokens=1-2 delims=/" %%i in ('findstr "%value_mi%\/" Log_Lib 2^>nul') do set count=%%j
if not defined count call:[logT]
:: �����Ҧ� /%value_mi% ? /%count%
..\Support\sed -i "s/\/%value_mi%#/\/%count%#/g" #Routingipv4#
if not "%str%" == "*" (set str=%str% \/%count%#) else set str=\/%count%#
set count=
goto :eof

:[logT]
:: value_mi �ȤŶW�L 2^31-1 �]�N�O 2147483647,�ѩ� 2147483647 ���O 2 ����,��ڱ��p�O�̤j 2^30 �]�N�O 1073741824
:[logT][inte]
setlocal enabledelayedexpansion
if %value_mi% == 0 goto [logT][end]
if %value_mi% == 1 goto [logT][end]
:[logT][main]
if %value_mi% gtr 1 (
	set /a value_mi">>="index,index_out+=index
	if !value_mi! equ 1 goto [logT][end]
	if !value_mi! lss 1 set /a index=1,indexx=2,value_mi=%value_mi%,index_out=%index_out%&goto [logT][main]
	if !value_mi! lss !indexx! set /a index=1,indexx=2&goto [logT][main]
	if !value_mi! equ !indexx! set /a index_out+=index&goto [logT][end]
	set /a index*=2,indexx*=indexx
	goto [logT][main]
)
:[logT][end]
for /f %%s in ("%index_out%") do endlocal&set /a count=32-%%s
echo.%value_mi%/%count%>>Log_Lib
goto :eof

:[WriteIPHead]
:: �g�J�C���Y
(echo.
echo.
echo.## IPv%1
)>"%temp%\IPv%1ListHead"
goto :eof

:END
exit
