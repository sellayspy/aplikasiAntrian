<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AntrianKategori extends Model
{
    protected $table = 'antrian_kategori';
    protected $fillable = [
        'nama_kategori',
        'awalan',
        'aktif'
    ];

   public function settingLayarDetails()
    {
        return $this->hasMany(SettingLayarDetail::class, 'antrian_kategori_id');
    }

    public function antrianDetails()
    {
        return $this->hasMany(AntrianDetail::class, 'antrian_kategori_id');
    }

}

