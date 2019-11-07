FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';$ProgressPreference='silentlyContinue';"]

RUN Invoke-WebRequest -OutFile nodejs.zip -UseBasicParsing "https://nodejs.org/dist/v12.4.0/node-v12.4.0-win-x64.zip"; Expand-Archive nodejs.zip -DestinationPath C:\; Rename-Item "C:\\node-v12.4.0-win-x64" c:\nodejs

RUN Invoke-WebRequest -OutFile azulJDK8.zip -UseBasicParsing "https://repos.azul.com/azure-only/zulu/packages/zulu-8/8u202/zulu-8-azure-jdk_8.36.0.1-8.0.202-win_x64.zip"; Expand-Archive -Path azulJDK8.zip -DestinationPath 'C:\Program Files\Java\'

COPY twistcli.exe 'C:\TwistLock\twistcli.exe'

RUN SETX PATH '%path%;C:\nodejs;C:\Program Files\Java\zulu-8-azure-jdk_8.36.0.1-8.0.202-win_x64\bin;C:\TwistLock'

RUN npm config set registry https://registry.npmjs.org/

WORKDIR /azp

COPY start.ps1 .

CMD powershell .\start.ps1