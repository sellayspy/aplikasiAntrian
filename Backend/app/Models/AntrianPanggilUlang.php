<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AntrianPanggilUlang extends Model
{
    protected $table    = 'antrian_panggil_ulang';
    protected $fillable = [
        'setting_layar_id',
        'antrian_panggil_detail_id',
        'tangal_panggil_ulang',
        'waktu_panggil_ulang'
    ];
}
