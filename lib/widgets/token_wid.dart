import 'package:ace/widgets/menssage.dart';
import 'package:flutter/material.dart';

Widget buildEnterCodeStep(
  TextEditingController codeController,
  VoidCallback onPressed,
) {
  return Column(
    children: [
      const SizedBox(height: 32),
      const Text(
        'Ingresa el código de recuperación',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 32),
      buildTextField(
        controller: codeController,
        hintText: 'Código de verificación',
        icon: Icons.lock,
      ),
      const SizedBox(height: 32),
      buildButton(
        text: 'VERIFICAR CÓDIGO',
        onPressed: () {
          if (codeController.text.isEmpty) {
            Messages.showErrorToast('Por favor, ingresa el código de verificación');
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