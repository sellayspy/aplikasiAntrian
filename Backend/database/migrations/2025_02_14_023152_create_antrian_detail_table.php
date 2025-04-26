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
        Schema::create('antrian_detail', function (Blueprint $table) {
            $table->id();
            $table->foreignId('antrian_kategori_id')->constrained('antrian_kategori')->onDelete('cascade');
            $table->foreignId('antrian_tujuan_id')->constrained('antrian_tujuan')->onDelete('cascade');
            $table->enum('aktif', ['Y', 'N'])->default('Y');
            $table->timestamps();

            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('antrian_detail');
    }
};
