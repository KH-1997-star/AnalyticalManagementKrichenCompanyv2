import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/widgets/wiating_data_widget.dart';
import 'package:flutter/material.dart';

class SearchingListView extends StatelessWidget {
  final List indexList, searchingList, clickedList;
  SearchingListView({
    this.clickedList,
    this.indexList,
    this.searchingList,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchingList.length,
        itemBuilder: (context, index) {
          return StreamBuilder(   
            stream: FirebaseFirestore.instance
                .collection('primaryMaterials')
                .doc(indexList[index])
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return WaitingData();
              } else {
                var doc = snapshot.data;

                return Card(
                  child: ListTile(
                      onTap: () {
                        UserData().queryFromUpdatePm(
                            'clicked', !doc['clicked'], indexList[index]);
                      },
                      leading: doc['clicked']
                          ? Icon(
                              Icons.done_all_rounded,
                              color: Colors.green,
                            )
                          : Icon(Icons.add_circle_outline_rounded),
                      title: Text(searchingList[index])),
                );
              }
            },
          );
        });
  }
}
