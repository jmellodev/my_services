import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:my_services/controllers/auth_controller.dart';

class LoginController extends GetxController {
  final authContoller = Get.put(AuthController());
  final RxBool _isPasswordObscure = true.obs;
  bool get isPasswordObscure => _isPasswordObscure.value;
  void togglePasswordObscure() =>
      _isPasswordObscure.value = !_isPasswordObscure.value;

  final RxString _accountType = 'tipo'.obs;
  String get accountType => _accountType.value;
  String setAccountType(String value) => _accountType.value = value;

  final RxString _email = ''.obs;
  String get email => _email.value;
  void setEmail(String value) => _email.value = value;

  final RxString _password = ''.obs;
  String get password => _password.value;
  void setPassword(String value) => _password.value = value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  void setLoading(bool value) => _isLoading.value = value;

  final RxBool _isError = false.obs;
  bool get isError => _isError.value;
  void setError(bool value) => _isError.value = value;

  void loginWithEmail() async {
    setLoading(true);
    setError(false);
    authContoller.login(email, password);
    setLoading(false);
  }

  void loginWithGoogle() async {
    setLoading(true);
    setError(false);
    authContoller.signInWithGoogle();
    setLoading(false);
  }

  void registerWithGoogle() async {
    setLoading(true);
    setError(false);
    if (accountType == 'tipo') {
      Get.snackbar(
        'Tipo de conta',
        'Escolha o tipo de conta',
        borderRadius: 0.0,
        colorText: Colors.white,
        backgroundColor: Get.theme.colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Adicione aqui a lógica de login com Google para prestadores
      authContoller.registerWithGoogle(accountType);
    }
    setLoading(false);
  }

  void loginWithFacebook() async {
    setLoading(true);
    setError(false);
    if (accountType == 'cliente') {
      // Adicione aqui a lógica de login com Facebook para clientes
    } else {
      // Adicione aqui a lógica de login com Facebook para prestadores
    }
    setLoading(false);
  }
}
