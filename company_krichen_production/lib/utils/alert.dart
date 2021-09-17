import 'package:flutter/material.dart';

alertShow(context, title, content, [action]) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            action != null
                ? TextButton(onPressed: action, child: Text('valider'))
                : Text(''),
            SizedBox(
              height: 100,
              width: 80,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Center(child: Text('return'))),
            )
          ],
        );
      });
}
