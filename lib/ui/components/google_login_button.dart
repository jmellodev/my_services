import 'package:flutter/material.dart';

import 'package:my_services/controllers/auth_controller.dart';

class GoogleLoginButton extends StatelessWidget {
  final String buttonText;
  final double borderRadius;
  final String? type;

  const GoogleLoginButton(
      {Key? key, required this.buttonText, this.borderRadius = 20.0, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        AuthController().signInWithGoogle(type);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      icon: Image.asset(
        'assets/images/google_logo.png',
        height: 24.0,
        width: 24.0,
      ),
      label: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
