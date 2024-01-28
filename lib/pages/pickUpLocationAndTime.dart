import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homescreen/pages/paymetntMethodScreen.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';

import '../data/car.dart';
import '../data/car2.dart';
import 'books.dart';

import 'dart:math' as math;

class CarRentalApp extends StatefulWidget {
  final Car car;
  final Car2 car2;
  final Book book;

  CarRentalApp({required this.car, required this.book, required this.car2});

  @override
  _CarRentalAppState createState() => _CarRentalAppState();
}

class _CarRentalAppState extends State<CarRentalApp> {
  final Location _locationService = Location();
  GoogleMapController? _mapController;
  LocationData? _currentLocation;
  TextEditingController _pickupTimeController = TextEditingController();
  DateTime? _selectedTime;
  bool _showMessage = false;

  MapType _currentMapType = MapType.normal;

  double _distance = 0.0; // Initialize with a default value

  // Step 2: Create a Set to hold the markers
  Set<Marker> _markers = {};

  Set<Polyline> _polylines = {};

  void _initializeLocationService() async {
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Fetch the current location after obtaining permission
    if (permissionGranted == PermissionStatus.granted) {
      _currentLocation = await _locationService.getLocation();
    }
  }

  // Method to draw a line from the target location to my location
  void _drawLineFromTargetToMyLocation() {
    if (_currentLocation != null) {
      LatLng targetLocation = LatLng(widget.car.coord1, widget.car.coord2);
      LatLng myLocation = LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      );

      _distance = _calculateDistance(targetLocation, myLocation);

      // Add the Polyline to the _polylines set
      _polylines.add(
        Polyline(
          width: 5,
          polylineId: PolylineId("routeLine"),
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
          points: [targetLocation, myLocation],
        ),
      );

      _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              myLocation.latitude - 0.1,
              myLocation.longitude - 0.1,
            ),
            northeast: LatLng(
              myLocation.latitude + 0.1,
              myLocation.longitude + 0.1,
            ),
          ),
          100.0,
        ),
      );

      // Update the state to trigger a redraw
      setState(() {});
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _selectTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            colorScheme: ColorScheme.light(
                primary:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
                onSurface: Theme.of(context)
                    .bottomNavigationBarTheme
                    .backgroundColor!),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              colorScheme: ColorScheme.light(
                  primary: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor!,
                  onSurface: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor!),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        _selectedTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _pickupTimeController.text =
            DateFormat.yMd().add_jm().format(_selectedTime!);

        // Reset _showMessage to false when a date and time are selected
        setState(() {
          _showMessage = false;
        });
      }
    }
  }

  void _showSelectedDateTimeDialog(DateTime selectedTime) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 20,
          shadowColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          title: Text(
            'Selected Date and Time',
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: ${DateFormat('EEEE, dd MMMM yyyy').format(selectedTime)}',
                style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 18,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Time: ${DateFormat.jm().format(selectedTime)}',
                style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 18,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Location: ' + widget.car2.location,
                style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '(Contact owners for adjustment in pick up location)',
                style: TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 12.5,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentMethodScreen()));
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeLocationService();

    // Initialize and add the marker when the screen loads
    _markers.add(
      Marker(
        markerId: MarkerId("currentLocation"),
        position: LatLng(widget.car.coord1, widget.car.coord2),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: widget.car2.location),
      ),
    );

    // Show InfoWindow for the "currentLocation" marker after a short delay
    Timer(Duration(milliseconds: 500), () {
      _mapController?.showMarkerInfoWindow(MarkerId("currentLocation"));
    });
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const int earthRadius = 6371; // in kilometers

    double lat1 = start.latitude;
    double lon1 = start.longitude;
    double lat2 = end.latitude;
    double lon2 = end.longitude;

    double dLat = (lat2 - lat1) * (math.pi / 180);
    double dLon = (lon2 - lon1) * (math.pi / 180);

    double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1 * (math.pi / 180)) *
            math.cos(lat2 * (math.pi / 180)) *
            math.pow(math.sin(dLon / 2), 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //MapType _currentMapType = MapType.normal;

    // Check if the current location is available before initializing the map
    final initialCameraPosition = _currentLocation != null
        ? CameraPosition(
            target: LatLng(
              _currentLocation!.latitude ?? 0.0,
              _currentLocation!.longitude ?? 0.0,
            ),
            zoom: 14,
          )
        : CameraPosition(
            target: LatLng(widget.car.coord1, widget.car.coord2),
            zoom: 17,
          );

    return Scaffold(
      /*appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        title: Text(
          'Pick Up Location and Time',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),*/
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  mapToolbarEnabled: true,
                  compassEnabled: true,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: initialCameraPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: _markers,
                  polylines: _polylines,
                  mapType: _currentMapType,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 47, 16, 15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        /*child: Container(
                                  height: size.width * 0.1,
                                  width: size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: kTextColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Image.asset('assets/images/back-arrow.png'),
                                  ),
                                ),*/
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2, 2),
                                blurRadius: 2,
                              ),
                            ],
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Icon(CupertinoIcons.back)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Pick Up Location and Time',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            //color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 15.0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      widget.car.name +
                          " " +
                          widget.car.model +
                          '\'s pickup location',
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 183,
                  left: 16,
                  child: ElevatedButton.icon(
                    onPressed: _drawLineFromTargetToMyLocation,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      elevation: 15,
                      minimumSize: Size(145, 40), // Increase the button size
                    ),
                    icon: Icon(Icons.my_location,
                        color: Colors.white), // Set icon color
                    label: Text(
                      'Find Distance',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Barlow', // Set text color
                        fontSize: 16, // Adjust text size
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 139,
                  left: 15.0,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Button pressed'); // Add this line
                      setState(() {
                        _currentMapType = _currentMapType == MapType.normal
                            ? MapType.hybrid
                            : MapType.normal;
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.map,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Change Terrain Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Barlow', // Set text color
                        fontSize: 16, // Adjust text size
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor!
                            .withOpacity(0.8),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Distance: ${_distance.toStringAsFixed(2)} km',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Barlow',
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              children: [
                // Inside your _CarRentalAppState class

                TextField(
                  controller: _pickupTimeController,
                  readOnly: true,
                  onTap: () => _selectTime(context),
                  decoration: InputDecoration(
                    labelText: 'Tap to choose your date and time',
                    labelStyle: TextStyle(
                      fontFamily: 'BArlow',
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      letterSpacing: 1,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!,
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).primaryColor,
                    contentPadding: EdgeInsets.all(15.0),
                    // Add a shadow
                  ),
                ),

                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _selectedTime != null
                      ? () {
                          _showSelectedDateTimeDialog(
                              _selectedTime!); // Show the selected date and time dialog

                          // Implement the logic to book the car with the selected time and location
                          // For demonstration purposes, you can show a success message or navigate to the next screen.
                          /*Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PaymentMethodScreen()));*/
                          _showMessage =
                              false; // Reset the message status when booking is attempted
                          // Show a success message or navigate to the next screen
                        }
                      : () {
                          // If no date and time are selected, show the message
                          setState(() {
                            _showMessage = true;
                          });
                        },
                  child: Text(
                    'Book Car',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5, // Add elevation to give a floating effect
                    primary: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor, // Background color
                    onPrimary: Theme.of(context).primaryColor, // Text color
                  ),
                ),

                if (_showMessage)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7.0, 5, 7, 2),
                    child: Text(
                      'Please select a date and time before booking.',
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
