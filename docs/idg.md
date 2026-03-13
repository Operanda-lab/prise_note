# Infrastructure des données géographiques (IDG)

## Definition

Il y a une couhce de gouvernance, organisatio sur des accords de partage
Coordiantion de ses membres car cela se fait à plusieurs
Il y a des services 
Stockage avec serveur

à l'échelle d'un territoire pour le citoyen

### Panorama Historique

Année 1990 développé en // de l'informatique et SIG


### Par l'approche composante

les IDG sont des dispositifs  rassemble informations, SI, normes et standards, accors organisationnels , ressource shumaines et communauté

### Par l'approche réseau
...

### Typologies IDG

- Généraliste ou territoriale
- IDG thématique plutot nationale, se concentre sur un enjeu territoriale (littoral, risque, santé ...)

### Cadre réglementaire

- 1978 Loi CADA : Le legislateur a posé un cadre pour faciliter l'accès du citoyen aux documents administratifs. 
- 2003 PSI au niveau européen : Ens. de règles pour accéder aux doc. admin. commmme la CADA
- 2005 Ordonance sur la réutilisation de l'information publique
- 2007 Directive INSPIRE : obligation de publier les données environementales et géographiques
- 2010 ...

### Dynamique des IDG en France

A partir de 2008 croissance continue et en 2015 portail Open data
Mais trop de portails qui sont des moyens de communication aussi

IDG > Plateforme de données géographiques > Plateforme territoraile de données
Plateforme englobe les outils de diffsuion mais aussi un dispo. organisationnels

L'aniamtion doit aussi etre au coeur de ce dispositifs

## Fonctionnalités

### Préconisés par la directive INSPIRE
5 fonctionnalités
- Services de recherche
- Services de consultation : Afficher, naviguer
- Service de téléchargement : Récupérer la données
- Service de transformation
- Service d'appel : WMS et WFS Protocole d'échange et CSW(Moissonage)

### Vison idélae des fonctionnalités

µImportant
Intégration des normes
Architecture technique

> 2000 - 2010
Geonetwork très brut mais qui a toutes les Fonctionnalités
**Brique de catalogage Geonetwork (Interface)**

> 2010 - 2020
- Envirronement plus Attractif
- Ajout de cartographie dynamique
- Ajout de Data viz
- On met en avant les données par l'usage et simplification des données
- On developpe l'usage des formats plats (1 seul fichier contient l'information: Geojson) VS les fichiers SIG (avec plusieurs fichiers: SHP...)
- On va vers 1 donnée = 1 API

**Brique de catalogage CKAN (Interface)**


> 2020 - ... : Contributive et sobre (Pas IA)
- eviter de mettre des choses qui ne servent à rien
- Problème de stockage
- Devellopement des 3D et jumeaux numériques
- Calibrage des données pour 'lusage de l'IA. Ce n'est plus une personne qui va le chercher mais des algo. Qu'est ce qu'il se passe ???


## Enjeux

### Interropérabilité

- Dans le champs sémantique : le sens , le contenu et la structuration des informations. Des modèles qui sont similaires.
- Dans le champs géographiques : Meme projection géodésique, système géographique. Des fois plus spécifique pour certaines info. geographique
- Dans le champs informatique : Protocole d'échanges entre syst. informatique .protocle réseau, systeme de base de données

>> Respecter les principes FAIR
- **Findable :** S'applique aux données et aux métadonnées.
- **Accessible :** Facile à trouver par humain et machine
- **Interoperable :** Une fois les données trouvées, l'utilisateur doit savoir y acceder savoir que la donnée existe meme si non récupérable. Les données peuvent être  intégrer facilement entre elles, et puissent être ouvertes dans les app.
- **Reusable :** Les données peuvent être réutilisable pour d ela recherche par exemple

### Interop appliqué au champs sémantique.

- Fabrique des standards
- Contribuer techniquement à rendre la donnée FAIR
- Plusieurs réf. en cours de mise en place.

### Interop appliqué au champs informatique

Open geospatial consortium
Architecture de haut niveau - OGC Standards baseline


### Animation / Accompagnement

Evolution des profils utilisateurs de - en - spécialistes géomatique. Comment fait on pour accompagner les usages ?
Dire aux thématiciens (zonage, espace anturel sensible ...)
Connecter une donnée sans composante géographique à des points géo : Elements Pivots (exemple code INSEE)
Le CRIGES améliore l'interop.

## Statégies Européenne de la donnée

fev. 2020 Mise en oeuvre
Objectif : créer un marché unique de la donnée pour garantir et allier compétitivité mondiale et la souveraineté en Europe.

> cadre juridique approprié a déployé : DGA, DA, IAA
> Création d'**Espaces communs de données (ECD)** ou **Data Space**

Cet espace de données "réunit les insfrastructures de données pertinentes et les cadres de gouvernance afin de faciliter la mise en commun et le partage de données"

### Espace commmun de données

- Espace de confiance
- Données non centralisées
- Création d'un centre d'appui aux espace de donnés
- Emergence d'initiative : [Mydata](https://mydata.org/), [Consortium Gaia-X](https://gaia-x.eu/)

### Exemple d'u ECD

Eona-X : projet européen pour faire marcher des flux de trqansport. avec des données partagées.

### Convergence d'editeur vers ECD

Collectif CICCLO et Gaia-X

## Plateforme territoriale de données

environ 130 soit régionales soit départementales
Certains tres thématique nationales (géorisque, agence ORE, géofoncier, Plateforme du SHOM, geoportail > geoplateforme avec cartes.gouv)

Solution de diffsuion de données

**Open source , utilisateur influence la roadmap**

- Prodige - Communautaire opensource
- Georquestra
- Onegeo Suite
- Isogeo

La plupart des briques utilisées sont internationnales

### Le programme geoplateforme

Infra mutualisé et collaborative pour production et diffusion des geo données

1. un moteur et une infrstructure un peu cachée : Socle technique pour pouvoir diffuser et agir dessus
2. Intefacage et diffusion / Une carte : carte.gouv

Promesse : d'autres structures que l'IGN peuvent y participer

## Mise en oeuvre d'un processus de catalogage et de diffusion de données (PLUTOT piloter un projet informatique au sens large)

### Portées et limites

problématique avant outils

**SAAS :**
- Avantages:

	- tranquilité d'esprit
	- Peu de compétences techniques

- Inconvénients :

	- Coût
	- Dépendant du prestataire
	- CCTP solide (c'est àdire bien définir le cahier des charges)
	- Possibilités d'évolutions limitées

**Hybride :**
- Avantages:
	- Délègue une partie des coûts
	- indépendant sur l'évolution d'une partie

- Inconvénients :
 
	- Selon avoir besoind econnaissances techniques
	- Difficulté à faire communiquer nos outils
	- Dépendant des mises à jour
 
 **Auto-géré :**
- Avantages:

	- Maitrise totale, 
	- cout contenu, 
	- valorisant, 
	- permet de s'intégrer dans communauté

- Inconvénients :

	- Solides connaissances, 
	- piloter un SI, 
	- veille cybersécurité

### Auto-géré

- Internalisation de l'hébergement ou délégation

	- Contrat prestataire .DNS, sauvegarde, déploiement, comment changer les connexions  serveur, modalité de l'assistance (ticket ..)
	- Est ce que la DSI a déjà un contrat ?
	- Structuration du SI
	- cartographie :
	- Documentation : le registre des accès, elle permet de faire une continuité de Services
	- Evolution : agir sur tentative d'inclusion, cyberattaque, limiter la surface d'attaque,
	- veille : rapport du CERT (pour cybersécurité) agence de L'ANSSI 
	
- Formation et sensibilisation
	- Les utilisateurs ont parfois trop de droits
		-> Gérer les accès, tenir un registre, 

### Cycle de vie

Le PDCA, plan do check act

1. plannification (Plan)

travaille à valider , objectif de projet, livrable attendu, les participants, les risques ou contraintes , indicateur de réussite.

2. Réaliser (do):

On met le projet à l'epreuve en faisant un mini projet

3. Contrôle (check)

On fait les contrôles. C'est à cette etape qu'on voit les choses à corriger , les anomalies.

4. Agir (act)

Mise en production

### L'analyse de risque

- Critères d'évaluation

4 étapes

- Identification des risques : panne, erreur réseau
- Evaluation: probabilité d'apparition et gravité , création d'indicateurs. => prioriser les point sà traiter. A faire dans un groupe de travail pour voir des choses qu'on ne peut voir tout seul
- Cartographie des risques permet de voir la tache à traiter en priorité
- Traitements des risques : 2 approches
	- Action préventive pour limiter l'impact
	- Plan d'action. Au cas ou un événement se produirait , quelles méthodes pour régler le problème. Je préviens qui => **procédures**

### CONCLUSION

Un SIG est la-même chose qu'un SI
Une mise à jour c'est déjà ça pour aller contre les hackers
Toujours contacter les SI et discuter , ça nous permet d'imaginer les problèmes possibles.


## Retour d'expérience

Se rend compte que :
- Ergonomie inadaptée
- Maj de l'applicatif difficile
- pb de sécurité

Les utilisateurs sont toujours ok pour un catalogage

Site internet et portail imbriqués

Mise en place d'une AMO pour définir les contours, refondre l'IDG

L'AMO devait aider à mieux comprendre l'IDG et comment la faire
produire une synthese des enjeux régionnaux. Réalisé en l'espace de 3 mois
Definir des scénarios

1. Phase 1 Diagnostic

- Faire emmerger une vision partagée des futurs services de l'IDG
- Identifier des profils utilisateurs et identifier les besoins : ont fait des entretiens avec des personnes, et des enquêtes.
- Mise en exergue de 5 besoins
	- Produire
	- Rechercher
	- Partager
	- Commander
	- S'informer

- Des personnas ont été identifiés : archétype d'utilisateurs
	- 5 personnas primaires
	- 4 personnas retenus
	
2. Scenarii et feuille de route

. Recherche, commande et téléchargement données
. Recherche réccurente avec téléchargement
. Partage(diffusion) de données avec adhésion à OPEN IGN
. Mise en conformité et partage de données 
. Co production basé sur le partage

**Promesse de service :**
3 chantiers 


3. Mettre en oeuvre les chantiers


...
...
...

## Evolution contexte national

- outils nationnaux augmentation
- Concept de données territoriales
- Besoins de données pour accompagnée les "transitions" et les adaptations au changement climatique
- IA
- Common european Data spaces
- Contraintes budgétaires 

## Evolution contexte occitanie

- La région laisse les pouvoirs d'aniamtion autour de l'open data en occitanie
- Préfiguration comité territorial de la donnée nen occitanieContriantes budgétaires

https://github.com/multibao/contributions/blob/master/contributions/accelerateur_de_projets.md

[Klaxoon](https://app.klaxoon.com/participate/board/G63KV9E)

## 2ème IDG-portail REGEX

## **C'est le mode de gouvernance**
- Chaque participants est libre de faire partie d'un groupe de travail et aussi opportunité dans leur emploi du temps
- But avoir du monde pour avoir une représentativité
- Ca permet aux gens d'être motivé


Travail sur 2 scenarios
- OpenIg infrstructure 
- Centralise les métadonnées des adhérents via des outils nationnaux

- Recueil de besoins
- Recensement des solutions existantes


### Principales thématique abordéeslors du GT1


