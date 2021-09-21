import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_krichen_production/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'circular_load.dart';

// ignore: must_be_immutable
class MaterialPrimaryPic extends StatefulWidget {
  int index;
  String id;

  MaterialPrimaryPic({
    this.index,
    this.id,
  });
  @override
  _CirclePicState createState() => _CirclePicState();
}

class _CirclePicState extends State<MaterialPrimaryPic> {
  PickedFile imageFile;
  String imageUrl = '';
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    final pm = Provider.of<QuerySnapshot>(context);
    return downloading
        ? SizedBox(
            height: 80,
            width: 100,
            child: Container(
              color: Colors.black,
              child: CircularLoad(),
            ),
          )
        : GestureDetector(
            onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (builder) => bottomSheet(),
                ),
            child: SizedBox(
              height: 120,
              width: 150,
              child: pm != null
                  ? pm.docs[widget.index]['image'] == ''
                      ? Image.asset('assets/images/camera.png')
                      : Image.network(pm.docs[widget.index]['image'])
                  : Text('loading data please wait...'),
            ));
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Text(
            'changer votre photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              TextButton.icon(
                  onPressed: () async => takePhoto(ImageSource.gallery),
                  icon: Icon(Icons.image),
                  label: Text('Galerie'))
            ],
          )
        ],
      ),
    );
  }

  takePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    imageFile = pickedImage;

    if (pickedImage != null) {
      var file = File(pickedImage.path);
      Navigator.pop(context);
      setState(() {
        downloading = true;
      });
      var snapshot = await FirebaseStorage.instance
          .ref(widget.id)
          .child(file.path)
          .putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });

      await UserData(id: widget.id)
          .updatePmProp('image', downloadUrl)
          .then((value) => setState(() {
                downloading = false;
              }));
    } else {
      print('no path recived');
      return null;
    }
  }
}
