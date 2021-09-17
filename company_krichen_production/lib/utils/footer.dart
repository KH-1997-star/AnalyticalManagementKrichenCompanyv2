import 'package:flutter/material.dart';
import 'package:footer/footer.dart';

Footer myFooter = Footer(
  backgroundColor: Colors.brown[50],
  child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        'Par :',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      SizedBox(
        height: 7,
      ),
      Text(
        'Société Krichene',
        style: TextStyle(
          color: Colors.brown[300],
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ],
  ),
);
