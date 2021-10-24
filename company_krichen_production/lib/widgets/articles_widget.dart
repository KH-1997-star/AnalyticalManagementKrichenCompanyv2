import 'package:company_krichen_production/models/final_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleWidget extends StatefulWidget {
  final int index;

  ArticleWidget({
    this.index,
  });

  @override
  _ArticleWidgetState createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  String userPic;

  bool downloading = false, searching = false;
  List searchingList = [], indexList = [];

  @override
  Widget build(BuildContext context) {
    final pf = Provider.of<List<FinalProduct>>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/fiche_technique_article',
            arguments: {
              'id': pf[widget.index].id,
            }),
        child: Column(
          children: [
            Container(
              height: 180,
              width: 160,
              child: pf[widget.index].image == null
                  ? Image.asset(
                      'assets/images/camera.png',
                      scale: 20,
                    )
                  : Image.network(pf[widget.index].image),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/fiche_technique_article',
                    arguments: {
                      'id': pf[widget.index].id,
                    });
              },
              child: Text(
                pf[widget.index].article,
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
}
