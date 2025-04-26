<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SettingPrinter extends Model
{
    protected $table = 'setting_printer';
    protected $fillable = [
        'nama_printer',
        'alamat_printer',
        'aktif',
        'feed_paper',
        'orientation',
        'font_size_width',
        'font_size_height',
        'autocat'
    ];
}
