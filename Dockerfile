# kiiduló image megadása
FROM node:25.2.1

# új felhasználó létrehozása a konténerben, hogy ne root-ként 
# fusson az alkalmazás 
# RUN addgroup appgroup &&  adduser -S -G appgroup appuser
RUN addgroup appgroup && adduser --system -ingroup appgroup appuser

# munka könyvtár beállítása
WORKDIR /app

# package-ok telepítése a konténerben
COPY package*.json ./
RUN npm install

# a szükséges fájlok konténerbe másolása (. . a jelenlegi könyvtárat és az abban lévő fájlokat jelenti, mint a *.*)
COPY . .

# jogok beállítása az új felhasználónak a konténerben lévő fájlokra
# olvasási jog a fájlokra és könyvtárakra
RUN chown -R appuser:appgroup /app
# minden jog a létrehzó felhasználónak a könyvtárra
RUN chmod 755 /app

# váltás az új felhasználóra
USER appuser

# alkalmazás portjának megnyitása a konténerben
EXPOSE 3000

# a konténer indítási parancsa - futtassa a fő fájlt közvetlenül vagy az npm start parancsot
# A legtisztább megoldás: node app.js
CMD ["node", "app.js"]