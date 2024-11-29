// restore_pass_com.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ace/models/restore_pass_model.dart';

class RestorePassCom {
  Future<bool> enviarCedula(String cedula) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/recuperar-contrasena'), // Cambia esto por tu URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'cedula': cedula}),
    );

    if (response.statusCode == 200) {
      // Procesar la respuesta
      final data = jsonDecode(response.body);
      return data['estado'];
    } else {
      throw Exception('Error al enviar la cédula');
    }
  }

Future<bool> verificarCodigo(String token) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/verificar-codigo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'token': token}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Response data: $data'); // Depuración

    // Retornar verdadero si el estado es true
    return data['estado'] == true; // Ajuste aquí
  } else {
    throw Exception('Error al verificar el código');
  }
}


}