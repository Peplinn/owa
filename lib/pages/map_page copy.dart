import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:owa/consts.dart';
//import 'package:get/get.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(6.605874, 3.349149),
    zoom: 13,
  );

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  LatLng? _currentP = null;
  

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
  }

  bool _isListeningToLocation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3773060372.
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                  position: _currentP!,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
          //buildBottomSheet(),
          buildFindBusTile(),
          // We are also going to be adding the side menu icon and map orient widgets here
          // I am yet to implement the collapse functionality in the bottom container
          // I might never implement it
        ],
      ),
      floatingActionButton: Container(        
        alignment: AlignmentDirectional.centerEnd,
        child: FloatingActionButton(
          shape: CircleBorder(),
          hoverElevation: 100,
          hoverColor: Colors.black,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          // onPressed: () => {_locationController.onLocationChanged
          //   .listen((LocationData currentLocation) {
          //     if (currentLocation.latitude != null &&
          //         currentLocation.longitude != null) {
          //       setState(() {
          //         _currentP =
          //             LatLng(currentLocation.latitude!, currentLocation.longitude!);
          //         _cameraToPosition(_currentP!);
          //       });
          //     }
          //   }),
          //   },
          

          onPressed: () {
            if (!_isListeningToLocation) {
              _isListeningToLocation = true;
              _locationController.onLocationChanged
                  .listen((LocationData currentLocation) {
                    if (currentLocation.latitude != null &&
                        currentLocation.longitude != null) {
                      setState(() {
                        _currentP =
                            LatLng(currentLocation.latitude!, currentLocation.longitude!);
                        _cameraToPosition(_currentP!);
                      });
                    }
                  })
                  // Cancel the subscription when the button is released
                  .onDone(() {
                    _isListeningToLocation = false;
                    print("Location updates stopped");
                  });
            }
          },
          child: const Icon(Icons.my_location_rounded),
        ),
      ), 
    );
  }

//           onPressed: () => _googleMapController.animateCamera(
      //     _info != null
      //         ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
      //         : CameraUpdate.newCameraPosition(_initialCameraPosition),

  Widget buildFindBusTile() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.white,
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              constraints: BoxConstraints.tightForFinite(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.width * 0.5,
                ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration( ),
              child: SizedBox (
                height: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                const TextSpan(
                                    text: 'Where are you going, ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28)
                                ),
                                TextSpan(
                                    text: 'Egbon',
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 30,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold
                                      )
                                ),
                                TextSpan(
                                    text: '?',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold
                                      )
                                ),
                              ]),
        
                              
                            ),
        
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: TextButton.icon(
                                  
                                  // TEXT BUTTON ICON FOR THE CURRENT LOCATION
                                  style: TextButton.styleFrom(
                                    alignment: Alignment.centerLeft,
                                    //alignment: Alignment(MediaQuery.of(context).size.width * 0.0001, MediaQuery.of(context).size.width * 0.05),
                                    //fixedSize: Size(500, 75),
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.8, MediaQuery.of(context).size.width * 0.09
                                    ),
                                    
                                    textStyle: TextStyle(
                                      height: 1.5,
                                      color: Color.fromARGB(255, 148, 138, 138),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Poppins',
                                      
                                    ),
                                    foregroundColor: Color.fromARGB(255, 148, 138, 138),
                                    backgroundColor: Color.fromARGB(255, 188, 231, 195),
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ), 
                                  ),
                                  onPressed: () => {},
                                  icon: Icon(
                                  
                                    Icons.trip_origin,
                                    color: Colors.indigo,
                                    size: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  label: Text('Current Location',),
                                ),
                              ),
                            ),
        
        
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 1.0, 0, 2.0),
                                child: TextButton.icon(
                                  
                                  // TEXT BUTTON ICON FOR THE DESTINATION
                                  style: TextButton.styleFrom(
                                    alignment: Alignment.centerLeft,
                                    //fixedSize: Size(500, 75),
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.8, MediaQuery.of(context).size.width * 0.09
                                    ),
                                    
                                    textStyle: TextStyle(
                                      
                                      textBaseline: TextBaseline.ideographic,
                                      color: Color.fromARGB(255, 148, 138, 138),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Poppins',
                                      
                                    ),
                                    foregroundColor: Color.fromARGB(255, 148, 138, 138),
                                    backgroundColor: Color.fromARGB(255, 188, 231, 195),
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ), 
                                  ),
                                  onPressed: () => {},
                                  icon: Icon(
                                    Icons.trip_origin,
                                    size: MediaQuery.of(context).size.width * 0.05,
                                    color: Colors.green,
                                  ),
                                  label: Text('Destination',),
                                ),
                              ),
                            ),
        
        
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
                              child: Center(
                                child: TextButton.icon(
                                  
                                  // TEXT BUTTON ICON FOR THE DESTINATION
                                  style: TextButton.styleFrom(
                                    //fixedSize: Size(500, 75),
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.5, MediaQuery.of(context).size.width * 0.13
                                    ),
                                    
                                    textStyle: TextStyle(
                                      
                                      color: Color.fromARGB(255, 148, 138, 138),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Poppins',
                                      
                                    ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.green,
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ), 
                                  ),
                                  onPressed: () => {},
                                  
                                  label: Text('Find Bus',),
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                  
                    ],
                  ),
              ),
            ),
          ),
        ),
        
      ],
    );
  }


  

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 17,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // _locationController.onLocationChanged
    //     .listen((LocationData currentLocation) {
    //   if (currentLocation.latitude != null &&
    //       currentLocation.longitude != null) {
    //     setState(() {
    //       _currentP =
    //           LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //       //_cameraToPosition(_currentP!);
    //     });
    //   }
    // });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.green,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}


