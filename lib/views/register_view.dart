import 'package:flutter/material.dart';
import 'package:ace/models/register_model.dart';
import 'package:ace/widgets/menssage.dart';
import 'package:intl/intl.dart';

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
  bool _isLoading = false;
  bool _dataLoaded = false;

  final RegistroModel registroModel = RegistroModel(baseUrl: 'http://10.0.2.2:8000/api');
  
  // Controllers for all form fields
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _otherCivilStatusController = TextEditingController();
  final TextEditingController _otherEthnicityController = TextEditingController();
  final TextEditingController _tipoDiscapacidadController = TextEditingController();
  final TextEditingController _porcentajeDiscapacidadController = TextEditingController();
  final TextEditingController _carnetDiscapacidadController = TextEditingController();
  final TextEditingController _otherOcupacionController = TextEditingController();
  final TextEditingController _parroquiaController = TextEditingController();
  final TextEditingController _barrioController = TextEditingController();
  final TextEditingController _calle1Controller = TextEditingController();
  final TextEditingController _calle2Controller = TextEditingController();
  final TextEditingController _otherGenderController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _confirmarClaveController = TextEditingController();

  // Dropdown values
  String _selectedDocumentType = 'Cédula Ecuatoriana';
  String? _selectedCivilStatus;
  String? _selectedEthnicity;
  String _selectedDisability = 'No';
  String? _selectedOccupation;
  String? _selectedEducationLevel;
  String? _selectedGender;
  DateTime? _selectedDate;

  List<Map<String, dynamic>> nacionalidades = [];
  List<Map<String, dynamic>> provincias = [];
  List<Map<String, dynamic>> ciudades = [];
  
  // Initialize with default values to avoid null issues
  int _selectedNacionalidadId = 1;
  int _selectedProvinciaId = 1;
  int _selectedCiudadId = 1;

  // Future to load data
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Load nacionalidades, provincias and ciudades
      final nacionalidadesData = await registroModel.fetchNacionalidades();
      final provinciasData = await registroModel.fetchProvincias();
      final ciudadesData = await registroModel.fetchCiudades();
      
      setState(() {
        nacionalidades = nacionalidadesData;
        provincias = provinciasData;
        ciudades = ciudadesData;
        
        // Set default values if data is available
        if (nacionalidades.isNotEmpty) {
          _selectedNacionalidadId = nacionalidades[0]['id'] ?? 1;
        }
        
        if (provincias.isNotEmpty) {
          _selectedProvinciaId = provincias[0]['id'] ?? 1;
        }
        
        // Only set a city if there's one that matches the selected province
        if (ciudades.isNotEmpty) {
          final filteredCities = ciudades.where((c) => 
            c['provincia_id'] != null && c['provincia_id'] == _selectedProvinciaId
          ).toList();
          
          if (filteredCities.isNotEmpty) {
            _selectedCiudadId = filteredCities[0]['id'] ?? 1;
          } else {
            // If no cities match the province, use the first city
            _selectedCiudadId = ciudades[0]['id'] ?? 1;
            // Update province to match the city
            final firstCityProvinceId = ciudades[0]['provincia_id'];
            if (firstCityProvinceId != null) {
              _selectedProvinciaId = firstCityProvinceId;
            }
          }
        }
        
        _dataLoaded = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: $e'), backgroundColor: Colors.red)
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    _cedulaController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _fechaNacimientoController.dispose();
    _otherCivilStatusController.dispose();
    _otherEthnicityController.dispose();
    _tipoDiscapacidadController.dispose();
    _porcentajeDiscapacidadController.dispose();
    _carnetDiscapacidadController.dispose();
    _otherOcupacionController.dispose();
    _parroquiaController.dispose();
    _barrioController.dispose();
    _calle1Controller.dispose();
    _calle2Controller.dispose();
    _otherGenderController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _claveController.dispose();
    _confirmarClaveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Registro de Usuario', 
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<void>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !_dataLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const WelcomeLogo(),
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

                    // Personal Information Section
                    _buildSectionTitle('Información Personal'),
                    
                    _buildDropdownField(
                      'Tipo de Documento de Identidad',
                      Icons.credit_card,
                      ['Cédula Ecuatoriana', 'Cédula Extranjera'],
                      (value) {
                        if (value != null) {
                          setState(() => _selectedDocumentType = value);
                        }
                      },
                      _selectedDocumentType,
                    ),
                    
                    _buildTextField(
                      'Número de ${_selectedDocumentType}',
                      Icons.person_outline,
                      hintText: 'Ingrese su número de documento',
                      controller: _cedulaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su número de documento';
                        }
                        return null;
                      },
                    ),
                    
                    _buildTextField(
                      'Nombres', 
                      Icons.person, 
                      hintText: 'Ingrese sus nombres completos',
                      controller: _nombreController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese sus nombres';
                        }
                        return null;
                      },
                    ),
                    
                    _buildTextField(
                      'Apellidos', 
                      Icons.people, 
                      hintText: 'Ingrese sus apellidos completos',
                      controller: _apellidoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese sus apellidos';
                        }
                        return null;
                      },
                    ),
                    
                    _buildDateField(
                      'Fecha de Nacimiento', 
                      Icons.calendar_today,
                      controller: _fechaNacimientoController,
                    ),
                    
                    _buildDropdownField(
                      'Estado Civil', 
                      Icons.favorite_border, 
                      ['Soltero/a', 'Casado/a', 'Viudo/a', 'Divorciado/a', 'Unión de hecho', 'Otro'],
                      (value) {
                        setState(() => _selectedCivilStatus = value);
                      },
                      _selectedCivilStatus,
                    ),
                    
                    if (_selectedCivilStatus == 'Otro')
                      _buildTextField(
                        'Especifique su estado civil', 
                        Icons.edit, 
                        hintText: 'Describa su estado civil',
                        controller: _otherCivilStatusController,
                      ),
                    
                    _buildDropdownField(
                      'Etnia', 
                      Icons.public, 
                      ['Indígena', 'Mestiza', 'Afro Ecuatoriana', 'Blanca', 'Otro'],
                      (value) {
                        setState(() => _selectedEthnicity = value);
                      },
                      _selectedEthnicity,
                    ),
                    
                    if (_selectedEthnicity == 'Otro')
                      _buildTextField(
                        'Especifique su Etnia', 
                        Icons.edit, 
                        hintText: 'Describa su etnia',
                        controller: _otherEthnicityController,
                      ),
                    
                    _buildDropdownField(
                      '¿Tiene alguna discapacidad?', 
                      Icons.accessible, 
                      ['Sí', 'No'],
                      (value) {
                        if (value != null) {
                          setState(() => _selectedDisability = value);
                        }
                      },
                      _selectedDisability,
                    ),
                    
                    if (_selectedDisability == 'Sí') ...[
                      _buildTextField(
                        'Tipo de discapacidad', 
                        Icons.accessibility_new, 
                        hintText: 'Especifique el tipo de discapacidad',
                        controller: _tipoDiscapacidadController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor especifique el tipo de discapacidad';
                          }
                          return null;
                        },
                      ),
                      
                      _buildTextField(
                        'Porcentaje de discapacidad', 
                        Icons.percent, 
                        hintText: 'Ingrese el porcentaje (0-100)',
                        controller: _porcentajeDiscapacidadController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el porcentaje';
                          }
                          final porcentaje = int.tryParse(value);
                          if (porcentaje == null || porcentaje < 0 || porcentaje > 100) {
                            return 'Por favor ingrese un porcentaje válido (0-100)';
                          }
                          return null;
                        },
                      ),
                      
                      _buildTextField(
                        'Número de Carnet CONADIS', 
                        Icons.card_membership, 
                        hintText: 'Ingrese el número de su carnet',
                        controller: _carnetDiscapacidadController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el número de carnet';
                          }
                          return null;
                        },
                      ),
                    ],
                    
                    _buildDropdownField(
                      'Ocupación Actual', 
                      Icons.work, 
                      ['Sin Empleo', 'Ama de casa', 'Estudiante', 'Empleado privado', 'Servidor Público', 'Artesano', 'Jornalero', 'Emprendedor', 'Jubilado', 'Otro'],
                      (value) {
                        setState(() => _selectedOccupation = value);
                      },
                      _selectedOccupation,
                    ),
                    
                    if (_selectedOccupation == 'Otro')
                      _buildTextField(
                        'Especifique su ocupación', 
                        Icons.edit, 
                        hintText: 'Describa su ocupación actual',
                        controller: _otherOcupacionController,
                      ),
                    
                    _buildDropdownField(
                      'Género', 
                      Icons.wc, 
                      ['Masculino', 'Femenino', 'No binario', 'Prefiero no decir', 'Otro'],
                      (value) {
                        setState(() => _selectedGender = value);
                      },
                      _selectedGender,
                    ),
                    
                    if (_selectedGender == 'Otro')
                      _buildTextField(
                        'Especifique su género', 
                        Icons.edit, 
                        hintText: 'Describa su identidad de género',
                        controller: _otherGenderController,
                      ),
                    
                    _buildDropdownField(
                      'Nivel de Educación', 
                      Icons.school, 
                      ['Educación básica', 'Bachillerato', 'Técnico/Tecnológico', 'Tercer Nivel (Grado)', 'Cuarto Nivel (Posgrado)', 'Ninguno'],
                      (value) {
                        setState(() => _selectedEducationLevel = value);
                      },
                      _selectedEducationLevel,
                    ),

                    // Información de Ubicación
                    _buildSectionTitle('Información de Ubicación'),

                    // Dropdown for Nacionalidad
                    _buildDataDropdown(
                      label: 'Nacionalidad',
                      icon: Icons.flag,
                      items: nacionalidades,
                      valueKey: 'id',
                      textKey: 'nombre',
                      value: _selectedNacionalidadId,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedNacionalidadId = value;
                          });
                        }
                      },
                    ),

                    // Dropdown for Provincia
                    _buildDataDropdown(
                      label: 'Provincia de Residencia',
                      icon: Icons.location_city,
                      items: provincias,
                      valueKey: 'id',
                      textKey: 'nombre',
                      value: _selectedProvinciaId,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedProvinciaId = value;
                            
                            // Try to select a valid city for this province
                            final filteredCities = ciudades.where((c) => 
                              c['provincia_id'] != null && c['provincia_id'] == value
                            ).toList();
                            
                            if (filteredCities.isNotEmpty) {
                              _selectedCiudadId = filteredCities[0]['id'] ?? _selectedCiudadId;
                            }
                          });
                        }
                      },
                    ),

                    // Dropdown for Ciudad
                    _buildDataDropdown(
                      label: 'Ciudad',
                      icon: Icons.location_on,
                      items: _getFilteredCities(),
                      valueKey: 'id',
                      textKey: 'nombre',
                      value: _selectedCiudadId,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCiudadId = value;
                          });
                        }
                      },
                    ),
                    
                    _buildTextField(
                      'Parroquia', 
                      Icons.place, 
                      hintText: 'Ingrese el nombre de su parroquia',
                      controller: _parroquiaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el nombre de su parroquia';
                        }
                        return null;
                      },
                    ),
                    
                    _buildTextField(
                      'Barrio', 
                      Icons.home, 
                      hintText: 'Ingrese el nombre de su barrio',
                      controller: _barrioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el nombre de su barrio';
                        }
                        return null;
                      },
                    ),
                    
                    _buildTextField(
                      'Calle Principal', 
                      Icons.add_road, 
                      hintText: 'Nombre de la calle principal',
                      controller: _calle1Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el nombre de la calle principal';
                        }
                        return null;
                      },
                    ),
                    
                    _buildTextField(
                      'Calle Secundaria', 
                      Icons.add_road, 
                      hintText: 'Nombre de la calle secundaria (opcional)',
                      controller: _calle2Controller,
                    ),

                    // Contact Information Section
                    _buildSectionTitle('Información de Contacto'),
                    
                    _buildTextField(
                      'Correo Electrónico', 
                      Icons.email, 
                      hintText: 'ejemplo@correo.com',
                      controller: _correoController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su correo electrónico';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Por favor ingrese un correo electrónico válido';
                        }
                        return null;
                      },
                    ),
                    
                    _buildTextField(
                      'Número de Celular', 
                      Icons.phone, 
                      hintText: '09XXXXXXXX',
                      controller: _telefonoController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su número de celular';
                        }
                        if (value.length < 10) {
                          return 'El número debe tener al menos 10 dígitos';
                        }
                        return null;
                      },
                    ),
                    
                    _buildPasswordField(
                      'Contraseña', 
                      Icons.lock, 
                      hintText: 'Mínimo 8 caracteres',
                      controller: _claveController,
                    ),
                    
                    _buildPasswordField(
                      'Confirmar Contraseña', 
                      Icons.lock, 
                      isConfirmPassword: true, 
                      hintText: 'Repita su contraseña',
                      controller: _confirmarClaveController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirme su contraseña';
                        }
                        if (value != _claveController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    _buildTermsAndConditions(),
                    const SizedBox(height: 24),
                    
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: _isLoading 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('COMPLETAR REGISTRO', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          );
        },
      ),
    );
  }

  // Helper method to get filtered cities based on province
  List<Map<String, dynamic>> _getFilteredCities() {
    if (ciudades.isEmpty) {
      return [];
    }
    
    final filtered = ciudades.where((c) => 
      c['provincia_id'] != null && c['provincia_id'] == _selectedProvinciaId
    ).toList();
    
    return filtered.isNotEmpty ? filtered : ciudades;
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label, IconData icon, List<String> items, ValueChanged<String?> onChanged, String? selectedValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Por favor seleccione una opción' : null,
      ),
    );
  }

  Widget _buildDataDropdown({
    required String label,
    required IconData icon,
    required List<Map<String, dynamic>> items,
    required String valueKey,
    required String textKey,
    required int value,
    required ValueChanged<int?> onChanged,
  }) {
    // If items is empty, return a disabled text field instead
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: 'Cargando datos...',
          ),
          enabled: false,
        ),
      );
    }
    
    // Create a list of valid IDs from the items
    final List<int> validIds = items
        .where((item) => item[valueKey] != null)
        .map<int>((item) => item[valueKey])
        .toList();
    
    // Check if the current value is valid
    final bool valueExists = validIds.contains(value);
    final int defaultValue = validIds.isNotEmpty ? validIds[0] : 1;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        value: valueExists ? value : defaultValue,
        items: items.where((item) => item[valueKey] != null).map((Map<String, dynamic> item) {
          return DropdownMenuItem<int>(
            value: item[valueKey],
            child: Text(item[textKey] ?? 'Sin nombre'),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextField(
    String label, 
    IconData icon, 
    {
      String? hintText,
      TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator,
    }
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: validator ?? ((value) => value == null || value.isEmpty ? 'Por favor ingrese $label' : null),
      ),
    );
  }

  Widget _buildDateField(
    String label, 
    IconData icon,
    {
      required TextEditingController controller,
    }
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: _selectedDate == null 
              ? 'Seleccione una fecha'
              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
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
      initialDate: _selectedDate ?? DateTime(DateTime.now().year - 18),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fechaNacimientoController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  Widget _buildPasswordField(
    String label, 
    IconData icon, 
    {
      bool isConfirmPassword = false, 
      String? hintText,
      required TextEditingController controller,
      String? Function(String?)? validator,
    }
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isConfirmPassword ? !_isConfirmPasswordVisible : !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: Icon(
              isConfirmPassword
                  ? (_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off)
                  : (_isPasswordVisible ? Icons.visibility : Icons.visibility_off)
            ),
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
        validator: validator ?? ((value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su contraseña';
          } else if (value.length < 8) {
            return 'La contraseña debe tener al menos 8 caracteres';
          }
          return null;
        }),
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

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        // Get values for dropdown fields
        final String ecivil = _selectedCivilStatus == 'Otro' 
            ? _otherCivilStatusController.text 
            : _selectedCivilStatus ?? '';
            
        final String etnia = _selectedEthnicity == 'Otro'
            ? _otherEthnicityController.text
            : _selectedEthnicity ?? '';
            
        final String discapacidad = _selectedDisability;
        
        final String ocupacion = _selectedOccupation == 'Otro'
            ? _otherOcupacionController.text
            : _selectedOccupation ?? '';
            
        final String genero = _selectedGender == 'Otro'
            ? _otherGenderController.text
            : _selectedGender ?? '';
        
        // Call API
        final response = await registroModel.registrarUsuario(
          cedula: _cedulaController.text,
          tipoced: _selectedDocumentType == 'Cédula Ecuatoriana' ? 1 : 2,
          nombre: _nombreController.text,
          apellido: _apellidoController.text,
          fechaNacimiento: _fechaNacimientoController.text,
          ecivil: ecivil,
          etnia: etnia,
          discapacidad: discapacidad,
          tipodis: discapacidad == 'Sí' ? _tipoDiscapacidadController.text : '',
          porcentajedis: discapacidad == 'Sí' ? int.tryParse(_porcentajeDiscapacidadController.text) ?? 0 : 0,
          ncarnetdis: discapacidad == 'Sí' ? _carnetDiscapacidadController.text : '',
          ocupacion: ocupacion,
          nacionalidad: _selectedNacionalidadId,
          ciudad: _selectedCiudadId,
          provincia: _selectedProvinciaId,
          parroquia: _parroquiaController.text,
          barrio: _barrioController.text,
          calle1: _calle1Controller.text,
          calle2: _calle2Controller.text,
          neducacion: _selectedEducationLevel ?? '',
          genero: genero,
          correo: _correoController.text,
          telefono: _telefonoController.text,
          clave: _claveController.text,
          check_terminos: _acceptTerms,
        );

        if (response['estado']) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registro completado exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${response['mensaje']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error en el registro: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe aceptar los términos y condiciones'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}

// Placeholder for WelcomeLogo widget - implement this or replace with Image.asset
class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(60),
        ),
        child: const Center(
          child: Text(
            'ACE 7',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}