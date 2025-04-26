<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class IdentitasPerusahaan extends Model
{
    protected $table = 'identitas_perusahaan';
    protected $fillable = [
        'nama_perusahaan',
        'alamat',
        'telepon',
        'email',
        'website',
        'logo',
        'deleted_at'
    ];
}
