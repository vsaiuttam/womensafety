import 'dart:async';

import 'package:battery/battery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ws1/notify.dart';
import 'package:ws1/safe.dart';
import 'package:ws1/taxi.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Timer timer;
  final _auth = FirebaseAuth.instance;
  var loc;
  var _flag = true;
  final _firestore = FirebaseFirestore.instance;
  final battery = Battery();
  int batteryLevel = 100;

  List<String> recipents = ["8247091320"];
  TextEditingController _numberCtrl = new TextEditingController();

  void listenBatteryLevel() {
    updateBatteryLevel();

    timer = Timer.periodic(
      Duration(seconds: 1),
          (_) async => updateBatteryLevel(),
    );
  }

  Future updateBatteryLevel() async {
    final batteryLevel = await battery.batteryLevel;
    print(batteryLevel);

    setState(() => this.batteryLevel = batteryLevel);
    if (this.batteryLevel >= 60){
      print(this.batteryLevel);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    // subscription.cancel();

    super.dispose();
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }


  Widget build(BuildContext context) {
    return _lite2();
  }

  Widget _lite(){
    _numberCtrl.text = "8297669333";

    return Scaffold(
      appBar: AppBar(
        actions: [Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
            },
            child: Icon(Icons.female),
          ),
        )],
        backgroundColor: Colors.blueGrey[900],
        // backgroundColor: Colors.amberAccent,
        //foregroundColor: Colors.purpleAccent,
        centerTitle: true,
        title:Text('BeSafe'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 10,),
              Expanded(child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      color: Colors.purple[200],
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${this.batteryLevel}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Icon(Icons.battery_alert_sharp,size: 40.0,),
                            ],
                          )
                      )
                  )
              )),
              SizedBox(width: 5,),
              Expanded(child: GestureDetector(
                onTap :(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Taxi()));
              },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.car_rental,size: 40,),
                        ))
                ),
              )),
              SizedBox(width: 10,)
            ],
          ),
          SizedBox(height: 30,),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                _sendSMS("My current Location \nLatitude: "+loc.latitude.toString()+ "\nLongitude: "+loc.longitude.toString(), recipents);
                FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("SOS",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),)),
                      ))
              ),
            ),
          )),
          SizedBox(height: 15,),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Safe(loc.latitude,loc.longitude)));
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      color: Colors.greenAccent[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Safe Area",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),)),
                      ))
              ),
            ),
          )),
          SizedBox(height: 30,),
          Row(
            children: [
              SizedBox(width: 10,),
              Expanded(child: GestureDetector(
                onTap: (){
                  FlutterPhoneDirectCaller.callNumber("8297669333");
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.phone,size: 40,),
                        ))
                ),
              )),
              SizedBox(width: 5,),
              Expanded(child: GestureDetector(
                onTap: (){
                  _sendSMS("My current Location \nLatitude: "+loc.latitude.toString()+ "\nLongitude: "+loc.longitude.toString(), recipents);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        color: Colors.blue[100],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.message_sharp,size: 40,),
                        ))
                ),
              )),
              SizedBox(width: 10,)
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  Widget _lite2(){
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('locations').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final docs = snapshot.data!.docs;
          for(var doc in docs){
            if(doc.get("user")==_auth.currentUser?.email) {
              _firestore.collection("locations").
                  doc(doc.id).update({
                "lat": loc.latitude,
                "lon": loc.longitude
              });
              _flag = false;
              break;
            }
          }
          if(_flag==true){
            _firestore.collection("locations")
                .add({
              'user':_auth.currentUser?.email,
              "lat":loc.latitude,
              "lon":loc.longitude,
            });
          }
          return _lite();
        }
        return Container();
      },
    );
  }
  @override
  void initState() {
    _flag = true;
    func();
    func1();
  }

  Future<void> func() async {
    var location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> func1() async {
    var location=Location();
    var locationdata= await location.getLocation();
    loc=locationdata;
  }



}
