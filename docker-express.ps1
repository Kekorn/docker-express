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

git init
git add .
git commit -m "Initial commit"