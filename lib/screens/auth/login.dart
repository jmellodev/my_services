import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:my_services/controllers/login_controller.dart';
import 'package:my_services/ui/components/or_divider.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 240.0,
                      child: Image.asset(
                        'assets/images/services.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(28, 20, 12, 12),
                          hintText: 'E-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white30),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          suffix: const Icon(Icons.email_outlined)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu email';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                      onChanged: controller.setEmail,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(28, 20, 12, 12),
                        hintText: 'Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white30),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: controller.togglePasswordObscure,
                        ),
                      ),
                      obscureText: controller.isPasswordObscure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        return null;
                      },
                      onChanged: controller.setPassword,
                    ),
                    const SizedBox(height: 20),
                    const Text('Tipo de conta'),
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
                    const SizedBox(height: 20),
                    Obx(
                      () => ElevatedButton.icon(
                        icon: controller.isLoading
                            ? const SizedBox.shrink()
                            : const Icon(Icons.email),
                        onPressed: controller.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  controller.loginWithEmail();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        label: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Entrar com Email'),
                      ),
                    ),
                    const OrDivider(),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: controller.isLoading
                          ? null
                          : () {
                              controller.loginWithGoogle();
                            },
                      icon: const Image(
                        image: AssetImage("assets/images/google_logo.png"),
                        height: 30.0,
                      ),
                      label: Text(
                        'Login com Google',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: controller.isLoading
                          ? null
                          : () {
                              controller.loginWithFacebook();
                            },
                      icon: const Icon(
                        Icons.facebook,
                        size: 30,
                      ),
                      label: const Text(
                        'Login com Facebook',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
