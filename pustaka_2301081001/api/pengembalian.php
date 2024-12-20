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


if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT pg.*, p.tanggal_pinjam, 
            a.nama as nama_anggota, a.nim as nim_anggota,
            b.judul as judul_buku
            FROM pengembalian pg
            JOIN peminjaman p ON pg.id_peminjaman = p.id
            JOIN anggota a ON p.id_anggota = a.id
            JOIN buku b ON p.id_buku = b.id
            ORDER BY pg.id DESC";
            
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


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($data['id_peminjaman']) || !isset($data['tanggal_pengembalian'])) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Data tidak lengkap'
        ]);
        exit;
    }
    
    $id_peminjaman = $conn->real_escape_string($data['id_peminjaman']);
    $tanggal_pengembalian = $conn->real_escape_string($data['tanggal_pengembalian']);
    
    
    $sql_peminjaman = "SELECT tanggal_kembali FROM peminjaman WHERE id = '$id_peminjaman'";
    $result_peminjaman = $conn->query($sql_peminjaman);
    $peminjaman = $result_peminjaman->fetch_assoc();
    
    $tanggal_seharusnya = new DateTime($peminjaman['tanggal_kembali']);
    $tanggal_aktual = new DateTime($tanggal_pengembalian);
    $selisih = $tanggal_seharusnya->diff($tanggal_aktual);
    
    $denda = 0;
    if ($tanggal_aktual > $tanggal_seharusnya) {
        $denda = $selisih->days * 1000;
    }
    
    $sql = "INSERT INTO pengembalian (id_peminjaman, tanggal_pengembalian, denda) 
            VALUES ('$id_peminjaman', '$tanggal_pengembalian', '$denda')";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode([
            'status' => 'success',
            'message' => 'Pengembalian berhasil ditambahkan',
            'denda' => $denda
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