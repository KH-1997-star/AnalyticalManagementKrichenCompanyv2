import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/models/final_product.dart';
import 'package:company_krichen_production/models/user.dart';
import 'package:company_krichen_production/screens/authentification.dart';
import 'package:company_krichen_production/screens/change_material_property.dart';
import 'package:company_krichen_production/screens/choice_pm.dart';
import 'package:company_krichen_production/screens/create_pf.dart';
import 'package:company_krichen_production/screens/fiche_tech.dart';
import 'package:company_krichen_production/screens/gerer_utilisateur.dart';
import 'package:company_krichen_production/screens/loading.dart';
import 'package:company_krichen_production/screens/matiere_premiere.dart';
import 'package:company_krichen_production/screens/menu.dart';
import 'package:company_krichen_production/screens/problem_page.dart';
import 'package:company_krichen_production/screens/produit_fini.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:company_krichen_production/utils/my_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserData userData = UserData();
    return MultiProvider(
      providers: [
        StreamProvider<List<UserInfo>>.value(
          value: userData.checkusers,
          initialData: [],
        ),
        StreamProvider<QuerySnapshot>.value(
            value: userData.pm, initialData: null),
        StreamProvider<List<FinalProduct>>.value(
          value: userData.pf,
          initialData: [],
        ),
      ],
      child: MaterialApp(
        theme: myThemeData,
        title: 'SOCIETE KRICHENE PRODUCTION',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/authentif': (context) => Authentification(),
          '/menu': (context) => Menu(),
          '/gerer_user': (context) => GererUser(),
          '/matiere_premiere': (context) => PriamryMaterials(),
          '/changer_material_property': (context) => ChangeMaterialProperty(),
          '/produit_fini': (context) => ProduitFini(),
          '/choice_pm': (context) => ChoicePM(),
          '/create_pf': (context) => CreatePF(),
          '/fiche_technique_article': (context) => FicheTechArticle(),
          '/problem_page': (context) => ProblemPage(),
        },
      ),
    );
  }
}
