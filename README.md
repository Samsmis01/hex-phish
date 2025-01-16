#HEX-PHISH 🦠

HEX-PHISH est un outil conçu pour automatiser le phishing et d'autres tâches similaires. Il offre une interface simple dans Termux, permettant aux utilisateurs de lancer des attaques ciblées ou de rejoindre un canal Telegram pour plus d'informations.


---

Fonctionnalités

Interface utilisateur interactive : Choisissez entre différentes options directement dans Termux.

Phishing Facebook : Simule une page de connexion Facebook pour collecter des informations.

Redirection Telegram : Permet de rejoindre un canal Telegram d'assistance.

Automatisation : Scripts configurés pour héberger les fichiers et exécuter les actions nécessaires.



---

Pré-requis

Avant de commencer, assurez-vous que vous avez :

1. Termux installé sur votre appareil Android.


2. Les dépendances nécessaires :

PHP

OpenSSH

Git





---

Installation

1. Clonez le dépôt :

git clone https://github.com/votre-utilisateur/hex-phish.git


2. Accédez au répertoire :

cd hex-phish


3. Donnez les permissions d'exécution au script start.sh :

chmod +x start.sh




---

Utilisation

1. Lancez l'outil avec la commande :

bash start.sh


2. Une interface interactive apparaîtra avec les options suivantes :

1. Attaque Facebook : Héberge une page de phishing Facebook.

2. Rejoindre notre canal Telegram : Redirige vers notre canal Telegram.



3. Suivez les instructions affichées dans Termux.




---

Structure du projet

index.html : Page de connexion Facebook factice.

login.php : Script PHP qui capture les identifiants soumis et les stocke dans un fichier.

start.sh : Script pour démarrer le serveur local et configurer Serveo pour la redirection.

README.md : Ce fichier, qui décrit le projet et fournit des instructions.



---

Dépendances

Si vous ne les avez pas installées, exécutez ces commandes dans Termux :

Installer PHP :

pkg install php -y

Installer OpenSSH :

pkg install openssh -y



---

Avertissement

Ce projet est à des fins éducatives uniquement. Toute utilisation abusive de cet outil est interdite. Les auteurs ne sont pas responsables des actions des utilisateurs.
