import 'package:company_krichen_production/widgets/add_pf_floating_button.dart';
import 'package:flutter/material.dart';

class ProduitFini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produit Fini'),
      ),
      floatingActionButton: AddProduitFini(),
    );
  }
}
