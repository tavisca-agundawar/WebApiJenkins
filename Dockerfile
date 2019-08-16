<<<<<<< HEAD
FROM mcr.microsoft.com/dotnet/core/sdk:2.2
WORKDIR /Api

COPY  . ./


RUN dotnet publish WebAPI.sln -c Release -o Publish

ENTRYPOINT [ "dotnet", "/Api/WebAPI/Publish/WebAPI.dll" ]
=======
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build

WORKDIR /home_dir

COPY  . ./


RUN dotnet publish WebAPI.sln -c Release -o Publish

ENTRYPOINT [ "dotnet", "/home_dir/WebAPI/Publish/WebAPI.dll" ]
>>>>>>> cfa01ea16ff7df0847d60d06f3fc7f00157390fe
