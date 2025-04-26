<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class AntrianSisaAmbil implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $namaLayar;
    public $kategoriData;

    public function __construct($namaLayar, $kategoriData)
    {
        $this->namaLayar = $namaLayar;
        $this->kategoriData = $kategoriData;
    }

    public function broadcastOn()
    {
        return new Channel('antrian.' . $this->namaLayar);
    }

    public function broadcastAs()
    {   
        return 'AntrianAmbilUpdated';
    }

    public function broadcastWith()
    {
        return [
            'nama_layar' => $this->namaLayar,
            'kategori' => $this->kategoriData,
        ];
    }
}