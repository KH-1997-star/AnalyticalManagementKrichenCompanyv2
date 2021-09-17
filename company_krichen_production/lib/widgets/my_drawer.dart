import 'package:company_krichen_production/widgets/circle_picture.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String name, lastName, cin, userPic;
  MyDrawer({this.name, this.lastName, this.cin, this.userPic});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.brown[50],
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(name),
                accountEmail: Text(lastName),
                currentAccountPicture: CirclePic(
                  cin: cin,
                  radius: 20,
                  userPic: userPic,
                )),
            cin == '11404764'
                ? ListTile(
                    leading: Icon(Icons.build_circle_rounded),
                    title: Text('gérer utilisateur'),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/gerer_user',
                    ),
                  )
                : SizedBox(),
            ListTile(
              leading: Icon(Icons.category_sharp),
              title: Text('matière première'),
              onTap: () => Navigator.pushNamed(
                context,
                '/matiere_premiere',
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_rounded),
              title: Text('produit fini'),
              onTap: () => Navigator.pushNamed(
                context,
                '/produit_fini',
              ),
            )
          ],
        ),
      ),
    );
  }
}
