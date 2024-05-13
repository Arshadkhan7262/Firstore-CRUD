import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firestore_crud/image_screen.dart';

import 'fetch.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDpF7GM6S4tUN3e9BxIaUDgqOQl1Ab8XWM',
          appId: '1:908130638391:android:e47fb8a9f9a51f35f73db2',
          messagingSenderId: '908130638391',
          projectId: 'firestorecrud-fd7e3',
      storageBucket: 'gs://firestorecrud-fd7e3.appspot.com'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formkey = GlobalKey<FormState>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final refernce = FirebaseFirestore.instance.collection('Users');

  TextEditingController nameController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController cnicContoller = TextEditingController();
  TextEditingController uniController = TextEditingController();
  TextEditingController cgpaController = TextEditingController();
  var Name, Father, Cnic, Uni, Cgpa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const Text(
                  'Firebase Firestore',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        label: const Text('Name'),
                        hintText: 'Enter  Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: fatherController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        label: const Text('Father Name'),
                        hintText: 'Enter Father Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Father Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: cnicContoller,
                    keyboardType: TextInputType.number,
                    maxLength: 13,
                    decoration: InputDecoration(
                        label: const Text('CNIC'),
                        hintText: 'Enter CNIC without dashes',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter CNIC';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: uniController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        label: const Text('University/College Name'),
                        hintText: 'Enter University or College Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Uni or College Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: cgpaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: const Text('CGPA/MARKS'),
                        hintText: 'Enter Cgpa or Marks',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter cgpa or marks';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        setState(() {
                          Name = nameController.text.toString();
                          Father = fatherController.text.toString();
                          Cnic = cnicContoller.text.toString();
                          Uni = uniController.text.toString();
                          Cgpa = cgpaController.text.toString();
                          var id=DateTime.now().millisecondsSinceEpoch.toString();
                          if (formkey.currentState!.validate()) {
                            refernce.doc(id).set({
                              'name': Name,
                              'father': Father,
                              'cnic': Cnic,
                              'uni': Uni,
                              'cgpa': Cgpa,
                              'id':id
                            }).then((value) {
                              Fluttertoast.showToast(
                                msg: 'Your Data Added to Firestore',
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                              );
                            }).onError((error, stackTrace) {
                              Fluttertoast.showToast(
                                msg: error.toString(),
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                              );
                            });
                          }
                        });
                      },
                      child: Text(
                        'Add to FireStore',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> FethScreen()));

                      },
                      child: const Text(
                        'Fetch from FireStore',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageScreen()));
                    }, child: Text('Image Fetch',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
