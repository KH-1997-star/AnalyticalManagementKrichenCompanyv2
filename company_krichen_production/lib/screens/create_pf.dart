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
    List selectedItems = [],
        refList = [],
        quantityList = [],
        idList = [],
        priceList = [];
    String nomArticle = '';
    double cout = 0;

    pm.docs.forEach((doc) {
      if (doc['clicked']) {
        selectedItems.add(doc);
        int len = selectedItems.length;
        idList.add(doc.id);
        priceList.add(doc['price']);
        refList.length = len;
        quantityList.length = len;
      }
    });

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
                              validator: (val) => val.isEmpty
                                  ? 'ce champ ne peut pas etre vmaide'
                                  : null,
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
            };

            for (int i = 0; i < selectedItems.length; i++) {
              await UserData(id: idList[i]).changeQuantity(-quantityList[i]);
              cout += priceList[i] * quantityList[i];
            }
            await UserData().addFinalProduct(myIngredients, nomArticle, cout);
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
