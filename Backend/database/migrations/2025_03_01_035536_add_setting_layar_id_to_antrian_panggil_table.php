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
        Schema::table('antrian_panggil', function (Blueprint $table) {
            $table->unsignedBigInteger('setting_layar_id')->after('antrian_kategori_id');
            $table->foreign('setting_layar_id')->references('id')->on('setting_layar')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('antrian_panggil', function (Blueprint $table) {
            $table->dropForeign(['setting_layar_id']);
            $table->dropColumn('setting_layar_id');
        });
    }
};
