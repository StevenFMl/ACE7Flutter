import 'package:ace/components/restore_pass_com.dart';
import 'package:ace/widgets/Carga._wid.dart';
import 'package:ace/widgets/menssage.dart';
import 'package:flutter/material.dart';
import 'package:ace/widgets/restore_pass_wild.dart';
import 'package:ace/widgets/token_wid.dart';
import 'package:ace/models/restore_pass_model.dart';


class RestorePasswordScreen extends StatefulWidget {
  const RestorePasswordScreen({Key? key}) : super(key: key);

  @override
  _RestorePasswordScreenState createState() => _RestorePasswordScreenState();
}

class _RestorePasswordScreenState extends State<RestorePasswordScreen> {
  int _currentStep = 0;
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final RestorePassCom _restorePassCom = RestorePassCom();
  bool _isLoading = false; // Estado de carga
  String? token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'RECUPERAR CONTRASEÑA',
          style: TextStyle(
            fontSize: 18, 
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
      ),
      body: _isLoading // Mostrar widget de carga si está en loading
          ? LoadingWidget(message: 'Enviando código...') 
          : Stack(
              children: [
                Center(
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'assets/escudo.png',
                      height: 300,
                    ),
                  ),
                ),
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
                          buildBottomLogo(),
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
      return buildEnterCedulaStep(
        _cedulaController,
        () async {
          setState(() {
            _isLoading = true; // Activar el loading
          });
          // Enviar cédula y avanzar al siguiente paso
          bool success = await _restorePassCom.enviarCedula(_cedulaController.text);
          setState(() {
            _isLoading = false; // Desactivar el loading
          });
          if (success) {
            setState(() => _currentStep = 1);
            Messages.showSuccessToast('Código enviado al correo electrónico'); // Mostrar el mensaje
          } else {
            Messages.showErrorToast("Cédula incorrecta");
          }
        },
      );
    case 1:
  return buildEnterCodeStep(
    _codeController,
    () async {
      setState(() {
        _isLoading = true; // Activar el loading
      });
      // Verificar código y avanzar al siguiente paso
      bool valid = await _restorePassCom.verificarCodigo(_codeController.text);
      setState(() {
        _isLoading = false; // Desactivar el loading
      });
      if (valid) {
        // Aquí puedes pasar el token o cualquier información que necesites
       Navigator.pushReplacementNamed(context, '/newpassword', arguments: _codeController.text);
        Messages.showSuccessToast("Código válido, cambia tu contraseña");
      } else {
        Messages.showErrorSnackBar(context, "Código de verificación inválido. Inténtalo de nuevo.");
      }
    },
  );
    default:
      return Container();
  }
}

}