<?php
require 'config.php';


header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");

$method = $_SERVER['REQUEST_METHOD'];
$Path_Info = isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : (isset($_SERVER['ORIG_PATH_INFO']) ? $_SERVER['ORIG_PATH_INFO'] : '');
$request = explode('/', trim($Path_Info, '/'));
$id = isset($request[1]) ? (int)$request[1] : null;

switch ($method) {
    case 'GET':
        if ($id) {
            
            $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
            $stmt->execute([$id]);
            $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($peminjaman) {
                echo json_encode($peminjaman);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Peminjaman not found"]);
            }
        } else {
           
            $stmt = $pdo->query("SELECT * FROM peminjaman");
            $peminjamanList = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($peminjamanList);
        }
        break;
        
    case 'POST':
        
        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!empty($data['kode_anggota']) && !empty($data['tgl_pinjam']) && !empty($data['tgl_kembali']) && !empty($data['kode_buku'])) {
            $stmt = $pdo->prepare("INSERT INTO peminjaman (kode_anggota, tgl_pinjam, tgl_kembali, kode_buku) VALUES (?, ?, ?, ?)");
            $stmt->execute([$data['kode_anggota'], $data['tgl_pinjam'], $data['tgl_kembali'], $data['kode_buku']]);
            echo json_encode(["message" => "Peminjaman created", "id" => $pdo->lastInsertId()]);
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Invalid data"]);
        }
        break;
        
    case 'PUT':
        
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);
            
            $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
            $stmt->execute([$id]);
            $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($peminjaman) {
                $kode_anggota = $data['kode_anggota'] ?? $peminjaman['kode_anggota'];
                $tgl_pinjam = $data['tgl_pinjam'] ?? $peminjaman['tgl_pinjam'];
                $tgl_kembali = $data['tgl_kembali'] ?? $peminjaman['tgl_kembali'];
                $kode_buku = $data['kode_buku'] ?? $peminjaman['kode_buku'];
                
                $stmt = $pdo->prepare("UPDATE peminjaman SET kode_anggota = ?, tgl_pinjam = ?, tgl_kembali = ?, kode_buku = ? WHERE id = ?");
                $stmt->execute([$kode_anggota, $tgl_pinjam, $tgl_kembali, $kode_buku, $id]);
                echo json_encode(["message" => "Peminjaman updated"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Peminjaman not found"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;
        
    case 'DELETE':
      
        if ($id) {
            $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
            $stmt->execute([$id]);
            $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($peminjaman) {
                $stmt = $pdo->prepare("DELETE FROM peminjaman WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(["message" => "Peminjaman deleted"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Peminjaman not found"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;
        
    default:
        http_response_code(405);
        echo json_encode(["message" => "Method not allowed"]);
        break;
}
?>
