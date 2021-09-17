import 'dart:io';
import 'package:company_krichen_production/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'circular_load.dart';

// ignore: must_be_immutable
class CirclePic extends StatefulWidget {
  String cin, userPic;
  final double radius;

  CirclePic({
    this.cin,
    this.radius,
    this.userPic,
  });
  @override
  _CirclePicState createState() => _CirclePicState();
}

class _CirclePicState extends State<CirclePic> {
  PickedFile imageFile;
  String imageUrl = '';
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    
    return downloading
        ? CircleAvatar(
            radius: widget.radius,
            child: CircularLoad(),
            backgroundColor: Colors.black,
          )
        : GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (builder) => bottomSheet(),
            ),
            child: CircleAvatar(
              radius: widget.radius,
              backgroundImage: widget.userPic == null
                  ? AssetImage('assets/images/user.png')
                  : NetworkImage(
                      widget.userPic,
                    ),
              backgroundColor: Colors.white,
            ),
          );
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
          .ref(widget.cin)
          .child(file.path)
          .putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        widget.userPic = downloadUrl;
      });

      await UserData(cin: widget.cin)
          .upDateProp('userPic', downloadUrl)
          .then((value) => setState(() {
                downloading = false;
              }));
    } else {
      print('no path recived');
      return null;
    }
  }
}
