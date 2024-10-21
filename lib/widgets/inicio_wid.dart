import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WelcomeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        minimumSize: const Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'EMPEZAR',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}