import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pushReplacementNamed(context, '/authentif'),
      icon: Icon(
        Icons.logout,
        color: Colors.white,
      ),
    );
  }
}
