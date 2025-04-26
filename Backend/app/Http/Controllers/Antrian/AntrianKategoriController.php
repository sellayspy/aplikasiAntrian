<?php

namespace App\Http\Controllers\Antrian;

use App\Http\Controllers\Controller;
use App\Models\AntrianDetail;
use App\Models\AntrianKategori;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class AntrianKategoriController extends Controller
{
     public function index()
    {
        try {
            $kategori = AntrianKategori::all();
            return response()->json([
                'success' => true,
                'data' => $kategori
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching antrian kategori: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data kategori antrian.',
                'error' => $e->getMessage()
            ], 500); 
        }
    }

     public function store(Request $request)
    {
        try {
            $data = $request->all();
        if (!isset($data[0])) {
            $data = [$data]; 
        }

        // Validasi
        $validatedData = Validator::make($data, [
            '*.nama_kategori' => 'required|string',
            '*.awalan' => 'required|string',
            '*.aktif' => 'required|string|in:Y,N'
        ]);

        if ($validatedData->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal.',
                'errors' => $validatedData->errors()
            ], 400);
        }

        // Simpan ke database
        AntrianKategori::insert($validatedData->validated());

            return response()->json([
                'success' => true,
                'message' => 'Kategori antrian berhasil ditambahkan.',
                'data' => $data
            ], 200); 
        } catch (\Exception $e) {
            Log::error('Error creating antrian kategori: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Gagal menambahkan kategori antrian.',
                'error' => $e->getMessage()
            ], 500); 
        }
    }

     public function show(AntrianKategori $antrianKategori)
    {
        try {
            return response()->json([
                'success' => true,
                'data' => $antrianKategori
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching antrian kategori detail: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil detail kategori antrian.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request, AntrianKategori $antrianKategori)
    {
        try {
            $request->validate([
                'nama_kategori' => 'sometimes|required|string|max:255',
                'awalan' => 'sometimes|required|string|max:1',
                'aktif' => 'sometimes|required|string|max:1',
            ]);

            $antrianKategori->update($request->all());

            return response()->json([
                'success' => true,
                'message' => 'Kategori antrian berhasil diperbarui.',
                'data' => $antrianKategori
            ]);
        } catch (\Exception $e) {
            Log::error('Error updating antrian kategori: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Gagal memperbarui kategori antrian.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function destroy(AntrianKategori $antrianKategori)
    {
        try {
            $antrianKategori->delete();

            return response()->json([
                'success' => true,
                'message' => 'Kategori antrian berhasil dihapus.'
            ]);
        } catch (\Exception $e) {
            Log::error('Error deleting antrian kategori: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Gagal menghapus kategori antrian.',
                'error' => $e->getMessage()
            ], 500); 
        }
    }

     public function getTujuanByKategori($kategoriId)
    {
        try {
            $antrianTujuan = AntrianDetail::where('antrian_kategori_id', $kategoriId)
                            ->with('antrianTujuan','antrianKategori') 
                            ->get();

            if ($antrianTujuan->isEmpty()) {
                return response()->json(['message' => 'No tujuan found for this kategori'],500);
            }

            return response()->json([
                'success'  => true,
                'data'     => $antrianTujuan
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal menambahkan antrian di kategori',
                'error' => $e->getMessage()
            ], 500); 
        }
    }

    public function addTujuanToKategori(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'antrian_kategori_id' => 'required|integer',
                'antrian_tujuan_id' => 'required|integer',
                'aktif' => 'required|string'
            ]);

            $antrianDetail = AntrianDetail::create($validatedData);
            return response()->json(['message' => 'Antrian tujuan added successfully', 'data' => $antrianDetail],200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'An error occurred while adding data', 'error' => $e->getMessage()],500);
        }
    }

}
