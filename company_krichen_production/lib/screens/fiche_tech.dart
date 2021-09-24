import 'package:company_krichen_production/models/final_product.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/utils/alert.dart';
import 'package:company_krichen_production/utils/consts.dart';
import 'package:company_krichen_production/utils/take_photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FicheTechArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = ModalRoute.of(context).settings.arguments;
    int myIndex = data['index'];
    final pf = Provider.of<List<FinalProduct>>(context);
    List ingredientslList = [];
    if (pf != null) ingredientslList = pf[myIndex].ingredients['quantity'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Fiche Technique D\'article'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  pf[myIndex].article,
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
                    id: pf[myIndex].id,
                    collection: 'finalProducts',
                    anyWidget: pf[myIndex].image == null
                        ? Image.asset('assets/images/camera.png')
                        : Image.network(pf[myIndex].image),
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
                Text('Quantité crée par mélange : ${pf[myIndex].litre} L'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                    'Cout par litre : ${(pf[myIndex].cout / pf[myIndex].litre)} L'),
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
                        fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                  Text(
                    'quantité',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueGrey),
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
                          Text(pf[myIndex].ingredients['reference'][index]),
                          Text(pf[myIndex]
                                  .ingredients['quantity'][index]
                                  .toString() +
                              ' ' +
                              pf[myIndex].ingredients['unity'][index])
                        ]),
                      ],
                    ),
                  );
                },
                itemCount: ingredientslList.length,
              ),
            ),
            TextButton(
                onPressed: () {
                  melangeChanger(pf, myIndex, ingredientslList.length, context);
                },
                child: Text('crée un melange'))
          ],
        ),
      ),
    );
  }
}
