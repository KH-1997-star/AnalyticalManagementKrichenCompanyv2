import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/utils/consts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pm = Provider.of<QuerySnapshot>(context);
    final formKey = GlobalKey<FormState>();
    List snapshotsList = [];
    List selectedItems = [],
        refList = [],
        quantityList = [],
        idList = [],
        priceList = [],
        unityList = [];
    String nomArticle = '';
    double cout = 0;
    double litre = 0;

    pm.docs.forEach((doc) {
      if (doc['clicked']) {
        selectedItems.add(doc);
        snapshotsList.add(doc.id);
        int len = selectedItems.length;
        idList.add(doc.id);
        priceList.add(doc['price']);
        unityList.add(doc['unity']);
        refList.length = len;
        quantityList.length = len;
      }
    });
    print(snapshotsList);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.keyboard_return_outlined),
        onPressed: () => Navigator.popUntil(
          context,
          ModalRoute.withName('/produit_fini'),
        ),
      )),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Text(
                'veuillez remplir ses matières premieres en kg ou en litre',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  validator: (val) => val.isEmpty
                      ? 'nom d\'article ne peut pas etre vide'
                      : null,
                  onChanged: (val) => nomArticle = val,
                  decoration: InputDecoration(hintText: 'nom d\'article'),
                )),
            SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    String erreur;
                    if (val.isEmpty) {
                      erreur = 'ce champ ne peut pas etre vide';
                    } else if (val.contains('-')) {
                      erreur = 'ce champ ne peut pas etre negatif';
                    }
                    return erreur;
                  },
                  onChanged: (val) => litre = pointConverter(val),
                  decoration: InputDecoration(hintText: 'litrage totales'),
                )),
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  refList[index] = selectedItems[index]['reference'];

                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: SizedBox(
                            width: 200,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                quantityList[index] = pointConverter(val);
                                if (quantityList[index] != null) {}
                              },
                              validator: (val) {
                                String erreur;
                                if (val.isEmpty) {
                                  erreur = 'ce champ ne peut pas etre vide';
                                } else if (val.contains('-')) {
                                  erreur = 'ce champ ne peut pas etre negatif';
                                }
                                return erreur;
                              },
                              decoration: InputDecoration(
                                hintText:
                                    '${selectedItems[index]['reference']} en ${selectedItems[index]['unity']}',
                              ),
                            ),
                          )),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () async {
          if (formKey.currentState.validate()) {
            Map myIngredients = {
              'reference': refList,
              'quantity': quantityList,
              'unity': unityList,
            };

            for (int i = 0; i < selectedItems.length; i++) {
              cout += priceList[i] * quantityList[i];
            }

            await UserData().addFinalProduct(
                myIngredients, nomArticle, cout, litre, snapshotsList);

            Navigator.popUntil(
              context,
              ModalRoute.withName('/produit_fini'),
            );
          }
        },
      ),
    );
  }
}
