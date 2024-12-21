### Guide d'installation et d'utilisation de Phirbo

Ce guide explique comment cloner le projet depuis GitHub, activer l'environnement virtuel et utiliser les commandes pour exécuter Phirbo.
### 1. Cloner le projet depuis GitHub

Tout d'abord, vous devez cloner le dépôt Phirbo sur votre machine locale. Pour ce faire, suivez ces étapes :
### a. Cloner le dépôt avec Git

Si vous avez Git installé sur votre machine, ouvrez un terminal et exécutez la commande suivante pour cloner le projet depuis GitHub :
```bash
git clone https://gitlab.com/Rassoul2024/phirbo.git
```
Cette commande va télécharger le projet Phirbo dans un dossier nommé teste sur votre ordinateur.
### b. Accéder au répertoire du projet

Une fois que le dépôt est cloné, allez dans le répertoire du projet avec la commande suivante :
```bash
cd phirbo
```
Vous devez maintenant être dans le répertoire du projet Phirbo.
### 2. Activer l'environnement virtuel

Un environnement virtuel est déjà configuré dans ce dépôt. Vous devez l'activer pour installer et utiliser les dépendances nécessaires.
### a. Sur Linux/macOS

Si vous êtes sous Linux ou macOS, vous pouvez activer l'environnement virtuel avec cette commande :
```bash
source venv/bin/activate
```
Une fois l'environnement activé, vous devriez voir (venv) au début de votre invite de commande, indiquant que l'environnement est actif.
### b. Sur Windows

Si vous êtes sous Windows, utilisez la commande suivante pour activer l'environnement virtuel :
```bash
.\venv\Scripts\activate
```
De même, vous devriez voir (venv) au début de l'invite de commande, indiquant que l'environnement virtuel est actif.
### 3. Installer les dépendances (si nécessaire)

Si ce n'est pas déjà fait, vous pouvez installer les dépendances nécessaires en exécutant la commande suivante dans l'environnement virtuel activé :
``` bash
pip install -r requirements.txt
```
Cela installera toutes les bibliothèques Python nécessaires pour exécuter Phirbo, comme spécifié dans le fichier requirements.txt.
### 4. Exécuter Phirbo

Une fois l'environnement virtuel activé et les dépendances installées, vous pouvez exécuter le programme Phirbo.
### a. Exécuter le script

Pour exécuter Phirbo, vous devez appeler le script phirbo.py avec les bons arguments. Par exemple :
```bash
cd Execution
python ./phirbo.py host/ virus/ output
```
    host/ : Le répertoire contenant les données des hôtes.
    virus/ : Le répertoire contenant les données des virus.
    output : Le répertoire où seront enregistrés les résultats.

Assurez-vous que ces répertoires existent dans le projet ou fournissez les chemins appropriés vers les répertoires sur votre machine.
### 5. Désactiver l'environnement virtuel

Lorsque vous avez terminé de travailler avec l'environnement virtuel, vous pouvez le désactiver en exécutant cette commande :
```bash
deactivate
```
### Résultats de PhiRbo

### Description
Les résultats obtenus représentent une matrice de scores générée par l'outil PhiRbo. Cette matrice évalue les associations probables entre des hôtes et des virus en fonction de leurs génomes.

### Structure de la matrice
- **Colonnes** : Identifiants des hôtes (par ex. `NC_022515`, `NC_022516`).
- **Lignes** : Identifiants des virus (par ex. `NC_000866`, `NC_000871`).
- **Cellules (valeurs)** : Scores indiquant la probabilité d'association entre un virus et un hôte.
  - Une valeur proche de `0.0` : Pas d'association détectée.
  - Une valeur plus élevée (ex. `0.282798`) : Association plus probable.

### Interprétation
- Les scores élevés mettent en évidence des relations potentielles entre un virus et un hôte.
- Les scores faibles ou nuls (`0.0`) indiquent l'absence d'association détectable.

### Utilisation
Ces données peuvent être utilisées pour :
1. Identifier des associations significatives entre virus et hôtes.
2. Visualiser des relations dans des graphes pour analyser des interactions complexes.
3. Filtrer les associations à valider expérimentalement.

