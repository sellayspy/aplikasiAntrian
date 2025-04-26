<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AntrianPanggilDetail extends Model
{
    protected $table = 'antrian_panggil_detail';
    protected $fillable = [
        'antrian_panggil_id',
        'antrian_detail_id',
        'awalan_panggil',
        'nomor_panggil',
        'status',
        'waktu_panggil',
        'waktu_selesai'
    ];

    public function antrianPanggil()
    {
      return $this->belongsTo(AntrianPanggil::class, 'antrian_panggil_id');
    }

    public function settingLayarDetail()
    {
      return $this->hasOne(SettingLayarDetail::class, 'antrian_kategori_id','antrian_detail_id');
    }

    public function antrianDetail()
    {
        return $this->belongsTo(AntrianDetail::class, 'antrian_detail_id');
    }
}
