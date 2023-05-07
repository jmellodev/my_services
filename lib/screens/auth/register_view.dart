import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:my_services/controllers/auth_controller.dart';
import 'package:my_services/controllers/login_controller.dart';
import 'package:my_services/ui/components/or_divider.dart';
import 'package:my_services/ui/components/social_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  String _accountType = 'cliente';
  bool _passwordObscure = true;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final controller = Get.put(LoginController());

  void _handlePasswordObscure() {
    setState(() {
      _passwordObscure = !_passwordObscure;
    });
  }

  void _handleRegister(
      String name, String email, String password, String type) {
    if (_formKey.currentState!.validate()) {
      // Enviar dados de registro para o servidor
      AuthController.authInstance.register(name, email, password, type);
      debugPrint('Dados de registro enviados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail';
                    }
                    if (!value.contains('@')) {
                      return 'Por favor, insira um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _passwordObscure,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordObscure
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _handlePasswordObscure,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    /*  if (value.length < 8) {
                      return 'Sua senha deve ter pelo menos 8 caracteres';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Sua senha deve ter pelo menos uma letra maiúscula';
                    }
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return 'Sua senha deve ter pelo menos uma letra minúscula';
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Sua senha deve ter pelo menos um número';
                    } */
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: _passwordObscure,
                  decoration: InputDecoration(
                    labelText: 'Confirmar senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordObscure
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _handlePasswordObscure,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, confirme sua senha';
                    }
                    if (value != _passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sou um:'),
                    Obx(
                      () {
                        return DropdownButton(
                          value: controller.accountType,
                          onChanged: (value) =>
                              controller.setAccountType(value!),
                          items: const [
                            DropdownMenuItem(
                              value: 'tipo',
                              child: Text('Escolha'),
                            ),
                            DropdownMenuItem(
                              value: 'cliente',
                              child: Text('Cliente'),
                            ),
                            DropdownMenuItem(
                              value: 'prestador',
                              child: Text('Prestador'),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _handleRegister(
                    _nameController.text.trim(),
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    _accountType,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Registrar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const OrDivider(text: 'Ou registre-se com:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      buttonType: SocialLoginButtonType.google,
                      controller: controller,
                    ),
                    const SizedBox(width: 20),
                    SocialButton(
                      buttonType: SocialLoginButtonType.facebook,
                      controller: controller,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
