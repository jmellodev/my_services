import 'package:flutter/material.dart';

import 'package:my_services/constants/app_themes.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
    this.text = 'Ou',
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(
              child: Divider(
            color: AppThemes.nevada,
            thickness: 0.4,
          )),
          const SizedBox(
            width: 8,
          ),
          Text(text!),
          const SizedBox(
            width: 8,
          ),
          const Expanded(
              child: Divider(
            color: AppThemes.nevada,
            thickness: 0.4,
          ))
        ],
      ),
    );
  }
}
