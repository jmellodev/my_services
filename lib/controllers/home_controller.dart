import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_services/models/user_model.dart';
import 'package:my_services/constants/firebase_constants.dart';

class HomeController extends GetxController {
  // RxList<UserModel> userList = RxList<UserModel>([]);
  StreamSubscription<QuerySnapshot>? _subscription;
  final userList = <UserModel>[].obs;
  final selectedUsers = <UserModel>[].obs;
  final box = GetStorage();
  late final Map<String, dynamic> userJson;

  @override
  void onReady() {
    userJson = box.read('user');
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _subscription?.cancel();
  }

  Stream<List<UserModel>> getUsersStream() {
    return usersCollection
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot query) => query.docs.map((doc) {
              final data = doc.data();
              return UserModel.fromJson(data as Map<String, dynamic>);
            }).toList());
  }

  void loadUsers() async {
    try {
      final snapshot = await usersCollection.orderBy('name').get();

      final users =
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();

      userList.assignAll(users);
    } catch (e) {
      print(e);
    }
  }

  void toggleSelectAll(bool value) {
    selectedUsers.clear();
    if (value) {
      selectedUsers.addAll(userList);
    }
  }

  Future<UserModel?> toggleSelectUser(UserModel user) async {
    if (user.isSelected) {
      selectedUsers.add(user);
    } else {
      selectedUsers.remove(user);
    }
    return null;
  }

  Future<void> deleteUser(UserModel user) async {
    try {
      await usersCollection.doc(user.id).delete();
      Get.back(); // fechar o diálogo
      Get.snackbar('Usuário excluído', 'O usuário foi excluído com sucesso');
    } catch (e) {
      Get.back(); // fechar o diálogo
      Get.snackbar('Erro ao excluir usuário', e.toString());
    }
  }

  void deleteSelected() async {
    for (final user in selectedUsers) {
      await usersCollection.doc(user.id).delete();
    }
    selectedUsers.clear();
  }

  Future<void> deleteUsersWithName(String name) async {
    try {
      final QuerySnapshot snapshot =
          await usersCollection.where('name', isEqualTo: name).get();

      if (snapshot.docs.isEmpty) {
        Get.snackbar(
            'Usuários não encontrados', 'Não há usuários com este nome');
        return;
      }

      final List<UserModel> users = snapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromJson(data as Map<String, dynamic>);
      }).toList();

      final confirmed = await Get.defaultDialog<bool>(
        title: 'Confirmar exclusão',
        middleText: 'Deseja excluir os seguintes usuários?',
        content: Column(
          children: users.map((user) => Text(user.name!)).toList(),
        ),
        textConfirm: 'Excluir',
        textCancel: 'Cancelar',
        barrierDismissible: false,
      );

      if (confirmed != true) {
        return;
      }

      await Future.wait(users.map((user) async {
        await usersCollection.doc(user.id).delete();
      }));
      Get.snackbar(
          'Usuários excluídos', 'Os usuários foram excluídos com sucesso');
    } catch (e) {
      Get.snackbar('Erro ao excluir usuários', e.toString());
    }
  }

  Future<void> addToCart() async {
    final user = UserModel.fromJson(userJson);
    Map<String, dynamic> $data = {
      'clientId': user.id,
      'price': 7.23,
      'quantity': 2,
      'amount': 14.46
    };

    await usersCollection.doc(user.id).collection('carts').doc().set($data);
  }
}
