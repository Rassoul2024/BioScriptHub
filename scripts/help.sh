# help.sh

help() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -h, --help        Affiche ce message d'aide et quitte.
  --input FILE      Spécifie le fichier d'entrée (obligatoire).
  --output DIR      Spécifie le dossier de sortie (sinon répertoire courant).

Description:
  Ce script permet d'exécuter des programmes de virologie tels que VirFinder et VirSorter2
  pour analyser un fichier d'entrée (fasta) et produire des résultats dans un dossier de sortie.
  L'utilisateur peut choisir d'exécuter ces programmes en arrière-plan avec nohup pour éviter
  l'interruption lors de la fermeture de la session.

Exemples:
  $(basename "$0") --input exemple.fa --output ./results
  $(basename "$0") --input exemple.fa
  $(basename "$0") --help

EOF
}

