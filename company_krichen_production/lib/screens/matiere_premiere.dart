import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/widgets/add_pm_floating_button.dart';
import 'package:company_krichen_production/widgets/material_row_floating_button.dart';
import 'package:company_krichen_production/widgets/primary_material_row.dart';
import 'package:company_krichen_production/widgets/primary_material_pic.dart';
import 'package:company_krichen_production/widgets/wiating_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriamryMaterials extends StatefulWidget {
  @override
  _PriamryMaterialsState createState() => _PriamryMaterialsState();
}

class _PriamryMaterialsState extends State<PriamryMaterials> {
  @override
  Widget build(BuildContext context) {
    final pm = Provider.of<QuerySnapshot>(context);

    return pm != null
        ? Scaffold(
            appBar: AppBar(
                title: Text('Matière Première'),
                leading: IconButton(
                  onPressed: () =>
                      Navigator.popUntil(context, ModalRoute.withName('/menu')),
                  icon: Icon(Icons.keyboard_return_outlined),
                )),
            body: GridView.count(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              childAspectRatio: 0.4,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              crossAxisCount: 2,
              children: List.generate(pm.size, (index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2.0,
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      children: [
                        MaterialPrimaryPic(
                          index: index,
                          id: pm.docs[index].id,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        PrimaryMaterialRow(
                          id: pm.docs[index].id,
                          index: index,
                          str: 'REF',
                          prop: 'reference',
                        ),
                        PrimaryMaterialRow(
                          id: pm.docs[index].id,
                          index: index,
                          str: 'PA',
                          prop: 'price',
                          unity: pm.docs[index]['currency'],
                        ),
                        PrimaryMaterialRow(
                          id: pm.docs[index].id,
                          index: index,
                          str: 'PV',
                          prop: 'prix de vente',
                          unity: pm.docs[index]['currency'],
                        ),
                        PrimaryMaterialRow(
                          id: pm.docs[index].id,
                          index: index,
                          str: 'QT',
                          prop: 'quantity',
                          unity: pm.docs[index]['unity'],
                        ),
                        PrimaryMaterialRow(
                          id: pm.docs[index].id,
                          index: index,
                          str: 'FRN',
                          prop: 'fournisseur',
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RowFloatingButtons(
                          index: index,
                          id: pm.docs[index].id,
                          quantity: pm.docs[index]['quantity'],
                        ),
                        WillPopScope(
                            child: Text(''),
                            onWillPop: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/menu'));
                              return null;
                            }),
                      ],
                    ),
                  )),
                );
              }),
            ),
            floatingActionButton: AddPrimaryMaterialsFloatingButton(),
          )
        : WaitingData();
  }
}
