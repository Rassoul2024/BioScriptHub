###                     Guide d'Installation et d'Utilisation de Phigaro(environnement virtuelle)   

###                                                     Introduction

### Phigaro est un outil de bioinformatique conçu pour analyser les génomes viraux. Il utilise des modèles HMM (Hidden Markov Models) pour effectuer des analyses basées sur des séquences génétiques. Ce guide détaillé vous montrera comment installer Phigaro, l'utiliser pour analyser vos séquences génétiques et gérer les résultats.
Prérequis

### Avant d'installer Phigaro, assurez-vous d'avoir :

    Python 3.6 ou supérieur
    git installé pour cloner le dépôt GitHub

Installer git (si ce n'est pas déjà installé)
```bash
sudo apt update
sudo apt install git
```
Étapes d'Installation
### 1. Cloner le Dépôt GitHub de Phigaro

Commencez par cloner le dépôt GitHub de Phigaro sur votre machine locale :
```bash
git clone https://github.com/bobeobibo/phigaro.git
```
Cela va télécharger le code source de Phigaro dans un répertoire nommé phigaro.
### 2. Installer Phigaro via pip

Une fois le dépôt cloné, allez dans le répertoire du dépôt et installez Phigaro à l'aide de pip :
```bash
cd phigaro
pip install ou pip --upgrade install
```
Cela va installer Phigaro ainsi que toutes les dépendances nécessaires, y compris HMMER et Prodigal, qui sont déjà incluses dans le dépôt.
### 3. Vérification de l'Installation

Pour vérifier que l'installation s'est bien déroulée, exécutez la commande suivante :
```bash
phigaro --help
```
Cela devrait afficher les options de ligne de commande disponibles pour Phigaro.
Utilisation de Phigaro
### 1. Lancer une Analyse

Pour analyser une séquence avec Phigaro, vous devez fournir un fichier FASTA contenant les séquences à analyser. Voici un exemple d'analyse pour le fichier Proviridae_KJ183192.1.fasta :
```bash
phigaro -f Proviridae_KJ183192.1.fasta -e tsv -o resultat.tsv
```
Explication des options :
```bash
    -f : Spécifie le fichier d'entrée contenant les séquences génétiques à analyser (ici, Proviridae_KJ183192.1.fasta).
    -e tsv : Définit le format de sortie des résultats (ici, en format TSV).
    -o : Spécifie le fichier de sortie pour enregistrer les résultats de l'analyse (ici, resultat.tsv).
```
### 2. Résultats dans le Répertoire proc(avec le phigaro de ce depot git,les input et output seront toujours dans le fichier proc )

Les résultats de l'analyse seront générés dans le répertoire proc. Ce répertoire contiendra tous les fichiers de sortie pour vos analyses. Vous y trouverez des fichiers tels que les résultats de HMMER et autres sorties de l'analyse.
Exemple Complet de Commande

Si vous souhaitez analyser un fichier comme Podoviridae_KJ183192.1.fasta, vous pouvez utiliser la commande suivante :
```bash
phigaro -f Podoviridae_KJ183192.1.fasta -e tsv -o proc
```

### 1. Mettre à Jour Phigaro

Pour mettre à jour Phigaro, exécutez les commandes suivantes dans le répertoire phigaro :
```bash
cd phigaro
git pull
pip install.
```
### 2. Désinstaller Phigaro

Si vous souhaitez désinstaller Phigaro, exécutez la commande suivante :
```bash
pip uninstall phigaro
```
### Conclusion

Vous avez maintenant toutes les informations nécessaires pour installer et utiliser Phigaro sur votre machine. Si vous rencontrez des problèmes, n'hésitez pas à consulter les logs de sortie pour plus d'informations sur les erreurs ou à vérifier la documentation officielle sur le dépôt GitHub.
Important Phigaro traite pas les courtes séquences 

### Résultats de PhiGaro

### Description des résultats
PhiGaro a détecté des **régions prophagiques** dans les génomes analysés. Chaque ligne des résultats inclut les informations suivantes :

- **Nom de la séquence** : Identifiant du génome analysé (ex. `KJ183192.1`).
- **Position** : Coordonnées (début et fin) de la région prophagique détectée.
- **VOG (Viral Orthologous Groups)** : Groupes fonctionnels associés aux gènes viraux.
- **GC Content** : Taux de contenu en GC dans la région prophagique (ex. `gc_cont=0.337`).
- **Scores et e-values** : Indicateurs de la fiabilité de la détection (une faible **e-value**, comme `5.6e-166`, reflète une correspondance significative).

### Interprétation des données
- **Coordonnées prophagiques** : Elles permettent de localiser précisément la région prophagique dans le génome hôte.
- **GC Content** : Permet d'évaluer les différences entre la région prophagique et l'ADN de l'hôte.
- **VOG** : Fournit des indices sur les fonctions potentielles des gènes détectés dans la région.

### Exemple de résultats
Voici un exemple tiré des résultats :
- `KJ183192.1_10` :
  - Région prophagique détectée avec un **GC Content** de `0.337`.
  - Associée au groupe fonctionnel **VOG0019**.
  - Fiabilité de détection : faible e-value (`5.6e-166`).

