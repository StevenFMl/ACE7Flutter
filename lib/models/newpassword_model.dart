class NewPasswordModel {
  final String token;
  final String newPassword;

  NewPasswordModel({required this.token, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'newPassword': newPassword,
    };
  }
}