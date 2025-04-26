<?php

namespace App\Http\Controllers\Antrian;

use App\Events\AntrianDiambil;
use App\Events\AntrianSisaAmbil;
use App\Events\AntrianSisaPanggil;
use App\Http\Controllers\Controller;
use App\Models\AntrianPanggil;
use App\Models\AntrianPanggilDetail;
use App\Models\SettingLayar;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class AmbilAntrianController extends Controller
{
    public function daftarLayanan()
    {
        try {
            $layarList = SettingLayar::with(['layarSettingDetails' => function ($query) {
                         $query->orderBy('urut', 'asc');
            },
            'layarSettingDetails.antrianKategori'])
            ->get();

            $result = $layarList->map(function ($item) {
                return [
                    'nama_layar' => $item->nama_layar,
                    'kategori' => $item->layarSettingDetails->map(function ($detail) {
                        return [
                            'nama_kategori' => $detail->antrianKategori->nama_kategori,
                            'urut' => $detail->urut,
                        ];
                    })->all()
                ];
            });

            return response()->json([
                'status' => 'success',
                'data' => $result
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Terjadi kesalahan saat mengambil data layar.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

  public function daftarLayananDetail(Request $request)
{
    try {
        $namaLayar = $request->query('layar');

        if (empty($namaLayar)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Parameter harus di isi'
            ], 400);
        }

        $layarAmbil = SettingLayar::where('nama_layar', $namaLayar)
            ->with(['layarSettingDetails.antrianKategori', 'layarSettingDetails.antrianKategori.antrianDetails.antrianTujuan'])
            ->first();

        if (!$layarAmbil) {
            return response()->json([
                'status' => 'error',
                'message' => 'Data layar tidak ditemukan.'
            ], 404);
        }

        $kategoriData = [];

         foreach ($layarAmbil->layarSettingDetails as $layarSettingDetail) {
            $antrianKategori = $layarSettingDetail->antrianKategori;

            $sisaAntrian = 0;
            foreach ($antrianKategori->antrianDetails as $antrianDetail) {
                $sisaAntrian += AntrianPanggilDetail::where('antrian_detail_id', $antrianDetail->id)
                    ->where('status', 'Menunggu')
                    ->count();
            }

            $kategoriData[] = [
                'nama_kategori' => $antrianKategori->nama_kategori,
                'tujuan_antrian' => $antrianKategori->antrianDetails->first()->antrianTujuan->nama_antrian ?? 'Tidak ada tujuan',
                'sisa_antrian' => $sisaAntrian,
                'urut' => $layarSettingDetail->urut
            ];
        }

        return response()->json([
            'status' => 'success',
            'data' => [
                'nama_layar' => $layarAmbil->nama_layar,
                'kategori' => $kategoriData
            ]
        ]);

    } catch (\Exception $e) {
        return response()->json([
            'status' => 'error',
            'message' => 'Terjadi kesalahan saat mengambil data layar.',
            'error' => $e->getMessage()
        ], 500);
    }
}


    public function ambilAntrian(Request $request)
{
    DB::beginTransaction();
    try {
        $namaLayar = $request->input('layar');
        $namaKategori = $request->input('kategori');

        // Validasi input
        if (empty($namaLayar) || empty($namaKategori)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Parameter layar dan kategori harus diisi'
            ], 400);
        }

        // Cari data layar
        $layar = SettingLayar::where('nama_layar', $namaLayar)->first();
        
        if (!$layar) {
            return response()->json([
                'status' => 'error',
                'message' => 'Data layar tidak ditemukan.'
            ], 404);
        }

        // Cari kategori yang sesuai dalam pengaturan layar
        $layarSettingDetail = $layar->layarSettingDetails()
            ->whereHas('antrianKategori', function ($query) use ($namaKategori) {
                $query->where('nama_kategori', $namaKategori);
            })
            ->first();

        if (!$layarSettingDetail) {
            return response()->json([
                'status' => 'error',
                'message' => 'Kategori tidak ditemukan di layar ini.'
            ], 404);
        }

        $antrianKategori = $layarSettingDetail->antrianKategori;
        
        // Cek antrian hari ini berdasarkan kategori dan layar
        $tanggalSekarang = now()->toDateString();
        $antrianPanggil = AntrianPanggil::where('antrian_kategori_id', $antrianKategori->id)
            ->where('setting_layar_id', $layar->id)
            ->where('tanggal', $tanggalSekarang)
            ->first();

        if (!$antrianPanggil) {
            $antrianPanggil = AntrianPanggil::create([
                'antrian_kategori_id' => $antrianKategori->id,
                'setting_layar_id' => $layar->id,
                'jumlah_antrian' => 0,
                'jumlah_antrian_terpanggil' => 0,
                'tanggal' => $tanggalSekarang,
                'waktu_ambil' => now(),
            ]);
        }

        $latestDetail = AntrianPanggilDetail::where('antrian_panggil_id', $antrianPanggil->id)
            ->orderBy('nomor_panggil', 'desc')
            ->first();

        $nomorPanggil = $latestDetail ? $latestDetail->nomor_panggil + 1 : 1;
        
        $awalanPanggil = $antrianKategori->awalan;

        $antrianDetail = $antrianKategori->antrianDetails()->first();
        
        $antrianPanggilDetail = AntrianPanggilDetail::create([
            'antrian_panggil_id' => $antrianPanggil->id,
            'antrian_detail_id' => $antrianDetail->id,
            'awalan_panggil' => $awalanPanggil,
            'nomor_panggil' => $nomorPanggil,
            'status' => 'Menunggu',
            'waktu_panggil' => now(),
        ]);

        $antrianPanggil->increment('jumlah_antrian');
        $antrianPanggil->save();

        $layarAmbil = SettingLayar::where('nama_layar', $namaLayar)
            ->with(['layarSettingDetails.antrianKategori', 'layarSettingDetails.antrianKategori.antrianDetails.antrianTujuan'])
            ->first();

        $kategoriData = [];
        foreach ($layarAmbil->layarSettingDetails as $layarSettingDetail) {
            $antrianKategori = $layarSettingDetail->antrianKategori;
            $sisaAntrianKategori = 0;
                foreach ($antrianKategori->antrianDetails as $antrianDetail) {
                    $count = AntrianPanggilDetail::where('antrian_detail_id', $antrianDetail->id)
                        ->where('status', 'Menunggu')
                        ->count();
                    $sisaAntrianKategori += $count;
        
                }
                if ($antrianKategori->nama_kategori === $namaKategori) {
                    $sisaAntrian = $sisaAntrianKategori;
                }
            $kategoriData[] = [
                'nama_kategori' => $antrianKategori->nama_kategori,
                'tujuan_antrian' => $antrianKategori->antrianDetails->first()->antrianTujuan->nama_antrian ?? 'Tidak ada tujuan',
                'sisa_antrian' => $sisaAntrian,
                'urut' => $layarSettingDetail->urut
            ];
        }

        broadcast(new AntrianSisaAmbil($namaLayar, $kategoriData));

        broadcast(new AntrianDiambil(
            $namaLayar,
            $namaKategori,
            $sisaAntrian,
            $antrianPanggil->jumlah_antrian,
            $awalanPanggil,
            $nomorPanggil
        ));

        DB::commit();

        return response()->json([
            'status' => 'success',
            'message' => 'Antrian berhasil diambil',
            'data' => [
                'awalan_panggil' => $awalanPanggil,
                'nomor_panggil' => $nomorPanggil,
            ]
        ], 201);

    } catch (\Exception $e) {
        DB::rollBack();
        return response()->json([
            'status' => 'error',
            'message' => 'Terjadi kesalahan saat mengambil antrian.',
            'error' => $e->getMessage()
        ], 500);
    }
}
}
