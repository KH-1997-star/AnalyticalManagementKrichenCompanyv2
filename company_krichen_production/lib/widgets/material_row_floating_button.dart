import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/utils/alert.dart';
import 'package:company_krichen_production/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RowFloatingButtons extends StatefulWidget {
  final double quantity;
  final int index;
  final String id;
  RowFloatingButtons({this.quantity, this.id, this.index});
  @override
  _RowFloatingButtonsState createState() => _RowFloatingButtonsState();
}

class _RowFloatingButtonsState extends State<RowFloatingButtons> {
  @override
  Widget build(BuildContext context) {
    double quantity = 0;
    final formKey = GlobalKey<FormState>();
    final pm = Provider.of<QuerySnapshot>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 50,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: 'btn${widget.index}',
              backgroundColor: Colors.green,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                          'Voullez vouz ? :',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/changer_material_property',
                                      arguments: {
                                        'txt': 'enter la nouvelle référence',
                                        'type': 'string',
                                        'prop': 'reference',
                                        'id': pm.docs[widget.index].id,
                                      }),
                                  icon: Icon(Icons.refresh),
                                  label: Flexible(
                                      child: Text('changer référence')),
                                ),
                                TextButton.icon(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/changer_material_property',
                                      arguments: {
                                        'txt':
                                            'enter le nouveaux prix d\'achat',
                                        'type': 'number',
                                        'prop': 'price',
                                        'id': pm.docs[widget.index].id,
                                      }),
                                  icon: Icon(Icons.monetization_on_sharp),
                                  label: Flexible(
                                      child: Text('changer prix d\'achat')),
                                ),
                                TextButton.icon(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/changer_material_property',
                                      arguments: {
                                        'txt':
                                            'enter le nouveaux prix de vente',
                                        'type': 'number',
                                        'prop': 'prix de vente',
                                        'id': pm.docs[widget.index].id,
                                      }),
                                  icon: Icon(Icons.monetization_on_outlined),
                                  label: Flexible(
                                      child: Text('changer prix de vente')),
                                ),
                                TextButton.icon(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/changer_material_property',
                                      arguments: {
                                        'txt': 'enter la quantité totale',
                                        'type': 'number',
                                        'prop': 'quantity',
                                        'id': pm.docs[widget.index].id,
                                      }),
                                  icon: Icon(Icons.all_inclusive_rounded),
                                  label: Flexible(
                                      child: Text('changer Quantité total')),
                                ),
                                TextButton.icon(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/changer_material_property',
                                      arguments: {
                                        'txt': 'enter le nouveaux fournisseur',
                                        'type': 'string',
                                        'prop': 'fournisseur',
                                        'id': pm.docs[widget.index].id,
                                      }),
                                  icon: Icon(Icons.shopping_cart_outlined),
                                  label: Flexible(
                                      child: Text('changer fournisseur')),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    alertShow(context, 'Attention',
                                        'êtes-vous sûr de supprimer cet matière première',
                                        () async {
                                      await UserData(id: widget.id)
                                          .deletePmDoc();

                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete_outlined,
                                    color: Colors.red,
                                  ),
                                  label: Flexible(
                                    child: Text(
                                      'suprimmer matière première',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    });
              },
              child: Icon(
                Icons.settings,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          height: 40,
          width: 50,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: 'btn1${widget.index}',
              backgroundColor: Colors.red,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                          'veuillez remplir la quantité à vendre',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) =>
                                      quantity = pointConverter(val),
                                  validator: (val) => val.isEmpty
                                      ? 'quantité ne peut pas etre vide'
                                      : null,
                                  decoration:
                                      InputDecoration(hintText: 'quantité'),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        await UserData(id: widget.id)
                                            .changeQuantity(-quantity);
                                        Navigator.pushNamed(
                                            context, '/matiere_premiere');
                                      }
                                    },
                                    child: Text(
                                      'vendre',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      );
                    });
              },
              child: Icon(Icons.remove_circle),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          height: 40,
          width: 50,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: 'btn2${widget.index}',
              backgroundColor: Colors.blue,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                          'veuillez remplir la quantité à ajouter',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) =>
                                      quantity = pointConverter(val),
                                  validator: (val) => val.isEmpty
                                      ? 'quantité ne peut pas etre vide'
                                      : null,
                                  decoration:
                                      InputDecoration(hintText: 'quantité'),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        await UserData(id: widget.id)
                                            .changeQuantity(quantity);
                                        Navigator.pushNamed(
                                            context, '/matiere_premiere');
                                      }
                                    },
                                    child: Text(
                                      'ajouter',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      );
                    });
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
