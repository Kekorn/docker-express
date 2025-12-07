# Létrehozzuk a tárolót a konténerünknek és kibontjuk a fájlokat
$path="C:\Docker\docker-express"

if(!(Test-Path $path)){
    New-Item $path -ItemType "directory"
    Expand-Archive -Path "$path.zip" -DestinationPath "$path" -Force
} 
Set-Location $path

# A VisualStudio Code megnyitása a projektmappával
code $path

# Git inicializálása és első commit létrehozása
if (!(Test-Path ".\.git" -PathType Container)) {
    git init
    git add .
    git commit -m "Initial commit"
} else {
    Write-Host "Már van Git tároló ebben a mappában."
}

# Alap Docker image letöltése:
#docker pull node:25.2.1-alpine3.23
docker pull m9g4gj/express-app:latest

# Saját konténer image létrehozása:
# (<.> a munkakönyvtár beállítása, ahol a Docker fájl található, <-t> verziózás <m9g4gj/express-app> a konténer neve)
docker build . -t m9g4gj/express-app

# Konténer futtatása:
# docker run -p 16111:3000 m9g4gj/express-app
docker run -d -p 16111:3000 m9g4gj/express-app

# A böngésző megnyitása a futó alkalmazással
# Start-Process "http://localhost:16111"

# Konténer leállítása (a konténer azonosítójának lekérése és leállítása)
# $containerId = docker ps -q --filter "ancestor=m9g4gj/express-app"
# docker stop $containerId
# docker rm $containerId
# docker ps -a

# A webapp publikus elérhetősége: https://express-docker-app.onrender.com/
# Github repo: https://github.com/m9g4gj/docker-express.git