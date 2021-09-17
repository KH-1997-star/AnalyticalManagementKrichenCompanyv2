import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyListRef extends StatelessWidget {
  final Function(List) onListChanged;
  List myList = [];
  MyListRef({this.onListChanged, this.myList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(title: Text(myList[index]['reference'])),
          );
        });
  }
}
