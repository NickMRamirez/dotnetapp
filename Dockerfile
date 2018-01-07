FROM microsoft/aspnetcore-build:latest AS build
WORKDIR /src
COPY . .
RUN dotnet clean
RUN dotnet restore
RUN dotnet build
RUN dotnet publish -o /output

FROM microsoft/aspnetcore:latest
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80
WORKDIR /app
COPY --from=build /output .
ENTRYPOINT ["dotnet", "dotnetapp.dll"]