#!/bin/bash
read -p "Quel département ? : " DEP
read -p "lien de la bd alti : " ALTI
#création dossier ${DEP}, dossier mnt, dossier shp, dossier asc
mkdir ${DEP} && mkdir ${DEP}/mnt && mkdir ${DEP}/shp && mkdir ${DEP}/mnt/asc

echo "
dossiers créés
" >> ${DEP}/historique.txt

#téléchargement de la BD alti ariège et renommage
wget -P ${DEP}/mnt ${ALTI}

echo "
téléchargment terminé
" >> ${DEP}/historique.txt

LIST=$(find "$PWD" -name "*.7z" -printf '%f\n' | head -n 1)
LIST=${LIST%.7z}
echo "
Liste définie
" >> ${DEP}/historique.txt

#unzip de la bd alti ${DEP}
7z x ${DEP}/mnt/${LIST}.7z -o${DEP}/mnt/

echo "
!!! unzip ok !!!
" >> ${DEP}/historique.txt

DOSSIER_PARENT1="${DEP}/mnt/${LIST}/BDALTIV2/"
PREMIER_DOSSIER1=$(find ${DOSSIER_PARENT1} -mindepth 1 -maxdepth 1 -type d | sort | head -n 1)
DIR=$(basename "$PREMIER_DOSSIER1")
DOSSIER_PARENT2="${DEP}/mnt/${LIST}/BDALTIV2/${DIR}/"
PREMIER_DOSSIER2=$(find "$DOSSIER_PARENT2" -mindepth 1 -maxdepth 1 -type d | sort | head -n 1)
DIR2=$(basename "$PREMIER_DOSSIER2")
echo "${DIR}"

# bouge les fichiers asc d'un dossier à l'autre
mv ${DEP}/mnt/${LIST}/BDALTIV2/${DIR}/${DIR2}/* ${DEP}/mnt/asc/

#echo "transfert des .asc dans "${DEP}"/mnt/asc/ effectué" #>> ${DEP}/historique.txt

#suppression des zip et dossier en trop
rm -rf ${DEP}/mnt/${LIST}
rm ${DEP}/mnt/${LIST}.7z

# Construit un fichier vrt combinnant tous les fichiers asc de la bd alti téléchargée

gdalbuildvrt -srcnodata -0 -a_srs EPSG:2154 ${DEP}/mnt/mnt_${DEP}.vrt ${DEP}/mnt/asc/*.asc

echo "compilation dans vrt effectuée" #>> ${DEP}/historique.txt

# va chercher la couche ${DEP} dans le wfs et transforme en gpkg
ogr2ogr -s_srs EPSG:4326 -t_srs EPSG:2154 -nlt MULTIPOLYGON ${DEP}/shp/dep_${DEP}.gpkg WFS:https://data.geopf.fr/wfs/ows?VERSION=2.0.0 BDTOPO_V3:departement -where "code_insee='${DEP}'"

echo "fichier gpkg créé avec filtre departement" >> ${DEP}/historique.txt

# 
gdalwarp -overwrite -s_srs EPSG:2154 -t_srs EPSG:2154 -of VRT -cutline ${DEP}/shp/dep_${DEP}.gpkg -cl BDTOPO_V3:departement ${DEP}/mnt/mnt_${DEP}.vrt ${DEP}/mnt/mnt_${DEP}_decoupe.vrt

echo "découpe du vrt réalisée" >> ${DEP}/historique.txt

# Création de courbes de niveaux de 50 mètres
gdal_contour -a elev ${DEP}/mnt/mnt_${DEP}_decoupe.vrt ${DEP}/shp/niveau_50.shp -i 50

echo "Fichier de courbes réalisé dans ${DEP}/shp/" >> ${DEP}/historique.txt

# création d'un tiff d'ombrage
gdaldem hillshade -z 1 ${DEP}/mnt/mnt_${DEP}_decoupe.vrt ${DEP}/mnt/mnt_${DEP}_ombrage.tiff

echo "ombrage ok" >> ${DEP}/historique.txt

# Création d'un texte de couleur pour les variations 
echo "nv 255 255 255 0
100 254 235 231
250 252 198 187
400 250 161 143
550 248 124 99
700 245 73 39
950 244 50 11
1100 200 41 9
1250 156 32 7
1400 112 23 5
1550 68 14 3
1800 24 5 1" >> ${DEP}/color.txt

# création de variation en fonction de l'élévation
gdaldem color-relief ${DEP}/mnt/mnt_${DEP}_decoupe.vrt ${DEP}/color.txt ${DEP}/mnt/mnt_${DEP}_variation.vrt