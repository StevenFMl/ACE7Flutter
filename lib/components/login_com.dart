import 'package:ace/views/login_vie.dart';
import 'package:ace/widgets/menssage.dart';
import 'package:flutter/material.dart';
import '../models/login_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCom extends StatefulWidget {
  @override
  _LoginComState createState() => _LoginComState();
}

class _LoginComState extends State<LoginCom> {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController claveController = TextEditingController();
  final LoginModel loginModel = LoginModel(baseUrl: 'http://10.0.2.2:8000/api/login'); // Cambia a la URL de tu API

  bool isLoading = false;

 void onLogin() async {
  final String usuario = cedulaController.text;
  final String clave = claveController.text;

  if (usuario.isEmpty || clave.isEmpty) {
    Messages.showToast("Por favor, completa todos los campos.", backgroundColor: Colors.red);
    return;
  }

  setState(() {
    isLoading = true; // Iniciar carga
  });

  try {
    final response = await loginModel.login(usuario, clave);
    // Manejar respuesta
    if (response['estado']) {
      String nombreUsuario = response['persona']['nombre'] ?? 'Usuario'; // Obtener el nombre del usuario
      Messages.showToast("Inicio de sesión exitoso. Bienvenido, $nombreUsuario.", backgroundColor: Colors.green);
      Navigator.pushNamed(context, '/home');
    } else {
      // Mostrar mensaje de error en caso de datos incorrectos
      Messages.showToast ("Datos Incorrectos", backgroundColor: Colors.red);
    }
  } catch (e) {
    Messages.showSnackBar(context, 'Error: $e');
  } finally {
    setState(() {
      isLoading = false; // Detener carga
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return LoginView(
      cedulaController: cedulaController,
      claveController: claveController,
      onLogin: isLoading ? null : onLogin,
    );
  }
}