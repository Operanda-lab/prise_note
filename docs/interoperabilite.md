# Interopérabilité

Dans la géomatique : 

## Comprendre

### Définition
interop n'est pas compatibilité

***Interopérabilité*** : système capable de fo,nctionner avec d'autres produits
sans restriction d'accès ou d emis ene oeuvre
Notion transversale permettant à de soutils de pouvoir comm. et fonct.
***compatibilité*** : Notion verticale faisant qu'un outil peut fonctionner dans un envir. donné

### De quoi parle t'on ?

C'est échanger des des informations avec les autres systèmes.
**Langage pivot** : langage universel qui limite l'effort de traduction

- exemple de CAO vs SIG (\_ outils QGIS : QCAD \_)

### Les enjeux de l'interrop.

**La sémantique** :
Définition standardisé des concepts, de la structure et du sens des données spat. couche VS classe d'entité

**Géographique**:
Coordonnées géo. basées IGN VS LAMBERT

**Standards et spec.**:
L'OGC developpent et promeuvent des standard souverts pour assur l'interrop. 
OGC faisait des spécifications sur les services et maintenant sur les API. [Voir ici](https://www.ogc.org/standards/)

**Directives et recommandations** (lois):
Des initiatives europ. comme INSPIRE -> rendre les données ouvertes notamment environnementales
Elle oblige de  la diffuser dans différents formats , webservices, , d'ouvrir et partager, de la documenter 

**Directives et recommandations**

### Les normes

L'organsation internat. de normalisation (ISO)
- Normalisation dans le domaine de l'information géo-graphique numérique. [ISO/TC 211](https://www.iso.org/fr/committee/54904/x/catalogue)

- Information géographique — Métadonnées [ISO 19115](https://www.iso.org/fr/search.html?PROD_isoorg_fr%5Bquery%5D=19115)

### OGC Open geospatial consortium

### Les géostandards pour une bonne diffusion
- **FAIR** : Findable, accessible, Interopérable , Reusable

- **TAIR** (Thomas) : Trouvable, accessible, interropérable, Réutilisable

**Exemple** age du WMS vs COG (le tiff a intégre une spec. Clowd optimized geotiff) fonctionnalité qui permet de déposer dans un server et se comporte ensuite comme un web services tuilé. Alors que le WMS, il faut le mettre sur un geoserver qui le transmette.
**SERVICES**
Les web services à lire dans une interface librairie javascript openlayer, leaflet. ou client carto
**PARMI LES STANDARDS**

- Des web-services distants
WMS
WMTS le plus utilisé
WFS remplacé par service vecteur tuilé vectoriel (tuilage par niveau de zoom)
WCS il découpe une emprise dans un WMS
CS-W pour le moissonnage
WPS

- Des formats (en local)
SLD
GML
KML
GPKG
WKT CRS

## concevoir la notion d'une conduite d'un projet
