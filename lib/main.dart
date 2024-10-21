import 'package:flutter/material.dart';
import 'helpers/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACE7',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRoutes.generateRoute,  // Usamos las rutas
      initialRoute: '/welcome',
    );
  }
}