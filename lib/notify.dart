import 'package:flutter/material.dart';



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Information on women safety',
              style: TextStyle(color: Colors.white, fontSize: 20.0,),

            ),
            backgroundColor: Colors.blueGrey[900],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  const [
                    //Text('count = $count'),
                    Text("     "),
                    Text(
                      '1. Make sure that you enter into taxi mode while travelling in a taxi/cab. ',
                      style: TextStyle(color: Colors.black, fontSize: 20.0 ,fontWeight: FontWeight.bold,),
                    ),
                    Text("     "),
                    Text(
                      '2.Use the sos button to send the location and details to your loved ones.',
                      style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                    Text("     "),
                    Text(
                      '3.As much as possible avoid late night travel using public transport.',
                      style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                    Text("     "),
                    Text(
                      '4.While using 2 wheeler be sure to wear helmet at all times,Do not stop for any stranger.',
                      style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                    Text("     "),
                    Text(
                      '5.Be aware of your surroundings.Do not let your gaurd down.',
                      style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                    Text("     "),
                    Text(
                      '6.Inform family members and friends before boarding a cab and send them the picture of the number plate of the cab',
                      style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                    Text("     "),
                    Text(
                      '7.Take known routes, avoid short cuts which you don\'t know.',
                      style: TextStyle(
                          color:
                          Colors.black, fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("     "),
                    Text(
                      '8.Avoid parking at desolate areas.',
                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text("     "),
                    Text(
                      '9.Do not doze off in a cab.',
                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text("     "),
                    Text(
                      '10.Self Defence is very important and highly encouraged.',
                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}