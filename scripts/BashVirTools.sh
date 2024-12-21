#!/bin/bash

source ./check_dependencies.sh
source ./help.sh
#source ./virsorter2.sh
#source ./virfinder.sh


# Variables pour activer ou désactiver certaines étapes
# Ces variables contrôlent si certaines étapes du script doivent être activées ou non.

activate_local_execution=true			 # Active l'exécution locale (peut être utilisé pour activer des processus locaux)
activate_phage_check=true  			     # Vérification d'images de phages (activer ou désactiver)



# variables d'entrées et de sortie
inputfile=""					                	# Variable pour stocker le fichier d'entrée
outputfolder=""					                	# Variable pour définir le dossier de sortie
datetime=$(date "+%Y%m%d_%Hh%M")	            	# Génère une timestamp pour les noms de fichiers


# Fonction pour afficher des messages avec des bordures
userMessages(){
  echo " "
  echo "*******************************************************************************"
  echo " "
  echo "$1"
  echo " "
  echo "*******************************************************************************"
  echo " "
}


# Fonction pour exécuter VirFinder (outil d'analyse de séquences génétiques)
virfinder() {

  output_file_name="${datetime}_file.txt"	    	# Nom du fichier de sortie avec un timestamp unique

  userMessages "Activation de l'environnement VirFinder et lancement de R pour utiliser la library de VirFinder..."
  ./virfinder.sh $inputfile $outputfolder

# Affiche l'emplacement du fichier de sortie
  userMessages "Le fichier de sortie est : ${outputfolder}/${output_file_name}"

}

# Fonction pour afficher l'usage du script si l'utilisateur entre une mauvaise commande
usage() {
  echo "Validez l'utilisation: $0 --input <chemin+fichier entree> --output <dossier de destination>"
  exit 1				                        	# Quitte le script avec une erreur si les arguments sont incorrects
}


# Fonction pour exécuter VirSorter2 (outil d'identification de virus à partir de séquences)
virsorter2() {

  userMessages "Attention : VirSorter2 demande des ressources importantes (processeur, mémoire et stockage) et peut prendre un temps considérable. \n"
  userMessages "Vérifiez que le fichier d'entrée est au format FA (>1500 pb) et que toutes les dépendances sont installées.\n"
  userMessages " "

  userMessages "Activation de l'environnement et lancement de VirSorter2!"
   outputfolder="${outputfolder%/}/virsorter2_${datetime}"

  ./virsorter2.sh $inputfile $outputfolder

  userMessages "Le dossier de sortie est : ${outputfolder}"
}


# Vérification des arguments d'entrée et de sortie
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    help
    exit 0
fi

#validation des arguments donnés avec le lancement du script
while [[ $# -gt 0 ]]; do
  case $1 in
    --input)
      inputfile="$2"                               # Récupère le fichier d'entrée
      shift 2
      ;;
    --output)
      outputfolder="$2"                            # Récupère le dossier de sortie
      shift 2
      ;;
    *)
      echo "Option inconnue : $1"
      usage                                        # Si une option inconnue est donnée, affiche l'usage et quitte
      #exit 1
      ;;
  esac
done

if [[ -z "$outputfolder" ]]; then
  outputfolder="$(pwd)"
fi

if [[ -z "$inputfile" || -z "$outputfolder" ]]; then
  echo "Erreur : Les options --input et --output doivent accompagner l'utilisation de $0."
  exit 1
fi

if [[ ! -f "$inputfile" ]]; then
    echo "Erreur : Le fichier d'entrée '$inputfile' n'existe pas."
    exit 1
fi

if [[ ! -d "$outputfolder" ]]; then
    echo "Erreur : Le dossier de sortie '$outputfolder' n'existe pas."
    exit 1
fi

check_dependencies

userMessages "⚠️  Attention : Les applications que vous allez exécuter peuvent prendre plusieurs heures et consommer beaucoup de ressources."

# Initialisation de la liste des applications à exécuter
applications=()

# Boucle principale pour le menu interactif
while true; do
    # Affiche le menu
    echo "Veuillez choisir une application à ajouter à la liste d'exécution :"
    echo ""
    echo "1. VirFinder"
    echo "2. VirSorter2"
    echo "h. Help"
    echo "l. Lancer les applications sélectionnées dans le terminal actuel"
    echo "n. Lancer les applications sélectionnées en arrière plan avec nohup"
    echo "q. Quitter"
    echo ""

    # Demande à l'utilisateur de choisir une option
    read -p "Votre choix : " choix
    
    # Traiter le choix de l'utilisateur
    case $choix in
        1)
            # Vérifie si l'application a déjà été ajoutée
            if [[ " ${applications[@]} " =~ "VirFinder" ]]; then
                userMessages "VirFinder a déjà été ajouté à la liste."
            else
                applications+=("VirFinder")                              # Ajoute VirFinder à la liste
                userMessages "VirFinder ajouté à la liste."
            fi
            ;;
        2)
            # Vérifie si l'application a déjà été ajoutée
            if [[ " ${applications[@]} " =~ "VirSorter2" ]]; then
                userMessages "VirSorter2 a déjà été ajouté à la liste."
            else
                applications+=("VirSorter2")                             # Ajoute VirSorter2 à la liste
                userMessages "VirSorter2 ajouté à la liste."
            fi
            ;;
        h)
            help
            ;;
        l)  if [[ ${#applications[@]} -eq 0 ]]; then                     # Choix terminale
                userMessages "Aucune application n'a été sélectionnée. Exécution annulée."
                exit 0
            else
                break
            fi
            ;;
        n)                                                              # Choix avec nohup
            if [[ ${#applications[@]} -eq 0 ]]; then
                userMessages "Aucune application n'a été sélectionnée. Exécution annulée."
                exit 0
            else
                break
            fi
            ;;
        q)                                                           # Quitte le script si l'utilisateur choisit "q"
            userMessages "Vous avez choisi de quitter sans lancer d'application."
            exit 0
            ;;
        *)
            userMessages "Choix invalide. Veuillez réessayer."
            ;;                                                       # Si un choix invalide est entré
    esac
done

# Exécution des applications sélectionnées
userMessages "Démarrage de l'exécution des applications sélectionnées : ${applications[*]}"

for app in "${applications[@]}"; do
    if [[ "$choix" == "l" ]]; then
        # Lancer dans le terminal actuel
        if [[ "$app" == "VirFinder" ]]; then
            virfinder
        elif [[ "$app" == "VirSorter2" ]]; then
            virsorter2
        fi
    elif [[ "$choix" == "n" ]]; then
        # Lancer avec nohup en arrière-plan
        if [[ "$app" == "VirFinder" ]]; then
            nohup bash -c "./virfinder.sh "$inputfile" "$outputfolder"" > "${outputfolder}/virfinder_${datetime}.nohup.out" 2>&1 &
            echo "VirFinder est exécuté en arrière-plan avec nohup. PID : $!"
        elif [[ "$app" == "VirSorter2" ]]; then
            nohup bash -c "./virsorter2.sh "$inputfile" "$outputfolder"" > "${outputfolder}/virsorter2_${datetime}.nohup.out" 2>&1 &
            echo "VirSorter2 est exécuté en arrière-plan avec nohup. PID : $!"
        fi
    fi
done

userMessages "Toutes les étapes sont terminées. À bientôt!"
exit 0

