import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
     
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/authentif');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SpinKitFadingGrid(
          color: Colors.white,
          size: 150,
        ),
      ),
    );
  }
}
