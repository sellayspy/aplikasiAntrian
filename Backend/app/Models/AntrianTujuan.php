<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AntrianTujuan extends Model
{
    protected $table = 'antrian_tujuan';
    protected $fillable = [
        'nama_antrian',
        'nama_file'
    ];
    protected $casts = [
        'nama_file' => 'array',
    ];

    public function antrianDetails()
    {
        return $this->hasMany(AntrianDetail::class, 'antrian_tujuan_id');
    }
}

