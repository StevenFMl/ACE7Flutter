// restore_pass_model.dart
class RestorePassModel {
  final String cedula;
  final String token;

  RestorePassModel({required this.cedula, required this.token});

  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'token': token,
    };
  }
}