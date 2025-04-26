<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class AntrianUpdated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    
    public $antrianSekarang;
    public $sisaAntrian;
    public $menungguAntrian;
    public $selesaiAntrian;

    public function __construct($antrianSekarang, $sisaAntrian, $menungguAntrian, $selesaiAntrian)
    {
        $this->antrianSekarang = $antrianSekarang;
        $this->sisaAntrian = $sisaAntrian;
        $this->menungguAntrian = $menungguAntrian;
        $this->selesaiAntrian = $selesaiAntrian;
    }
    
    public function broadcastOn(): Channel
    {
        return new Channel('antrian');
    }

    public function broadcastAs()
    {
       return 'AntrianUpdated';
    }

    public function broadcastWith()
    {
        return [
            'antrian_sekarang' => $this->antrianSekarang,
            'sisa_antrian' => $this->sisaAntrian,
            'menunggu_antrian' => $this->menungguAntrian,
            'selesai_antrian' => $this->selesaiAntrian
        ];
    }
}
