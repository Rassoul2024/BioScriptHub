inputfile=$1					                	# Variable pour stocker le fichier d'entrée
outputfolder=$2					                	# Variable pour définir le dossier de sortie
datetime=$(date "+%Y%m%d_%Hh%M")

# Fonction de spinner (indicateur de progression pendant l'exécution)
 spinner() {
    local spinner_chars="\|/-"			        	# Les caractères de l'animation
    while kill -0 "$app_pid" 2>/dev/null; do		# Vérifie si l'application est toujours en cours
        for (( i=0; i<${#spinner_chars}; i++ )); do	# Affiche les caractères de progression
            echo -ne "${spinner_chars:$i:1}" "\r"	# Met à jour l'animation de manière continue
            sleep 0.2				            	# Pause entre les changements
        done
    done
}

  echo "Activation de l'environnement et lancement de VirSorter2!"
  source activate vs2			               	   # Active l'environnement virtuel de VirSorter2

# Configure VirSorter2 pour utiliser 4 threads pour l'outil HMMSEARCH
  virsorter config --set HMMSEARCH_THREADS=4

# Exécute VirSorter2 sur le fichier d'entrée, avec des paramètres spécifiques pour la sortie
  virsorter run -w "${outputfolder%/}/virsorter2_${datetime}" -i "$inputfile" --min-length 1500 -j 6  &
  app_pid=$!					                   # Récupère le PID de l'application pour afficher le spinner pendant son exécution

# Affiche le spinner jusqu'à la fin de l'exécution
  spinner
  userMessages "Le dossier de sortie est : ${outputfolder%/}/virsorter2${datetime}"