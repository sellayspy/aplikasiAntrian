<?php

namespace App\Http\Controllers\Antrian;

use App\Http\Controllers\Controller;
use App\Models\AntrianTujuan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class AntrianTujuanController extends Controller
{
     public function index()
    {
        try {
            $tujuan = AntrianTujuan::all();
            return response()->json([
                'success' => true,
                'data' => $tujuan
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching antrian tujuan: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data tujuan antrian.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
            'nama_antrian' => 'required|string|max:255',
            'nama_file' => 'required|array',
            'nama_file.*' => 'required|file|mimes:wav,mp3', 
        ]);

        $fileNames = [];

        // Simpan file yang diunggah
        if ($request->hasFile('nama_file')) {
            foreach ($request->file('nama_file') as $file) {
                $fileName = time() . '_' . $file->getClientOriginalName();
                $file->storeAs('antrian_tujuan', $fileName, 'public');
                $fileNames[] = $fileName;
            }
        }

        // Simpan data ke database
         $tujuan = AntrianTujuan::create([
            'nama_antrian' => $request->nama_antrian,
            'nama_file' => $fileNames,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Tujuan antrian berhasil ditambahkan.',
            'data' => $tujuan,
        ], 200);
    } catch (\Exception $e) {
        Log::error('Error creating antrian tujuan: ' . $e->getMessage());
        return response()->json([
            'success' => false,
            'message' => 'Gagal menambahkan tujuan antrian.',
            'error' => $e->getMessage()
        ], 500); 
        }
    }

   public function show(AntrianTujuan $antrianTujuan)
    {
    try {
        return response()->json([
            'success' => true,
            'data' => [
                'nama_antrian' => $antrianTujuan->nama_antrian,
                'nama_file' => json_decode($antrianTujuan->nama_file, true), 
            ]
        ]);
    } catch (\Exception $e) {
        Log::error('Error fetching antrian tujuan detail: ' . $e->getMessage());
        return response()->json([
            'success' => false,
            'message' => 'Gagal mengambil detail tujuan antrian.',
            'error' => $e->getMessage()
        ], 500);
    }
    }


     public function update(Request $request, AntrianTujuan $antrianTujuan)
    {
    try {
        $request->validate([
            'nama_antrian' => 'nullable|string|max:255',
            'nama_file' => 'nullable|array',
            'nama_file.*' => 'nullable|file|mimes:wav,mp3',
        ]);

        $fileNames = $antrianTujuan->nama_file ?? []; 

        // Jika ada file baru, simpan dan tambahkan ke array
        if ($request->hasFile('nama_file')) {
            foreach ($request->file('nama_file') as $file) {
                $fileName = time() . '_' . $file->getClientOriginalName();
                $file->storeAs('antrian_tujuan', $fileName, 'public');
                $fileNames[] = $fileName;
            }
        }

        $antrianTujuan->update([
            'nama_antrian' => $request->nama_antrian ?? $antrianTujuan->nama_antrian,
            'nama_file' => $fileNames,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Tujuan antrian berhasil diperbarui.',
            'data' => $antrianTujuan
        ]);
    } catch (\Exception $e) {
        Log::error('Error updating antrian tujuan: ' . $e->getMessage());
        return response()->json([
            'success' => false,
            'message' => 'Gagal memperbarui tujuan antrian.',
            'error' => $e->getMessage()
        ], 500);
    }
}



     public function destroy(AntrianTujuan $antrianTujuan)
    {
        try {
            $antrianTujuan->delete();

            return response()->json([
                'success' => true,
                'message' => 'Tujuan antrian berhasil dihapus.'
            ]);
        } catch (\Exception $e) {
            Log::error('Error deleting antrian tujuan: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Gagal menghapus tujuan antrian.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
