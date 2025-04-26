<?php

namespace App\Http\Controllers\Antrian;

use App\Events\AntrianLayarUpdated;
use App\Events\AntrianUpdated;
use App\Http\Controllers\Controller;
use App\Models\AntrianDetail;
use App\Models\AntrianKategori;
use App\Models\AntrianPanggil;
use App\Models\AntrianPanggilDetail;
use App\Models\AntrianPanggilUlang;
use App\Models\SettingLayar;
use Carbon\Carbon;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class AntrianPanggilController extends Controller
{
    public function getAntrianPanggil(){
        try {
            $antrianPanggil = SettingLayar::with([
                'layarSettingDetails.antrianKategori.antrianDetails.antrianTujuan'
                ])->get();

            $result = $antrianPanggil->map(function ($layar) {
        
            $kategori = $layar->layarSettingDetails ? $layar->layarSettingDetails->map(function ($detail) {
             
                if ($detail->antrianKategori) {
                    return [
                        'nama_antrian_kategori' => $detail->antrianKategori->nama_kategori,
                        'tujuan' => $detail->antrianKategori->antrianDetails ? $detail->antrianKategori->antrianDetails->map(function ($antrianDetail) {
                           
                            return $antrianDetail->antrianTujuan ? $antrianDetail->antrianTujuan->nama_antrian : null;
                        })->filter()->unique()->values()->toArray() : [],
                    ];
                }
                return null; 
            })->filter()->toArray() : [];

            return [
                'nama_layar' => $layar->nama_layar,
                'kategori' => $kategori,
            ];
        });

        return response()->json([
            'status' => 'success',
            'data' => $result,
        ], 200);
        } catch (\Exception $e) {
              Log::error('Error saat mengambil antrian: ' . $e->getMessage());
                return response()->json([
                    'status' => 'error',
                    'message' => 'Terjadi kesalahan saat mengambil antrian.',
                    'error' => $e->getMessage(),
             ], 500);
        }
    }

    public function getAntrianPanggilDetail(Request $request)
    {
        try {
        $namaLayar = $request->query('layar');
        $namaKategori = $request->query('kategori');

        if (!$namaLayar || !$namaKategori) {
            return response()->json([
                'status' => 'error',
                'message' => 'Nama layar dan kategori harus diisi',
            ], 400);
        }

        $antrianPanggil = AntrianPanggil::with([
                         'antrianKategori', 
                         'antrianPanggilDetails' => function ($query) {
                             $query->orderBy('nomor_panggil', 'asc');
                         },
                          'antrianPanggilDetails.antrianDetail.antrianTujuan'])
                          ->whereHas('antrianKategori', function ($query) use ($namaKategori) {
                              $query->where('nama_kategori', $namaKategori);
                          })
                          ->whereHas('settingLayar', function ($query) use ($namaLayar) {
                              $query->where('nama_layar', $namaLayar);
                          })
                          ->first();

        if (!$antrianPanggil) {
            return response()->json([
                'status' => 'error',
                'message' => 'Data antrian tidak ditemukan',
            ], 400);
        }

        $antrianSekarang = $antrianPanggil->antrianPanggilDetails
                            ->where('status', 'Sedang Dilayani')
                            ->first();

        if (!$antrianSekarang) {
            $antrianSekarang = $antrianPanggil->antrianPanggilDetails
                            ->where('status', 'Menunggu')
                            ->sortBy('nomor_panggil')
                            ->first();

        if ($antrianSekarang) {
            $antrianSekarang->update([
                'status' => 'Sedang Dilayani',
                'waktu_panggil' => Carbon::now(),
            ]);
        }
    }

        $ambilUlang      = $antrianPanggil->antrianPanggilDetails
                            ->where('status', 'Selesai')
                            ->map(fn ($item) => $item->awalan_panggil . $item->nomor_panggil)
                            ->toArray();

        $menungguAntrian = $antrianPanggil->antrianPanggilDetails
                            ->where('status', 'Menunggu')
                            ->sortBy('nomor_panggil')
                            ->map(fn ($item) => $item->awalan_panggil . $item->nomor_panggil)
                            ->toArray();

        $sisaAntrian = count($menungguAntrian);
        $antrianKategori = $antrianPanggil->antrianKategori->nama_kategori;
        $namaAntrian = $antrianSekarang
            ? $antrianSekarang->antrianDetail->antrianTujuan->nama_antrian
            : null;
        $jumlahAntrian = $antrianPanggil->jumlah_antrian;
        $jumlahAntrianTerpanggil = $antrianPanggil->jumlah_antrian_terpanggil;



        return response()->json([
            'status' => 'success',
            'data' => [
                'antrian_detail' => $antrianSekarang,
                'antrian_sekarang' => $antrianSekarang ? $antrianSekarang->awalan_panggil . $antrianSekarang->nomor_panggil : null,
                'nama_antrian' => $namaAntrian,
                'selesai_antrian' => $ambilUlang,
                'menunggu_antrian' => $menungguAntrian,
                'sisa_antrian' => $sisaAntrian,
                'antrian_kategori' => $antrianKategori,
                'jumlah_antrian' => $jumlahAntrian,
                'jumlah_antrian_terpanggil' => $jumlahAntrianTerpanggil,
            ],
        ], 200);
    }catch (\Exception $e) {
              Log::error('Error saat mengambil antrian: ' . $e->getMessage());
                return response()->json([
                    'status' => 'error',
                    'message' => 'Terjadi kesalahan saat mengambil data panggil antrian.',
                    'error' => $e->getMessage(),
             ], 500);
        }
    }

    public function panggilAntrian(Request $request)
    {
        DB::beginTransaction();
        try {
            
            $namaLayar = $request->input('layar');
            $namaKategori = $request->input('kategori');

            $antrianPanggil = AntrianPanggil::with(['antrianPanggilDetails' => function ($query) {
                            $query->where('status', 'Menunggu')
                            ->orderBy('nomor_panggil', 'asc');
                            }])
                            ->whereHas('antrianKategori', function ($query) use ($namaKategori) {
                                $query->where('nama_kategori', $namaKategori);
                            })
                            ->whereHas('settingLayar', function ($query) use ($namaLayar) {
                                $query->where('nama_layar', $namaLayar);
                            })
                            ->first();

            if(!$antrianPanggil) {
                throw new \Exception('Data antrian panggil tidak ditemukan',400);
            }

            $antrianBerikutnya = $antrianPanggil->antrianPanggilDetails->first();

            if(!$antrianBerikutnya) {
                throw new \Exception('Tidak ada antrian yang bisa dipanggil',400);
            }

            $antrianSekarang = $antrianPanggil->antrianPanggilDetails()
                            ->where('status', 'Sedang Dilayani')
                            ->first();
            
            if($antrianSekarang) {
                $antrianSekarang->update([
                    'status' => 'Selesai',
                    'waktu_selesai' => Carbon::now(),
                ]);
            }

            $antrianBerikutnya = $antrianPanggil->antrianPanggilDetails()
                            ->where('status', 'Menunggu')
                            ->orderBy('nomor_panggil', 'asc')
                            ->first();

            if (!$antrianBerikutnya) {
                throw new \Exception('Tidak ada antrian yang bisa dipanggil',400);
            }

            $antrianBerikutnya->update([
                'status' => 'Sedang Dilayani',
                'waktu_panggil' => Carbon::now(),
            ]);            

            $antrianPanggil->increment('jumlah_antrian_terpanggil');

            $sisaAntrian = $antrianPanggil->antrianPanggilDetails()
                            ->where('status', 'Menunggu')
                            ->count();

            $settingLayar = SettingLayar::where('nama_layar', $namaLayar)
                            ->with(['layarSettingDetails.antrianKategori', 'layarSettingDetails.antrianKategori.antrianDetails.antrianTujuan'])
                            ->first();

            if (!$settingLayar) {
                throw new \Exception('Data layar tidak ditemukan',400);
            }

            $menungguAntrian = [];
            foreach ($settingLayar->LayarSettingDetails as $detail){
                $antrian = AntrianPanggilDetail::with([
                    'antrianDetail.antrianKategori',
                    'antrianDetail.antrianTujuan',
                ])
                ->whereHas('antrianDetail.settingLayarDetail', function ($query) use ($settingLayar) {
                    $query->where('setting_layar_id', $settingLayar->id);
                })
                ->whereHas('antrianDetail.antrianKategori', function ($query) use ($detail) {
                    $query->where('antrian_kategori_id', $detail->antrian_kategori_id);
                })
                ->where('status', 'Menunggu')
                ->orderBy('nomor_panggil', 'asc')
                ->first();

                if ($antrian) {
                    $menungguAntrian[] = [
                        'nama_kategori' => $detail->antrianKategori->nama_kategori,
                        'nama_tujuan' => $detail->antrianDetail->antrianTujuan->nama_antrian ?? 'Tidak Ditentukan',
                        'awalan_panggil' => $antrian->awalan_panggil,
                        'nomor_panggil' => $antrian->nomor_panggil,
                        'status' => $antrian->status,
                        'waktu_panggil' => $antrian->waktu_panggil ? Carbon::parse($antrian->waktu_panggil)->format('H:i:s') : null,
                    ];
                }
            }

            $sedangDilayani = [
                'nama_kategori'     => $antrianBerikutnya->antrianDetail->antrianKategori->nama_kategori,
                'nama_tujuan'       => $antrianBerikutnya->antrianDetail->antrianTujuan->nama_antrian ?? 'Tidak Ditentukan',
                'awalan_panggil'    => $antrianBerikutnya->awalan_panggil,
                'nomor_panggil'     => $antrianBerikutnya->nomor_panggil,
                'status'            => $antrianBerikutnya->status,
                'waktu_panggil'     => $antrianBerikutnya->waktu_panggil ? Carbon::parse($antrianBerikutnya->waktu_panggil)->format('H:i:s') : null,
            ];

            $selesaiAntrian = $antrianPanggil->antrianPanggilDetails()
                            ->where('status', 'Selesai')
                            ->get()
                            ->map(fn ($item) => $item->awalan_panggil . $item->nomor_panggil)
                            ->toArray();

            DB::commit();

            $antrianSekarangValue = $antrianBerikutnya->awalan_panggil . $antrianBerikutnya->nomor_panggil;

            broadcast(new AntrianUpdated(
                $antrianSekarangValue,
                $sisaAntrian,
                $menungguAntrian,
                $selesaiAntrian
            ));

            broadcast(new AntrianLayarUpdated(
                $sedangDilayani,
                $menungguAntrian
            ));

            return response()->json([
                'status'       => 'success',
                'message'      => 'antrian berhasil dipanggil',
                'data'         => [
                    'antrian_sekarang' => $antrianSekarangValue,
                    'sisa_antrian' => $sisaAntrian,
                ]
            ], 200);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'error',
                'message' => 'Terjadi kesalahan saat memanggil antrian.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function pangilUlangAntrian(Request $request, $nomorPanggil)
    {
        DB::beginTransaction();
        try {

            $namaLayar = $request->input('layar');
            $namaKategori = $request->input('kategori');

            $antrianPanggil = AntrianPanggil::with(['antrianPanggilDetails' => function ($query) use ($nomorPanggil) {
                $query->where('nomor_panggil', $nomorPanggil);
            }])
            ->whereHas('antrianKategori', function ($query) use ($namaKategori) {
                $query->where('nama_kategori', $namaKategori);
            })
            ->whereHas('settingLayar', function ($query) use ($namaLayar) {
                $query->where('nama_layar', $namaLayar);
            })
            ->firstOrFail();

            $antrianUlang = $antrianPanggil->antrianPanggilDetails->firstOrFail();

            if (!$antrianPanggil) {
                return response()->json([
                    'status'  => 'error',
                    'message' => 'Antrian tidak ditemukan'
                ], 400);
            }

            if (!$antrianUlang) {
                return response()->json([
                    'status'  => 'error',
                    'message' => 'Tidak ada antrian yang bisa dipanggil ulang'
                ], 400);
            }

            $antrianUlang->update([
                'status' => 'Sedang Dilayani',
                'waktu_panggil' => Carbon::now(),
            ]);

            AntrianPanggilUlang::create([
                'setting_layar_id'          => $antrianPanggil->setting_layar_id,
                'antrian_panggil_detail_id' => $antrianUlang->id,
                'tangal_panggil_ulang'     => Carbon::today(),
                'waktu_panggil_ulang'       => Carbon::now(),
            ]);

            DB::commit();

            return response()->json([
            'status'  => 'success',
            'message' => 'Antrian berhasil dipanggil ulang',
            'data'    => [
                'antrianSekarang' => $antrianUlang->nomor_panggil,
                 ],
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
        return response()->json([
            'status'  => 'error',
            'message' => 'Terjadi kesalahan saat memanggil ulang antrian.',
            'error'   => $e->getMessage()
        ], 500);
        }
    }

    private function KirimKeMicromatic($nomorAntrian, $awalanPanggil)
    {
        try {
            $client = new Client();
            $response = $client->post('https://api.micromatic.com/antrian/panggil', [
                'json' => [
                    'nomor_antrian'  => $nomorAntrian,
                    'awalan_panggil' => $awalanPanggil,
                    'waktu_panggil'  => Carbon::now()->toDateString(),
                ]
                ]);

            return json_decode($response->getBody()->getContents(), true);
        } catch (\Exception $e) {
            Log::error("Gagal mengirim antrian ke micromatic:" . $e->getMessage());
            return false;
        }
    }
}
