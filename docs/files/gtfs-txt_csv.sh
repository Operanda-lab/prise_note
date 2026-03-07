#!/bin/bash

# pour éviter les bugs silencieux
# -----------------------------------
set -e # stop si une commande échoue
set -u # stop si une variable n'existe pas
set -o pipefail
# -----------------------------------

# création de variable avec le chemin d'enregistrement sur le wsl linux et le lien vers le fichier zip trouvé sur le web
# -----------------------------------

echo "------ Téléchargement GTFS ------"

# bien commencer et finir son chemin par les slash '/'
read -p "chemin linux de téléchargement : " chemin

# attention le lien ne doit pas proposé le .zip car il sera rajouté ensuite dans le script
read -p "lien du fichiez GTFS zip : " lien_ZIP

#nom du dossier GTFS final
read -p "nom du dossier GTFS final : " GTFS
# -----------------------------------

# recupération du lien et téléchgargement dans le dossier spécifié, rennomage en GTFS.zip et
echo "Téléchargement..."
sudo apt install wget
wget -q --show-progress -P ${chemin} -O ${chemin}${GTFS}.zip ${lien_ZIP}

# Unzip du fichier GTFS téléchargé dans un dossier GTFS
echo "Extraction..."
sudo apt install zip
unzip -d ${chemin}${GTFS}/ ${chemin}${GTFS}.zip
rm ${chemin}${GTFS}.zip


cd ${chemin}${GTFS}/

echo "------ Nettoyage fichiers ------"

mv routes.txt routes.csv
mv stop_times.txt relation_arret_trips.csv &
mv stops.txt arrets.csv
mv trips.txt voyage.csv

rm -f agency.txt calendar.txt calendar_dates.txt transfers.txt shapes.txt

echo "------ Conversion séparateurs ------"

sed -i -e 's/,/;/g' arrets.csv
sed -i -e 's/,/;/g' relation_arret_trips.csv
sed -i -e 's/,/;/g' voyage.csv
sed -i -e 's/,/;/g' routes.csv

echo "------ Création géométrie arrêts ------"

ogr2ogr \
-f CSV "${chemin}${GTFS}/arrets_geom.csv" "${chemin}${GTFS}/arrets.csv" -lco GEOMETRY=AS_WKT -lco SEPARATOR=SEMICOLON -dialect SQLite -sql "SELECT *, MakePoint(CAST(stop_lon AS DECIMAL), CAST(stop_lat AS DECIMAL), 4326) AS geom FROM arrets"

mv ${chemin}${GTFS}/arrets_geom.csv ${chemin}${GTFS}/arrets.csv

echo "------ Terminé ------"
