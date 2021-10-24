import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/models/final_product.dart';
import 'package:company_krichen_production/utils/consts.dart';
import 'package:company_krichen_production/widgets/log_out_button.dart';
import 'package:company_krichen_production/widgets/my_caroussel.dart';
import 'package:company_krichen_production/widgets/my_circulart_chart.dart';
import 'package:company_krichen_production/widgets/my_drawer.dart';
import 'package:company_krichen_production/widgets/red_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool removed = false;

   
  @override
  

  Widget build(BuildContext context) {
    Map data = {};

    data = ModalRoute.of(context).settings.arguments;
    final pm = Provider.of<QuerySnapshot>(context);
    final pf = Provider.of<List<FinalProduct>>(context);

    List<String> refMin = [];
    String strProblem = '';

    insufficientReference(
      pm,
      refMin,
    );
    strProblem = problemStr(refMin, strProblem);
    if (removed == true) {
      Timer(
          (Duration(seconds: 10)),
          () => setState(() {
                removed = false;
              }));
    }

    return Scaffold(
      drawer: MyDrawer(
        name: data['name'],
        lastName: data['lastName'],
        cin: data['cin'],
        userPic: data['userPic'],
      ),
      appBar: AppBar(
        title: Text('Société Krichene'),
        actions: [
          LogOutButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'vente et création',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'de produits d\'entretiens',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                MyCircularChart(
                  pf: pf,
                ),
                !removed && refMin.isNotEmpty
                    ? RedAlert(
                        onRemoved: () => setState(() {
                          removed = true;
                        }),
                        strProblem: strProblem,
                      )
                    : Text(''),
              ],
            ),
            Expanded(child: MyCaroussel()),
          ],
        ),
      ),
    );
  }
}
