import 'package:company_krichen_production/models/user.dart';
import 'package:company_krichen_production/utils/alert.dart';
import 'package:company_krichen_production/utils/footer.dart';
import 'package:company_krichen_production/widgets/obscure_text.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer_view.dart';
import 'package:provider/provider.dart';

class Authentification extends StatefulWidget {
  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  
  bool hidden = true, allowed = false;
  String cin = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserInfo>>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Authentification'),
      ),
      body: Form(
        key: formKey,
        child: FooterView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 25,
              ),
              child: Column(
                children: [
                  Text(
                    'écrire votre carte d\'identité s\'il vous plait',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value.isEmpty ? 'cin non écrit' : null,
                      onChanged: (val) => cin = val,
                      maxLength: 8,
                      obscureText: hidden,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.perm_identity_rounded),
                        suffixIcon: ObscureText(
                          obscureText: () {
                            setState(() {
                              hidden = !hidden;
                            });
                          },
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 200,
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          users.forEach((user) {
                            if (user.id == cin) {
                              Navigator.pushNamed(context, '/menu', arguments: {
                                'name': user.name,
                                'lastName': user.lastName,
                                'cin': user.id,
                                'userPic': user.userPic,
                              });

                              setState(() {
                                allowed = true;
                              });
                            }
                          });
                          if (allowed == false) {
                            return alertShow(
                              context,
                              'Impossible d\'entrer',
                              'votre cin : $cin n\'a pas l\'autorisation pour entrer',
                            );
                          }
                        }
                      },
                      child: Text(
                        'conexion',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          footer: myFooter,
          flex: 4,
        ),
      ),
    );
  }
}
