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
        Schema::create('menu', function (Blueprint $table) {
            $table->id();
            $table->string('nama_menu');
            $table->foreignId('menu_kategori_id')->constrained('menu_kategori')->onDelete('cascade');
            $table->string('class')->nullable();
            $table->string('url')->nullable();
            $table->foreignId('module_id')->constrained('module')->onDelete('cascade');
            $table->tinyInteger('aktif')->default(1);
            $table->tinyInteger('new')->default(0);
            $table->tinyInteger('urut')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('menu');
    }
};
