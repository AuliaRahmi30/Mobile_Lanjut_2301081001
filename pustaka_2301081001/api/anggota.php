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
    die(json_encode(['status' => 'error', 'message' => 'Connection failed: ' . $conn->connect_error]));
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT * FROM anggota";
    $result = $conn->query($sql);
    
    if ($result) {
        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        echo json_encode(['status' => 'success', 'data' => $data]);
    } else {
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($data['nim']) || !isset($data['nama']) || !isset($data['jenis_kelamin'])) {
        echo json_encode(['status' => 'error', 'message' => 'Data tidak lengkap']);
        exit;
    }
    
    $nim = $conn->real_escape_string($data['nim']);
    $nama = $conn->real_escape_string($data['nama']);
    $alamat = $conn->real_escape_string($data['alamat'] ?? '');
    $jenis_kelamin = $conn->real_escape_string($data['jenis_kelamin']);
    
    $check = $conn->query("SELECT nim FROM anggota WHERE nim = '$nim'");
    if ($check->num_rows > 0) {
        echo json_encode(['status' => 'error', 'message' => 'NIM sudah terdaftar']);
        exit;
    }
    
    $sql = "INSERT INTO anggota (nim, nama, alamat, jenis_kelamin) 
            VALUES ('$nim', '$nama', '$alamat', '$jenis_kelamin')";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode(['status' => 'success', 'message' => 'Data anggota berhasil ditambahkan']);
    } else {
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
    }
}

$conn->close();
?> 