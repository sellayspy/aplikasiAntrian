<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('antrian_panggil_ulang', function (Blueprint $table) {
            $table->id();
            $table->foreignId('setting_layar_id')->constrained('setting_layar')->onDelete('cascade');
            $table->foreignId('antrian_panggil_detail_id')->constrained('antrian_panggil_detail')->onDelete('cascade');
            $table->date('tangal_panggil_ulang');
            $table->time('waktu_panggil_ulang');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('antrian_panggil_ulang');
    }
};
