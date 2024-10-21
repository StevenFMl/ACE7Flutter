import 'package:ace/components/login_com.dart';
import 'package:ace/views/restore_password.dart';
import 'package:flutter/material.dart';
import '../views/inicio_vie.dart'; // Asegúrate de importar la vista correcta

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      
      case '/login': // Nueva ruta para el Login
        return MaterialPageRoute(builder: (_) => LoginCom()); // Cambia a LoginCom
      case '/restorepassword':
        return MaterialPageRoute(builder: (_) => const RestorePasswordScreen() );

      default:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    }
  }
}