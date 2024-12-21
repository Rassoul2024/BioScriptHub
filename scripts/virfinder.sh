
inputfile=$1					                	# Variable pour stocker le fichier d'entrée
outputfolder=$2					                	# Variable pour définir le dossier de sortie
datetime=$(date "+%Y%m%d_%Hh%M")

output_file_name="${datetime}_file.txt"	    	# Nom du fichier de sortie avec un timestamp unique

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

mkdir -p $outputfolder			            	# Crée le dossier de sortie si nécessaire
echo "Activation de l'environnement VirFinder et lancement de R pour utiliser la library de VirFinder..."
source activate vf				            	# Active l'environnement virtuel de VirFinder

# Exécute le script R pour l'analyse
Rscript --vanilla vfinder_script.R "$inputfile" "${outputfolder}/${output_file_name}"  &
app_pid=$!					                    # Récupère le PID de l'application pour afficher le spinner pendant son exécution

conda deactivate				                    # Désactive l'environnement virtuel une fois terminé

# Affiche l'emplacement du fichier de sortie
echo "Le fichier de sortie est : ${outputfolder}/${output_file_name}"
