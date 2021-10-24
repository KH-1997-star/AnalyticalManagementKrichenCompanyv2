import 'package:company_krichen_production/models/final_product.dart';
import 'package:company_krichen_production/utils/consts.dart';
import 'package:company_krichen_production/widgets/add_pf_floating_button.dart';
import 'package:company_krichen_production/widgets/normal_grid_view.dart';
import 'package:company_krichen_production/widgets/searching_grid_view.dart';
import 'package:company_krichen_production/widgets/wiating_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProduitFini extends StatefulWidget {
  @override
  _ProduitFiniState createState() => _ProduitFiniState();
}

class _ProduitFiniState extends State<ProduitFini> {
  bool searching = false;
  List searchingList = [],
      indexList = [],
      imageList = [],
      coutList = [],
      currencyList = [];

  @override
  Widget build(BuildContext context) {
    final pf = Provider.of<List<FinalProduct>>(context);

    return pf == null
        ? WaitingData()
        : Scaffold(
            appBar: AppBar(
              title: Text('Produit Fini'),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        searching = !searching;
                      });
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
            body: Column(
              children: [
                searching
                    ? TextField(
                        onChanged: (val) {
                          setState(() {
                            myFinalProductSearchingFunction(
                                pf,
                                val,
                                searchingList,
                                indexList,
                                imageList,
                                coutList,
                                currencyList);
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'searshing...',
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                searching = false;
                              }),
                              icon: Icon(Icons.cancel_outlined),
                            )),
                      )
                    : Text(''),
                Expanded(
                  child: !searchingList.isEmpty && searching
                      ? SearchingGridView(
                          searchingList: searchingList,
                          indexList: indexList,
                          imageList: imageList,
                          coutList: coutList,
                          currencyList: currencyList,
                        )
                      : NormalGridView(
                          pf: pf,
                        ),
                ),
              ],
            ),
            floatingActionButton: AddProduitFini(),
          );
  }
}
