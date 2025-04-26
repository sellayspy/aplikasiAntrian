<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SettingLayarDetail extends Model
{
    protected $table = 'setting_layar_detail';
    protected $fillable = [
        'setting_layar_id',
        'antrian_kategori_id',
        'urut'
    ];

    public function settingLayar()
    {
        return $this->belongsTo(SettingLayar::class, 'setting_layar_id');
    }

    public function antrianKategori()
    {
        return $this->belongsTo(AntrianKategori::class, 'antrian_kategori_id');
    }
}

