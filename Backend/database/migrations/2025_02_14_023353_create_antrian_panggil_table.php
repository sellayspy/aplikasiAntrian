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
        Schema::create('antrian_panggil', function (Blueprint $table) {
            $table->id();
            $table->foreignId('antrian_kategori_id')->constrained('antrian_kategori')->onDelete('cascade');
            $table->integer('jumlah_antrian');
            $table->integer('jumlah_antrian_terpanggil')->default(0);
            $table->date('tanggal');
            $table->time('waktu_ambil');
            $table->time('waktu_selesai')->nullable();
            $table->timestamps();

            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('antrian_panggil');
    }
};
