# escape=`
FROM microsoft/windowsservercore:10.0.14393.1884
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ARG FILEBEAT_VERSION 
ENV ES_HOSTS= `
    LOGSTASH_HOSTS= 

VOLUME [ "C:\\ContainerLogs" ]

WORKDIR C:\\FilebeatInstall
RUN Invoke-WebRequest https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$env:FILEBEAT_VERSION-windows-x86_64.zip -OutFile Filebeat.zip; `
    Expand-Archive filebeat.zip .\Filebeat; `
    Copy-Item .\Filebeat\filebeat-$env:FILEBEAT_VERSION-windows-x86_64 'C:\Program Files\Filebeat' -Recurse

WORKDIR "C:\\Program Files\\Filebeat\\"
RUN powershell.exe -ExecutionPolicy Unrestricted -File install-service-filebeat.ps1
ADD filebeat.yml filebeat.yml

WORKDIR C:\\
ADD entrypoint.ps1 entrypoint.ps1

HEALTHCHECK --retries=5 --start-period=60s CMD powershell -command `
    if ((Get-Service "filebeat").Status -eq "Running") { return 0 } `
    else { return 1 };

ENTRYPOINT ["powershell", ".\\entrypoint.ps1"]