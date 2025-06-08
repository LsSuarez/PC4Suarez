# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar solo el archivo del proyecto
COPY suarez.csproj ./
RUN dotnet restore

# Copiar el resto del contenido
COPY . ./
RUN dotnet publish -c Release -o /app/out

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copiar el resultado del build
COPY --from=build /app/out .

# Render usará el puerto indicado en la variable de entorno $PORT
ENV ASPNETCORE_URLS=http://+:$PORT

# Ejecutar la app principal (suarez.dll)
ENTRYPOINT ["dotnet", "suarez.dll"]
