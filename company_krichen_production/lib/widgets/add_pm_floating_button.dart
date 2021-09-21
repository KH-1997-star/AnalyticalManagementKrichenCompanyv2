import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/utils/consts.dart';
import 'package:flutter/material.dart';

class AddPrimaryMaterialsFloatingButton extends StatefulWidget {
  @override
  _AddPrimaryMaterialsFloatingButtonState createState() =>
      _AddPrimaryMaterialsFloatingButtonState();
}

class _AddPrimaryMaterialsFloatingButtonState
    extends State<AddPrimaryMaterialsFloatingButton> {
  final _formKey = GlobalKey<FormState>();
  String ref = '', fournisseur = '', type = '', img = '', unity = '';
  double quantity = 0, price = 0, poids = 0, prixV;

  List listItem = ['kg', 'L'];
  @override
  void initState() {
    super.initState();
    unity = listItem[0];
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'ht4',
      child: Icon(Icons.add),
      onPressed: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('Ajouter matière premiére'),
                  content: Text(
                    'veuillez remplir les donées de nouvelle matière premiére.',
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
                              onChanged: (val) => ref = val,
                              validator: (val) => val.isEmpty
                                  ? 'référence ne peut pas etre vide'
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'référence',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (val) =>
                                        quantity = pointConverter(val),
                                    validator: (val) => val.isEmpty
                                        ? 'quantité ne peut pas etre vide'
                                        : null,
                                    decoration: InputDecoration(
                                      hintText: 'quantité en kg ou litrage',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                DropdownButton(
                                  value: unity,
                                  onChanged: (value) {
                                    setState(() {
                                      unity = value;
                                    });
                                  },
                                  items: listItem.map((valueItem) {
                                    return DropdownMenuItem(
                                      child: Text(valueItem),
                                      value: valueItem,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            TextFormField(
                              onChanged: (val) => fournisseur = val,
                              decoration: InputDecoration(
                                hintText: 'fournisseur',
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (val) => price = pointConverter(val),
                              validator: (val) => val.isEmpty
                                  ? 'prix ne peut pas etre vide'
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'prix d\'achat par kg/l',
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (val) => prixV = pointConverter(val),
                              validator: (val) => val.isEmpty
                                  ? 'prix ne peut pas etre vide'
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'prix de vente par kg/l',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  UserData().addPrimaryMaterials(ref, quantity,
                                      fournisseur, img, price, unity, prixV);

                                  Navigator.pop(context);
                                  setState(() {});
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
      },
    );
  }
}
