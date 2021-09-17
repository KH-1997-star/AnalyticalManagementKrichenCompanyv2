import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimaryMaterialRow extends StatefulWidget {
  final String id;
  final String str;
  final prop;
  final String unity;
  final int index;
  PrimaryMaterialRow({this.id, this.str, this.prop, this.unity, this.index});

  @override
  _PrimaryMaterialRowState createState() => _PrimaryMaterialRowState();
}

class _PrimaryMaterialRowState extends State<PrimaryMaterialRow> {
  @override
  Widget build(BuildContext context) {
    final pm = Provider.of<QuerySnapshot>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Text(
            '${widget.str} : ',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(pm.docs[widget.index][widget.prop].toString()),
          ),
          widget.unity == 'L' ? Text(' L') : Text(''),
          widget.unity == 'kg' ? Text(' kg') : Text(''),
          widget.unity == 'dt' ? Text(' dt') : Text(''),
        ],
      ),
    );
  }
}
