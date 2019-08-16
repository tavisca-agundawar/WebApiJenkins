FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build

WORKDIR /home_dir

COPY  . ./


RUN dotnet publish WebAPI.sln -c Release -o Publish

ENTRYPOINT [ "dotnet", "/home_dir/WebAPI/Publish/WebAPI.dll" ]
