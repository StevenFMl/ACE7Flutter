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
    required String fechaNacimiento,
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
    required bool check_terminos, // Recibe el valor desde el formulario
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
        'fecha_nacimiento': fechaNacimiento,
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
        'check_terminos': check_terminos, // Usamos el valor pasado desde el formulario
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
  Future<List<Map<String, dynamic>>> fetchNacionalidades() async {
    final response = await http.get(Uri.parse('$baseUrl/nacionalidades'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['estado'] == true) {
        return List<Map<String, dynamic>>.from(jsonResponse['datos']);
      }
    }
    throw Exception('Error al obtener nacionalidades');
  }

  Future<List<Map<String, dynamic>>> fetchCiudades() async {
    final response = await http.get(Uri.parse('$baseUrl/ciudades'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['estado'] == true) {
        return List<Map<String, dynamic>>.from(jsonResponse['datos']);
      }
    }
    throw Exception('Error al obtener ciudades');
  }

  Future<List<Map<String, dynamic>>> fetchProvincias() async {
    final response = await http.get(Uri.parse('$baseUrl/provincias'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['estado'] == true) {
        return List<Map<String, dynamic>>.from(jsonResponse['datos']);
      }
    }
    throw Exception('Error al obtener provincias');
  }
}
