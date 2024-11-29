import 'package:ace/widgets/newpassword_wid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewpasswordScreen extends StatelessWidget {
  final String token; // Agrega el token aquí

   const NewpasswordScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

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
      body: Stack(
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
                child: NewPasswordWidget(token: token), // Pasamos el token aquí
              ),
            ),
          ),
        ],
      ),
    );
  }
}