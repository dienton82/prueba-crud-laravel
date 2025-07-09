<?php

namespace App\Http\Controllers;

use App\Models\Usuario;
use Illuminate\Http\Request;

class UsuarioController extends Controller
{
    // Listar usuarios
    public function index() {
        return Usuario::all();
    }

    // Crear usuario
    public function store(Request $request) {
        $data = $request->validate([
            'nombre' => 'required',
            'email' => 'required|email|unique:usuarios'
        ]);
        $usuario = Usuario::create($data);
        return response()->json($usuario, 201);
    }

    // Consultar usuario por ID
    public function show($id) {
        return Usuario::findOrFail($id);
    }

    // Actualizar usuario
    public function update(Request $request, $id) {
        $usuario = Usuario::findOrFail($id);
        $usuario->update($request->only('nombre', 'email'));
        return response()->json($usuario, 200);
    }

    // Eliminar usuario
    public function destroy($id) {
        Usuario::destroy($id);
        return response()->json(null, 204);
    }
}
