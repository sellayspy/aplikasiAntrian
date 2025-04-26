<?php

use Illuminate\Support\Facades\Route;
use App\Events\AntrianUpdated;

Route::get('/', function () {
    return view('welcome');
});

