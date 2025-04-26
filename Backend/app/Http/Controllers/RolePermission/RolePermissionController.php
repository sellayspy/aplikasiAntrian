<?php

namespace App\Http\Controllers\RolePermission;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolePermissionController extends Controller
{
    public function indexRoles()
    {
        try {
            $roles = Role::with('permissions')->get();
            return response()->json($roles);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Terjadi kesalahan saat mengambil roles', 'message' => $e->getMessage()], 500);
        }
    }

    // Menampilkan semua permission
    public function indexPermissions()
    {
        try {
            $permissions = Permission::all();
            return response()->json($permissions);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Terjadi kesalahan saat mengambil permissions', 'message' => $e->getMessage()], 500);
        }
    }

    public function storeRole(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'name' => 'required|unique:roles,name',
            ]);

            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()], 422);
            }

            $role = Role::create(['name' => $request->name]);
            return response()->json(['message' => 'Role berhasil ditambahkan', 'role' => $role]);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Gagal menambahkan role', 'message' => $e->getMessage()], 500);
        }
    }

    // Menambahkan permission baru
    public function storePermission(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'name' => 'required|unique:permissions,name',
            ]);

            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()], 422);
            }

            $permission = Permission::create(['name' => $request->name]);
            return response()->json(['message' => 'Permission berhasil ditambahkan', 'permission' => $permission]);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Gagal menambahkan permission', 'message' => $e->getMessage()], 500);
        }
    }

    // Memberikan permission ke role
    public function assignPermissionToRole(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'role' => 'required|exists:roles,name',
                'permission' => 'required|exists:permissions,name',
            ]);

            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()], 422);
            }

            $role = Role::where('name', $request->role)->first();
            $permission = Permission::where('name', $request->permission)->first();

            $role->givePermissionTo($permission);

            return response()->json(['message' => 'Permission berhasil diberikan ke role']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Gagal memberikan permission ke role', 'message' => $e->getMessage()], 500);
        }
    }

    // Menghapus role
    public function deleteRole($id)
    {
        try {
            $role = Role::find($id);
            if (!$role) {
                return response()->json(['message' => 'Role tidak ditemukan'], 404);
            }

            $role->delete();
            return response()->json(['message' => 'Role berhasil dihapus']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Gagal menghapus role', 'message' => $e->getMessage()], 500);
        }
    }

    // Menghapus permission
    public function deletePermission($id)
    {
        try {
            $permission = Permission::find($id);
            if (!$permission) {
                return response()->json(['message' => 'Permission tidak ditemukan'], 404);
            }

            $permission->delete();
            return response()->json(['message' => 'Permission berhasil dihapus']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Gagal menghapus permission', 'message' => $e->getMessage()], 500);
        }
    }
}
