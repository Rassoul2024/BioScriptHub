#!/bin/bash

# Fonction pour vérifier les dépendances
check_dependencies() {
    echo "Vérification des dépendances pour VirFinder et VirSorter2..."
    missing_dependencies=false
    virsorter=$(source activate vs2)
    virfinder=$(source activate vs)


    # Vérification si R est installé
    if ! command -v R &> /dev/null; then
        echo "❌ R n'est pas installé. Veuillez l'installer."
        missing_dependencies=true
    fi

    # Vérification si le script VirFinder est présent
    if [[ ! -f "vfinder_script.R" ]]; then
        echo "❌ Le script 'vfinder_script.R' est manquant. Assurez-vous qu'il se trouve dans le répertoire courant."
        missing_dependencies=true
    fi

    # Vérification si VirFinder est installé
    if [[ $virfinder = *vs* ]] &> /dev/null; then
        echo "❌ VirFinder n'est pas installé ou n'est pas accessible."
        missing_dependencies=true
    fi

    # Vérification si VirSorter2 est installé
    if [[ $virsorter = *vs2* ]]  &> /dev/null; then
        echo "❌ VirSorter2 n'est pas installé. Veuillez l'installer."
        missing_dependencies=true
    fi

    # Vérification si le module venv de Python est disponible
    if ! python3 -c "import venv" &> /dev/null; then
        echo "❌ Le module 'venv' pour Python n'est pas disponible."
        missing_dependencies=true
    fi

    # Vérification finale et message global
    if [ "$missing_dependencies" = true ]; then
        echo "⚠️  Certaines dépendances sont manquantes. Veuillez les installer avant de continuer."
        exit 1
    else
        echo "✅ Toutes les dépendances nécessaires sont satisfaites."
    fi
}

