import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_services/controllers/auth_controller.dart';
import 'package:my_services/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userJson = box.read('user');
    if (userJson == null) {
      return const Scaffold(
        body: Center(
          child: Text('Usuário não encontrado'),
        ),
      );
    }
    final user = UserModel.fromJson(userJson);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoUrl ??
                  'https://lh3.googleusercontent.com/ogw/AOLn63FdGK0NuVHy3T6P0TjcFeSyyDvIjhq8NbeBmO4nMg=s32-c-mo'),
            ),
            const SizedBox(height: 16),
            Text(user.name ?? 'Sem nome',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(user.email ?? ''),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => AuthController.authInstance.signOut(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.exit_to_app),
                  Text('Sair'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
