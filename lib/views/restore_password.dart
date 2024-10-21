import 'package:flutter/material.dart';

class RestorePasswordScreen extends StatefulWidget {
  const RestorePasswordScreen({Key? key}) : super(key: key);

  @override
  _RestorePasswordScreenState createState() => _RestorePasswordScreenState();
}

class _RestorePasswordScreenState extends State<RestorePasswordScreen> {
  int _currentStep = 0;
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.black,
  title: const Text(
    'RECUPERAR CONTRASEÑA',
    style: TextStyle(
      fontSize: 18, 
      color: Colors.white, // Cambiado a blanco
    ),
  ),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.of(context).pop(),
  ),
),
      body: Stack(
        children: [
          // Imagen centrada en el fondo
          Center(
            child: Opacity(
              opacity: 0.1, // Ajusta la opacidad para que no sea muy dominante
              child: Image.asset(
                'assets/escudo.png',
                height: 300, // Ajusta el tamaño según tus preferencias
              ),
            ),
          ),
          // Contenido principal
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    _buildCurrentStep(),
                    const SizedBox(height: 20),
                    _buildBottomLogo(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildEnterCedulaStep();
      case 1:
        return _buildEnterCodeStep();
      case 2:
        return _buildResetPasswordStep();
      default:
        return Container();
    }
  }

  Widget _buildEnterCedulaStep() {
    return Column(
      children: [
        const Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          'Ingresa tu cédula para recuperar tu contraseña.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 32),
        _buildTextField(
          controller: _cedulaController,
          hintText: 'Cédula',
          icon: Icons.person,
          
        ),
        const SizedBox(height: 32),
        _buildButton(
          text: 'RECUPERAR CONTRASEÑA',
          onPressed: () {
            setState(() => _currentStep = 1);
          },
        ),
      ],
    );
  }

  Widget _buildEnterCodeStep() {
    return Column(
      children: [
        const SizedBox(height: 32),
        const Text(
          'Ingresa el código de recuperación',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          'Revisa tu correo y escribe el código aquí.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 32),
        _buildTextField(
          controller: _codeController,
          hintText: 'Código de verificación',
          icon: Icons.lock,
        ),
        const SizedBox(height: 32),
        _buildButton(
          text: 'VERIFICAR CÓDIGO',
          onPressed: () {
            setState(() => _currentStep = 2);
          },
        ),
      ],
    );
  }

  Widget _buildResetPasswordStep() {
    return Column(
      children: [
        const Text(
          'Restablecer Contraseña',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          'Ingrese su nueva contraseña.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 32),
        _buildTextField(
          controller: _newPasswordController,
          hintText: 'Nueva Contraseña',
          icon: Icons.lock,
          isPassword: true,
          isPasswordVisible: _isPasswordVisible,
          onVisibilityChanged: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _confirmPasswordController,
          hintText: 'Confirmar Contraseña',
          icon: Icons.lock,
          isPassword: true,
          isPasswordVisible: _isConfirmPasswordVisible,
          onVisibilityChanged: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
        ),
        const SizedBox(height: 32),
        _buildButton(
          text: 'RESTABLECER CONTRASEÑA',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
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

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildBottomLogo() {
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
}