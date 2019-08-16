FROM mcr.microsoft.com/dotnet/core/sdk:2.2
WORKDIR /Api

COPY  . ./


RUN dotnet publish WebAPI.sln -c Release -o Publish

ENTRYPOINT [ "dotnet", "/Api/WebAPI/Publish/WebAPI.dll" ]
