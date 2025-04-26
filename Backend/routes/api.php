<?php

use App\Http\Controllers\Antrian\AmbilAntrianController;
use App\Http\Controllers\Antrian\AntrianKategoriController;
use App\Http\Controllers\Antrian\AntrianPanggilController;
use App\Http\Controllers\Antrian\AntrianTampilLayarController;
use App\Http\Controllers\Antrian\AntrianTujuanController;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\UserController;
use App\Http\Controllers\Identitas\IdentitasPerusahaanController;
use App\Http\Controllers\RolePermission\RolePermissionController;
use App\Http\Controllers\Setting\SettingLayarController;
use App\Http\Controllers\Setting\SettingPrinterController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// AuthUserController
// Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/update-password', [AuthController::class, 'updatePassword']);
    Route::get('/users', [UserController::class, 'getUser']);
    Route::put('/users/{user}', [UserController::class, 'updateUser']);
    Route::delete('/users/{user}', [UserController::class, 'deleteUser']);
// });
// AuthUserController

// RolePermission
// Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/roles', [RolePermissionController::class, 'indexRoles']);
    Route::get('/permissions', [RolePermissionController::class, 'indexPermissions']);
    Route::post('/roles', [RolePermissionController::class, 'storeRole']);
    Route::post('/permissions', [RolePermissionController::class, 'storePermission']);
    Route::post('/roles/assign-permission', [RolePermissionController::class, 'assignPermissionToRole']);
    Route::delete('/roles/{id}', [RolePermissionController::class, 'deleteRole']);
    Route::delete('/permissions/{id}', [RolePermissionController::class, 'deletePermission']);
// });
// RolePermission

// Manajemen Identitas
Route::apiResource('identitas', IdentitasPerusahaanController::class);
// Manajemen Identitas

// Manajemen Antrian Kategori
Route::apiResource('antrian_kategori', AntrianKategoriController::class);
// Manajemen Antrian Kategori

// Manajemen Antrian Tujuan
Route::apiResource('antrian_tujuan', AntrianTujuanController::class);
// Manajemen Antrian Tujuan

// Manajemen Antrian Panggil
Route::get('/antrian-tujuan/{kategoriId}', [AntrianKategoriController::class, 'getTujuanByKategori']);
Route::post('/add-tujuan', [AntrianKategoriController::class, 'addTujuanToKategori']);
Route::post('/ambil-antrian/{antrianKategoriId}/{antrianTujuanId}', [AntrianPanggilController::class, 'ambilAntrian']);
Route::get('/antrian-panggil', [AntrianPanggilController::class, 'getAntrianPanggil']);
Route::get('/antrian-panggil-detail', [AntrianPanggilController::class, 'getAntrianPanggilDetail']);
Route::post('/panggil-next-antrian', [AntrianPanggilController::class, 'panggilAntrian']);
Route::post('/panggil-ulang-antrian/{nomorPanggil}', [AntrianPanggilController::class, 'pangilUlangAntrian']);
// Manajemen Antrian Panggil

// Panggil Antrian
Route::get('/daftar-tampil-layar', [AntrianTampilLayarController::class, 'daftarTampilLayar']);
Route::get('/layar-antrian', [AntrianTampilLayarController::class, 'tampilkanLayarAntrian']);
// Panggil Antrian

// Ambil Antrian
Route::get('/daftar-layanan', [AmbilAntrianController::class, 'daftarLayanan']);
Route::get('daftar-layanan-detail', [AmbilAntrianController::class, 'daftarLayananDetail']);
Route::post('/ambil-antrian', [AmbilAntrianController::class, 'ambilAntrian']);
// Ambil Antrian

// Manajemen Setting Layar
Route::apiResource('setting-printer', SettingPrinterController::class);
Route::apiResource('setting-layar', SettingLayarController::class);
Route::get('/layar-kategori/{settingLayarId}', [SettingLayarController::class, 'getSettingLayar']);
Route::post('/add-kategori-layar', [SettingLayarController::class, 'addKategoriToLayar']);
// Manajemen Setting Layar
