import 'package:ace/views/newpassword.dart';
import 'package:ace/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:ace/components/login_com.dart';
import 'package:ace/views/restore_password.dart';
import 'package:ace/views/inicio_vie.dart'; // Asegúrate de importar la vista correcta

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/login': // Nueva ruta para el Login
        return MaterialPageRoute(builder: (_) => LoginCom()); // Cambia a LoginCom
      case '/restorepassword':
        return MaterialPageRoute(builder: (_) => const RestorePasswordScreen());
       case '/newpassword':
        // Aquí extraemos el token del settings.arguments
        final String token = settings.arguments as String; // Asegúrate de que esto sea un String
        return MaterialPageRoute(builder: (_) => NewpasswordScreen(token: token)); // Pasamos el token
        case '/registro':
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      default:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    }
  }
}