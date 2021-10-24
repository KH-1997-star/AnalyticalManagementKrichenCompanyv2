import 'package:flutter/material.dart';

class RedAlert extends StatelessWidget {
  VoidCallback onRemoved;
  String strProblem;
  RedAlert({this.onRemoved, this.strProblem});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        color: Colors.red,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      onRemoved();
                    },
                    icon: Icon(Icons.dangerous)),
              ],
            ),
            Center(
                child: Text(
              strProblem,
              style: TextStyle(fontSize: 20),
            )),
          ],
        ),
      ),
    );
  }
}
