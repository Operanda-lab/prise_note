# Administrer son serveur de base de données

## Concept d'administration

on doit différencier la gestion du serveur de la gestion des bases de données

### Différence entre SG et DB

1.1. Composants BD => Base de Données

- modèles de données (MCD, MLD, MPD),
- les schémas,
- les données,
- applications connectées (clients),
- utilisateurs de la base de données (rôles),
- requêtes,
- indexes

1.2. Composants SG => Système de Gestion

- architecture,
- réseau,
- CPU,
- RAM,
- Stockage,
- OS

Système d'exploitation

Une base de dev et une base de prod

## Étapes de la Création d'un système de base de données

Établir les caractéristiques de la base

Évaluation du matériel du serveur

Installation du logiciel PostgreSQL/ PostGIS (serveur et clients)

Créer et ouvrir la base de données

Sauvegarde de la ou des bases de données

Créer et gérer les utilisateurs et leur droits d'accès (stratégie de sécurité dédiée)

Implémenter la structure de la base

Optimiser les performances de la base

[pgtune](https://pgtune.leopard.in.ua/)

    PGTune calcule la configuration de PostgreSQL en fonction des performances maximales obtenues pour une configuration matérielle donnée. 
	Il ne s'agit pas d'une solution miracle pour l'optimisation de PostgreSQL.
	De nombreux paramètres dépendent non seulement de la configuration matérielle, mais aussi de la taille de la base de données, du nombre de clients et de la complexité des requêtes.
	Une configuration optimale de la base de données ne peut être obtenue qu'en tenant compte de tous ces paramètres.

## Architecture et arborescence

### Datas

ls -la /var/lib/postgresql/<version>/main/

| Eléments | Description |
|---|---|
| PG_VERSION | Un fichier contenant le numéro de version majeur de PostgreSQL™ |
| base | Sous-répertoire contenant les sous-répertoires par base de données |
| global | Sous-répertoire contenant les tables communes au groupe, telles que pg_database |
| pg_commit_ts | Sous-répertoire contenant des données d'horodatage des validations de transations |
| pg_clog | Sous-répertoire contenant les données d'état de validation des transactions |
| pg_dynshmem | Sous-répertoire contenant les fichiers utilisés par le système de gestion de la mémoire partagée dynamique |
| pg_logical | Sous-répertoire contenant les données de statut pour le décodage logique |
| pg_multixact | Sous-répertoire contenant des données sur l'état des multi-transactions (utilisé pour les verrous de lignes partagées) |
| pg_notify | Sous-répertoire contenant les données de statut de LISTEN/NOTIFY |
| pg_replslot | Sous-répertoire contenant les données des slots de réplication |
| pg_serial | Sous-répertoire contenant des informations sur les transactions sérialisables validées |
| pg_snapshots | Sous-répertoire contenant les snapshots (images) exportés |
| pg_stat | Sous-répertoire contenant les fichiers permanents pour le sous-système de statistiques |
| pg_stat_tmp | Sous-répertoire contenant les fichiers temporaires pour le sous-système des statistiques |
| pg_subtrans | Sous-répertoire contenant les données d'états des sous-transaction |
| pg_tblspc | Sous-répertoire contenant les liens symboliques vers les espaces logiques |
| pg_twophase | Sous-répertoire contenant les fichiers d'état pour les transactions préparées |
| pg_xlog | Sous-répertoire contenant les fichiers WAL (Write Ahead Log) |
| postgresql.auto.conf | Fichier utilisé pour les paramètres configurés avec la commande ALTER SYSTEM |
| postmaster.opts | Un fichier enregistrant les options en ligne de commande avec lesquelles le serveur a été lancé la dernière fois |
| postmaster.pid | Un fichier verrou contenant l'identifiant du processus postmaster en cours d'exécution (PID), le chemin du répertoire de données, la date et l'heure du lancement de postmaster, le numéro de port, le chemin du répertoire du socket de domaine Unix (vide sous Windows), la première adresse valide dans listen_address (adresse IP ou *, ou vide s'il n'y a pas d'écoute TCP) et l'identifiant du segment de mémoire partagé (ce fichier est supprimé à l'arrêt du serveur) |

### Configuration

ls -la /etc/postgresql/<version>/main

**pg_hba.conf** : pour paramétrer les options de connections, méthodes d’accès et qui (machine) accède

**postgresql.conf** : pour paramétrer tous les détails et capacité du serveur, comme par exemple le port.

Les fichiers pgdata /var/lib/postgresql/10/main/
ou on retrouve les tablespace et OID

Pour vérifier les services qui tournent
Vérifier les services postgres qui tourne :

ps auxf | grep postgres



3.3 Les principaux binaires de PostgreSQL

- pg_ctl (réalisé par les installateurs comme systemD ou celui de windows)
	- gestion de l'instance / cluster
	- start / stop / kill
	- init : création autre espace de datas
	- promote : promotion de standby
- psql
	- le premier client de connexion en mode CLI
	- on se connecte avec un utilisateur à une base de donnée
	- on peux exécuter du SQL et des méta-commandes, ou des script sql (fichiers)

- pg_createcluster
	- création d'une instance PG
	- Création des répertoires (/etc et /var/lib)

Accompagné de pg_dropcluster (suppression de cluster), pg_lscluster (lister), pg_ctlcluster (contrôleur du cluster)

**Les binaires pour la sauvegarde**
- pg_dump
	- sauvegarde d'une instance
	- différents formats : plain text (DDL schéma et SQL), binaire (lisible seulement par PG), compressé
	- différents niveaux d'objets (cluster, db, table, schéma)
- pg_dumpall
	- sauvegarde intégrale en format binaire, il sauvegarde les rôles, les utilisateurs.
- pg_restore
	- restauration à partir d'une sauvegarde pg_dumpall
	
**Wrappers (ce qui veut dire "des raccourcis")**
- createdb
- dropdb
- createuser
- dropuser

**Maintenance**
Dans l'admi de base de données, il yu a des taches attendus, obligatoires tout un tas de choses à faire au quotidien. Des qu'on fait de la mise à jour de données, il faut réindexer pour optimiser les temps de requetes.

Ce qu'on doit faire systematiquement c'est un index spatial qui consiste à enregistrer des emprises de toutes nos données. On le fait avec [GIST voir cours de JULIEN FASTRE]

- reindexdb : réindexation 
- vaccumdb : tâche de maintenance (ménage)
faire : sudo ls -lah main/base/5 le h permet de voir **human readible**
permet de voir ce qui peut être ménagé avec vaccumdb

****Attention****

**Spécifiques système avancées**

- pg_controldata : vérifie l'état du serveur et des infos critiques
- pg_resetwal : en cas de crash avec des pb de WAL (risques de pertes de données)
- pg_receive_wal : récupération des WAL d'une autre DB (réplication)
- pg_basebackup : récupération de datas par une autre connexion à une autre DB (réplication)

3.4 PostgreSQL est un service

PostgreSQL est considéré comme un service
Création du fichier .bat de connexion au démarrage

4. Focus sur les Tablespaces

PGDATA / La ou on a le dossier base / dossier avec des chiffres OID 

Physiquement le pgdefaut si on change rien tous les emplacements physqiues se trouvent ici.

Par contre je peux mettre mabase et tous les objets à l'intérieur ou une partie dans un autre endroit

Par exemple on peut mettre les indexations (indexes) dans des diques ultraperformant. Mettre donc le tablespace dans un SSD pour être plus rapide et les données sur un HDD

On peut donc stocker des OID sur des disques différents


| d | rwx | rwx | rwx |
|---|---|---|---|
| Dossier | proprietaire | groupe | utilisateur |
 
Si par exemple on a un disque saturé on peut mettre du coup le sOID sur d'autres disques
	
1. créer le dossier physqiue sur le disque
2. Création de la tablespace dans le dossier Physique

	CREATE TABLESPACE mine OWNER postgres 	LOCATION '/home/idgeo/tablespace';

3. Les objets vont dans les Tablespaces

5. Le rôle de DBA

la gestion des droits utilisateurs,

la gestion des tablespaces,

la gestion de l'espace disque,

identifier les tables à suivre,

la gestion des sauvegardes

6. Manipulations diverses

Pgtune & modification de la configuration du serveur

Gestion des tablespaces

Création d'une base et attribution du tablespace

Création d'une base de données template

Création d'un utilisateur = ! de postgres

Création de tables et affectation à un tablespace

Création d'indexes et affectation à un tablespace

4. Sauvegarder / Restaurer - Maintenir un serveur de bases de données

4.1. Maintenance - Vacuum et autre dashboard

4.1.1. Définition
Récupère l'espace inutilisé et, optionnellement, analyse une base.

Lors des opérations normales de PostgreSQL, les lignes supprimées ou rendues obsolètes par une mise à jour ne sont pas physiquement supprimées de leur table.

Vacuum permet de récupérer l'espace occupé par les lignes supprimées.

4.1.2 Remarque

Le VACCUM standard (sans FULL) récupère simplement l'espace et le rend disponible pour une réutilisation. Cette forme de la commande peut opérer en parallèle avec les opérations normales de lecture et d'écriture de la table, car elle n'utilise pas de verrou exclusif.

VACCUM FULL fait un traitement plus complet et, en particulier, déplace des lignes dans d'autres blocs pour compacter la table au maximum sur le disque. Cette forme est beaucoup plus lente et pose un verrou exclusif sur la table pour faire son traitement.

Des VACUUM standard et d'une fréquence modérée sont une meilleure approche que des VACUUM FULL, même non fréquents, pour maintenir des tables mises à jour fréquemment.

4.1.3. **Conseil**

Après avoir ajouté ou supprimé un grand nombre de lignes, il peut être utile de faire un VACUUM ANALYZE sur la table affectée. Cela met les catalogues système à jour de tous les changements récents et permet à l'optimiseur de requêtes de PostgreSQL™ de faire de meilleurs choix lors de l'optimisation des requêtes.

Pour exécuter un VACUUM sur une table, vous devez habituellement être le propriétaire de la table ou un super utilisateur. Les propriétaires de la base de données sont autorisés à exécuter VACUUM sur toutes les tables de leurs bases de données, sauf sur les catalogues partagés. Cette restriction signifie qu'un vrai VACUUM sur une base complète ne peut se faire que par un super utilisateur.

Il est recommandé que les bases de données actives de production soient traitées par VACUUM fréquemment (au moins toutes les nuits), pour supprimer les lignes mortes.

4.2. Auto-vacuum
Automatiser l'exécution des commandes VACUUM et ANALYZE

Une fois activé, le démon autovacuum s'exécute périodiquement et vérifie les tables ayant un grand nombre de lignes insérées, mises à jour ou supprimées. Ces vérifications utilisent la fonctionnalité de récupération de statistiques au niveau ligne.

Dans la configuration par défaut, l'autovacuum est activé et les paramètres liés sont correctement configurés.


**EXO**
 sudo psql -U postgres -p 5433 -f /mnt/d/olivier/A2_admin_BDD/top_14.sql
 
 Va intégrer lire le fichier sql et faire tout ce que celui ci demande. On y met aussi les informations psql comme \c ou \l+
 
```SQL
-- Créer la base de données "rugby_top" avec l'extension PostGIS
CREATE DATABASE rugby_top TABLESPACE mine;
\c rugby_top;
CREATE EXTENSION postgis;

-- Créer la table "clubs_rugby" avec un champ géométrique "geom"
CREATE TABLE clubs_rugby (
    id SERIAL PRIMARY KEY,
    nom_club VARCHAR(255) NOT NULL,
    ville VARCHAR(255) NOT NULL,
    latitude NUMERIC,
    longitude NUMERIC,
    geom GEOMETRY(Point, 4326)
);

-- Création de l'index spatail sur geom
CREATE INDEX idx_club_geom ON clubs_rugby USING gist (geom);

-- Insérer les données des 14 clubs du Top 14 avec leurs coordonnées géographiques
INSERT INTO clubs_rugby (nom_club, ville, latitude, longitude, geom)
VALUES
('Stade Toulousain', 'Toulouse', 43.6047, 1.4442, ST_SetSRID(ST_MakePoint(1.4442, 43.6047), 4326)),
('Union Bordeaux-Bègles', 'Bordeaux', 44.8378, -0.5792, ST_SetSRID(ST_MakePoint(-0.5792, 44.8378), 4326)),
('Stade Rochelais', 'La Rochelle', 46.1603, -1.1511, ST_SetSRID(ST_MakePoint(-1.1511, 46.1603), 4326)),
('ASM Clermont Auvergne', 'Clermont-Ferrand', 45.7772, 3.0870, ST_SetSRID(ST_MakePoint(3.0870, 45.7772), 4326)),
('RC Toulon', 'Toulon', 43.1242, 5.9280, ST_SetSRID(ST_MakePoint(5.9280, 43.1242), 4326)),
('Racing 92', 'Nanterre', 48.8924, 2.2066, ST_SetSRID(ST_MakePoint(2.2066, 48.8924), 4326)),
('Stade Français Paris', 'Paris', 48.8412, 2.2530, ST_SetSRID(ST_MakePoint(2.2530, 48.8412), 4326)),
('Castres Olympique', 'Castres', 43.6062, 2.2400, ST_SetSRID(ST_MakePoint(2.2400, 43.6062), 4326)),
('Montpellier Hérault Rugby', 'Montpellier', 43.6110, 3.8767, ST_SetSRID(ST_MakePoint(3.8767, 43.6110), 4326)),
('Section Paloise', 'Pau', 43.2951, -0.3700, ST_SetSRID(ST_MakePoint(-0.3700, 43.2951), 4326)),
('Aviron Bayonnais', 'Bayonne', 43.4929, -1.4748, ST_SetSRID(ST_MakePoint(-1.4748, 43.4929), 4326)),
('USA Perpignan', 'Perpignan', 42.6986, 2.8956, ST_SetSRID(ST_MakePoint(2.8956, 42.6986), 4326)),
('LOU Rugby', 'Lyon', 45.7600, 4.8320, ST_SetSRID(ST_MakePoint(4.8320, 45.7600), 4326)),
('Oyonnax Rugby', 'Oyonnax', 46.2598, 5.6556, ST_SetSRID(ST_MakePoint(5.6556, 46.2598), 4326));

-- Afficher la structure de la table
\d clubs_rugby;

-- Voir le tablespace des base \l+
\l+
-- Voir le contenur de la table
SELECT * FROM clubs_rugby;
```

 
4.3. Dashboard - Visuel sur les indicateurs de la base

4.2. Les tablespaces

**definition**

Les tablespaces se définissent en amont de la base.

On les nomme et leur indique un dossier physique dans l'arborescence de la machine, de préférence dans un emplacement de stockage puisqu'il va contenir les données.

```SQL
CREATE TABLESPACE nom_du_tbsp OWNER user_name LOCATION /emplacement/choisi/;
```

**Attention**
La configuration de base ...
La configuration de base stocke toutes les bases dans le même emplacement PGDATA/base ...

Cela suppose de prévoir l'espace nécessaire à cet emplacement.

C'est le risque de tout perdre ! Tout est au même endroit. (ndrl toutes les bases)

En terme d'optimisation, il y a mieux à faire.

**Remarque : La gestion des Tablespaces et bonnes pratiques.**

- Création d'un emplacement (dossier) par base.
- Création de plusieurs Tablaspaces par base possible (si on atteint la capacité maximale d'un disque par exemple).
- Séparation des tables et des indexes sur des tablespaces différent.s L'indexation et son utilisation étant gourmand en ressources, il est envisageable de stocker les indexes sur un disque rapide type SSD et les tables sur disque mécanique.

4.3. Sauvegarder et restaurer les données de postgreSQL en ligne de commande

**4.3.1 Sauver**

Objectif : produire un fichier texte de commandes SQL (« fichier dump »), qui, si on le renvoie au serveur, recrée une base de données identique à celle sauvegardée.

PostgreSQL™ propose pour cela le programme utilitaire pg_dump.


```SQL
pg_dump base_de_donnees > fichier_sauvegarde

pg_dump -d rugby_top -U postgres -p 5434 -f rugby_save.sql
```

Les extractions peuvent être réalisées sous la forme de scripts ou de fichiers d'archive.

- Les scripts sont au format texte et contiennent les commandes SQL nécessaires à la reconstruction de la base de données dans l'état où elle était au moment de la sauvegarde. La restauration s'effectue en chargeant ces scripts avec psql.

- La reconstruction de la base de données à partir d'autres formats de fichiers archive est obtenue avec pg_restore. Les formats de fichier en sortie les plus flexibles sont le format « custom » (-Fc) et le format « directory » (-Fd). Ils permettent la sélection et le ré-ordonnancement de tous les éléments archivés, le support de la restauration en parallèle. De plus, ils sont compressés par défaut. Le format « directory » est aussi le seul format à permettre les sauvegardes parallélisées.

pg_dump permet de restaurer des bases dans des versions du serveur plus récentes.

**Remarque**

pg_dump est aussi la seule méthode qui fonctionnera lors du transfert d'une base de données vers une machine d'une architecture différente (comme par exemple d'un serveur 32 bits à un serveur 64 bits).

**4.3.2 Restaurer**

Les fichiers texte créés par pg_dump peuvent être lus par le programme psql.

```SQL
psql base_de_donnees < fichier_sauvegarde
```

**Remarque**

Tous les utilisateurs possédant des objets ou ayant certains droits sur les objets de la base sauvegardée doivent exister préalablement à la restauration de la sauvegarde. S'ils n'existent pas, la restauration échoue pour la création des objets dont ils sont propriétaires ou sur lesquels ils ont des droits.

**4.3.3 Sauvegarder une base directement d'un serveur sur un autre**

```SQL
pg_dump -h serveur1 base_de_donnees | psql -h serveur2 > base_de_donnees

```

**Conseil**

Après la restauration d'une sauvegarde, il est conseillé d'exécuter ANALYZE sur chaque base de données pour que l'optimiseur de requêtes dispose de statistiques utiles.

**4.3.4 Mettre en place une sauvegarde automatique**

Encore une fois, suivant la taille de la structure des sauvegardes peuvent intervenir à plusieurs niveau.

- Bien souvent, il existe une sauvegarde du serveur qui héberge le serveur PostgreSQL.

- On peut mettre une sauvegarde au niveau d'une base de données en choisissant le rythme adéquat (mise à jour des données régulière, vs modèles peu évolutif)

**Exemple : Script + crontab**

Etablir une commande pg_dump dans un script bash vers une sortie « .dump »

Ce fichier pour s'appeler

On positionnera ce script dans le dossier /usr/bin/


Etablir une commande pg_dump dans un script bash vers une sortie « .dump »

Ce fichier pour s'appeler

On positionnera ce script dans le dossier /usr/bin/
```

```
```shell
DB_USER="postgres"         	# utilisateur de la base de données PostgreSQL
DB_NAME="ma_base"      	    # nom de la base de données à sauvegarder
DB_SCHEMA="pourquoi_pas"    # pour ne sauver que le schéma
current_date=$(date +%Y-%m-%d)
backup_file="/home/xxx/sauv_bdd/sauv_${DB_NAME}${DB_SCHEMA}${current_date}.dump"
```

```
if ! pg_dump -U "$DB_USER" -F c "$DB_NAME" -n "$DB_SCHEMA" > "$backup_file"; then
echo "Echec: La sauvegarde de la bdd a échouée"
return 1
fi
printf "Sauvegarde de la base ok"
```
Paramétrer une tâche « Crontab »


```
crontab -e

# m h  dom mon dow   command
20 * * * * /usr/bin/script_sauv.sh
```
Ca veut dire qu'a chaque fois qu'on est à 20 minutes dans l'heure alors il fait une sauvegarde.


**4.3.4 Utilisation de pg_dumpall**

Permet une sauvegarde de tout un cluster (bases de données, rôles et tablespaces).

Permet une sauvegarde de tout un cluster (bases de données, rôles et tablespaces).

```bash
pg_dumpall > fichier_sauvegarde
```
Le fichier de sauvegarde résultant peut être restauré avec psql :

```bash
psql -h localhost -p 5432 -U postgres -c "CREATE DATABASE nombase;"
psql -h localhost -p 5432 -U postgres -d nombase -c "CREATE EXTENSION postgis;"
psql -h localhost -p 5432 -U utilisateur -d nombase -f chemin\complet\du\fichier.sql
```

Il est préférable d'avoir les droits de superutilisateur de la base de données pour obtenir une sauvegarde complète.

Il faut obligatoirement avoir le profil superutilisateur pour restaurer une sauvegarde faite avec pg_dumpall, afin de pouvoir restaurer les informations sur les rôles et les tablespaces. Si les tablespaces sont utilisés, il faut s'assurer que leurs chemins sauvegardés sont appropriés à la nouvelle installation.

**pgdump_all c'est bien pour les montées en version, ou changement de bécane.**

Le principe de la sauvegarde c'est à investiguer, la vocation c'est que la sauvegarge ne reste pas sur le meme serveur.


## Les droits d'accès aux données (rôles et privilèges)

Le super utilisateur utilisé avec parcimonie est seulement pour 1 personne, un administrateur

D'un point de vue postgrsql on parle de rôle. Différence entre groupe et utilisateurs c'est la capacité à se connecter.

La on définit des caractéristiques à un rôle différent des droits
```sql
CREATE ROLE postgres WITH
  LOGIN
  SUPERUSER
  INHERIT -- ou NO INERIT on peut faire heriter des utilisateurs 
  CREATEDB -- ou NOCREATEDB
  CREATEROLE
  REPLICATION
  BYPASSRLS
  ENCRYPTED PASSWORD
```

Pour créer un template seule le superutilisateur peut le faire

Pour faire un groupe il faut passer en nologin car le groupe n'est pas un utilisateur 

### Les contrôles d'accès



### Les privilèges (GRANT)

Un privilège est un **droit** sur un objet de la base **attribué à un rôle**.

Les SGBD permettent généralement de spécifier assez finement les privilèges d'un utilisateur en fonction des objets manipulés :

- base de données
- schéma
- table (relation)
- colonne (attribut)

Ainsi, un utilisateur peut se voir attribuer un privilège pour toute une base de données, le contenu d'un schéma, ou seulement pour quelques tables, ou encore sur uniquement quelques colonnes de certaines tables.

**Fondamental : Regles d'attribution des privilèges**

**- Règle n°0 : un mot de passe pour chacun**

Tous les utilisateurs (clients, applications) doivent avoir un mot de passe.

**- Règle n°1 : attribution du moindre privilège.**

Les utilisateurs ne doivent avoir que le minimum de droits, ceux strictement nécessaires à l'accomplissement de leurs tâches. Les privilèges peuvent évoluer au cours du temps car les besoins et les tâches affectées ne sont pas immuables, mais à un moment donné, seuls les droits indispensables doivent être fournis à un utilisateur.

Il faut éviter de créer plusieurs comptes avec des droits d'administrateur.

**- Règle n°2 : contrôle de la population.**

Le personnel d'une entreprise bouge, il y a des départs, des arrivées, des promotions... Les privilèges doivent êtres synchrones avec la réalité de la population : il faut supprimer les comptes des utilisateurs quittant l'entreprise et de ceux n'étant plus affectés à telle ou telle tâche.

**- Règle n°3 : supervision de la délégation des tâches d'administration.**

Un administrateur peut être amené à déléguer auprès d'une autre personne les tâches d'attribution des privilèges de tout ou partie de la population des utilisateurs (cf WITH GRANT OPTION). Un contrôle a posteriori doit être réalisé afin de vérifier que le résultat de cette délégation est conforme à la politique adoptée.

**- Règle n°4 : contrôle physique des connexions.**

La connexion d'un utilisateur à une base de données peut être réalisée depuis n'importe où dans le monde grâce à Internet. Il est nécessaire de restreindre les connexions à des hôtes spécifiques connus (hba_conf).

### Les principaux privilèges :
Les droits possibles sont :

**SELECT**

Autorise une sélection sur toutes les colonnes, ou sur les colonnes listées spécifiquement, de la table, vue ou séquence indiquée. Autorise aussi l'utilisation de COPY TO. De plus, ce droit est nécessaire pour référencer des valeurs de colonnes existantes avec UPDATE ou DELETE.

**INSERT**

Autorise une insertion d'une nouvelle ligne dans la table indiquée. Si des colonnes spécifiques sont listées, seules ces colonnes peuvent être affectées dans une commande INSERT, (les autres colonnes recevront par conséquent des valeurs par défaut). Autorise aussi COPY FROM.

**UPDATE**

Autorise une mise à jour sur toute colonne de la table spécifiée, ou sur les colonnes spécifiquement listées. (En fait, toute commande UPDATE nécessite aussi le droit SELECT car elle doit référencer les colonnes pour déterminer les lignes à mettre à jour et/ou calculer les nouvelles valeurs des colonnes.)

**DELETE**

Autorise la suppression d'une ligne sur la table indiquée. (En fait, toute commande DELETE nécessite aussi le droit SELECT car elle doit référencer les colonnes pour déterminer les lignes à supprimer.)

**TRUNCATE**

Autorise la suppression de tous les enregistrements de la table.

**REFERENCES**

Ce droit est requis sur les colonnes de référence et les colonnes qui référencent pour créer une contrainte de clé étrangère. Le droit peut être accordé pour toutes les colonnes, ou seulement des colonnes spécifiques.

**TRIGGER**

Autorise la création d'un déclencheur sur la table indiquée.

**CREATE**

Pour les bases de données, autorise la création de nouveaux schémas dans la base de données.

Pour les schémas, autorise la création de nouveaux objets dans le schéma. Pour renommer un objet existant, il est nécessaire d'en être le propriétaire et de posséder ce droit sur le schéma qui le contient.

Pour les tablespaces, autorise la création de tables, d'index et de fichiers temporaires dans le tablespace et autorise la création de bases de données utilisant ce tablespace par défaut. (Révoquer ce privilège ne modifie pas l'emplacement des objets existants.)

**CONNECT**

Autorise l'utilisateur à se connecter à la base indiquée. Ce droit est vérifié à la connexion (en plus de la vérification des restrictions imposées par pg_hba.conf).

**TEMPORARY, TEMP**

Autorise la création de tables temporaires lors de l'utilisation de la base de données spécifiée.

**EXECUTE**

Autorise l'utilisation de la fonction indiquée et l'utilisation de tout opérateur défini sur cette fonction. C'est le seul type de droit applicable aux fonctions. (Cette syntaxe fonctionne aussi pour les fonctions d'agrégat)

**ALL PRIVILEGES**

Octroie tous les droits disponibles en une seule opération. Le mot clé PRIVILEGES est optionnel sous PostgreSQL™ mais est requis dans le standard SQL.

La commande SQL GRANT permet de définir les droits :

### Les droits d'accès aux données spatiales



### Les rôles par l'exemple - Illustration QGIS


extensions hstore pour integrer des bases de données clés/valeurs


## FOREIGN DATA WRAPPERS

Faire correspondre une base de données distantes à notre base de données. 

Extention "fdw" 
"ogr fdw" on peut se connecter à un flux
"postgre fdw" pour se connecter à une base autre
" file fdw" se connecter à un fichier

