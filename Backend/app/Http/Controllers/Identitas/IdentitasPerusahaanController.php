<?php

namespace App\Http\Controllers\Identitas;

use App\Http\Controllers\Controller;
use App\Http\Requests\Identitas\IdentitasRequest;
use App\Http\Resources\Identitas\IdentitasResource;
use App\Models\IdentitasPerusahaan;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;


class IdentitasPerusahaanController extends Controller
{
    public function index()
    {
        try {
            $perusahaan = IdentitasPerusahaan::all();
            return response()->json(['data' => IdentitasResource::collection($perusahaan)],200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'internal server error'],500);
        }
    }

    public function store(IdentitasRequest $request)
    {
        try {
            $validasiIdentitas = $request->validated();

            if ($request->hasFile('logo')) {

                $logoPath = $request->file('logo')->storeAs('logos', $request->file('logo')->hashName(), 'public');
                $validasiIdentitas['logo'] = $logoPath;
            }
            $identitas = IdentitasPerusahaan::create($validasiIdentitas);
            return response()->json(['data'    => new IdentitasResource($identitas)], 200);
        } catch (\Exception $e){
            return response()->json(['error'  => 'unable create'], 500);
        }
    }

    public function update(IdentitasRequest $request, $id)
    {
    try {
        $identitas = IdentitasPerusahaan::findOrFail($id);

        $validasiIdentitas = $request->validated();

        if ($request->hasFile('logo')) {
           if ($request->hasFile('logo')){
            Storage::disk('public')->delete($identitas->logo);
           }

           $logoPath = $request->file('logo')->storeAs('logos', $request->file('logo')->hashName(), 'public');
           $validasiIdentitas['logo'] = $logoPath;
        }

        $identitas->update($validasiIdentitas);
        return response()->json(['data' => new IdentitasResource($identitas)], 200);
    } catch (\Exception $e) {
        Log::error('Error updating data:', ['error' => $e->getMessage()]);
        return response()->json(['error' => 'Gagal Update', 'message' => $e->getMessage()], 500);
    }
    }

    public function destroy($id)
    {
        try {
            $identitas = IdentitasPerusahaan::findOrFail($id);
            if ($identitas->logo) {
                Storage::disk('public')->delete($identitas->logo);
            }
            $identitas->delete();
            return response()->json(['message'  => 'Perusahaan Berhasil DiHapus'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'unable to delete'], 500);
        }
    }
}
