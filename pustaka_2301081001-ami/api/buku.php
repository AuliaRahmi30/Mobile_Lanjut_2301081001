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
        'status' => 'error',
        'message' => 'Connection failed: ' . $conn->connect_error
    ]));
}

// GET - Mengambil semua data buku
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT * FROM buku";
    $result = $conn->query($sql);
    
    if ($result) {
        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        echo json_encode([
            'status' => 'success',
            'data' => $data
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => $conn->error
        ]);
    }
}

// POST - Menambah data buku baru
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $judul = $conn->real_escape_string($data['judul']);
    $pengarang = $conn->real_escape_string($data['pengarang']);
    $penerbit = $conn->real_escape_string($data['penerbit']);
    $tahun_terbit = $conn->real_escape_string($data['tahun_terbit']);
    $image = $conn->real_escape_string($data['image']);
    
    $sql = "INSERT INTO buku (judul, pengarang, penerbit, tahun_terbit, image) 
            VALUES ('$judul', '$pengarang', '$penerbit', '$tahun_terbit', '$image')";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode([
            'status' => 'success',
            'message' => 'Buku berhasil ditambahkan'
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => $conn->error
        ]);
    }
}

$conn->close();
?> 