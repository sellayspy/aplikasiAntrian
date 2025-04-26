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
        Schema::create('antrian_panggil_detail', function (Blueprint $table) {
            $table->id();
            $table->foreignId('antrian_panggil_id')->constrained('antrian_panggil')->onDelete('cascade');
            $table->foreignId('antrian_detail_id')->constrained('antrian_detail')->onDelete('cascade');
            $table->char('awalan_panggil', 1)->nullable();
            $table->smallInteger('nomor_panggil')->nullable();
            $table->enum('status', ['Menunggu', 'Sedang Dilayani', 'Selesai'])->default('Menunggu');
            $table->dateTime('waktu_panggil')->nullable();
            $table->timestamps();

            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('antrian_panggil_detail');
    }
};
