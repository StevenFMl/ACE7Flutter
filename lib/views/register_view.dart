import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _acceptTerms = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _selectedDocumentType;
  String? _selectedCivilStatus;
  String? _selectedEthnicity;
  String? _selectedDisability;
  String? _selectedOccupation;
  String? _selectedNationality;
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedGender;
  String? _selectedEducationLevel;
  DateTime? _selectedDate; // Variable para almacenar la fecha seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Registro de Usuario', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLogo(),
                const SizedBox(height: 24),
                const Text(
                  '¡Bienvenido a ACE 7!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Completa tu perfil para comenzar',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildDropdownField(
                  'Tipo de Documento de Identidad',
                  Icons.credit_card,
                  ['Cédula Ecuatoriana', 'Cédula Extranjera'],
                  (value) {
                    setState(() => _selectedDocumentType = value);
                  },
                ),
                if (_selectedDocumentType != null)
                  _buildTextField(
                    'Número de ${_selectedDocumentType}',
                    Icons.person_outline,
                    hintText: 'Ingrese su número de ${_selectedDocumentType?.toLowerCase()}',
                  ),
                _buildTextField('Nombres', Icons.person, hintText: 'Ingrese sus nombres completos'),
                _buildTextField('Apellidos', Icons.people, hintText: 'Ingrese sus apellidos completos'),
                _buildDateField('Fecha de Nacimiento', Icons.calendar_today),
                _buildDropdownField('Estado Civil', Icons.favorite_border, ['Soltero/a', 'Casado/a', 'Viudo/a', 'Divorciado/a', 'Unión de hecho', 'Otro'], (value) {
                  setState(() => _selectedCivilStatus = value);
                }),
                if (_selectedCivilStatus == 'Otro')
                  _buildTextField('Especifique su estado civil', Icons.edit, hintText: 'Describa su estado civil'),
                _buildDropdownField('Etnia', Icons.public, ['Indígena', 'Mestiza', 'Afro Ecuatoriana', 'Blanca', 'Otro'], (value) {
                  setState(() => _selectedEthnicity = value);
                }),
                if (_selectedEthnicity == 'Otro')
                  _buildTextField('Especifique su Etnia', Icons.edit, hintText: 'Describa su etnia'),
                _buildDropdownField('¿Tiene alguna discapacidad?', Icons.accessible, ['Sí', 'No'], (value) {
                  setState(() => _selectedDisability = value);
                }),
                if (_selectedDisability == 'Sí') ...[
                  _buildTextField('Tipo de discapacidad', Icons.accessibility_new, hintText: 'Especifique el tipo de discapacidad'),
                  _buildTextField('Porcentaje de discapacidad', Icons.percent, hintText: 'Ingrese el porcentaje (0-100)'),
                  _buildTextField('Número de Carnet CONADIS', Icons.card_membership, hintText: 'Ingrese el número de su carnet'),
                ],
                _buildDropdownField('Ocupación Actual', Icons.work, ['Sin Empleo', 'Ama de casa', 'Estudiante', 'Empleado privado', 'Servidor Público', 'Artesano', 'Jornalero', 'Emprendedor', 'Jubilado', 'Otro'], (value) {
                  setState(() => _selectedOccupation = value);
                }),
                if (_selectedOccupation == 'Otro')
                  _buildTextField('Especifique su ocupación', Icons.edit, hintText: 'Describa su ocupación actual'),
                _buildDropdownField('Nacionalidad', Icons.flag, ['Ecuatoriana', 'Otra'], (value) {
                  setState(() => _selectedNationality = value);
                }),
                _buildDropdownField('Provincia de Residencia', Icons.location_city, ['Pichincha', 'Guayas', 'Azuay', 'Otra'], (value) {
                  setState(() => _selectedProvince = value);
                }),
                if (_selectedProvince != null) ...[
                  _buildDropdownField('Ciudad', Icons.location_on, ['Quito', 'Guayaquil', 'Cuenca', 'Otra'], (value) {
                    setState(() => _selectedCity = value);
                  }),
                  _buildTextField('Parroquia', Icons.place, hintText: 'Ingrese el nombre de su parroquia'),
                  _buildTextField('Barrio', Icons.home, hintText: 'Ingrese el nombre de su barrio'),
                  _buildTextField('Calle Principal', Icons.add_road, hintText: 'Nombre de la calle principal'),
                  _buildTextField('Calle Secundaria', Icons.add_road, hintText: 'Nombre de la calle secundaria (opcional)'),
                ],
                _buildDropdownField('Género', Icons.wc, ['Masculino', 'Femenino', 'No binario', 'Prefiero no decir', 'Otro'], (value) {
                  setState(() => _selectedGender = value);
                }),
                if (_selectedGender == 'Otro')
                  _buildTextField('Especifique su género', Icons.edit, hintText: 'Describa su identidad de género'),
                _buildDropdownField('Nivel de Educación', Icons.school, ['Educación básica', 'Bachillerato', 'Técnico/Tecnológico', 'Tercer Nivel (Grado)', 'Cuarto Nivel (Posgrado)', 'Ninguno'], (value) {
                  setState(() => _selectedEducationLevel = value);
                }),
                _buildTextField('Correo Electrónico', Icons.email, hintText: 'ejemplo@correo.com'),
                _buildTextField('Número de Celular', Icons.phone, hintText: '09XXXXXXXX'),
                _buildPasswordField('Contraseña', Icons.lock, hintText: 'Mínimo 8 caracteres'),
                _buildPasswordField('Confirmar Contraseña', Icons.lock, isConfirmPassword: true, hintText: 'Repita su contraseña'),
                const SizedBox(height: 24),
                _buildTermsAndConditions(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('COMPLETAR REGISTRO', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 24),
                const Text(
                  '© 2024 Alcaldía De Ibarra - Todos los derechos reservados',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '7',
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Icon(Icons.calculate, color: Colors.white, size: 24),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Icon(Icons.attach_money, color: Colors.white, size: 24),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Icon(Icons.bar_chart, color: Colors.white, size: 24),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Icon(Icons.account_balance, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, IconData icon, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Por favor seleccione una opción' : null,
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {String? hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: (value) => value!.isEmpty ? 'Por favor ingrese $label' : null,
      ),
    );
  }

  Widget _buildDateField(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Seleccione una fecha',
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onTap: _selectDate,
        validator: (value) => _selectedDate == null ? 'Por favor seleccione su fecha de nacimiento' : null,
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildPasswordField(String label, IconData icon, {bool isConfirmPassword = false, String? hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: isConfirmPassword ? !_isConfirmPasswordVisible : !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: Icon(isConfirmPassword ? (_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off) : (_isPasswordVisible ? Icons.visibility : Icons.visibility_off)),
            onPressed: () {
              setState(() {
                if (isConfirmPassword) {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                } else {
                  _isPasswordVisible = !_isPasswordVisible;
                }
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su contraseña';
          } else if (value.length < 8) {
            return 'La contraseña debe tener al menos 8 caracteres';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (bool? value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
        ),
        const Expanded(
          child: Text(
            'Acepto los términos y condiciones',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      // Aquí puedes agregar la lógica para enviar el formulario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro completado exitosamente')),
      );
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe aceptar los términos y condiciones')),
      );
    }
  }
}
