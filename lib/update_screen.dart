import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateScreen extends StatefulWidget {
  var name, father, cgpa, cnic, uni;
  String datakey;

  UpdateScreen(
      {required this.name,
      required this.father,
      required this.cgpa,
      required this.cnic,
      required this.uni,
      required this.datakey});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController? nameController;
  TextEditingController? fatherController;
  TextEditingController? cgpaController;
  TextEditingController? cnicController;
  TextEditingController? uniContoller;
  final refernce=FirebaseFirestore.instance.collection('Users');
  var id=DateTime.now().millisecondsSinceEpoch.toString();
  var Name,Father,Cnic,Cgpa,Uni;

  int counter=0;
  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    fatherController = TextEditingController(text: widget.father);
    cgpaController = TextEditingController(text: widget.cgpa);
    cnicController = TextEditingController(text: widget.cnic);
    uniContoller = TextEditingController(text: widget.uni);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text('Name'),
                      hintText: 'Enter Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: fatherController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text('Father'),
                      hintText: 'Father Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller:cnicController,
                  keyboardType: TextInputType.number,
                  maxLength: 13,
                  decoration: InputDecoration(
                      label: Text('CNIC'),
                      hintText: 'Enter CNIC',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: cgpaController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                      label: Text('CGPA or MARKS'),
                      hintText: 'Enter CGPA',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: uniContoller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text('UNI OR COLLEGE'),
                      hintText: 'UNI OR COLLEGE',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor:Colors.orange),
                  onPressed: (){
                  setState(() {
                    Name=nameController!.text.toString();
                    Father=fatherController!.text.toString();
                    Cgpa=cgpaController!.text.toString();
                    Cnic=cgpaController!.text.toString();
                    Uni=uniContoller!.text.toString();



                  });
                  refernce.doc('${widget.datakey}').update({
                    'name':Name,
                    'father':Father,
                    'cgpa':Cgpa,
                    'cnic':Cnic,
                    'uni':Uni,
                  }).then((value){
                    Fluttertoast.showToast(msg: 'Data Updated Successfully',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    gravity: ToastGravity.BOTTOM);

                  }).onError((error, stackTrace){
                    Fluttertoast.showToast(msg: error.toString(),
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        gravity: ToastGravity.BOTTOM);

                  });

              }, child: Text('Update Data')),
            ],
          ),
        ),
      ),
    );
  }
}
