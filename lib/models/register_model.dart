import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistroModel {
  final String baseUrl;

  RegistroModel({required this.baseUrl});

  Future<Map<String, dynamic>> registrarUsuario({
    required String cedula,
    required int tipoced,
    required String nombre,
    required String apellido,
    required String fecha_nacimiento,
    required String ecivil,
    required String etnia,
    required String discapacidad,
    String? tipodis,
    int? porcentajedis,
    String? ncarnetdis,
    required String ocupacion,
    required int nacionalidad,
    required int ciudad,
    required int provincia,
    String? parroquia,
    String? barrio,
    required String calle1,
    String? calle2,
    required String neducacion,
    required String genero,
    required String correo,
    required String telefono,
    required String clave,
    required bool check_terminos,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registro-usuario'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'cedula': cedula,
        'tipoced': tipoced,
        'nombre': nombre,
        'apellido': apellido,
        'fecha_nacimiento': fecha_nacimiento,
        'ecivil': ecivil,
        'etnia': etnia,
        'discapacidad': discapacidad,
        'tipodis': tipodis,
        'porcentajedis': porcentajedis,
        'ncarnetdis': ncarnetdis,
        'ocupacion': ocupacion,
        'nacionalidad': nacionalidad,
        'ciudad': ciudad,
        'provincia': provincia,
        'parroquia': parroquia,
        'barrio': barrio,
        'calle1': calle1,
        'calle2': calle2,
        'neducacion': neducacion,
        'genero': genero,
        'correo': correo,
        'telefono': telefono,
        'clave': clave,
        'check_terminos': true, // Por defecto lo seteamos en true ya que es requerido
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {
        'estado': false,
        'mensaje': 'Error al registrar el usuario',
      };
    }
  }
}
