
import 'package:ace/components/newpassword_com.dart';
import 'package:ace/models/newpassword_model.dart';
import 'package:ace/widgets/menssage.dart';
import 'package:flutter/material.dart';

class NewPasswordWidget extends StatefulWidget {
  final String token; // Recibe el token como argumento

  const NewPasswordWidget({Key? key, required this.token}) : super(key: key);

  @override
  _NewPasswordWidgetState createState() => _NewPasswordWidgetState();
}

class _NewPasswordWidgetState extends State<NewPasswordWidget> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final NewPasswordCom _newPasswordCom = NewPasswordCom();
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        const Text(
          '¿Nueva contraseña?',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          'Ingresa tu nueva contraseña y confírmala.',
          style: TextStyle(fontSize: 16, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        _buildPasswordField(
          controller: _newPasswordController,
          hintText: 'Nueva Contraseña',
          isPasswordVisible: _isNewPasswordVisible,
          onVisibilityChanged: () {
            setState(() {
              _isNewPasswordVisible = !_isNewPasswordVisible;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildPasswordField(
          controller: _confirmPasswordController,
          hintText: 'Confirmar Contraseña',
          isPasswordVisible: _isConfirmPasswordVisible,
          onVisibilityChanged: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _changePassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'CAMBIAR CONTRASEÑA',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isPasswordVisible,
    required VoidCallback onVisibilityChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: !isPasswordVisible,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          prefixIcon: const Icon(Icons.lock, color: Colors.white),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: onVisibilityChanged,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  void _changePassword() async {
  if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
    Messages.showErrorSnackBar(context, 'Por favor, complete ambos campos de contraseña.');
    return;
  }

  if (_newPasswordController.text.length < 8) {
    Messages.showErrorSnackBar(context, 'La contraseña debe tener al menos 8 caracteres.');
    return;
  }

  if (_newPasswordController.text != _confirmPasswordController.text) {
    Messages.showErrorSnackBar(context, 'Las contraseñas no coinciden. Por favor, inténtelo de nuevo.');
    return;
  }

  // Crear una instancia del modelo de nueva contraseña
  final newPasswordModel = NewPasswordModel(
    token: widget.token,
    newPassword: _newPasswordController.text,
  );

  // Llamar al método para cambiar la contraseña
  bool success = await _newPasswordCom.cambiarContrasena(newPasswordModel);

  if (success) {
    // Si el cambio de contraseña fue exitoso, reemplazar la pantalla actual con la pantalla de login
    Navigator.pushReplacementNamed(context, '/login');
  } else {
    Messages.showErrorSnackBar(context, 'Error al cambiar la contraseña. Intente de nuevo.');
  }
}

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}