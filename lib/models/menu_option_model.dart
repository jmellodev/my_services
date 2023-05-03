// Model class to hold menu option data (language and theme)
import 'package:flutter/material.dart';

class MenuOptionsModel {
  final String key;
  final String value;
  final IconData? icon;

  MenuOptionsModel({required this.key, required this.value, this.icon});
}
