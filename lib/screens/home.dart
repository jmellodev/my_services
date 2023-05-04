import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:my_services/controllers/auth_controller.dart';
// import 'package:my_services/controllers/auth_controller.dart';
import 'package:my_services/controllers/home_controller.dart';
import 'package:my_services/models/user_model.dart';
import 'package:my_services/ui/settings_ui.dart';
import 'package:my_services/widgets/user_list_item.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuários'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SettingsUI());
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              _controller.toggleSelectAll;
            },
            icon: const Icon(Icons.select_all),
          ),
          IconButton(
            onPressed: () async {
              bool? confirm = await Get.dialog<bool>(
                AlertDialog(
                  title: const Text('Excluir usuários selecionados?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(result: false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Get.back(result: true),
                      child: const Text('Excluir'),
                    ),
                  ],
                ),
              );
              if (confirm!) {
                _controller.deleteSelected();
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: _controller.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return UserListItem(
                user: user,
                onSelect: () => _controller.toggleSelectUser(user),
                isSelected: _controller.selectedUsers.contains(user),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => _controller.addToCart(),
        onPressed: () => AuthController().signOut(),
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
