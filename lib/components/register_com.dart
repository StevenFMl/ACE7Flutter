import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ace/models/register_model.dart';
import '../widgets/menssage.dart';

class RegistroCom extends StatefulWidget {
  @override
  _RegistroComState createState() => _RegistroComState();
}

class _RegistroComState extends State<RegistroCom> {
  final _formKey = GlobalKey<FormState>();
  final RegistroModel registroModel = RegistroModel(baseUrl: 'http://10.0.2.2:8000/api/registrar-usuario');
  
  bool isLoading = false;
  bool checkTerminos = false;

  final Map<String, TextEditingController> controllers = {
    'cedula': TextEditingController(),
    'nombre': TextEditingController(),
    'apellido': TextEditingController(),
    'fechaNacimiento': TextEditingController(),
    'ecivil': TextEditingController(),
    'etnia': TextEditingController(),
    'discapacidad': TextEditingController(),
    'ocupacion': TextEditingController(),
    'correo': TextEditingController(),
    'telefono': TextEditingController(),
    'clave': TextEditingController(),
    'tipodis': TextEditingController(),
    'porcentajedis': TextEditingController(),
    'ncarnetdis': TextEditingController(),
    'parroquia': TextEditingController(),
    'barrio': TextEditingController(),
    'calle1': TextEditingController(),
    'calle2': TextEditingController(),
    'neducacion': TextEditingController(),
    'genero': TextEditingController(),
  };
  List<Map<String, dynamic>> nacionalidades = [];
  List<Map<String, dynamic>> ciudades = [];
  List<Map<String, dynamic>> provincias = [];
  int? selectedNacionalidad;
  int? selectedCiudad;
  int? selectedProvincia;
@override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final nacionalidadesData = await registroModel.fetchNacionalidades();
      final ciudadesData = await registroModel.fetchCiudades();
      final provinciasData = await registroModel.fetchProvincias();

      setState(() {
        nacionalidades = nacionalidadesData;
        ciudades = ciudadesData;
        provincias = provinciasData;
      });
    } catch (e) {
      Messages.showSnackBar(context, 'Error al cargar los datos: $e');
    }
  }

  void onRegister() async {
    if (!_formKey.currentState!.validate() || !checkTerminos) {
      Messages.showToast("Por favor, completa los campos correctamente y acepta los términos.", backgroundColor: Colors.red);
      return;
    }
    
    setState(() => isLoading = true);
    try {
      final response = await registroModel.registrarUsuario(
        cedula: controllers['cedula']!.text,
        tipoced: 1,
        nombre: controllers['nombre']!.text,
        apellido: controllers['apellido']!.text,
        fechaNacimiento: controllers['fechaNacimiento']!.text,
        ecivil: controllers['ecivil']!.text,
        etnia: controllers['etnia']!.text,
        discapacidad: controllers['discapacidad']!.text,
        tipodis: controllers['tipodis']!.text,
        porcentajedis: int.tryParse(controllers['porcentajedis']!.text),
        ncarnetdis: controllers['ncarnetdis']!.text,
        ocupacion: controllers['ocupacion']!.text,
        nacionalidad: selectedNacionalidad ?? 1,
        ciudad: selectedCiudad ?? 1,
        provincia: selectedProvincia ?? 1,
        parroquia: controllers['parroquia']!.text,
        barrio: controllers['barrio']!.text,
        calle1: controllers['calle1']!.text,
        calle2: controllers['calle2']!.text,
        neducacion: controllers['neducacion']!.text,
        genero: controllers['genero']!.text,
        correo: controllers['correo']!.text,
        telefono: controllers['telefono']!.text,
        clave: controllers['clave']!.text,
        check_terminos: checkTerminos,
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
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Usuario')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<int>(
                value: selectedNacionalidad,
                items: nacionalidades.map((n) {
                  return DropdownMenuItem<int>(
                    value: n['id'],
                    child: Text(n['nombre']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedNacionalidad = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Nacionalidad'),
              ),
              DropdownButtonFormField<int>(
                value: selectedProvincia,
                items: provincias.map((p) {
                  return DropdownMenuItem<int>(
                    value: p['cod_provincia'],
                    child: Text(p['nombre_provincia']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProvincia = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Provincia'),
              ),
              DropdownButtonFormField<int>(
                value: selectedCiudad,
                items: ciudades.map((c) {
                  return DropdownMenuItem<int>(
                    value: c['cod_ciudad'],
                    child: Text(c['nombre_ciudad']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCiudad = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Ciudad'),
              ),
              ...controllers.entries.map((entry) => TextFormField(
                    controller: entry.value,
                    decoration: InputDecoration(labelText: entry.key.replaceAll(RegExp(r"([A-Z])"), " \$1")),
                    validator: (value) => value!.isEmpty ? 'Este campo es obligatorio' : null,
                  )),
              Row(
                children: [
                  Checkbox(
                    value: checkTerminos,
                    onChanged: (value) => setState(() => checkTerminos = value!),
                  ),
                  Text('Acepto los términos y condiciones')
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : onRegister,
                child: isLoading ? CircularProgressIndicator() : Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}