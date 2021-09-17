import 'package:company_krichen_production/services/database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangeMaterialProperty extends StatelessWidget {
  Map data = {};
  var newVal;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    print(data);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 200,
          horizontal: 50,
        ),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  Text(data['txt']),
                  SizedBox(
                      width: 500,
                      child: TextFormField(
                        keyboardType: data['type'] == 'number'
                            ? TextInputType.number
                            : TextInputType.text,
                        onChanged: (val) {
                          data['type'] == 'number'
                              ? newVal = double.parse(val)
                              : newVal = val;
                        },
                        validator: (val) =>
                            val.isEmpty ? 'valeur non donner' : null,
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        await UserData(id: data['id'])
                            .updatePmProp(data['prop'], newVal);
                        Navigator.popUntil(
                            context, ModalRoute.withName('/matiere_premiere'));
                      }
                    },
                    icon: Icon(Icons.check),
                    label: Text('valider'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
