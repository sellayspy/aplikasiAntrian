<?php

namespace App\Http\Resources\Identitas;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class IdentitasResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'             => $this->id,
            'namaPerusahaan' => $this->nama_perusahaan,
            'alamat'         => $this->alamat,
            'telepon'        => $this->telepon,
            'email'          => $this->email,
            'website'        => $this->website,
            'logo'           => $this->logo,
            'created_at'    => Carbon::parse($this->created_at)->format('Y-m-d H:i:s'),
            'updated_at'    => Carbon::parse($this->updated_at)->format('Y-m-d H:i:s'),
        ];
    }
}
