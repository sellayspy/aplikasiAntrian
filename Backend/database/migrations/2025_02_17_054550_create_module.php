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
        Schema::create('module', function (Blueprint $table) {
            $table->id();
            $table->string('nama_module')->unique();
            $table->string('judul_module');
            $table->foreignId('model_status_id')->constrained('module_status')->onDelete('cascade');
            $table->enum('login',['Y','N','R'])->default('Y');
            $table->string('deskripsi');
            $table->timestamps();

            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('module');
    }
};
