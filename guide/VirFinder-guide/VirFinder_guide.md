
# Guide d'installation et d'utilisation

## VirFinder

### Description de l'application
**Date de publication** : 27 septembre 2019 
**Auteur** :  Jie Ren, Nathan Ahlgren, Yang Lu, Jed Fuhrman, Fengzhu Sun

### Version actuelle
Ce guide a été rédigé pour la version 1.1

### Description du programme
VirFinder est un outil de détection de virus à partir de séquences de génomes, qui utilise une approche d'apprentissage machine pour identifier des séquences virales dans des ensembles de données de génomes microbiens. VirFinder se distingue par sa capacité à analyser et à classer des séquences à partir de bases de données génomiques pour améliorer la précision de la détection des virus.

## Installation

### Installation de miniforge
Les installer sont disponible [ici](https://github.com/conda-forge/miniforge?tab=readme-ov-file#download) 


### Installation de VirFinder

```bash
conda create --name vf r-base
conda activate vf

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

conda install -c bioconda r-virfinder

```

## Utiliser VirFinder

1. Activez l'environnement `virfinder` :
   ```bash
   conda activate vf
 
   ```

2. Activez l'environnement `R` : 
  ```bash
    R
   ```

2. Exécutez VirFinder avec les paramètres suivants :
   ```R
   library(VirFinder)
   predResult <- VF.pred("path_to_the_fasta_file")
   ```
   **Important** : Ceci affichera les résultats à l'écran. Pour exporter les données dans un fichier externe, vous pouvez faire ces commandes : 

   ```R
   sink("fichieroutput.txt") 
   predResult <- VF.pred("path_to_the_fasta_file")
   sink() 
   ```
3. Pour quitter `R`, exécutez :
   ```R
   q()
   ```

4. Pour désactiver l'environnement `virfinder`, exécutez :
   ```bash
   conda deactivate
   ```

### Arguments et options

#### Options disponibles :

| Option                 | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `--fasta [file]`      | Spécifie le fichier FASTA contenant les séquences à analyser. |
| `--score`    | Affiche le score de probabilité pour chaque séquence.           |
| `--pvalue`      | Affiche la valeur p associée à chaque séquence.                       |
| `--threads [int]`     | Définit le nombre de threads à utiliser pour le traitement parallèle       |
| `--output [file]` | Spécifie le fichier de sortie pour enregistrer les résultats.                            |
| `--kmer [int]`     | Définit la taille des k-mers utilisés pour l'analyse (par défaut : 8).       |
| `--verbose`     | Active l'affichage détaillé des étapes du traitement.       |
| `--help`     | Affiche l'aide et les options disponibles.       |

Il suffit d'executer la commande : 
```bash
   virfinder --option_choisie
   ```
### Explication des sorties

L'output de **VirFinder** est généralement un fichier tabulaire contenant les informations suivantes pour chaque séquence analysée :

| Colonne         | Description                                                                 |
|-----------------|-----------------------------------------------------------------------------|
| `Sequence`      | Le nom ou l'identifiant de la séquence analysée.                           |
| `Score`         | La probabilité que la séquence soit virale (valeur entre 0 et 1).          |
| `P-value`       | La valeur p associée au score, indiquant la confiance dans la prédiction.  |
| `Group`         | (Optionnel) Le groupe viral prédit, si applicable.                         |

En autres mots:
 - `Score` : Plus le score est proche de 1, plus il est probable que la séquence soit virale.
 - `P-value` : Une valeur p faible (par exemple, < 0.05) indique une prédiction statistiquement significative.
 - `Group` : Si l'option `--include-groups` est utilisée, le groupe viral prédit peut être inclus.

\
Les outputs peuvent inclure les éléments suivants :

- **final-viral-combined.fa** : Séquences identifiées comme étant virales.
- **final-viral-score.tsv** : Table avec les informations de score pour chaque séquence.
- **final-viral-boundary.tsv** : Table des informations de localisation des séquences virales.

Ces résultats permettent d'identifier les séquences virales potentielles et de prioriser les analyses ultérieures. 

### Tiré et traduit directement de [VirFinder Documentation](https://github.com/jessieren/VirFinder)
