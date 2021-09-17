import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/models/Ingredients.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/utils/consts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pm = Provider.of<QuerySnapshot>(context);
    List<Ingredients> myNumbers = [];
    final formKey = GlobalKey<FormState>();

    List selectedItems = [];
    List refList = [];
    List valueList = [];

    pm.docs.forEach((doc) {
      if (doc['clicked']) {
        selectedItems.add(doc);
        int len = selectedItems.length;
        refList.length = len;
        valueList.length = len;
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
                                List myVal = val.split('');

                                valueList[index] = pointConverter(myVal);
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
            for (int i = 0; i < valueList.length; i++) {
              await myNumbers.add(
                Ingredients(
                  reference: refList[i],
                  quantity: valueList[i],
                ),
              );
            }
            Map myIngredients = {
              'ingredients': refList,
              'quantity': valueList,
            };
            UserData().addFinalProduct(myIngredients);
            print(myIngredients);
          }
        },
      ),
    );
  }
}
