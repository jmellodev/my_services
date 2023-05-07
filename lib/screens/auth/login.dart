import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:my_services/controllers/login_controller.dart';
import 'package:my_services/ui/components/or_divider.dart';
import 'package:my_services/ui/components/social_button.dart';

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
                      decoration: const InputDecoration(
                        filled: true,
                        label: Text('E-mail'),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 12, 12),
                      ),
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
                    Obx(
                      () {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            label: const Text('Senha'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(
                          buttonType: SocialLoginButtonType.google,
                          controller: controller,
                          onTap: () => controller.loginWithGoogle(),
                        ),
                        const SizedBox(width: 20),
                        SocialButton(
                          buttonType: SocialLoginButtonType.facebook,
                          controller: controller,
                          onTap: () => controller.loginWithFacebook(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Esqueceu a senha?'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => Get.toNamed('/register'),
                      icon: const Icon(Icons.person_add_alt_outlined),
                      label: const Text('Registre-se'),
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
