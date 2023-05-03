import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:my_services/controllers/auth_controller.dart';
import 'package:my_services/controllers/theme_controller.dart';
import 'package:my_services/models/menu_option_model.dart';
import 'package:my_services/ui/components/segmented_selector.dart';

class SettingsUI extends StatelessWidget {
  const SettingsUI({super.key});

  //final LanguageController languageController = LanguageController.to;
  //final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        themeListTile(context),
        ListTile(
            title: Text('settings.updateProfile'.tr),
            trailing: ElevatedButton(
              onPressed: () async {
                // Get.to(UpdateProfileUI());
              },
              child: const Text(
                'Atualizar perfil',
              ),
            )),
        ListTile(
          title: const Text('Sair'),
          trailing: ElevatedButton(
            onPressed: () {
              AuthController.authInstance.signOut();
            },
            child: const Text(
              'Sair',
            ),
          ),
        )
      ],
    );
  }

  themeListTile(BuildContext context) {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system", value: 'Sistema', icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light", value: 'Light', icon: Icons.brightness_low),
      MenuOptionsModel(key: "dark", value: 'Dark', icon: Icons.brightness_3)
    ];
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: const Text('Configurações'),
        trailing: SegmentedSelector(
          selectedOption: controller.currentTheme,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
