import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:company_krichen_production/widgets/wiating_data_widget.dart';
import 'package:flutter/material.dart';

class SearchingGridView extends StatelessWidget {
  final List indexList, searchingList, imageList, coutList, currencyList;

  SearchingGridView(
      {this.searchingList,
      this.indexList,
      this.imageList,
      this.coutList,
      this.currencyList});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        childAspectRatio: 0.8,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        crossAxisCount: 2,
        children: List.generate(searchingList.length, (index) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('finalProducts')
                  .doc(indexList[index])
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return WaitingData();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, '/fiche_technique_article',
                          arguments: {
                            'id': indexList[index],
                          }),
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            width: 160,
                            child: imageList[index] == null
                                ? Image.asset(
                                    'assets/images/camera.png',
                                    scale: 20,
                                  )
                                : Image.network(imageList[index]),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, '/fiche_technique_article',
                                arguments: {
                                  'id': indexList[index],
                                }),
                            child: Text(
                              searchingList[index],
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              });
        }));
  }
}
