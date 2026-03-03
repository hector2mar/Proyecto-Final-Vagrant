<?php
$host = "192.168.56.20";
$user = "admin";
$pass = "password123";
$db = "proyecto";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Registrar visita
$hostname = gethostname();
$conn->query("INSERT INTO visitas (servidor) VALUES ('$hostname')");

// Mostrar datos
echo "<h1>Hola desde " . $hostname . "</h1>";
echo "<h3>Últimos accesos registrados en la DB:</h3>";

$result = $conn->query("SELECT * FROM visitas ORDER BY id DESC LIMIT 5");
while($row = $result->fetch_assoc()) {
    echo "ID: " . $row["id"] . " - Servidor: " . $row["servidor"] . " - Fecha: " . $row["fecha"] . "<br>";
}
?>