import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Safe extends StatefulWidget {
  double lat;
  double long;
  Safe(this.lat,this.long);

  @override
  _SafeState createState() => _SafeState();
}

class _SafeState extends State<Safe> {

  var s = 'str';
  var count=0;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('locations').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          count=0;
          final docs = snapshot.data!.docs;
          for(var doc in docs){
            if(calculateDistance(widget.lat, widget.long , doc.get("lat"), doc.get("lon"))<2){
              count++;
            }
          }
          print(count);
          if(count>3){
            s="Safe Area";
          }else{
            s="Unsafe Area";
          }
          return _test();
        }
        s="NO data";
        return _test();
      },
    );
  }
  Widget _test(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Safe Area',
        style: TextStyle(
            color: Colors.white,
        ),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Area Detected",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 75.0,
                  child: Text('$s',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            ),
            Text("$count people are Detected near your area",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

          ],
        ),
      ),
    );
  }

  double calculateDistance(double lat1,double lon1,double lat2,double lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

}
