#!/bin/bash

read -p "user ? : " DB_USER         	# utilisateur de la base de données PostgreSQL
read -p "ma base ? " DB_NAME      	    # nom de la base de données à sauvegarder
read -p "schema ? " DB_SCHEMA    # pour ne sauver que le schéma
current_date=$(date +%Y-%m-%d)
backup_file="/home/idgeo/sauv_${DB_NAME}${DB_SCHEMA}${current_date}.dump"

if ! pg_dump -U "$DB_USER" -F c "$DB_NAME" -n "$DB_SCHEMA" > "$backup_file"; then
echo "Echec: La sauvegarde de la bdd a échouée"
return 1
fi
printf "Sauvegarde de la base ok"