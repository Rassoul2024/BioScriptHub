# Guide d'installation et d'utilisation

# VirSorter2

## Description de l'app

**Date de publication** :  
**Auteur** : Jiarong Guo et Simon Roux
**Laboratoire** :   
**Contact** : guojiaro@gmail.com
ou @simroux_virus (sur X)

### Version actuelle
Ce guide a été rédigé pour la version  **2.2.4**

### Description du programme
Outil d'identification des virus à ADN et à ARN qui exploite les avancées des bases de données informées
par le génome à travers une collection de classificateurs automatiques personnalisés afin d'améliorer la précision 
et l'étendue de la détection des séquences virales[^1].



## Installation
Le guide d'installation détaillé se trouve [ici](https://github.com/jiarong/VirSorter2) 

### Installation de miniforge
Les installer sont disponible [ici](https://github.com/conda-forge/miniforge?tab=readme-ov-file#download) 


### Installation de VirSorter2

```bash
micromamba create -n vs2 -c conda-forge -c bioconda virsorter=2
micromamba activate vs2
```

### Base de données

```bash
virsorter setup -d db -j 4
```
Des étapes supplémentaires sont nécessiares si jamais l'application a déjà été installée. Se référer à la section [Download Database and dependencies](https://github.com/jiarong/VirSorter2?tab=readme-ov-file#download-database-and-dependencies)

## Utiliser VirSorter2

```bash
micromamba activate vs2
virsorter run -w test.out -i test.fa --min-length 1500 -j 4 all
```
- **test.out** est le chemin vers le dossier créé par l'application pour extraire les fichiers de sortie
- **test.fa** Le chemin vers le fichier d'entrée 

Vous pouvez désactiver l'environnement de vs2 en faisant :

```bash
micromamba deactivate vs2
```

### Arguments et options

Les options détaillées se retrouvent [ici](https://github.com/jiarong/VirSorter2?tab=readme-ov-file#more-options)  

| Option                     | Description                                                                                                                                    |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| `--include-groups [group]` | Les groupes disponibles : dsDNAphage, NCLDV, RNA, ssDNA virus, and lavidaviridae.                                                          |
| `--min-score [classify]`   | Permet de modifier le score minimal et d'éviter la portion longue du pipeline.                                                             |
| `--label labelname`        | Permet de mettre une étiquette sur le résultat lorsque l'application est lancée.                                                               | 
| `--provirus-off`           | Permet de ne pas faire l'étape provirus et accélère l'obtention de résultats.                                                              |
| `--max-orf-per-seq int`    | Permet de sous-échantillonner les ORFs si une séquence a plus d'ORFs que le nombre fourni. Cette option doit être utilisée avec `--provirus-off` |

### Explication des sorties
Les informations détaillées se trouvent dans cette [section de la documentation](https://github.com/jiarong/VirSorter2?tab=readme-ov-file#detailed-description-on-output-files)
- **final-viral-combined.fa** :  Séquences identifiées.
- **final-viral-score.tsv** : Table avec des information pour le dépistage.
- **final-viral-boundary.tsv** :  Table avec des informations complémentaires.



[^1]:Tiré et traduit directement de https://microbiomejournal.biomedcentral.com/articles/10.1186/s40168-020-00990-y