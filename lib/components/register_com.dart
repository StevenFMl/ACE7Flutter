import 'package:ace/models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/menssage.dart';

class RegistroCom extends StatefulWidget {
  @override
  _RegistroComState createState() => _RegistroComState();
}

class _RegistroComState extends State<RegistroCom> {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController fechaNacimientoController = TextEditingController();
  final TextEditingController ecivilController = TextEditingController();
  final TextEditingController etniaController = TextEditingController();
  final TextEditingController discapacidadController = TextEditingController();
  final TextEditingController ocupacionController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController claveController = TextEditingController();

  final RegistroModel registroModel = RegistroModel(baseUrl: 'http://10.0.2.2:8000/api/'); // Cambia a la URL de tu API

  bool isLoading = false;

  void onRegister() async {
    final String cedula = cedulaController.text;
    final String nombre = nombreController.text;
    final String apellido = apellidoController.text;
    final String fechaNacimiento = fechaNacimientoController.text;
    final String ecivil = ecivilController.text;
    final String etnia = etniaController.text;
    final String discapacidad = discapacidadController.text;
    final String ocupacion = ocupacionController.text;
    final String correo = correoController.text;
    final String telefono = telefonoController.text;
    final String clave = claveController.text;

    if (cedula.isEmpty || nombre.isEmpty || apellido.isEmpty || fechaNacimiento.isEmpty || ecivil.isEmpty || etnia.isEmpty || discapacidad.isEmpty || ocupacion.isEmpty || correo.isEmpty || telefono.isEmpty || clave.isEmpty) {
      Messages.showToast("Por favor, completa todos los campos.", backgroundColor: Colors.red);
      return;
    }

    setState(() {
      isLoading = true; // Iniciar carga
    });

    try {
      final response = await registroModel.registrarUsuario(
        cedula: cedula,
        tipoced: 1, // Puedes reemplazar por el valor correcto
        nombre: nombre,
        apellido: apellido,
        fechaNacimiento: fechaNacimiento,
        ecivil: ecivil,
        etnia: etnia,
        discapacidad: discapacidad,
        ocupacion: ocupacion,
        nacionalidad: 1, // Puedes reemplazar por el valor correcto
        ciudad: 1, // Puedes reemplazar por el valor correcto
        provincia: 1, // Puedes reemplazar por el valor correcto
        calle1: 'Calle1', // Puedes ajustar según el formulario
        neducacion: 'Secundaria', // Puedes ajustar según el formulario
        genero: 'Masculino', // Puedes ajustar según el formulario
        correo: correo,
        telefono: telefono,
        clave: clave,
      );

      if (response['estado']) {
        Messages.showToast("Registro exitoso.", backgroundColor: Colors.green);
        Navigator.pushNamed(context, '/login');
      } else {
        Messages.showToast("Error: ${response['mensaje']}", backgroundColor: Colors.red);
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
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Usuario')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: cedulaController, decoration: InputDecoration(labelText: 'Cédula')),
            TextField(controller: nombreController, decoration: InputDecoration(labelText: 'Nombre')),
            TextField(controller: apellidoController, decoration: InputDecoration(labelText: 'Apellido')),
            TextField(controller: fechaNacimientoController, decoration: InputDecoration(labelText: 'Fecha de Nacimiento')),
            TextField(controller: ecivilController, decoration: InputDecoration(labelText: 'Estado Civil')),
            TextField(controller: etniaController, decoration: InputDecoration(labelText: 'Etnia')),
            TextField(controller: discapacidadController, decoration: InputDecoration(labelText: 'Discapacidad')),
            TextField(controller: ocupacionController, decoration: InputDecoration(labelText: 'Ocupación')),
            TextField(controller: correoController, decoration: InputDecoration(labelText: 'Correo')),
            TextField(controller: telefonoController, decoration: InputDecoration(labelText: 'Teléfono')),
            TextField(controller: claveController, decoration: InputDecoration(labelText: 'Contraseña'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : onRegister,
              child: isLoading ? CircularProgressIndicator() : Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
