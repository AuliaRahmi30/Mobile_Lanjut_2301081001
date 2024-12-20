<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

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

// GET - Mengambil data peminjaman
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT p.*, a.nama as nama_anggota, a.nim as nim_anggota, b.judul as judul_buku 
            FROM peminjaman p
            LEFT JOIN anggota a ON p.id_anggota = a.id
            LEFT JOIN buku b ON p.id_buku = b.id
            ORDER BY p.id DESC";
            
    $result = $conn->query($sql);
    
    if ($result) {
        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = array(
                'id' => $row['id'],
                'nama_anggota' => $row['nama_anggota'],
                'nim_anggota' => $row['nim_anggota'],
                'judul_buku' => $row['judul_buku'],
                'tanggal_pinjam' => $row['tanggal_pinjam'],
                'tanggal_kembali' => $row['tanggal_kembali']
            );
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

// POST - Menambah peminjaman baru
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    
    // Debug input
    error_log("Received data: " . print_r($data, true));
    
    if (!isset($data['anggota_id']) || !isset($data['buku_id']) || 
        !isset($data['tanggal_pinjam']) || !isset($data['tanggal_kembali'])) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Data tidak lengkap',
            'received_data' => $data
        ]);
        exit;
    }
    
    $id_anggota = $conn->real_escape_string($data['anggota_id']);
    $id_buku = $conn->real_escape_string($data['buku_id']);
    $tanggal_pinjam = $conn->real_escape_string($data['tanggal_pinjam']);
    $tanggal_kembali = $conn->real_escape_string($data['tanggal_kembali']);
    
    $sql = "INSERT INTO peminjaman (id_anggota, id_buku, tanggal_pinjam, tanggal_kembali) 
            VALUES ('$id_anggota', '$id_buku', '$tanggal_pinjam', '$tanggal_kembali')";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode([
            'status' => 'success',
            'message' => 'Peminjaman berhasil ditambahkan'
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Database error: ' . $conn->error,
            'sql' => $sql
        ]);
    }
}

$conn->close();
?> 