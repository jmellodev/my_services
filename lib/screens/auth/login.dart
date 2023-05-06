import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:my_services/controllers/auth_controller.dart';
import 'package:my_services/models/menu_option_model.dart';
import 'package:my_services/screens/auth/register_view.dart';
import 'package:my_services/ui/components/segmented_selector.dart';
/* 
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Crie controladores para os campos de entrada de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adicione um campo de texto para o e-mail
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              const SizedBox(height: 16.0),
              // Adicione um campo de texto para a senha
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 32.0),
              // Adicione um botão de login destacado
              ElevatedButton(
                onPressed: () {
                  // this is for the login function in auth controller
                  AuthController.authInstance.login(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              // Adicione um botão para fazer login usando a conta do Google
              OutlinedButton.icon(
                onPressed: () {
                  // Adicione a lógica para fazer login usando a conta do Google
                  AuthController.authInstance.signInWithGoogle();
                },
                icon: const Icon(Icons.login),
                label: const Text('Entrar com o Google'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  String _accountType = 'cliente';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleLogin() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // Realizar a autenticação do usuário aqui
      AuthController.authInstance.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      // e navegar para a próxima tela
      debugPrint('Autenticação do usuário...');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, corrija os erros no formulário'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                /* Image.asset(
                  'assets/images/julia_share.png',
                  height: 120,
                ), */
                const SizedBox(height: 20),
                const Text(
                  'Bem-vindo(a)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Digite seu e-mail',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, digite seu e-mail';
                    }
                    if (!value!.contains('@')) {
                      return 'Por favor, digite um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, digite sua senha';
                    }
                    if (value!.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Você é:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SegmentedSelector(
                    menuOptions: [
                      MenuOptionsModel(
                        key: "cliente",
                        value: "Cliente",
                        icon: Icons.person,
                      ),
                      MenuOptionsModel(
                        key: 'prestador',
                        value: 'Prestador',
                        icon: Icons.build_sharp,
                      )
                    ],
                    selectedOption: _accountType,
                    onValueChanged: (value) {
                      setState(() {
                        print(_accountType);
                        _accountType = value;
                      });
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.to(() => const RegisterView()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Registre-se'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navegar para a tela de recuperação de senha
                    debugPrint('Recuperação de senha...');
                  },
                  child: const Text('Esqueceu a senha?'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    if (_accountType == null) {
                      Get.snackbar('Tipo', 'Escolha o tipo de usuário.');
                    } else {
                      AuthController.authInstance
                          .signInWithGoogle(_accountType);
                    }
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar com o Google'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
