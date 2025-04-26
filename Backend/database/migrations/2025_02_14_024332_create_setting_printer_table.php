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
        Schema::create('setting_printer', function (Blueprint $table) {
            $table->id();
            $table->string('nama_printer')->unique();
            $table->string('alamat_printer');
            $table->tinyInteger('aktif')->default(0);
            $table->tinyInteger('feed_paper')->default(0);
            $table->enum('orientation', ['portrait', 'landscape'])->default('portrait');
            $table->tinyInteger('font_size_width')->default(0);
            $table->tinyInteger('font_size_height')->default(0);
            $table->enum('autocat', ['Y', 'N'])->default('N');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('setting_printer');
    }
};
