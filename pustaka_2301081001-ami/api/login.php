<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

$host = "localhost";
$username = "root";
$password = "";
$database = "pustaka_2301081001";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die(json_encode([
        'success' => false,
        'message' => 'Connection failed: ' . $conn->connect_error
    ]));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (isset($data['username']) && isset($data['password'])) {
        $username = $conn->real_escape_string($data['username']);
        $password = $conn->real_escape_string($data['password']);
        
        $sql = "SELECT id, username, nama FROM admin WHERE username='$username' AND password='$password'";
        $result = $conn->query($sql);
        
        if ($result && $result->num_rows > 0) {
            $user = $result->fetch_assoc();
            echo json_encode([
                'success' => true,
                'message' => 'Login berhasil',
                'user' => [
                    'id' => $user['id'],
                    'username' => $user['username'],
                    'nama' => $user['nama']
                ]
            ]);
        } else {
            echo json_encode([
                'success' => false,
                'message' => 'Username atau Password tidak valid'
            ]);
        }
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Data tidak lengkap'
        ]);
    }
}

$conn->close();
?>