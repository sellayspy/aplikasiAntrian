<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AntrianDetail extends Model
{
    protected $table = 'antrian_detail';
    protected $fillable = [
        'antrian_kategori_id',
        'antrian_tujuan_id',
        'aktif'
    ];

    public function antrianTujuan()
    {
    return $this->belongsTo(AntrianTujuan::class, 'antrian_tujuan_id');
    }

    public function antrianKategori()
    {
    return $this->belongsTo(AntrianKategori::class, 'antrian_kategori_id');
    }

    public function settingLayarDetail()
    {
        return $this->belongsTo(SettingLayarDetail::class, 'antrian_kategori_id', 'antrian_kategori_id');
    }

    public function antrianPanggilDetail()
    {
        return $this->hasOne(AntrianPanggilDetail::class, 'antrian_detail_id', 'id'); 
    }

}

