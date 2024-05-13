import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_crud/fetch_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final ref = FirebaseFirestore.instance.collection('Images');
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  final refernce = FirebaseStorage.instance.ref('/image');

  ImagePicker imagepicker = ImagePicker();
  XFile? imagefile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                  child: imagefile != null
                      ? Image.file(
                          File(imagefile!.path),
                          height: 200,
                          width: 200,
                          fit: BoxFit.fill,
                        )
                      : Text('No Image Found')),
            ),
          ),
          GestureDetector(
              onTap: () async {
                final pickedimage =
                    await imagepicker.pickImage(source: ImageSource.gallery);
                if (pickedimage == null) {
                  print('No Image Selected');
                } else {
                  setState(() {
                    imagefile = pickedimage;
                  });
                }
              },
              child: Icon(Icons.image)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () async {
                setState(() {});
                if (imagefile == null) {
                  Fluttertoast.showToast(
                      msg: 'No Image Found to be Uploaded',
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
                } else {
                  UploadTask uploadTask =
                      refernce.putFile(File(imagefile!.path));
                  await Future.value(uploadTask);
                  var url = await refernce.getDownloadURL();
                  ref.doc('$id').set({'url': url}).then((value) {
                    Fluttertoast.showToast(
                        msg: 'Image Uploaded Successfully',
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                  }).onError((error, stackTrace) {
                    Fluttertoast.showToast(
                        msg: error.toString(),
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white);
                  });
                }
              },
              child: Text(
                'Upload Image to Firebase',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> FetchScreen()));
          }, child: Text('Fetch Image')),
        ],
      ),
    );
  }
}
