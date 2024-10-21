import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/login_wid.dart';
import '../widgets/socialmedia.dart';
import 'dart:ui';

class LoginView extends StatelessWidget {
  final TextEditingController cedulaController;
  final TextEditingController claveController;
   final VoidCallback? onLogin; // Cambiar a VoidCallback?

  const LoginView({
    super.key,
    required this.cedulaController,
    required this.claveController,
    required this.onLogin,
  });

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background image
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Image.asset(
              'assets/obelisco.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Semi-transparent white overlay
          Container(
            color: Colors.white.withOpacity(0.7),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    'Ingreso',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ingrese a su cuenta',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    controller: cedulaController,
                    icon: Icons.person,
                    hintText: 'Cédula',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: claveController,
                    icon: Icons.lock,
                    hintText: 'Contraseña',
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: onLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('INICIAR SESIÓN', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Add forgot password functionality
                       Navigator.pushNamed(context, '/restorepassword'); // Navega a la vista de recuperación de contraseña
                    },
                    child: const Text(
                      '¿OLVIDÉ MI CONTRASEÑA?',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                   child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.userPlus, // Ícono de registro
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'REGISTRARSE',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIcon(icon: FontAwesomeIcons.facebookF, url: 'https://www.facebook.com/GadIbarra'),
                      const SizedBox(width: 24),
                      SocialIcon(icon: FontAwesomeIcons.instagram, url: 'https://www.instagram.com/gadibarra'),
                      const SizedBox(width: 24),
                      SocialIcon(icon: FontAwesomeIcons.twitter, url: 'https://twitter.com/gadibarra'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '© Gad Municipal - Ibarra 2024',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}