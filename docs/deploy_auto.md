Dans ton dossier :

```
nano deploy.sh
```

Tu mets dedans :
```
#!/bin/bash

# Vérifie qu'un message est fourni
if [ -z "$1" ]; then
  echo "Tu dois fournir un message de commit."
  echo "Usage : ./deploy.sh \"Mon message\""
  exit 1
fi

# Ajout des fichiers
git add *

# Commit avec le message passé en argument
git commit -m "$1"

# Push
git push

# Déploiement MkDocs
mkdocs gh-deploy
```
Ensuite :

Ctrl + O
Entrée
Ctrl + X

🔐 4️⃣ Rendre le script exécutable

Très important :
```
chmod +x deploy.sh
```

👉 Ça donne le droit d’exécution au fichier.

🚀 5️⃣ Utilisation

Ensuite tu pourras faire :
```
./deploy.sh "Ajout section PostGIS"
```