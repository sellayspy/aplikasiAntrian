<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AntrianPanggil extends Model
{
    protected $table = 'antrian_panggil';
    protected $fillable = [
        'antrian_kategori_id',
        'setting_layar_id',
        'jumlah_antrian',
        'jumlah_antrian_terpanggil',
        'tanggal',
        'waktu_ambil',
        'waktu_selesai'
    ];

    public function antrianKategori()
    {
    return $this->belongsTo(AntrianKategori::class, 'antrian_kategori_id');
    }

    public function settingLayar()
    {
    return $this->belongsTo(SettingLayar::class, 'setting_layar_id');
    }

    public function antrianPanggilDetails()
    {
    return $this->hasMany(AntrianPanggilDetail::class, 'antrian_panggil_id');
    }
}

