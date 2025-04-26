<?php

namespace App\Http\Requests\Identitas;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Log;

class IdentitasRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {

        Log::info('Request Data:', $this->all()); 
        Log::info('Route Parameter:', ['id' => $this->route('id')]);

        $rules =  [
            'nama_perusahaan'   => 'sometimes|required|string',
            'alamat'            => 'sometimes|required|string',
            'telepon'           => 'sometimes|required',
            'email'             => 'sometimes|required',
            'website'           => 'sometimes|nullable',
            'logo'              => 'sometimes|nullable|image|mimes:jpeg,png,jpg,gif,svg'
        ];

        return $rules;
    }
}
