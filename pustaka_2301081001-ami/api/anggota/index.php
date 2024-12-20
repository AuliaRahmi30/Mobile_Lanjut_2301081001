<?php
require_once '../config/database.php';


if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT * FROM anggota";
    $result = $conn->query($sql);
    
    $anggota = array();
    while ($row = $result->fetch_assoc()) {
        array_push($anggota, $row);
    }
    
    echo json_encode(['status' => 'success', 'data' => $anggota]);
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $nim = $data['nim'];
    $nama = $data['nama'];
    $alamat = $data['alamat'];
    $jenis_kelamin = $data['jenis_kelamin'];
    
    $sql = "INSERT INTO anggota (nim, nama, alamat, jenis_kelamin) 
            VALUES ('$nim', '$nama', '$alamat', '$jenis_kelamin')";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode(['status' => 'success', 'message' => 'Data anggota berhasil ditambahkan']);
    } else {
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
    }
}


if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $id = $data['id'];
    $nim = $data['nim'];
    $nama = $data['nama'];
    $alamat = $data['alamat'];
    $jenis_kelamin = $data['jenis_kelamin'];
    
    $sql = "UPDATE anggota 
            SET nim='$nim', nama='$nama', alamat='$alamat', jenis_kelamin='$jenis_kelamin' 
            WHERE id=$id";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode(['status' => 'success', 'message' => 'Data anggota berhasil diupdate']);
    } else {
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $id = $_GET['id'];
    
    $sql = "DELETE FROM anggota WHERE id=$id";
    
    if ($conn->query($sql) === TRUE) {
        echo json_encode(['status' => 'success', 'message' => 'Data anggota berhasil dihapus']);
    } else {
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
    }
}

$conn->close();
?> 