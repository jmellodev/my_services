import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_services/models/user_model.dart';
import 'package:my_services/screens/client/list_services.dart';

class UserListItem extends StatelessWidget {
  final UserModel user;
  final VoidCallback onSelect;
  final bool isSelected;

  const UserListItem(
      {super.key,
      required this.user,
      required this.onSelect,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(user.name![0].isEmpty ? 'N' : user.name![0]),
      ),
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Text(user.name!),
      ),
      subtitle: Text(user.email!),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (value) {
          onSelect();
        },
      ),
      onTap: () => Get.to(() => ServicesView(clientId: user.id)),
    );
  }
}
