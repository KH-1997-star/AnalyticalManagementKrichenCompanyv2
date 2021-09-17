import 'package:company_krichen_production/services/database.dart';
import 'package:flutter/material.dart';

class AddUserFloatingButton extends StatefulWidget {
  @override
  _AddUserFloatingButtonState createState() => _AddUserFloatingButtonState();
}

class _AddUserFloatingButtonState extends State<AddUserFloatingButton> {
  final _formKey = GlobalKey<FormState>();
  String name = '', lastName = '', cin = '';

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ajouter Utilisateur'),
              content: Text(
                'veuillez remplir les donées de nouveau utilisateur.',
                textAlign: TextAlign.center,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (val) => name = val,
                          validator: (val) =>
                              val.isEmpty ? 'nom ne peut pas etre vide' : null,
                          decoration: InputDecoration(
                            hintText: 'nom',
                          ),
                        ),
                        TextFormField(
                          onChanged: (val) => lastName = val,
                          validator: (val) => val.isEmpty
                              ? 'prénom ne peut pas etre vide'
                              : null,
                          decoration: InputDecoration(
                            hintText: 'prénom',
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          onChanged: (val) => cin = val,
                          validator: (val) =>
                              val.isEmpty ? 'cin ne peut pas etre vide' : null,
                          decoration: InputDecoration(
                            hintText: 'cin',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                UserData().addUser(cin, name, lastName);
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'ajouter',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
