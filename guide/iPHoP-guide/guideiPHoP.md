# Utilisation d'iPHoP

## Introduction à iPHoP

iPHoP (integrating Phage-Host Predictions) est un outil conçu pour prédire les hôtes des bactériophages et des virus archaéens en s'appuyant sur des approches basées sur les phages et les hôtes, intégrant des données génomiques, des CRISPR spacers, et des modèles k-mer.

## Installation et Configuration

1. **Cloner le dépôt**

   ```bash
   git clone https://bitbucket.org/srouxjgi/iphop.git
   cd iphop
   ```

2. **Créer l'environnement Conda**

   Utilisez le fichier `iphop_environment.yml` fourni dans le dépôt :

   ```bash
     conda env create -f iphop_environment.yml
     ```

4. **Activer l'environnement**
   
   ```bash
   conda activate iphop
   ```

6. **Installer TensorFlow**
   
   ```bash
   python -m pip install https://files.pythonhosted.org/packages/72/8a/033b584f8dd863c07aa8877c2dd231777de0bb0b1338f4ac6a81999980ee/tensorflow-2.7.0-cp38-cp38-manylinux2010_x86_64.whl -vv
   ```

8. **Installer TensorFlow Decision Forests**
   
   ```bash
   python -m pip install https://files.pythonhosted.org/packages/2a/78/bf49937d0d9a36a19faca28dac470a48cfe4894995a70e73f3c0c1684991/tensorflow_decision_forests-0.2.2-cp38-cp38-manylinux_2_12_x86_64.manylinux2010_x86_64.whl -vv
   ```

10. **Installer les dépendances restants**
    
   ```bash
   python -m pip install .
   ```

11. **Vérifier l'installation**
   Pour valider que tout fonctionne correctement :

   ```bash
   iphop -h
   iphop predict -h
   ```
## Téléchargement et Installation de la Base de Données

1. Créez un répertoire pour la base de données :
   
     ```bash
     mkdir iphop_db
     ```
   - Remarque : Le téléchargement de la base de données prendra **30+ heures** et nécessitera **350 Go** d'espace.
   - Cette commande n'est pas recommandée :
     ```bash
     iphop download --db_dir iphop_db/
     ```

### Diviser le téléchargement en segments

Le serveur prend en charge les requêtes par plage (**Range requests**), vous pouvez donc diviser le téléchargement en segments à l'aide d'**aria2**, qui télécharge plusieurs parties du fichier simultanément.

1. **Installer aria2 :**
   ```bash
   sudo apt install aria2
   ```

2. **Utiliser `screen` pour libérer votre terminal :**
   ```bash
   screen -S download
   ```

3. **Télécharger avec aria2 :**
   ```bash
   aria2c -x 16 -s 16 -o iphop_db/iPHoP_db_Aug23_rw.tar.gz https://portal.nersc.gov/cfs/m342/iphop/db/iPHoP_db_Aug23_rw.tar.gz
   ```
   Ici, `-x 16` spécifie le nombre de connexions et `-s 16` divise le fichier en 16 segments.
   **Ce téléchargement vous protège contre les plantages et vous permet d'arrêter et de reprendre plus tard.**

4. **Pour cacher le téléchargement en arrière-plan avec screen :**
   ```bash
   ctrl A D
   ```

5. **Reprendre :**
   ```bash
   screen -r download
   ```
   
## Prévisions des Hôtes avec iPHoP
### Commande de base pour prédire les hôtes

Pour exécuter la prédiction sur des génomes viraux (fichier `.fasta`) :

```bash
iphop predict --fa_file my_input_phages.fasta --db_dir path/to/iphop_db/ --out_dir iphop_output/
```

### Résultats principaux

- Detailed_output_by_tool.csv : Fichier contenant les prédictions de chaque outil utilisé (RaFAH, blastn, CRISPR, etc.).
- Host_prediction_to_genus_m90.csv : Liste des genres hôtes prédits avec leurs scores.
- Host_prediction_to_genome_m90.csv : Liste des génomes hôtes avec des scores détaillés.

## Cas d'Usage Avancés

### Ajouter des génomes personnalisés à la base de données

Vous pouvez enrichir la base d'hôtes avec vos propres génomes bactériens ou MAGs :

1. Placez vos génomes au format FASTA dans un répertoire spécifique.

2. Utilisez la commande suivante pour les ajouter :
```bash
iphop add_to_db --fa_dir my_custom_genomes/ --db_dir iphop_db/
```
## Les commandes IpHop et leurs options

| **Commande**           | **Description**                                                                                                  | **Options**                                                                                      | **Exemple**                                                   |
|-------------------------|------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| `iphop -h`             | Afficher l'aide générale pour iPHoP.                                                                             | `-h`, `--help` : Afficher l'aide.                                                               | `iphop -h`                                                    |
| `iphop predict`        | Exécuter le pipeline complet pour générer des prédictions d'hôtes pour des génomes de phages en entrée.          | `--input` : Fichier FASTA d'entrée contenant les génomes.<br>`--db_dir` : Répertoire de la base de données.<br>`--output` : Répertoire des résultats. | `iphop predict --input genomes.fasta --db_dir iphop_db --output output_dir` |
| `iphop download`       | Télécharger et configurer la dernière base de données d'hôtes.                                                  | `--db_dir` : Répertoire cible pour enregistrer la base de données.                              | `iphop download --db_dir iphop_db`                            |
| `iphop add_to_db`      | Ajouter des génomes d'hôtes (par exemple, des MAGs) à la base de données existante.                              | `--input` : Fichier FASTA contenant les génomes à ajouter.<br>`--db_dir` : Répertoire de la base de données. | `iphop add_to_db --input genomes_to_add.fasta --db_dir iphop_db` |
| `iphop split`          | Diviser un fichier FASTA en lots plus petits pour une exécution par lots.                                        | `--input` : Fichier FASTA à diviser.<br>`--output_dir` : Répertoire pour enregistrer les fichiers divisés. | `iphop split --input large_input.fasta --output_dir split_files` |
| `iphop clean`          | Nettoyer le répertoire de sortie en compressant certains fichiers volumineux générés par iPHoP.                  | `--output_dir` : Répertoire contenant les fichiers à nettoyer.                                  | `iphop clean --output_dir output_dir`                         |