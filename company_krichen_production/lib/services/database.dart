import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/models/final_product.dart';

import 'package:company_krichen_production/models/user.dart';
import 'package:company_krichen_production/utils/alert.dart';
import 'package:flutter/material.dart';

class UserData {
  final String cin;
  final String id;
  UserData({this.cin, this.id});
  CollectionReference users = FirebaseFirestore.instance.collection('users'),
      primaryMaterials =
          FirebaseFirestore.instance.collection('primaryMaterials'),
      finalProduct = FirebaseFirestore.instance.collection('finalProducts');

  Future addUser(cin, name, lastName) async {
    await users.doc(cin).set({
      'name': name,
      'lastName': lastName,
      'userPic': null,
      'searchKey': name.toString().substring(0, 1),
    });
  }

  Future addPrimaryMaterials(
      ref, quantity, fournisseur, img, price, unity, prixV) async {
    await primaryMaterials.doc().set({
      'currency': 'dt',
      'reference': ref,
      'quantity': quantity,
      'fournisseur': fournisseur,
      'image': img ?? '',
      'price': price,
      'unity': unity,
      'clicked': false,
      'prix de vente': prixV,
    });
  }

  Future addFinalProduct(
      Map ingQuantity, String article, double cout, double litre) async {
    await finalProduct.doc().set({
      'ingredients': ingQuantity,
      'article': article,
      'cout': cout,
      'currency': 'dt',
      'image': null,
      'litre': litre,
      'melange': 0,
    });
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

  Future updateAnyProp(String collection, prop, val) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).update({
      prop: val,
    });
  }

  Future queryFromUpdatePm(prop, val, id) async {
    await primaryMaterials.doc(id).update({
      prop: val,
    });
  }

  Future changeQuantity(double quantity) async {
    await primaryMaterials.doc(id).update({
      'quantity': FieldValue.increment((quantity)),
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

  Future<QuerySnapshot> queryDataByFiled(
    val,
    quantity,
  ) async {
    String myId = '';
    await primaryMaterials
        .where('reference', isEqualTo: val)
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
              myId = element.id;
              UserData(id: myId).changeQuantity(quantity);
            }));
    return null;
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

  List<FinalProduct> _finalProductListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FinalProduct(
        article: doc['article'],
        cout: doc['cout'],
        currency: doc['currency'],
        ingredients: doc['ingredients'],
        image: doc['image'],
        litre: doc['litre'],
        id: doc.id,
      );
    }).toList();
  }

  Stream<List<UserInfo>> get checkusers {
    return users.snapshots().map(_userListFromSnapshot);
  }

  Stream<QuerySnapshot> get pm => primaryMaterials.snapshots();

  Stream<List<FinalProduct>> get pf =>
      finalProduct.snapshots().map(_finalProductListFromSnapshot);
}
