import 'package:flutter/material.dart';

import 'articles_widget.dart';

class NormalGridView extends StatelessWidget {
  final List pf;
  NormalGridView({this.pf});

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
        children: List.generate(pf.length, (index) {
          return ArticleWidget(
            index: index,
          );
        }));
  }
}
