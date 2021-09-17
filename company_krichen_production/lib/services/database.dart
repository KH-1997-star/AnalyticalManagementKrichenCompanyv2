import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:company_krichen_production/models/user.dart';

class UserData {
  final String cin;
  final String id;
  UserData({this.cin, this.id});
  CollectionReference users = FirebaseFirestore.instance.collection('users'),
      primaryMaterials =
          FirebaseFirestore.instance.collection('primaryMaterials'),
      pf = FirebaseFirestore.instance.collection('finalProducts');

  Future addUser(cin, name, lastName) async {
    await users.doc(cin).set({
      'name': name,
      'lastName': lastName,
      'userPic': null,
      'searchKey': name.toString().substring(0, 1),
    });
  }

  Future addPrimaryMaterials(
      ref, quantity, fournisseur, img, price, poids, unity) async {
    await primaryMaterials.doc().set({
      'currency': 'dt',
      'reference': ref,
      'quantity': quantity * poids,
      'fournisseur': fournisseur,
      'image': img ?? '',
      'weight': poids,
      'price': price,
      'unity': unity,
      'clicked': false,
    });
  }

  Future addFinalProduct( Map ingQuantity) async {
    await pf.doc().set({'ingredients': ingQuantity});
  }

  Future deleteUser(cin) async {
    await users.doc(cin).delete();
  }

  Future upDateProp(prop, val) async {
    await users.doc(cin).update({
      prop: val,
    });
  }

  Future updatePmProp(prop, val) async {
    await primaryMaterials.doc(id).update({
      prop: val,
    });
  }

  Future queryFromUpdatePm(prop, val, id) async {
    await primaryMaterials.doc(id).update({
      prop: val,
    });
  }

  Future addQuantity(weight, quantity) async {
    await primaryMaterials.doc(id).update({
      'quantity': FieldValue.increment(weight * quantity),
    });
  }

  Future removeQuantity(weight, quantity) async {
    await primaryMaterials.doc(id).update({
      'quantity': FieldValue.increment(-(weight * quantity)),
    });
  }

  Future deletePmDoc() async {
    await primaryMaterials.doc(id).delete();
  }

  Future unselectAll() async {
    var querySnapshots = await primaryMaterials.get();

    for (var doc in querySnapshots.docs) {
      if (doc['clicked']) {
        await doc.reference.update({
          'clicked': false,
        });
      }
    }
    return querySnapshots;
  }

  List<UserInfo> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInfo(
        name: doc['name'] ?? '',
        lastName: doc['lastName'] ?? '',
        id: doc.id ?? '',
        userPic: doc['userPic'],
      );
    }).toList();
  }

  Stream<List<UserInfo>> get checkusers {
    return users.snapshots().map(_userListFromSnapshot);
  }

  Stream<QuerySnapshot> get pm => primaryMaterials.snapshots();
}
