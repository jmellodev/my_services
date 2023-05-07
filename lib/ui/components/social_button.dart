import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:my_services/controllers/login_controller.dart';

enum SocialLoginButtonType { facebook, google, github, twitter }

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.controller,
    required this.onTap,
    this.icon,
    required this.buttonType,
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
  });

  final LoginController controller;
  final VoidCallback? onTap;
  final Widget? icon;
  final SocialLoginButtonType buttonType;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    Color? backgroundColor;
    switch (buttonType) {
      case SocialLoginButtonType.facebook:
        icon = const Icon(
          Icons.facebook,
          size: 30,
        );
        backgroundColor = const Color(0xFF334D92);
        break;
      case SocialLoginButtonType.google:
        icon = const Image(
          image: AssetImage("assets/images/google_logo.png"),
          height: 25.0,
        );
        backgroundColor = Colors.white;
        break;
      case SocialLoginButtonType.github:
        backgroundColor = const Color(0xFF444444);
        break;
      case SocialLoginButtonType.twitter:
        backgroundColor = const Color.fromARGB(255, 0, 183, 255);
        break;
    }
    return Obx(
      () {
        return InkWell(
          onTap: controller.isLoading ? null : onTap,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: controller.isLoading
                  ? BorderRadius.circular(50.0)
                  : BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 6.0,
                  color: Colors.black12,
                )
              ],
            ),
            child: controller.isLoading
                ? const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  )
                : icon,
          ),
        );
      },
    );
  }
}
