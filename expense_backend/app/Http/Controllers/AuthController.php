<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function register(Request $request) {
        $request->validate([
            'name' => 'required|String',
            'email' => 'required|email|unique::users',
            'password' => 'required|min:6',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
        ]);

        $token = $user->createToken('auth_Token')->plainTextToken;

        return response()->json($request->all());
    }

    public function login(Request $request) {
        $user = User::where('email', $request->email)->first();
        $token = $user->createToken('auth_Token')->plainTextToken;

        return response()->json([
            'token' => $token,
            'user' => $user,
        ]);
    }

    public function logout(Request $request) {
        $request->user()->tokens()->delete();
        return response()->json([
            "message" => "Logged In!"
        ]);
    }
}
