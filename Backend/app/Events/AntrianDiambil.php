<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class AntrianDiambil implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $namaLayar;
    public $namaKategori;
    public $sisaAntrian;
    public $jumlahAntrian;
    public $awalanPanggil;
    public $nomorPanggil;


    public function __construct($namaLayar, $namaKategori, $sisaAntrian, $jumlahAntrian, $awalanPanggil, $nomorPanggil)
    {
        $this->namaLayar = $namaLayar;
        $this->namaKategori = $namaKategori;
        $this->sisaAntrian = $sisaAntrian;
        $this->jumlahAntrian = $jumlahAntrian;
        $this->awalanPanggil = $awalanPanggil;
        $this->nomorPanggil = $nomorPanggil;
    }

    public function broadcastOn()
    {
        $channelName = str_replace(' ', '-', $this->namaLayar);
        return new Channel('antrian.' . $channelName);
    }
    
    public function broadcastAs()
    {
        return 'antrian.diambil';
    }

    public function broadcastWith()
    {
        return [
            'namaLayar' => $this->namaLayar,
            'namaKategori' => $this->namaKategori,
            'sisaAntrian' => $this->sisaAntrian,
            'jumlahAntrian' => $this->jumlahAntrian,
            'awalanPanggil' => $this->awalanPanggil,
            'nomorPanggil' => $this->nomorPanggil,
        ];
    }
}
