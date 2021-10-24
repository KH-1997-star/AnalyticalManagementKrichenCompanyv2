import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:flutter/material.dart';

class NormalListView extends StatelessWidget {
  final QuerySnapshot pm;
  NormalListView({this.pm});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: pm.docs.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                onTap: () {
                  UserData(id: pm.docs[index].id)
                      .updatePmProp('clicked', !pm.docs[index]['clicked']);
                },
                leading: pm.docs[index]['clicked']
                    ? Icon(
                        Icons.done_all_rounded,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.add_circle_outline_rounded,
                      ),
                title: Text(pm.docs[index]['reference'])),
          );
        });
  }
}
