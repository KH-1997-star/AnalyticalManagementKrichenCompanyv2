import 'package:company_krichen_production/models/final_product.dart';
import 'package:company_krichen_production/widgets/add_pf_floating_button.dart';
import 'package:company_krichen_production/widgets/articles_widget.dart';
import 'package:company_krichen_production/widgets/wiating_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProduitFini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pf = Provider.of<List<FinalProduct>>(context);

    return pf == null
        ? WaitingData()
        : Scaffold(
            appBar: AppBar(
              title: Text('Produit Fini'),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: GridView.count(
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
                      })),
                ),
              ],
            ),
            floatingActionButton: AddProduitFini(),
          );
  }
}
