# outils VRT
Apporté par OGR GDAL sous le format raster mais aussi vectoriel

## Definition

**Outils qui permet de connecter des données**

concept : reproductibilité + que l'automatisation

Outils logique ETL de transformation de fichiers : 
- Power Query
- FME
- Modeleur
- Postgis avec les vues : Pour changer une donné comme on le souhaite à la fin

Une vue en BDD : on ne duplique pas la donnée.
La vue est une présentation, via un script rejoué.

L'intérêt du VRT est un format qui défini une vue virtuelle sur une donnée
En général un fichier vrt qui correspond
Il est lisible nativement par OGR, QGIS, FME
Peut servir a faire des mises à jour.

Comment ne pas changer le fichier d'origine
Permet de faire de l'automatisation mai sdans le sens d'une vue c'est à dire qu'il ne créé pas un fichier conséquent

Principe du XML : Format très structuré très hiérarchique

**EXEMPLE DE FICHIER VRT** servant à récupérer des communes 47 et 32
```
<?xml version="1.0" encoding="UTF-8"?>
<OGRVRTDataSource>
  <OGRVRTUnionLayer name="communes4732">
    <SourceLayerFieldName>source</SourceLayerFieldName>
    <OGRVRTLayer name="Gers">
      <SrcDataSource relativeToVRT="1" shared="1">32/COMMUNE.shp</SrcDataSource>
      <!-- <SrcSql dialect="sqlite">SELECT * FROM 'COMMUNE' WHERE "INSEE_DEP"='32'</SrcSql> -->
      <SrcSql dialect="sqlite">SELECT *, 'coucou les gens de '||"NOM" AS hello FROM 'COMMUNE' WHERE "INSEE_DEP"='32'</SrcSql>
      <!-- <SrcSql dialect="sqlite">SELECT *, 'coucou les gens de '||"NOM" AS hello ,ST_Area(GEOMETRY)/10000 AS surf_total_ha FROM 'COMMUNE' WHERE "INSEE_DEP"='32'</SrcSql> -->
      <!-- <SrcLayer>COMMUNE</SrcLayer> --> 
```
Ici je crée tous mes noms de champs avec le typage et la minusculisation des noms qui supplante ensuite la partie SQL plus haut
```
      <Field name="ID" src="ID" type="String" width="24"/>
      <Field name="insee_com" src="INSEE_COM" type="String" width="5"/>
      <Field name="hello" src="hello" type="String" width="50"/>
      <Field name="INSEE_DEP" src="INSEE_DEP" type="String" width="5"/>
      <Field name="INSEE_REG" src="INSEE_REG" type="String" width="5"/>
      <Field name="NOM" src="NOM" type="String" width="80"/>
      <!-- <Field name="surf_total" src="surf_total" type="real"/> -->
    </OGRVRTLayer>
    <OGRVRTLayer name="Lot-et-garonne">
      <SrcDataSource relativeToVRT="1" shared="1">47/COMMUNE.shp</SrcDataSource>
      <SrcSql dialect="sqlite">SELECT * FROM 'COMMUNE' WHERE "INSEE_DEP"='47'</SrcSql>
      <!-- <SrcLayer>COMMUNE</SrcLayer> -->
      <Field name="ID" src="ID" type="String" width="24"/>
      <Field name="insee_com" src="INSEE_COM" type="String" width="5"/>
      <Field name="INSEE_DEP" src="INSEE_DEP" type="String" width="5"/>
      <Field name="INSEE_REG" src="INSEE_REG" type="String" width="5"/>
      <Field name="NOM" src="NOM" type="String" width="80"/>
    </OGRVRTLayer>
  </OGRVRTUnionLayer>
</OGRVRTDataSource>
```

## GDAL OGR

Licence permissive réutilisé par les logiciels qui vendent 

Vient du géospatial

FME utilise GDAL en sous jacent, il supporte tous les formats utilisés par GDAL

**GDAL** est le nom de la librairie il se réfère à toutes les fonctionnalités **RASTER**

**OGR** se réfère à toutes **les couches vecteurs**

Mais depuis il y a eu des évolutions.
Ils ont fournis des programmes de commandes, pour inspection, transformation, reprojection. 
C'est le concept ENTREE/ SORTIE, savoir lire et savoir ensuite écrire

Aujourd'hui on est intéressé par les outils vecteur : https://gdal.org/en/stable/programs/index.html#vector-programs
Il n'y en a pas beaucoup mais il y a des OTUILS très important comme [ogr2ogr](https://gdal.org/en/stable/programs/ogr2ogr.html#ogr2ogr)  et [ogrinfo](https://gdal.org/en/stable/programs/ogrinfo.html#ogrinfo)

Le cours peut être défini ici : [VRT en vecteur](https://gdal.org/en/stable/drivers/vector/vrt.html) et [VRT en raster](https://gdal.org/en/stable/drivers/raster/vrt.html)

A défaut d'utiliser des FME et d'oublier ce que l'on a fait, 
Faire de modifier des flux de façon reproductible
Originaire de la librairie GDAL
- OGR VRT, ça vous permet notamment de :
  - Faire l’économie d’un ETL
  - Autonomiser vos collègues amateurs d’Excel (et donc alléger votre charge de travail)
  - Augmenter la reproductibilité de vos flux de traitement de données
  - Automatiser vos flux de traitement de données
  - Frimer pendant une soirée (de géomaticiens)
- Supporté par QGIS
- Pas limité aux données tabulaires, loin de là. Mais les supporte
- Fichier XML, de configuration de la source de données. Permet de :
  - renommer des champs
  - changer le type des champs (entier, réel, date, texte)
  - ne conserver qu’un sous-ensemble des champs
  - choisir les champs définissant la géométrie (si présents)
  - filtrer le jeu de données via une requête SQL
  - découper sur une étendue via une requête SQL
  - reprojeter un jeu de données
  - fusionner plusieurs sources
  - charger des sources de données en ligne
  
**OGRINFO**
Elle permet  d'aller inspecter de la donnée vecteur notamment 

```
ogrinfo -so -al XX_nom_fichier_XX
```
Pour dézipper
```
ogrinfo /vsizip/XX_nom_fichier_XX.zip
```

Pour aller chercher url
```
ogrinfo /vsicurl/XX_nom_fichier_XX.zip
```

This driver supports [virtual I/O operations (/vsimem/, etc.)](https://gdal.org/en/stable/user/virtual_file_systems.html#virtual-file-systems) peut aller lire à l'intérieur

To point to a file inside a zip file, the filename must be of the form 
```
/vsizip/path/to/the/file.zip/path/inside/the/zip/file
```

vsistdin ou stdout envoi les données dans la console
**pour les réseaux** 
[/vsicurl/](https://gdal.org/en/stable/user/virtual_file_systems.html#vsicurl-http-https-ftp-files-random-access) et [/vsicurl_streaming/](https://gdal.org/en/stable/user/virtual_file_systems.html#vsicurl-http-https-ftp-files-random-access)  permettent de se connecter à des informations sur le web sans télécharger
