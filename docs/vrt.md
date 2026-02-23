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
on peut choisir un des deux en fonction s des serveurs. si il y en a un qui marche pas alors il faut changer
[/vsicurl/](https://gdal.org/en/stable/user/virtual_file_systems.html#vsicurl-http-https-ftp-files-random-access) et [/vsicurl_streaming/](https://gdal.org/en/stable/user/virtual_file_systems.html#vsicurl-http-https-ftp-files-random-access)  permettent de se connecter à des informations sur le web sans télécharger


## POURQUOI VRT vs CSV dans QGIS

Déjà parce que je peux renommer les champs etc ...
Ensuite la méthode est manuelle sur qgis alors que si je veux importer dans un nouveau projet qgis je suis obligé de refaire
Autre avantage tout es rassemblé si je mets d'autres CSV


## SPREAD SHEET
depuis un fichier excel ou csv permet de créer un fichier VRT de base assez bien pour commencer son fichier vrt final

Ensuite pour faire des comandes SQL
il faut changer

```
<SrcLayer>DEP</SrcLayer>
```

par
```
<SrcSQL dialect="sqlite">SELECT *, pp_vacant_24/pp_total_24 as tx_vacant_2024 FROM 'DEP'</SrcSQL>
```

```
  Generate a VRT file from a OGR-compatible source. The result is to be
  considered as a "kickoff" VRT file, to refine according to your desires but
  it will save you some time.

  SOURCE can be a local file or a remote URL

Options:
  -o, --out_file TEXT  Output file name. Default: name of the template,
                       without the jinja extension
  --relative_to_file   When building the datasource string, wheter to use
                       absolute path or not. Defaults to absolute
  -d, --db_friendly    convert layer and field names to DB-friendly names (no
                       space, accent, all-lowercase)
  --no_vsicurl         do not even try to use vsicurl. Prefer download and
                       local use
  --data_formats TEXT  file extensions to look for when querying an archive
                       (zip, tgz, etc). Defaults to a list of common data file
                       extensions
  --logfile TEXT       logfile path. Default: prints logs to the console
  -t, --template TEXT  template file path. Default: templates/vrt.j2
  -v, --verbose        verbose output (debug loglevel)
  --help               Show this message and exit.
  
  ```
  -d = database friendly cad renomme les champs  en petite casse et sans accent
  -o = crée le fichier dans le dossier
  Si on lui donne une url il va essayer de faire un lien optimisé
 
**EXERCICE 2** 
 ``` 
   ogr2vrt_cli generate-vrt -d -o donnee_commune.vrt https://www.data.gouv.fr/api/1/datasets/r/b7ce51bf-5675-4843-b618-247ef209416d
 ```

**EXERCICE 3** 
 Pour vérifier les 10 premières lignes  du résultat potenteil du VRT
 
  ``` 
 ogr2ogr -f CSV /vsistdout/ bourse.vrt | head
 ``` 
 
 /mnt/d/olivier/A2_VRT/dev/formation_VRT/exos/exo3

## CRON 

**EXERCICE 7**

Intéressant pour faire une tache toute seule a des intervalles de temps réguliers

### Déroulé
#### Mise en route de cron

A défaut d'accéder à un serveur, on va activer temporairement cron sur votre instance WSL2. Dans une console linux : 

```
# On regarde si cron tourne (en principe non)
sudo service cron status
# S'il n'est en effet pas activé, on le démarre
sudo service cron start
```

Vous trouverez plein de docs sur crontab sur le net. Par exemple : https://www.linuxtricks.fr/wiki/cron-et-crontab-le-planificateur-de-taches. 

#### Utilisation de cron

On va commencer par une tâche bêbête : créer un fichier et changer sa date de modif. Comme ça on saura si cron marche

`crontab -e` pour éditer le ficher de config cron.

Et on ajoute la ligne
```
* * * * * touch ~/cron-marche.txt
```
Sauvegardez.

Attendons maintenant une minute, et le fichier devrait avoir été créé dans ~/cron-marche.txt : `ls -la ~/` devrait vous le montrer.

Attendez encore une minute ou deux, recommencez la commande ls, la date de modif du fichier doit avoir changé. Ca marche.

#### Publication/mise à jour automatique de la donnée

Vous avez noté la commande utilisée pour la publication de l'exercice 5 ? Allez, on l'automatise.

A savoir que cron ne sait pas tout. Pas tout ce qu'on sait. Il n'a pas accès à nos variables d'environnement. Le mot de passe postgresql par exemple. Et ne sait pas toujours où trouver les fichiers exécutables, en dehors de la base. On va donc lui faciliter la tâche : 

1. on localise le chemin complet vers la commande ogr2ogr : `which ogr2ogr`. On utilisera ce chemin pour l'appeler dans la ligne cron
1. on va faire simple, on va utiliser le mot de passe et les autres valeurs en clair dans la commande. Ajustez votre commande ogr2ogr en fonction. Dans la "vie réelle", on procéderait différemment, par exemple avec un fichier `.pgpass`.
1. allez, zou, `crontab -l` et programmez une publi de votre fichier toutes les 5 minutes (on pensera à supprimer cette tâche en fin de cours, afin de ne pas republier cette donnée éternellement).

_**Faites un `crontab -l` et faites-en une copie d'écran, pour le livrable de cet exercice.**_


Cela vous donne-t-il des idées de tâches de votre quotidien (pro) que vous pourriez automatiser ainsi ? On peut prendre un instant pour en discuter.

---

*[Exercice suivant](exercice8.md)*

## Exercice 8 : faisons une 'appli' basique de crowdsourcing

***Nous allons faire cet exercice ensemble.***

Google Sheet est capable d'exposer son contenu sur le web au format CSV :   Fichier->Partager->Publier sur le web.  
Il faut bien faire attention à 

- définir un lien pour le document complet, pas juste la feuille
- choisir un format CSV
- activer la publication


### Source de donnée

Nous allons utiliser une feuille Google Sheet pour collecter des observations d'ours sur l'Ariège.

J'ai créé une feuille, sur laquelle vous pouvez saisir vos observations de plantigrades : 

https://docs.google.com/spreadsheets/d/1S5FwbLntADv9ztYlmUrHw83PFOyWCycM5WD8308ttBo/edit?usp=sharing


### Déroulé

- Créer le fichier VRT qui permet de publier cette donnée. Pour obtenir le lien correct, on va dans Fichier -> Partager-> Publier sur le web : https://docs.google.com/spreadsheets/d/e/2PACX-1vRRhuM4Y4JVH-f_ggR8EiHG8cEkqHR5hfLMzursUWTj130ffZEkRY9o8uEwUe63Nr8v-F5pFHqJRYo_/pub?output=csv
- La publier en BD
- La joindre avec la couche des communes, filtrée sur l'Ariège
- Faire une jolie carte montrant combien d'observations ont eu lieu par commune.

Avec une tâche cron, on peut mettre cette donnée à jour toutes les qq minutes, et avoir une carte quasi temps-réel pour suivre une collecte en mode collaboratif.

---

*[Lien suivant](conclusion.md)*

# Infos utiles

## Connexion à la base de données

On utilisera la base de donnée servie sur l'ordi du formateur (s'appuyer sur docker/docker-compose.yml). 

Les paramètres de connexion seront es suivants : 
- hôte : IP à voir en fonction de la config réseau
- port : `5432` 
- user: `cpgeom`
- mot de passe: `secret`
- schema : vous créerez un schema qui vous sera propre : première lettre du prénom suivi du nom de famille (dans mon cas par exemple : `jpommier`)

Oui, je sais. Ce n'est absolument pas sécurisé. Ce n'est en effet pas un cours sur les bases de données, plutôt sur l'étape en amont (publication/transfo des données).

### *Pour info*, cas d'une connexion à une BD distante, sécurisée, accès via tunnel ssh

En général, vous ne pourrez pas accéder directement à une BD externe sur le port 5432. En effet, pour que cela soit possible en sécurité, cela implique de configurer une connexion cryptée, à minima. Et malgré tout, la BD reste un peu exposée.

En général, ce qui se fait, c'est de maintenir la BD dans un réseau interne, qui n'est pas accessible directement depuis internet. Ensuite, trois options : 
1. ben... pas d'accès externe du tout. Pas pratique, mais le plus secure.
2. accès via un VPN
3. accès via un tunnel SSH. Dans ce cas, un accès SSH sur une machine du réseau interne est possible. Cette machine pouvant elle-même accéder à la BD. Dans ce cas, on peut configurer ce qu'on appelle un *tunnel SSH* : une connexion sécurisée est établie entre votre PC et la machine SSH, avec une configuration permettant de relier la BD *à travers* ce tunnel. On joue à saute-moutons si vous voulez.


Le tunnel SSH, nous permettra de faire correspondre un port de notre machine (localhost) avec le port 5432 de la machine *comme si on était dessus*, via une connection cryptée SSH.

La commande est la suivante :
```
ssh -L 15432:localhost:5432 my_user@my_server
```
*Il faudra garder cette connection ssh ouverte tout le temps qu'on voudra accéder à la base à distance*
Et la BD sera accessible localement, sur notre ordi, à localhost:15432

**Note** :
- sous Windows, ça peut aussi se configurer, avec un outil comme Putty par exemple
- pgadmin4 aussi, sait configurer une connexion via tunnel SSH. Le hic étant qu'on ne va pas utiliser que pgadmin4, donc ça ne fera pas l'affaire ici. QGIS par exemple a besoin qu'on établisse le tunnel par nous-même.


## Changer l'encodage d'un fichier
VRT nécessite qu'on travaille avec des fichiers en UTF8. Si ce n'est pas le cas, on doit changer l'encodage préalablement. Par exemple, en ligne de commande, avec la commande suivante :
```
uconv -f windows-1252 -o monfichier-utf8.csv monfichier.csv
```

## Publier un fichier en BD avec ogr
```
# Ou bien on utilise le driver PostgreSQL d'OGR
ogr2ogr -f "PostgreSQL" -nln "roads" -nlt PROMOTE_TO_MULTI -lco OVERWRITE=YES -lco SCHEMA=yourusername PG:"dbname='cqpgeom' host='localhost' port='5433' user='cqpgeom' password='pass'" roads.vrt

# Ou bien on passe par un dump PG (utile dans certains cas)
ogr2ogr -f PGDUMP -nln roads -lco PG_USE_COPY=YES -lco SCHEMA=yourusername -nlt PROMOTE_TO_MULTI /vsistdout/ roads.vrt | psql -h localhost -p 5433 -d cqpgeom -U cqpgeom -f -
```


## EN plus

On peut regarder qq cas concrets dans lesquels le VRT m'a bien servi et fait gagner beaucoup de temps :

https://github.com/pi-geosolutions/vrt2rdf
un cas de réorganisation des données, pour le projet SAGUI : https://github.com/HydroMetGuyane-Hydro-Matters/sagui_backend/tree/main/data
les VRT utilisés couramment par l'équipe SIG de la région des Hauts de France : https://github.com/geo2france/vrt/
Combiné à un peu de code python, on peut faire des miracles en termes de traitement de données.

Ah, et j'oubliais : remarquez dans la doc de vrt2rdf comment on peut même pointer vers une source WFS