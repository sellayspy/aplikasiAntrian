<?php

namespace App\Helpers;

use App\Http\Controllers\Antrian\AntrianTampilLayarController;
use App\Models\AntrianPanggil;

class AntrianHelper
{
    public static function getTampilanLayar($antrianPanggilId)
    {
        $controller = new AntrianTampilLayarController();
        return $controller->tampilkanLayarAntrian($antrianPanggilId);
    }
}
