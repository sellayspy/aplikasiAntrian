<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SettingLayar extends Model
{
    protected $table = 'setting_layar';
    protected $fillable = [
        'nama_layar',
        'setting_printer_id',
    ];

    public function layarSettingDetails() {
        return $this->hasMany(SettingLayarDetail::class, 'setting_layar_id');
    }
}



