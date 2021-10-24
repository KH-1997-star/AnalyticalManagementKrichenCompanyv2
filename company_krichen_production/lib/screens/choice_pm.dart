import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/utils/consts.dart';
import 'package:company_krichen_production/widgets/norml_list_view.dart';
import 'package:company_krichen_production/widgets/searching_list_view.dart';
import 'package:company_krichen_production/widgets/wiating_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoicePM extends StatefulWidget {
  @override
  _ChoicePMState createState() => _ChoicePMState();
}

class _ChoicePMState extends State<ChoicePM> {
  bool searching = false, done = false;
  List listCounter = [];
  List searchingList = [], indexList = [];
  List clickedList = [];

  @override
  void initState() {
    super.initState();
    UserData().unselectAll().then((value) => setState(() {
          done = true;
        }));
  }

  Widget build(BuildContext context) {
    final pm = Provider.of<QuerySnapshot>(context);

    return pm == null || !done
        ? WaitingData()
        : Scaffold(
            appBar: AppBar(
              title: Text('Crée Produit Fini'),
              actions: [
                IconButton(
                  onPressed: () => setState(() {
                    searching = true;
                  }),
                  icon: Icon(Icons.search),
                )
              ],
            ),
            body: Column(
              children: [
                searching
                    ? TextField(
                        onChanged: (val) {
                          setState(() {
                            mySearchingFunction(
                              pm,
                              val,
                              searchingList,
                              indexList,
                              'reference',
                              clickedList,
                            );
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'searshing...',
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                searching = false;
                              }),
                              icon: Icon(Icons.cancel_outlined),
                            )),
                      )
                    : Text(''),
                Expanded(
                  child: !searchingList.isEmpty && searching
                      ? SearchingListView(
                          indexList: indexList,
                          searchingList: searchingList,
                          clickedList: clickedList,
                        )
                      : NormalListView(
                          pm: pm,
                        ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/create_pf',
                );
              },
              child: Text('crée'),
            ));
  }
}
