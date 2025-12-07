# Létrehozzuk a tárolót a konténerünknek:

$path="C:\Docker\docker-express"

if(!(Test-Path $path)){
    New-Item $path -ItemType "directory"
} 
Set-Location $path

# Bemásoljuk az előkészített projekt fájlokat a tárolóba:
Expand-Archive -Path "$path.zip" -DestinationPath "$path" -Force

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
docker pull node:25.2.1-alpine3.23

# Konténer image létrehozása:
# (<.> a munkakönyvtár beállítása, ahol a Docker fájl található, <-t> verziózás <m9g4gj/express-app> a konténer neve)
docker build . -t m9g4gj/express-app

# Konténer futtatása:
docker run -d -p 16111:3000 m9g4gj/express