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
        Schema::create('antrian_kategori', function (Blueprint $table) {
            $table->id();
            $table->string('nama_kategori')->unique();
            $table->char('awalan', 1);
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
        Schema::dropIfExists('antrian_kategori');
    }
};
