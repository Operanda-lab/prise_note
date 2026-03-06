#!/bin/bash

wget -P /mnt/d/olivier/git_work/prise_note/ -O /mnt/d/olivier/git_work/prise_note/gtfs.zip https://data.toulouse-metropole.fr/api/explore/v2.1/catalog/datasets/tisseo-gtfs/files/fc1dda89077cf37e4f7521760e0ef4e9

unzip /mnt/d/olivier/git_work/prise_note/gtfs.zip

cd /mnt/d/olivier/git_work/prise_note/gtfs/

mv routes.txt routes.csv && mv stop_times.txt relation_arret_trips.csv && mv stops.txt arrets.csv && mv trips.txt voyage.csv

rm agency.txt && rm calendar.txt && rm calendar_dates.txt && rm transfers.txt && rm shapes.txt

sed -i -e 's/,/;/g' -e 's/\./,/g' arrets.csv
sed -i -e 's/,/;/g' -e 's/\./,/g' relation_arret_trips.csv
sed -i -e 's/,/;/g' -e 's/\./,/g' voyage.csv
sed -i -e 's/,/;/g' -e 's/\./,/g' routes.csv

changer les lat et long de routes pour les mettre dans une colonne geom 4326

