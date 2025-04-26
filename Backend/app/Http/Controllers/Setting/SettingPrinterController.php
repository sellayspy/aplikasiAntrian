<?php

namespace App\Http\Controllers\Setting;

use App\Http\Controllers\Controller;
use App\Models\SettingPrinter;
use Illuminate\Http\Request;

class SettingPrinterController extends Controller
{
    
    public function index()
    {
        try {
            $printers = SettingPrinter::all();

            return response()->json([
                'status' => 'success',
                'message' => 'Setting Printers retrieved successfully',
                'data' => $printers
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to retrieve Setting Printers',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'nama_printer' => 'required|string|max:255',
                'alamat_printer' => 'required|string|max:255',
                'aktif' => 'required|boolean',
                'feed_paper' => 'required|integer',
                'orientation' => 'required|string|max:50',
                'font_size_width' => 'required|integer',
                'font_size_height' => 'required|integer',
                'autocat' => 'required|string|max:50',
            ]);

            $printer = SettingPrinter::create($validated);

            return response()->json([
                'status' => 'success',
                'message' => 'Setting Printer created successfully',
                'data' => $printer
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to create Setting Printer',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request,$id)
    {
         try {
            $validated = $request->validate([
                'nama_printer' => 'nullable|string|max:255',
                'alamat_printer' => 'nullable|string|max:255',
                'aktif' => 'nullable|boolean',
                'feed_paper' => 'nullable|integer',
                'orientation' => 'nullable|string|max:50',
                'font_size_width' => 'nullable|integer',
                'font_size_height' => 'nullable|integer',
                'autocat' => 'nullable|string|max:50',
            ]);

            $printer = SettingPrinter::findOrFail($id);
            $printer->update($validated);

            return response()->json([
                'status' => 'success',
                'message' => 'Setting Printer updated successfully',
                'data' => $printer
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to update Setting Printer',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $printer = SettingPrinter::findOrFail($id);
            $printer->delete();

            return response()->json([
                'status' => 'success',
                'message' => 'Setting Printer deleted successfully'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Printer',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
