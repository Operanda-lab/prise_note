# Concept d'administration

on doit différencier la gestion du serveur de la gestion des bases de données

1. Différence entre SG et DB

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

2. Étapes de la Création d'un système de base de données

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

3. Architecture et arborescence

Datas

Configuration

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

4.2. 

4.3. Sauvegarder et restaurer les données de postgreSQL en ligne de commande

4.3.1 Sauver

Objectif : produire un fichier texte de commandes SQL (« fichier dump »), qui, si on le renvoie au serveur, recrée une base de données identique à celle sauvegardée.

PostgreSQL™ propose pour cela le programme utilitaire pg_dump.


```SQL
pg_dump base_de_donnees > fichier_sauvegarde
```

Les extractions peuvent être réalisées sous la forme de scripts ou de fichiers d'archive.

- Les scripts sont au format texte et contiennent les commandes SQL nécessaires à la reconstruction de la base de données dans l'état où elle était au moment de la sauvegarde. La restauration s'effectue en chargeant ces scripts avec psql.

- La reconstruction de la base de données à partir d'autres formats de fichiers archive est obtenue avec pg_restore. Les formats de fichier en sortie les plus flexibles sont le format « custom » (-Fc) et le format « directory » (-Fd). Ils permettent la sélection et le ré-ordonnancement de tous les éléments archivés, le support de la restauration en parallèle. De plus, ils sont compressés par défaut. Le format « directory » est aussi le seul format à permettre les sauvegardes parallélisées.

pg_dump permet de restaurer des bases dans des versions du serveur plus récentes.

**Remarque**

pg_dump est aussi la seule méthode qui fonctionnera lors du transfert d'une base de données vers une machine d'une architecture différente (comme par exemple d'un serveur 32 bits à un serveur 64 bits).