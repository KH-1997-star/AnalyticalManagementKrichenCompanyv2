import 'package:company_krichen_production/utils/consts.dart';
import 'package:company_krichen_production/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Menu extends StatelessWidget {
  @override
  Map data = {};
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      drawer: MyDrawer(
        name: data['name'],
        lastName: data['lastName'],
        cin: data['cin'],
        userPic: data['userPic'],
      ),
      appBar: AppBar(
        title: Text('Société Krichene'),
        actions: [
          myLogOutButton(context),
        ],
      ),
      body: Center(
        child: Text(''),
      ),
    );
  }
}
