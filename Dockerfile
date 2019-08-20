FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
ADD  WebAPI/Publish /app
ENTRYPOINT ["dotnet", "WebAPI.dll"]