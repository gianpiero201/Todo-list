FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /Todo.Api

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /Todo.Api
COPY --from=build-env /Todo.Api/out .
ENTRYPOINT ["dotnet", "Todo.Api.dll"]
EXPOSE 80