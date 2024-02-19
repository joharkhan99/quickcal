import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            child: Text('Settings'),
          ),
          const PopupMenuItem(
            child: Text('About'),
          ),
        ];
      },
      tooltip: 'Menu',
      offset: const Offset(0, 40),
    );
  }
}
