import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firestore_crud/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';
import 'package:firebase_database/firebase_database.dart';

class FethScreen extends StatefulWidget {
  const FethScreen({super.key});

  @override
  State<FethScreen> createState() => _FethScreenState();
}

class _FethScreenState extends State<FethScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final refernce = FirebaseFirestore.instance.collection('Users').snapshots();
  var id = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: refernce,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                Center(child: Text('Error:${snapshot.error}'));
              }
              final documents = snapshot.data!.docs;
              return Expanded(
                child: ListView.separated(
                    itemBuilder: (context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.deepPurple),
                        child: Column(
                          children: [


                            Row(
                              children: [

                                Text(
                                  'Name: ${snapshot.data!.docs[index]['name'].toString()}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      var cgpa = snapshot
                                          .data!.docs[index]['cgpa']
                                          .toString();
                                      var name = snapshot
                                          .data!.docs[index]['name']
                                          .toString();
                                      var father = snapshot
                                          .data!.docs[index]['father']
                                          .toString();
                                      var cnic = snapshot
                                          .data!.docs[index]['cnic']
                                          .toString();
                                      var uni = snapshot
                                          .data!.docs[index]['uni']
                                          .toString();
                                      String datakey = snapshot!
                                          .data!.docs[index]['id']
                                          .toString();


                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateScreen(
                                                      name: name,
                                                      father: father,
                                                      cgpa: cgpa,
                                                      cnic: cnic,
                                                      uni: uni,
                                                      datakey: datakey)));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Colors.green,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Father: ${snapshot.data!.docs[index]['father'].toString()}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are You Sure you want to Delete?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      ref
                                                          .doc(snapshot.data!
                                                                  .docs[index]
                                                              ['id'])
                                                          .delete()
                                                          .then((value) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Data Deleted Successfully',
                                                            backgroundColor:
                                                                Colors.green,
                                                            textColor:
                                                                Colors.white,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM);
                                                      }).onError((error,
                                                              stackTrace) {
                                                        Fluttertoast.showToast(
                                                            msg: error
                                                                .toString(),
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Yes')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('No'))
                                              ],
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'CNIC: ${snapshot.data!.docs[index]['cnic'].toString()}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Uni or clg: ${snapshot.data!.docs[index]['uni'].toString()}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'CGPA or Marks:${snapshot.data!.docs[index]['cgpa'].toString()}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 5,
                        thickness: 5,
                        color: Colors.black,
                      );
                    },
                    itemCount: documents.length),
              );
            },
          ))
        ],
      ),
    );
  }
}
