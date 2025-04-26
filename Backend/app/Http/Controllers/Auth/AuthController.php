<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255',
                'username' => 'required|string|unique:users,username',
                'email' => 'required|string|email|unique:users,email',
                'password' => 'required|string|min:6',
                'role' => 'required|string|exists:roles,name',
                'permissions' => 'array',
                'permissions.*' => 'exists:permissions,name',
                'avatar' => 'nullable|image|mimes:jpg,jpeg,png|max:2048'
            ]);

             $avatarPath = $request->file('avatar') ? $request->file('avatar')->store('avatars', 'public') : null;

            $user = User::create([
                'name' => $request->name,
                'username' => $request->username,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'status' => 'active',
                'avatar' => $avatarPath,
            ]);

            $user->assignRole($request->role);

            if ($request->has('permissions')) {
                $user->givePermissionTo($request->permissions);
            }

            return response()->json([
                'status' => 'success',
                'message' => 'User registered successfully',
                'user' => $user
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }

     public function login(Request $request)
    {
        try {
            $request->validate([
                'username' => 'required',
                'password' => 'required'
            ]);

            if (!Auth::attempt($request->only('username', 'password'))) {
                return response()->json(['error' => 'Invalid credentials'], 401);
            }

            $user = Auth::user();
            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json(['token' => $token, 'user' => $user]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }

     public function logout(Request $request)
    {
        try {
            $request->user()->tokens()->delete();
            return response()->json(['message' => 'Logged out successfully']);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function updatePassword(Request $request)
    {
        try {
            $request->validate([
                'current_password' => 'required',
                'new_password' => 'required|min:6',
            ]);

            $user = Auth::user();

            if (!Hash::check($request->current_password, $user->password)) {
                return response()->json(['error' => 'Current password is incorrect'], 400);
            }

            $user->update(['password' => Hash::make($request->new_password)]);

            return response()->json(['message' => 'Password updated successfully']);
        }catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to delete Setting Layar',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
