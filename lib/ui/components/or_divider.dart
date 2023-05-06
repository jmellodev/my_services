import 'package:flutter/material.dart';

import 'package:my_services/constants/app_themes.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Divider(
            color: AppThemes.nevada,
            thickness: 0.4,
          )),
          SizedBox(
            width: 8,
          ),
          Text('Ou'),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Divider(
            color: AppThemes.nevada,
            thickness: 0.4,
          ))
        ],
      ),
    );
  }
}
