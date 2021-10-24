import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/models/final_product.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/utils/alert.dart';
import 'package:flutter/material.dart';

mySearchingFunction(QuerySnapshot pm, String val, List searchingList,
    List indexList, String prop,
    [List clickedList]) {
  for (var doc in pm.docs) {
    if (doc[prop].toString().toUpperCase().contains(val.toUpperCase()) &&
        !searchingList.contains(doc[prop])) {
      searchingList.add(doc[prop]);
      indexList.add(doc.id);
      clickedList.add(doc['clicked']);
    } else {
      searchingList.remove(doc[prop]);
      indexList.remove(doc.id);
      clickedList.remove(doc['clicked']);
    }
  }
}

myFinalProductSearchingFunction(
  List<FinalProduct> pm,
  String val,
  List searchingList,
  List indexList,
  List imageList,
  List coutList,
  List currencyList,
) {
  for (var doc in pm) {
    if (doc.article.toString().toUpperCase().contains(val.toUpperCase()) &&
        !searchingList.contains(doc.article)) {
      searchingList.add(doc.article);
      indexList.add(doc.id);
      imageList.add(doc.image);
      coutList.add(doc.cout);
      currencyList.add(doc.currency);
    } else {
      searchingList.remove(doc.article);
      indexList.remove(doc.id);
    }
  }
  print(searchingList);
  print(indexList);
}

double pointConverter(String val) {
  List l = val.split('');
  for (int i = 0; i < l.length; i += 1) {
    if (l[i] == ',') {
      l[i] = '.';
    }
  }
  return double.parse(l.join());
}

void melangeChanger(
    doc, pmList, int len, context, List<String> alertList, id) async {
  String str = '';
  for (int i = 0; i < len; i += 1) {
    await UserData().checkQuantity(
        pmList[i]['reference'], alertList, doc['ingredients']['quantity'][i]);
  }
  if (alertList.isEmpty) {
    for (int i = 0; i < len; i += 1) {
      UserData().queryDataByFiled(
          pmList[i]['reference'], -doc['ingredients']['quantity'][i]);
    }
  } else {
    for (int i = 0; i < alertList.length; i += 1) {
      str += '\n ${alertList[i]}';
    }
  }

  if (str == '') {
    Navigator.pop(context);
    alertShow(context, 'Notice', 'votre melange est crée avec succeé');
    UserData(id: id).addMelange();
  } else {
    alertShow(context, 'Attention', str);
  }
}

void insufficientReference(
  QuerySnapshot pm,
  List<String> refMin,
) {
  if (pm != null) {
    pm.docs.forEach((element) {
      if (element['quantity'] <= element['minQuantity'])
        refMin.add(element['reference']);
    });
  }
}

String problemStr(List<String> refMin, String strProblem) {
  if (refMin.length == 1) {
    strProblem = 'l\'ingrédient ${refMin[0]} est insufissant !';
  } else if (refMin.length > 0 && refMin.length != 1) {
    String allRef = '';
    for (int i = 0; i < refMin.length; i += 1) {
      allRef += ' ${refMin[i]}, ';
    }
    strProblem = 'les ingrédients $allRef sont insuffisants !';
  }
  return strProblem;
}
