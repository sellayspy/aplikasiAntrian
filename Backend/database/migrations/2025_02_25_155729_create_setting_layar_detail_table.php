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
        Schema::create('setting_layar_detail', function (Blueprint $table) {
            $table->id();
            $table->foreignId('setting_layar_id')->constrained('setting_layar')->onDelete('cascade');
            $table->foreignId('antrian_kategori_id')->constrained('antrian_kategori')->onDelete('cascade');
            $table->tinyInteger('urut')->nullable();
            $table->timestamps();

            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('setting_layar_detail');
    }
};
