import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginModel {
  final String baseUrl;

  LoginModel({required this.baseUrl});

  Future<Map<String, dynamic>> login(String usuario, String clave) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'usuario': usuario,
        'clave': clave,
      }),
    );

    // Verifica el estado de la respuesta
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {
        'estado': false, // Solo indica el estado de error
      };
    }
  }
}