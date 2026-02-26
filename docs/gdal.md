## GDAL
```
salut, pourquoi dit on que ogr GDAL est une librairie de bas niveau. 
Saurais tu m'expliquer ? 
SI ce n'est pas ça alors peux tu me l'expliquer aussi ?
```

### 1. Pourquoi on dit que OGR/GDAL est une librairie “bas niveau” ?

Déjà, précision :

GDAL = raster

OGR = vecteur
(OGR est aujourd’hui intégré dans GDAL, mais on garde le nom par habitude.)

**Quand on dit bas niveau, ça veut dire** : Elle manipule les structures de données géospatiales très proches de leur représentation brute (fichiers, drivers, géométries, buffers mémoire).

### 2. Concrètement, ça veut dire quoi ?

Avec GDAL/OGR, tu travailles directement avec :

- des drivers
- des datasources
- des layers
- des features
- des géométries
- des bandes raster
- des buffers mémoire

Tu dois gérer toi-même :

- l’ouverture / fermeture des datasets
- la gestion des erreurs
- les projections
- les conversions de type
- parfois la mémoire
- C’est proche du moteur.

### 3. Comparaison avec du “haut niveau”

🔹 Avec GDAL (bas niveau)

En Python : Tu manipules directement les objets internes.
```
ds = ogr.Open("parcelles.shp")
layer = ds.GetLayer()
for feature in layer:
    geom = feature.GetGeometryRef()
```
👉 Donc GDAL = moteur


🔹 Avec GeoPandas (haut niveau)

```
import geopandas as gpd
gdf = gpd.read_file("parcelles.shp")
```

En une ligne, tu as :

- lecture
- projection gérée
- dataframe prêt à analyser
- intégration avec pandas
- GeoPandas utilise GDAL en dessous.

👉 GeoPandas / QGIS / Fiona = carrosserie confortable

### 4. Analogie mécanique (version Olivier)

**GDAL, c’est :**

Le moteur thermique démonté sur l’établi.

**GeoPandas, c’est :**

La voiture clé en main.

**QGIS, c’est :**

Le tableau de bord + volant + GPS.

Toi, avec PostGIS, tu travailles plutôt au niveau “moteur optimisé sur banc d’essai” 😄

### 5. Pourquoi c’est important en géomatique ?

Parce que GDAL :

- supporte des centaines de formats

- est écrit en C/C++

- est ultra performant

- est la base de presque tous les outils SIG modernes

Sans GDAL :

- pas de QGIS

- pas de conversion massive de formats

- pas de raster reprojection rapide

### 6. Est-ce vraiment “bas niveau” ?

Ça dépend du point de vue :

Contexte	Niveau
Développeur C++	Moyen niveau
Data scientist Python	Bas niveau
Utilisateur QGIS	Très bas niveau

Donc le terme est relatif.

### 7. Pourquoi ça peut te parler particulièrement

Vu ton projet tiny house avec vues matérialisées en PostGIS :

Tu as déjà une approche “structure interne des données”.

GDAL est dans la même logique :

tu contrôles

tu comprends les couches

tu ne passes pas par une abstraction magique

Et comme tu aimes comprendre avant d’automatiser (je me souviens 😉), apprendre GDAL, c’est comme comprendre le BIOS avant d’écrire l’OS.


## CLI = Le mode ligne de commande dans une console

on peut utiliser mv pour déplacer mais aussi pour renommer

## PSQL
Rentrer dans psql

```bash
sudo apt install postgresql-client-16
psql -h 192.168.10.1 -p 15432 -U editeur -d olivier
```
liste des métacommandes "\..." ici : https://www.postgresql.org/docs/current/app-psql.html

## GDAL / OGR - Le géomagicien en ligne de commande

C'est la base de tous nos logiciels 
librairie libre attaquable depuis python, bash, R etc ...
https://gdal.org/en/stable/

dans linux ca marche bien


