@echo off
color f0
Title Proctor Scheduler Certificates
cls
echo Clearing old Directories...
RMDIR /S /Q "C:\APPS\Certificates"

echo Changing Directory...
cd C:\APPS

echo Creating New directories and files...
md C:\APPS\Certificates
md C:\APPS\Certificates\ProctorScheduler
REM echo >C:\APPS\Certificates\ProctorScheduler\.keystore

echo Changing Directory...
echo.
echo Is this helpful? "%JAVA_HOME%"
echo.

set /p javahome="JAVA_HOME: "
cd %javahome%\bin

echo.
echo Starting keystore...
echo. 

REM keytool -importkeystore -srckeystore C:\APPS\Certificates\ProctorScheduler\.keystore -destkeystore C:\APPS\Certificates\ProctorScheduler\.keystore -deststoretype pkcs12
REM keytool -genkey -keystore "C:\APPS\Certificates\ProctorScheduler\.keystore" -alias ALIAS -keyalg RSA -keysize 4096 -validity 720
keytool -genkey -keystore "C:\APPS\Certificates\ProctorScheduler\.keystore" -alias ALIAS -deststoretype pkcs12 -validity 720

echo.
echo Keystore is finished
echo. 


echo Is this helpful? "C:\xampp; C:\APPS\xampp"
echo.

set /p xampphome="XAMPP: "
echo.

echo Changing Directory...
cd %xampphome%\tomcat\conf
echo.

echo Enter your Keystore password:
set /p pass="Password: "

echo.
echo Here is your XML to paste in.
echo.

echo ^<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
echo        maxThreads="150" SSLEnabled="true" scheme="https" secure="true"
echo        clientAuth="false" sslProtocol="TLS"
echo        keyAlias="ALIAS" keystoreFile="C:\APPS\Certificates\ProctorScheduler\.keystore"
echo        keystorePass="%pass%" /^> 
echo.

echo Saving a copy at "C:\APPS\Certificates\ProctorScheduler\Connector.xml"
(
    echo ^<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
    echo        maxThreads="150" SSLEnabled="true" scheme="https" secure="true"
    echo        clientAuth="false" sslProtocol="TLS"
    echo        keyAlias="ALIAS" keystoreFile="C:\APPS\Certificates\ProctorScheduler\.keystore"
    echo        keystorePass="%pass%" /^> 
)>C:\APPS\Certificates\ProctorScheduler\Connector.xml
echo.

echo When you are done copying, press any key to open the xml file
pause>nul

echo Opening Server.xml...
code %xampphome%\tomcat\conf\server.xml
pause