import 'package:ace/widgets/menssage.dart';
import 'package:flutter/material.dart';

Widget buildEnterCedulaStep(
  TextEditingController cedulaController,
  VoidCallback onPressed,
) {
  return Column(
    children: [
      const Text(
        '¿Olvidaste tu contraseña?',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      const Text(
        'Ingresa tu cédula para recuperar tu contraseña.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      const SizedBox(height: 32),
      buildTextField(
        controller: cedulaController,
        hintText: 'Cédula',
        icon: Icons.person,
      ),
      const SizedBox(height: 32),
      buildButton(
        text: 'RECUPERAR CONTRASEÑA', 
        onPressed: () {
          if (cedulaController.text.isEmpty) {
            Messages.showErrorToast('Por favor, ingresa tu cédula');
          } else {
            onPressed();
        }
        },
      ),
    ],
  );

}

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool isPassword = false,
  bool isPasswordVisible = false,
  VoidCallback? onVisibilityChanged,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.8),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: onVisibilityChanged,
              )
            : null,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    ),
  );
}

Widget buildButton({required String text, required VoidCallback onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Text(text, style: const TextStyle(fontSize: 16)),
  );
}

Widget buildBottomLogo() {
  return Column(
    children: const [
      SizedBox(height: 8),
      Text(
        '© 2024 Gad Municipal - Ibarra',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ],
  );
}