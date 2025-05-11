#!/bin/bash

# Fichier pour sauvegarder les scores
SCORE_FILE="scores.txt"

# Fonction pour afficher le menu principal
function main_menu {
    clear
    echo "=== QUIZZ INTERACTIF ==="
    echo "1. Jouer"
    echo "2. Voir les scores"
    echo "3. Quitter"
    echo -n "Choisissez une option [1-3] : "
    read choice
    case $choice in
        1) play_game ;;
        2) show_scores ;;
        3) echo "Au revoir !" && exit 0 ;;
        *) echo "Option invalide." && sleep 1 && main_menu ;;
    esac
}

# Fonction pour jouer au quizz
function play_game {
    score=0
    questions=(
        "Quelle commande permet de lister les fichiers d’un répertoire ?|ls"
        "Quelle commande permet de changer de répertoire ?|cd"
        "Quelle commande affiche le chemin absolu ?|pwd"
        "Quelle commande affiche le contenu d’un fichier ?|cat"
        "Quelle commande permet de copier un fichier ?|cp"
    )

    echo -n "Entrez votre nom : "
    read player

    for q in "${questions[@]}"; do
        IFS='|' read -r question answer <<< "$q"
        echo "$question"
        read -p "Votre réponse : " user_answer
        if [[ "$user_answer" == "$answer" ]]; then
            echo "Bonne réponse !"
            ((score++))
        else
            echo "Faux. La bonne réponse était : $answer"
        fi
        echo ""
    done

    echo "$player : $score/5" >> "$SCORE_FILE"
    echo "Votre score : $score/5"
    read -p "Appuyez sur Entrée pour revenir au menu..." _
    main_menu
}

# Fonction pour afficher les scores
function show_scores {
    if [[ -f $SCORE_FILE ]]; then
        echo "=== SCORES ==="
        cat "$SCORE_FILE"
    else
        echo "Aucun score enregistré."
    fi
    read -p "Appuyez sur Entrée pour revenir au menu..." _
    main_menu
}

# Lancement du menu principal
main_menu
