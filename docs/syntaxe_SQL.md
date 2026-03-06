# La syntaxe de l'aide sur les commandes SQL

Dans l'aide en ligne des commandes SQL (https://www.postgresql.org/docs/11/sql-commands.html), vous allez retrouver des conventions pour la syntaxe :

{ } = liste de choix

mot_clé1 | mot_clé2 = choix entre mot_clé1 OU mot_clé2

[mot_clé] = optionnel

Exemple :

DROP TABLE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]

peut s'écrire :

DROP TABLE ma_table ;

DROP If EXISTS ma_table ;

DROP ma_table, ma_table1,ma_table2 ;

DROP ma_table CASCADE ;

DROP ma_table RESTRICT ;

DROP If EXISTS ma_table,ma_table1 CASCADE ;