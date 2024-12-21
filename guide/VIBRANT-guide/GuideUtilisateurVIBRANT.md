# UtilisationVibrant

# VIBRANT

## Identification des Virus par Annotation Itérative

**Date de publication** : 22/06/2020  
**Auteur** : Kristopher Kieft  
**Laboratoire** : Anantharaman Lab, Université du Wisconsin-Madison  
**Contact** : kieft@wisc.edu

### Version actuelle
**VIBRANT v1.2.1**

---

### Mises à jour

#### Version 1.2.1 (13/03/2020)
- Résolution d’un bug : `pfam_name` non défini causant des erreurs dans les exécutions parallèles.
- Nouveaux fichiers de sortie : `phages_circular.fna` et `integrated_prophage_coordinates.tsv`.
- Ajout de fichiers de logs pour le suivi des erreurs : `log_run.log` et `log_annotation.log`.

#### Version 1.2.0 (09/02/2020)
- Suppression de la pré-filtration des scaffolds basée sur l'inversion des brins.
- Simplification des bases de données HMM requises.

#### Version 1.1.0 (07/02/2020)
- Résolution d'un problème d'enregistrement d'informations sur les brins.
- Ajout de l’option `-folder` pour définir un dossier de sortie spécifique.

#### Version 1.0.1
- Résolution d’un bug affectant la séquence génomique des provirus extraits.
- Modification de la longueur minimale des séquences pour une meilleure identification virale.

---

### Description du programme
VIBRANT est un outil d'identification, d'annotation et de récupération automatisée des virus bactériens et archéens. Il utilise des réseaux neuronaux pour détecter les virus dans les assemblages métagénomiques, caractériser leur fonction et identifier les gènes viraux auxiliaires.

- Utilisation d'un apprentissage automatique basé sur des signatures de protéines.
- Détermination de la complétude des génomes viraux.
- Identification et extraction des provirus intégrés.

---

### Bases de données utilisées
1. **KEGG** : [https://www.genome.jp/kegg/](https://www.genome.jp/kegg/)
2. **Pfam** : [https://pfam.xfam.org](https://pfam.xfam.org)
3. **VOG** : [http://vogdb.org/](http://vogdb.org/)

---

### Exigences système
- **Systèmes** : Mac, Linux, Ubuntu.
- **Dépendances** : Python3, Prodigal, HMMER3, gzip, tar, wget.

---

## Installation de Miniconda (20 minutes)

### Télécharger l'installateur de Miniconda
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```
### Lancer l'installation
```bash
bash Miniconda3-latest-Linux-x86_64.sh
```
### Confirmer l'installation en tapant "yes"
```bash
yes
enter
yes
```
### Ajouter Miniconda au PATH dans .bashrc
```bash
echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.bashrc
```
### Recharger .bashrc pour appliquer les changements
```bash
source ~/.bashrc
```

---

## Installation de VIBRANT (4-5h) - Le nombre de temps est varibles selon les ressources de votre serveur

### Cloner le dépôt
```bash
git clone https://github.com/AnantharamanLab/VIBRANT
chmod -R 777 VIBRANT
cd VIBRANT
```
### Créer un environnement conda
Car cela fonctionne seulement avec cette version de python
```bash
conda create -n py36 python=3.6
conda activate py36
python --version
```
### Installation des dépendances

- **Packages requis** : BioPython, Pandas, Matplotlib, Seaborn, Numpy, Scikit-learn, hmmer, Prodigal.

```bash
pip install pandas biopython tqdm hmmer
pip install matplotlib seaborn numpy scikit-learn
conda install -c bioconda prodigal
pip install --upgrade scikit-learn==0.21.3
pip install --upgrade numpy==1.17.0
pip install seaborn==0.9.0
```
Important avant de continuer : valider qu'il n'y a pas eu d'échec de téléchargement.

#### Installation de VIBRANT (environ ~20 Go nécessaires pendant l'installation et environ ~11 Go par la suite)
Cette étape prend plusieurs heures et non quelques minutes.
```bash
cd databases
./VIBRANT_setup.py
```

#### Vérifier le fichier log pendant le processus
Ouvrir un autre terminal:
```bash
cd VIBRANT/databases
vim VIBRANT_setup.log
```

#### Vérifier les dépendances après le processus
```bash
./VIBRANT_setup.py -test
```
---

### Exécution de VIBRANT

```bash
python3 VIBRANT_run.py <argument optionel> <fichier input>
```

---

### Arguments et options

| Option               | Description                                                                                                                                                                      |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `-h, --help`        | Affiche les options de VIBRANT.                                                                                                                                                  |
| `--version`         | Affiche la version de VIBRANT.                                                                                                                                                   |
| `-i I`              | Utiliser un fichier fasta.( `I` : le nom du fichier)                                                                                                                                                       |
| `-f {prot,nucl}`    | Changer le format de l'entrée (défaut = `nucl`).                                                                                                                                |
| `-folder folder`    | Chemin du dossier de sortie ou des fichiers temporaires (par défaut : répertoire de travail).                                                                                    |
| `-t T`              | Nombre de tâches parallèles, chaque tâche utilise 1 CPU (par défaut=1, maximum de 1 CPU par échafaudage).                                                                       |
| `-l L`              | Longueur minimale en paires de bases des séquences d'entrée (par défaut=1000).                                                                                                   |
| `-o O`              | Nombre minimal d'OFR par échafaudage pour limiter les séquences d'entrée (par défaut=4).                                                                                        |
| `-virome`           | Utilise ce paramètre si l'ensemble de données est principalement composé de virus (par défaut=off).                                                                            |
| `-no_plot`          | Supprime la génération de graphiques récapitulatifs (par défaut=off).                                                                                                            |
| `-d D`              | Chemin vers le répertoire original "databases" contenant les fichiers .HMM (si déplacé).                                                                                        |
| `-m M`              | Chemin vers le répertoire "files" contenant les fichiers .tsv et les modèles (si déplacé).                                                                                       |

---

### Explication des sorties
Voir fichier détaillé sur les sorties: https://github.com/AnantharamanLab/VIBRANT/blob/master/output_explanations.pdf

#### Les dossiers créer a l'execution de l'application

```plaintext
VIBRANT_nom_du_fichier
├── nom_du_fichier.prodigal.faa
├── nom_du_fichier.prodigal.ffn
├── nom_du_fichier.prodigal.gff
├── VIBRANT_figures_nom_du_fichier
│   ├── VIBRANT_figure_pathways_nom_du_fichier.pdf
│   ├── VIBRANT_figure_PCA_nom_du_fichier.pdf
│   ├── VIBRANT_figure_phages_nom_du_fichier.pdf
│   ├── VIBRANT_figure_quality_nom_du_fichier.pdf
│   └── VIBRANT_figure_sizes_nom_du_fichier.pdf
├── VIBRANT_HMM_tables_parsed_nom_du_fichier
│   ├── nom_du_fichier.KEGG_hmmtbl_parse.tsv
│   ├── nom_du_fichier.Pfam_hmmtbl_parse.tsv
│   └── nom_du_fichier.VOG_hmmtbl_parse.tsv
├── VIBRANT_HMM_tables_unformatted_nom_du_fichier
│   ├── nom_du_fichier_unformatted_KEGG.hmmtbl
│   ├── nom_du_fichier_unformatted_Pfam.hmmtbl
│   └── nom_du_fichier_unformatted_VOG.hmmtbl
├── VIBRANT_log_annotation_nom_du_fichier.log
├── VIBRANT_log_run_nom_du_fichier.log
├── VIBRANT_phages_nom_du_fichier
│   ├── nom_du_fichier.phages_circular.fna
│   ├── nom_du_fichier.phages_combined.faa
│   ├── nom_du_fichier.phages_combined.ffn
│   ├── nom_du_fichier.phages_combined.fna
│   ├── nom_du_fichier.phages_combined.gbk
│   ├── nom_du_fichier.phages_combined.txt
│   ├── nom_du_fichier.phages_lysogenic.faa
│   ├── nom_du_fichier.phages_lysogenic.ffn
│   ├── nom_du_fichier.phages_lysogenic.fna
│   ├── nom_du_fichier.phages_lytic.faa
│   ├── nom_du_fichier.phages_lytic.ffn
│   └── nom_du_fichier.phages_lytic.fna
└── VIBRANT_results_nom_du_fichier
    ├── VIBRANT_AMG_counts_nom_du_fichier.tsv
    ├── VIBRANT_AMG_individuals_nom_du_fichier.tsv
    ├── VIBRANT_AMG_pathways_nom_du_fichier.tsv
    ├── VIBRANT_annotations_nom_du_fichier.tsv
    ├── VIBRANT_complete_circular_nom_du_fichier.tsv
    ├── VIBRANT_figure_PCA_nom_du_fichier.tsv
    ├── VIBRANT_genbank_table_nom_du_fichier.tsv
    ├── VIBRANT_genome_quality_nom_du_fichier.tsv
    ├── VIBRANT_integrated_prophage_coordinates_nom_du_fichier.tsv
    ├── VIBRANT_machine_nom_du_fichier.tsv
    ├── VIBRANT_summary_normalized_nom_du_fichier.tsv
    └── VIBRANT_summary_results_nom_du_fichier.tsv
```

- Cela peut sembler intimidant d’avoir autant de fichiers, mais c’est uniquement parce que **VIBRANT effectue une analyse très détaillée**.  
- Il produit tous les fichiers, même lorsqu’il n’a pas les données nécessaires pour les remplir.  
- Par la suite, vous pouvez supprimer certains fichiers vides si nécessaire.  
- Les dossiers que je trouve les plus utiles sont :  
  - **VIBRANT_figures** : Contient des visualisations importantes.  
  - **VIBRANT_HMM_tables_unformatted** : Utile pour analyser les données spécifiques que nous avons traitées.  
- Les trois fichiers produits par Prodigal (protéines, gènes, et prédictions GFF) :  
  - **`.faa`**, **`.ffn`**, et **`.gff`**  
  - Ces fichiers servent de **base pour générer les analyses suivantes** effectuées par VIBRANT.

### Points negatifs

- GUI
- Dépendences multiples
- Prend énormément d'espace
- Temps d'exécution très élevé
