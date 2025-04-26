<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class AntrianLayarUpdated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $sedangDilayani;
    public $menungguBerikutnya;

    public function __construct($sedangDilayani, $menungguBerikutnya)
    {
        $this->sedangDilayani = $sedangDilayani;
        $this->menungguBerikutnya = $menungguBerikutnya;
    }

    public function broadcastOn()
    {
        return new Channel('antriandisplay');
    }

    public function broadcastAs()
    {   
        return 'AntrianLayarUpdated';
    }

    public function broadcastWith()
    {
        $formatData = function($item) {
            return [
                'nama_kategori'     => $item['nama_kategori'] ?? 'Unknown',
                'nama_tujuan'       => $item['nama_tujuan'] ?? 'Unknown',
                'awalan_panggil'    => $item['awalan_panggil'],
                'nomor_panggil'     => $item['nomor_panggil'],
                'status'            => $item['status'],
                'waktu_panggil'     => $item['waktu_panggil'] ?? null,
            ];
        };

        return [
            'sedang_dilayani' => $this->sedangDilayani ? $formatData($this->sedangDilayani) : null,
            'menunggu_berikutnya' => array_map($formatData, $this->menungguBerikutnya),
        ];
    }

}
