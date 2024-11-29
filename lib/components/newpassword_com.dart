// components/new_password_com.dart

import 'dart:convert';
import 'package:ace/models/newpassword_model.dart';
import 'package:http/http.dart' as http;
import 'package:ace/widgets/menssage.dart';

class NewPasswordCom {
Future<bool> cambiarContrasena(NewPasswordModel model) async {
  final url = 'http://10.0.2.2:8000/api/nueva-contrasena';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'token': model.token, // Asegúrate de que estás utilizando 'token' aquí
        'nueva_contrasena': model.newPassword, // Asegúrate de que sea 'nueva_contrasena'
      }),
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['estado'] == true) {
        Messages.showSuccessToast(responseBody['mensaje']);
        return true;
      } else {
        Messages.showErrorToast(responseBody['mensaje']);
        return false;
      }
    } else {
      Messages.showErrorToast('Error al cambiar la contraseña: ${response.body}');
      return false;
    }
  } catch (e) {
    Messages.showErrorToast('Error: $e');
    return false;
  }
}
}
