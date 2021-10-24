import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/models/final_product.dart';
import 'package:company_krichen_production/utils/consts.dart';
import 'package:company_krichen_production/utils/take_photo.dart';
import 'package:company_krichen_production/widgets/wiating_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FicheTechArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = ModalRoute.of(context).settings.arguments;
    final pm = Provider.of<QuerySnapshot>(context);
    final pf = Provider.of<List<FinalProduct>>(context);
    List myList = [];
    List pmList = [];
    print(data['id']);
    pf.forEach((element) {
      if (element.id == data['id']) {
        myList = element.idList;
      }
    });
    print(myList);
    for (int i = 0; i < pm.size; i += 1) {
      if (myList.contains(pm.docs[i].id)) {
        pmList.add(pm.docs[i]);
      }
    }
    double cout = 0;

    print(pmList[0]['reference']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Fiche Technique D\'article'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('finalProducts')
              .doc(data['id'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var doc = snapshot.data;

              List lenTab = doc['ingredients']['reference'];
              for (int i = 0; i < pmList.length; i += 1) {
                cout +=
                    (pmList[i]['price'] * doc['ingredients']['quantity'][i]);
              }

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          doc['article'],
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 150,
                          child: MyImagePicker(
                            id: data['id'],
                            collection: 'finalProducts',
                            anyWidget: doc['image'] == null
                                ? Image.asset('assets/images/camera.png')
                                : Image.network(doc['image']),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text('Quantité crée par mélange : ${doc['litre']} L'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                            'Cout par litre : ${(cout / doc['litre']).toStringAsFixed(3)} dt/l'),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Table(
                      children: [
                        TableRow(children: [
                          Text(
                            'ingrédients',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                          Text(
                            'quantité',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          )
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Table(
                              children: [
                                TableRow(children: [
                                  Text(pmList[index]['reference']),
                                  Text(doc['ingredients']['quantity'][index]
                                          .toString() +
                                      ' ' +
                                      doc['ingredients']['unity'][index])
                                ]),
                              ],
                            ),
                          );
                        },
                        itemCount: lenTab.length,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          List<String> alertList = [];

                          melangeChanger(doc, pmList, lenTab.length, context,
                              alertList, data['id']);
                        },
                        child: Text('crée un mélange'))
                  ],
                ),
              );
            } else {
              return WaitingData();
            }
          }),
    );
  }
}
