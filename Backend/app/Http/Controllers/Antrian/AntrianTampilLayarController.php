<?php

namespace App\Http\Controllers\Antrian;

use App\Http\Controllers\Controller;
use App\Models\AntrianPanggilDetail;
use App\Models\SettingLayar;
use Carbon\Carbon;
use Illuminate\Http\Request;

class AntrianTampilLayarController extends Controller
{
    public function daftarTampilLayar()
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

    public function tampilkanLayarAntrian(Request $request)
    {
        try {
            $namaLayar      = $request->query('layar');

            if (!$namaLayar) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Nama layar dan kategori harus diisi.'
                ], 400);
            }

            $settingLayar = SettingLayar::where('nama_layar', $namaLayar)
                ->with(['layarSettingDetails.antrianKategori', 'layarSettingDetails.antrianKategori.antrianDetails.antrianTujuan'])
                ->first();
                            
            if (!$settingLayar) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Data layar tidak ditemukan.'
                ], 404);
            }

            $antrianSedangDilayani = AntrianPanggilDetail::with([
                'antrianDetail.antrianKategori',
                'antrianDetail.antrianTujuan',
            ])
            ->whereHas('antrianDetail.settingLayarDetail', function ($query) use($settingLayar) {
                $query->where('setting_layar_id', $settingLayar->id);
            })

            ->where('status', 'Sedang Dilayani')
            ->orderBy('waktu_panggil', 'desc')
            ->first();

            $kategoriList = $settingLayar->layarSettingDetails->map(function ($detail) {
                return [
                    'nama_kategori' => $detail->antrianKategori->nama_kategori,
                    'nama_tujuan' => $detail->antrianKategori->antrianDetails->first()->antrianTujuan->nama_antrian ?? 'Tidak Ditentukan',
                    'antrian_kategori_id' => $detail->antrian_kategori_id,
                ];
            })->unique('nama_kategori')->values();

           $antrianMenunggu = [];
            foreach ($kategoriList as $kategori) {
                $antrian = AntrianPanggilDetail::with([
                    'antrianDetail.antrianKategori',
                    'antrianDetail.antrianTujuan',
                ])
                ->whereHas('antrianDetail.settingLayarDetail', function ($query) use ($settingLayar) {
                    $query->where('setting_layar_id', $settingLayar->id);
                })
                ->whereHas('antrianDetail.antrianKategori', function ($query) use ($kategori) {
                    $query->where('antrian_kategori_id', $kategori['antrian_kategori_id']);
                })
                ->where('status', 'Menunggu')
                ->orderBy('waktu_panggil', 'asc')
                ->first();

                $antrianMenunggu[] = [
                    'nama_kategori' => $kategori['nama_kategori'],
                    'nama_tujuan' => $kategori['nama_tujuan'],
                    'awalan_panggil' => $antrian ? $antrian->awalan_panggil : null,
                    'nomor_panggil' => $antrian ? $antrian->nomor_panggil : null,
                    'status' => $antrian ? $antrian->status : 'Menunggu',
                    'waktu_panggil' => $antrian && $antrian->waktu_panggil ? Carbon::parse($antrian->waktu_panggil)->format('H:i:s') : null,
                ];
            }
            
            $formatData = function ($item) {
                return [
                    'nama_kategori' => $item->antrianDetail->antrianKategori->nama_kategori,
                    'nama_tujuan' => $item->antrianDetail->antrianTujuan->nama_antrian,
                    'awalan_panggil' => $item->awalan_panggil,
                    'nomor_panggil' => $item->nomor_panggil,
                    'status' => $item->status,
                    'waktu_panggil' => $item->waktu_panggil ? Carbon::parse($item->waktu_panggil)->format('H:i:s') : null,
                ];
            };

            $data = [
                'sedang_dilayani' => $antrianSedangDilayani ? $formatData($antrianSedangDilayani) : null,
                'menunggu_berikutnya' => $antrianMenunggu,
            ];

            return response()->json([
                'status' => 'success',
                'data' => $data
            ], 200);

        } catch (\Exception $e) {
             return response()->json([
            'status' => 'error',
            'message' => 'Terjadi kesalahan saat mengambil data antrian.',
            'error' => $e->getMessage()
        ], 500);
        }
    }
}
