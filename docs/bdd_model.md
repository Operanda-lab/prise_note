# Modelisation MCD, MLD, MPD
[-- Par Julien FASTRE --](https://www.champs-libres.coop/)

## 1. Définitions

### Un système de gestion de base de donnée (SGBD)

Une base de donnée est un logiciel qui permet de stocker et retrouver l’intégralité des données en rapport avec un thème ou une activité.
Elle est généralement au centre de dispositifs informatiques de collecte et de stockage d’information.
Un système de gestion de base de donnée est une suite de logiciel qui permettent de stocker et de retrouver l’information dans la base.

Elle sert à (SOSI) :

- Stocker des données
- Organiser des données
- Structurer des données
- Interroger les données

On change de BDD en fonction de la nature des données ou des moyens d'y accéder.


### Modèles logiques de donnée (MLD)

La typologie des bases de données peuvent être différentes selon : 
- les usages (données pour mobiles, données pour usage client/serveur)
- La licence d'utilisation
- Si elles respectent ou non des principes (ACID)

#### Clés/valeurs

Les bases de données clé/valeurs enregistrent une simple clé à une ou plusieurs valeurs.

Exemple :

| **Clé** |  **Valeurs** |
|---------|:------------:|
| 01      |   Bon état   |
| 02      | Mauvais état |
| 03      |     Mort     |


#### - Time serie databases

Les bases de données « time series », (en français « séries chronologiques ») permettent de retracer l’évolution d’une valeur au cours du temps.

#### - Base de donnée en graphe

Les bases de données en graphe permettent d’interroger des données sous forme de graphe : les éléments sont enregistrés sous formes de noeuds et de relations.

#### - Orienté documents

Les bases de données orientées documents enregistrent les informations au sein de « documents », qui contiennent les données semi-structurées de chaque entité.

#### - Système de gestion de base de donnée relationnel

Les système de gestion de base de donnée relationnel sont les plus fréquemment utilisées des bases de donnée.

### Concepts principaux des systèmes de gestion de base de donnée relationnels

#### - Schema de base d'une BDD relationnelle

1. Dans un système de gestion de base de donnée relationnel, les informations sont conservées au sein de tables.
2. Au sein de chaque table, nous retrouvons les enregistrements.
3. Les tables peuvent être mise en relation les unes aux autres.
4. Cette mise en relation est effectuée en définissant des clés qui servent de référence dans les tables.

mais aussi

**IMPORTANT**

1. Lors de la conception, d’une base de donnée, les données calculées ne sont pas conservées : elles sont recalculées. Elles seront décrites par le **modèle conceptuel des traitements (MCT)**.
2. Les tables correspondent à des entités uniques, qui partagent les mêmes caractéristiques. Lorsque des attributs se répètent, il est possible de les extraire dans une table séparée et de créer des relations entre les tables (et les enregistrements).

#### - Les tables

- Les tables enregistrent les éléments qui ont les mêmes caractéristiques.
- Chaque table définit un certain nombre de champs : des colonnes qui sont typées
- Une table est peuplée d’enregistrements

**IMPORTANT**

Le principe de création d’une table est qu’aucune donnée ne soit redondante : une information identique ne devrait pas être stockée à deux endroits. Si c’est le cas, il est fort probable qu’elle puisse être extraite et stockée dans sa propre table.

#### - Les relations

Les tables peuvent être mises en relation les unes aux autres.

- une liste de ville peuvent appartenir à un pays
- un animal peut être d’une certaine espèce

#### - Clés primaires

Les clés primaires sont des identifiants uniques des enregistrements. Par définition, une clé unique doit être... unique pour tous les enregistrements de la table.
Elles peuvent porter sur une seule colonne, comme pour plusieurs. Dans ce deuxième cas, la contrainte d’unicité porte sur la combinaison des deux colonnes.

#### - Clés étrangères

Lorsque des relations sont créées entre des tables d’un système de gestion de base de donnée relationnel, la table qui effectue la référence contient une relation vers la clé primaire de la table référencée. Cette colonne « de relation » est appelée une clé étrangère.

## Modélisation des données au sein d’un SGBDR

La modélisation de la base de donnée est une étape importante pour construire celle-ci.

Cette étape donne lieu à des questions :
- savoir dans quelle table placer certaines colonnes (par exemple, l’adresse de livraison se met dans la table des clients ou dans la table des commandes ?)
- décider des tables de jonction intermédiaires (par exemple, la table des interprétations qui est indispensable entre les tables des films et la table des acteurs).

**La modélisation MERISE (Méthode d’Étude et de Réalisation Informatique pour les Systèmes d’Entreprise)** élaborée en France en 1978 [Tardieu et al.], qui permet notamment de concevoir un système d’information d’une façon standardisée et méthodique.

### Modèle Conceptuel, Logique et Physique des données

3 étapes

#### Modèle Conceptuel de Données (MCD)

- Le modèle conceptuel de données s’attache à décrire les entités et leurs relations. Les relations sont nommées généralement par des verbes, et les entités par le nom d’un objet.
- Chaque entité comporte des attributs. Chaque attribut doit être rempli pour chaque entité. Un identifiant est généralement également mentionné.
- Les relations peuvent également comporter des attributs.
- Les cardinalités des relations sont également décrites.

#### Modèle Logique de Données (MLD)

Le modèle logique de données reprend le contenu du MCD précédent, mais précise également la manière dont ce modèle sera implémenté. Lorsque le système utilise un SGBDR, on retrouve à ce stade la liste des tables et des colonnes, la mention des clés étrangères, etc.

#### Modèle Physique de Données (MPD ou LDD)

Le modèle physique de données décrit de manière précise la manière dont le MLD sera implémenté. Il explique, par exemple, les choix d’un logiciel de SGBDR.

## Construire un MCD

### Les entités

Une entité est **la représentation d’un objet matériel ou immatériel**. Elle est une population d’individus homogène, c’est à dire un ensemble de données cohérentes ayant des caractéristiques simples.

Une **propriété** (ou attribut) est une donnée élémentaire relative à une entité. On ne considère que les propriétés qui ont du sens dans le contexte abordé. Il n’y a pas de propriété facultative : chacune devra être renseignée.

2 manières textuelles d'écrire les entité et leurs propriétés:
```
ENTITÉ (attribut_1, attribut_2, attribut_3, attribut_4 )
ou
ENTITÉ: attribut_1, attribut_2, attribut_3, attribut_4
```

**L’identifiant** est une propriété ou groupe de propriétés qui sert à identifier une entité. Il est choisi de manière à être unique : deux occurrences d’une entité ne peuvent pas avoir le même identifiant.

Par convention, l’identifiant est la première propriété. Si l’identifiant est composé de plusieures propriétés, on préfixe le nom de ces propriétés par un caractère de soulignement (_).

### Les associations

Une association (ou relation) est une liaison sémantique entre entités.

L’association peut être le lien entre :
1. entité reliée à elle-même : la relation est dite **réflexive**,
2. entités : la relation est dite **binaire** (ex : une usine ‹ est implantée › dans un pays),
3. plus rarement 3 ou plus : **ternaire**, voire de dimension supérieure. En fait, si une relation a 3 points d’attache ou plus, on peut réécrire la relation en transformant la relation en table et en transformant les liens en relations.

Cette description sémantique est enrichie par la notion de **cardinalité**, celle-ci indique le nombre **minimum**(généralement 0 ou 1) et **maximum** (généralement 1 ou n) de fois où une occurrence quelconque d’une entité peut participer à une association.

**EXEMPLE :**

```
Une association peut également être porteuse d’une ou plusieurs propriétés. 
(ex : ‹ date d’intégration ›, ‹ fonction › d’un employé dans un service)
Un employé a au moins un service d’appartenance, et peut appartenir à plusieurs services.
Chaque appartenance a une date de début et une date de fin.
Un service contient aucun (cardinalité min=0) ou plusieurs employés (cardinalité max=n).
```

```
EMPLOYÉ: numéro de l'employé, nom, prénom
APPARTIENT, 1N EMPLOYÉ, 0N SERVICE: date d'intégration, date de fin, fonction
SERVICE: nom_service, heure d'ouverture
```

Le nom des relations est parfois remplacé par **DF, pour « Dépendance fonctionnelle »** lorsqu’une des cardinalités d’une association binaire est 1. En effet, dans ce cas, le nom disparaitra lors de la conversion vers un MLD.

## Normalisation d'un MCD

Le but essentiel de la normalisation est d’éviter les anomalies transactionnelles pouvant découler d’une mauvaise modélisation des données et ainsi éviter un certain nombre de problèmes potentiels tels que les anomalies de lecture, les anomalies d’écriture, la redondance des données et la contreperformance.

### Des attributs qui se suffisent à eux mêmes

Chaque attribut doit être complet, se suffire à lui-même. Il ne doit pas pouvoir se décomposer en plusieurs autres attributs.

**IMPORTANT**

- Une date est un seul attribut elle ne se décompose pas
- Exemple du nom et prénom comme 1 seul attribut. Les deux éléments peuvent être différenciés. 

Les attributs doivent avoir une certaine forme de persistance : ils ne doivent pas changer au fil du temps. SI ils sont amener à changer, on pourrait les retrouver en tant que propriété 'atteribut) d'une table de relation comme la fonction d'une personne.

### Des ensembles d’attributs cohérents

Les règles de normalisation stipulent que chaque attribut doit se référer à l’objet qui est référencé, et uniquement à lui.

Ainsi, si un attribut dépend d’un autre attribut, alors il est sans doute intéressant de promouvoir cet attribut comme un nouvel identifiant dans une nouvelle entité, et de lui accoler cet attribut.

**EXEMPLE :**

| Numéro de commande | Produit | Paquet | Poids du paquet | Date d’envoi du paquet |
|---|---|---|---|---|
| 1 | 123456 | ABC456LESS | 5kg | 15/01/2022 | 
| 1 | 456798 | ABC456LESS | 5kg | 15/01/2022 | 
| 1 | 789123 | ABC456LESS | 5kg | 15/01/2022 | 
| 1 | 456789 | GHIDD456LES | 3kg | 15/03/2022 |

=>

| Numéro de commande | Produit | Paquet |
|---|---|---|
| 1 | 123456 | ABC456LESS | 
| 1 | 456798 | ABC456LESS | 
| 1 | 789123 | ABC456LESS | 
| 1 | 456789 | GHIDD456LES |

**ET**

| Paquet | Poids du paquet | Date d’envoi du paquet |
|---|---|---|
| ABC456LESS | 5kg | 15/01/2022 | 
| ABC456LESS | 5kg | 15/01/2022 | 
| ABC456LESS | 5kg | 15/01/2022 | 
| GHIDD456LES | 3kg | 15/03/2022 |

## Outils de modélisation


**entité** = Classe d 'objet - objet - 
**propriété** = attribut - 
**association** = relation - 