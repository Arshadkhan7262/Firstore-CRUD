import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  final id =DateTime.now().millisecondsSinceEpoch.toString();
  final refernce=FirebaseFirestore.instance.collection('Images').snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: refernce,
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting)
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  if(snapshot.hasData)
                    {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                          String imageurl=snapshot.data!.docs[index]['url'].toString();
                        return Container(
                          height: 100,
                            width: 200,
                            child: Image.network(imageurl));
                      });
              
                    }
                  return Text('No Image Found');
              
              
              
                },
              ),
            )
        
        
          ],
        ),
      ),
    );
  }
}
