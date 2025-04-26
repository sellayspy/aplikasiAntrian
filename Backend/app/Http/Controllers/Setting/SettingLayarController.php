<?php

namespace App\Http\Controllers\Setting;

use App\Http\Controllers\Controller;
use App\Models\SettingLayar;
use App\Models\SettingLayarDetail;
use Illuminate\Http\Request;

class SettingLayarController extends Controller
{
     public function index()
    {
        try {
            $layars = SettingLayar::all();

            return response()->json([
                'status' => 'success',
                'message' => 'Setting Layars retrieved successfully',
                'data' => $layars
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to retrieve Setting Layars',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'nama_layar' => 'required|string|max:255',
                'setting_printer_id' => 'required|exists:setting_printer,id',
            ]);

            $layar = SettingLayar::create($validated);

            return response()->json([
                'status' => 'success',
                'message' => 'Setting Layar created successfully',
                'data' => $layar
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to create Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
         try {
            $validated = $request->validate([
                'nama_layar' => 'nullable|string|max:255',
                'setting_printer_id' => 'nullable|exists:setting_printer,id',
            ]);

            $layar = SettingLayar::findOrFail($id);
            $layar->update($validated);

            return response()->json([
                'status' => 'success',
                'message' => 'Setting Layar updated successfully',
                'data' => $layar
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to update Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $layar = SettingLayar::findOrFail($id);
            $layar->delete();

            return response()->json([
                'status' => 'success',
                'message' => 'Setting Layar deleted successfully'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function getSettingLayar($settingLayarId)
    {
        try {
            $settingLayar = SettingLayarDetail::where('setting_layar_id', $settingLayarId)
                            ->with('antrianKategori','settingLayar')
                            ->get();
                
        if ($settingLayar->isEmpty()) {
            return response()->json(['message' => 'Kategori found for this layar'],500);
        }

        return response()->json([
            'success'   => true,
            'data'      => $settingLayar
        ]);
        }catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal menambahkan antrian di kategori',
                'error' => $e->getMessage()
            ], 500); 
        }
    }

    public function addKategoriToLayar(Request $request)
    {
        try {
            $validated = $request->validate([
                'setting_layar_id'      => 'required|integer',
                'antrian_kategori_id'   => 'required|integer',
                'urut'                  => 'nullable'
            ]);

            $layarDetail = SettingLayarDetail::create($validated);
            return response()->json(['message' => 'Kategori Berhasil di tambahkan', 'data' => $layarDetail],200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'An error occurred while adding data', 'error' => $e->getMessage()],500);
        }
    }
}
