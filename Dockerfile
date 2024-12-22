# Stage 1: Build the application using the SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory to the project folder
WORKDIR /app

# Copy the project files into the container
COPY ./AdventureWorksVS ./

# Restore the dependencies (via NuGet)
RUN dotnet restore

# Publish the application in Release mode
RUN dotnet publish -c Release -o /publish

# Stage 2: Use the runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

# Set the working directory to /app for the runtime container
WORKDIR /app
EXPOSE 80

# Copy the published files from the build stage
COPY --from=build /publish .

# Set the entry point to run the application DLL
ENTRYPOINT ["dotnet", "AdventureWorksVS.dll"]



