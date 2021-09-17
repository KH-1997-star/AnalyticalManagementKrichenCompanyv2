import 'package:company_krichen_production/models/user.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/widgets/add_user_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GererUser extends StatefulWidget {
  @override
  _GererUserState createState() => _GererUserState();
}

class _GererUserState extends State<GererUser> {
  @override
  Widget build(BuildContext context) {
    UserData userData = UserData();
    final users = Provider.of<List<UserInfo>>(context);
    List<UserInfo> usersExcept = [];
    if (users != null) {
      users.forEach((user) {
        if (user.id != '11404764') {
          usersExcept.add(user);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gérer Utilisateur'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: usersExcept[index].userPic == null
                    ? AssetImage('assets/images/user.png')
                    : NetworkImage(usersExcept[index].userPic),
              ),
              title: Text(
                usersExcept[index].name + ' ' + usersExcept[index].lastName,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    userData.deleteUser(usersExcept[index].id);
                  });
                },
              ),
            ),
          );
        },
        itemCount: usersExcept.length,
      ),
      floatingActionButton: AddUserFloatingButton(),
    );
  }
}
