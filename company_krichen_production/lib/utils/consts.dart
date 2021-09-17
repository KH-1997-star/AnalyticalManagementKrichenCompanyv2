import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/widgets/wiating_data_widget.dart';
import 'package:flutter/material.dart';

IconButton myLogOutButton(context) {
  return IconButton(
    onPressed: () => Navigator.pushReplacementNamed(context, '/authentif'),
    icon: Icon(
      Icons.logout,
      color: Colors.white,
    ),
  );
}

String dinarFormatConverter(price) {
  List tab = price.toString().split('');
  int j = 1;
  for (var i = 0; i < tab.length; i++) {
    if (tab[i] != '.' && j == 4) {
      tab.insert(i, ' ');
      j = 0;
    }
    j++;
  }
  return tab.join('') + " dt";
}

Padding primaryMaterialsRow(int index, str, prop, id, propContent, [name]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    child: Row(
      children: [
        Text(
          '$str : ',
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: SizedBox(
          width: 100,
          height: 20,
          child: TextFormField(
            keyboardType:
                name != null ? TextInputType.number : TextInputType.name,
            onChanged: (val) {
              if (name != null) double.parse(val);
              UserData(id: id).updatePmProp(prop, val);
            },
            initialValue: propContent.toString(),
            decoration: InputDecoration(),
          ),
        )),
        name == 'kg' ? Text('kg') : Text(''),
        name == 'dt' ? Text('dt') : Text(''),
      ],
    ),
  );
}

Widget mySearchListView(
    List indexList, QuerySnapshot pm, List searchingList, List clickedList) {
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
              print('snapshot ' + doc['reference']);
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

Widget normalListView(QuerySnapshot pm) {
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

mySearchingFunction(QuerySnapshot pm, String val, List searchingList,
    List indexList, List clickedList) {
  for (var doc in pm.docs) {
    if (doc['reference'].toString().toUpperCase().contains(val.toUpperCase()) &&
        !searchingList.contains(doc['reference'])) {
      searchingList.add(doc['reference']);
      indexList.add(doc.id);
      clickedList.add(doc['clicked']);
    } else {
      searchingList.remove(doc['reference']);
      indexList.remove(doc.id);
      clickedList.remove(doc['clicked']);
    }
  }
}

double pointConverter(List l) {
  for (int i = 0; i < l.length; i += 1) {
    if (l[i] == ',') {
      l[i] = '.';
    }
  }
  return double.parse(l.join());
}
