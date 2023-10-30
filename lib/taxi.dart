import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'dart:async';

import 'package:ws1/main.dart';

class LocationService {
  late UserLocation _currentLocation;

  var location = Location();
  StreamController<UserLocation> _locationController =
  StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude!,
              longitude: locationData.longitude!,
            ));
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude!,
        longitude: userLocation.longitude!,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}


class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation({required this.latitude, required this.longitude});
}

class Taxi extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      initialData: UserLocation(latitude: 17.3535345, longitude: 17.34346346),
      create: (context) => LocationService().locationStream,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Taxi Mode'),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: HomeView(),
      )
    );
  }
}

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('You have Entered Taxi Mode',
    style: TextStyle(
        fontSize: 30.0
    ),
        ),
        Center(
          child: Text(
              '\nLocation \nLatitude :   ${userLocation.latitude}\nLongitude: ${userLocation.longitude}',
            style: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
        SizedBox(height: 100.0,),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('* When you go off grid the app automatically sends an sms to your favorite contacts',
          ),
        )
      ],
    );
  }
}