import 'package:flutter/material.dart';

class ObscureText extends StatefulWidget {
  final VoidCallback obscureText;
  ObscureText({this.obscureText});
  @override
  _ObscureTextState createState() => _ObscureTextState();
}

class _ObscureTextState extends State<ObscureText> {
  Icon hide = Icon(Icons.visibility_off_rounded);
  Icon visible = Icon(Icons.remove_red_eye);
  bool visiblity = false;

  @override
  Widget build(BuildContext context) {
    List<Icon> myIcons = [hide, visible];
    int x = visiblity ? 1 : 0;
    return IconButton(
        color: Colors.blueGrey,
        onPressed: () {
          widget.obscureText();
          setState(() {
            visiblity = !visiblity;
          });
        },
        icon: myIcons[x]);
  }
}
