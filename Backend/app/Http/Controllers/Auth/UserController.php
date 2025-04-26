<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    public function getUser()
    {
        try {
            $users = User::with('roles', 'permissions')->get();
            return response()->json(['users' => $users]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function updateUser(Request $request, User $user)
    {
        try {
            $request->validate([
                'name' => 'sometimes|string|max:255',
                'username' => 'sometimes|string|unique:users,username,' . $user->id,
                'email' => 'sometimes|string|email|unique:users,email,' . $user->id,
                'status' => 'sometimes|string|in:active,inactive',
                'role' => 'sometimes|string|exists:roles,name',
                'permissions' => 'array',
                'permissions.*' => 'exists:permissions,name',
                'avatar' => 'nullable|image|mimes:jpg,jpeg,png|max:2048'
            ]);

            if ($request->hasFile('avatar')) {
                if ($user->avatar) {
                    Storage::disk('public')->delete($user->avatar);
                }
                $user->avatar = $request->file('avatar')->store('avatars', 'public');
            }

            $user->update($request->only('name', 'username', 'email', 'status', 'avatar'));

            if ($request->has('role')) {
                $user->syncRoles([$request->role]);
            }
            if ($request->has('permissions')) {
                $user->syncPermissions($request->permissions);
            }

            return response()->json(['message' => 'User updated successfully', 'user' => $user]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function deleteUser(User $user)
    {
        try {
            if ($user->avatar) {
                Storage::disk('public')->delete($user->avatar);
            }
            $user->delete();
            return response()->json(['message' => 'User deleted successfully']);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
