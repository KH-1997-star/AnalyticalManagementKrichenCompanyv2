import 'package:flutter/material.dart';

class AddProduitFini extends StatefulWidget {
  @override
  _AddProduitFiniState createState() => _AddProduitFiniState();
}

class _AddProduitFiniState extends State<AddProduitFini> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/choice_pm'),
      child: Icon(Icons.add),
    );
  }
}
