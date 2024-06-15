import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              initialCameraPosition: CameraPosition(
                target: _currentP!,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                ),
                Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pGooglePlex),
                Marker(
                    markerId: MarkerId("_destionationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pApplePark)
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
          //buildBottomSheet(),
          buildFindBusTile(),
          // We are also going to be adding the side menu icon and map orient widgets here
          // I am yet to implement the collapse functionality in the bottom container
          // I might never implement it
        ],
      )
        
    );
  }


  // Widget buildBottomSheet() {
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Container(
  //       //width: Get.width * 0.8,
  //       width: 8,
  //       height: 25,
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Colors.black.withOpacity(0.05),
  //                 spreadRadius: 4,
  //                 blurRadius: 10)
  //           ],
  //           borderRadius: BorderRadius.only(
  //               topRight: Radius.circular(12), topLeft: Radius.circular(12))),
  //       child: Center(
  //         child: Container(
  //           //width: Get.width * 0.6,
  //           width: 5,
  //           height: 4,
  //           color: Colors.black45,
  //         ),
  //       ),
  //     ),
  //   );
  // }


  Widget buildFindBusTile() {
    return Align(
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
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey,
              //     offset: Offset(0.0, 0.0), //(x,y)
              //     blurRadius: 10.0,
              //   ),
              //]
            ),
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
                        

                        


                        // TextButton(
                        // // if you are not set the alignment, by default it will align center
                        //   child: const Align( 
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       'Current Location',
                        //         style: TextStyle(color: Color.fromARGB(255, 148, 138, 138), fontSize: 24),
                        //         textAlign: TextAlign.left),
                        //   ),
                        //   onPressed: () {},
                        // ),


                        // Theme(
                        //   data: Theme.of(context).copyWith(
                        //     textButtonTheme: TextButtonThemeData(
                        //       style: TextButton.styleFrom(
                        //       //fixedSize: Size(500, 75),
                        //       fixedSize: Size(
                        //         MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.width * 0.13
                        //       ),
                              
                        //       textStyle: TextStyle(
                        //         fontWeight: FontWeight.normal,
                        //         fontSize: 24,
                        //         fontStyle: FontStyle.normal,
                        //         fontFamily: 'Poppins',
                        //         color: Color.fromARGB(255, 148, 138, 138),
                        //       ),
                        //       backgroundColor: Color.fromARGB(255, 188, 231, 195),
                        //       shape:RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(24.0),
                        //       ), 
                        //       ),
                        //     ),
                        //     // colorScheme: ColorScheme.fromSwatch(
                        //     //   primarySwatch: Colors.green,
                        //     // ),
                        //   ),
                        //   child: TextButton.icon(
                        //     // TEXT BUTTON ICON FOR THE CURRENT LOCATION
                        //     iconAlignment: IconAlignment.start,
                        //     onPressed: () => {},
                        //     icon: Icon(
                        //       Icons.trip_origin,
                        //       color: Colors.indigo,
                        //     ),
                        //     label: Text('Current Location',),
                        //   ),
                        //
                        // ),

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
                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Container (
                        //       // For selecting Current Location
                        //       height: MediaQuery.of(context).size.width * 0.1,
                        //       width: MediaQuery.of(context).size.width * 0.7,
                        //       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        //       decoration: BoxDecoration(
                        //     // Suggested code may be subject to a license. Learn more: ~LicenseLog:2542991049.
                        //         color: Color.fromARGB(255, 188, 231, 195),
                        //         borderRadius: BorderRadius.circular(50),
                        //       ),
                        //       child: Center(
                        //         child: Column(
                        //           children: [
                        //             Icon(
                        //               Icons.trip_origin,
                        //               color: Colors.indigo,
                        //             ),
                        //             Text(
                        //             "Current Location",
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.normal,
                        //               fontSize: 20,
                        //               color: Color.fromARGB(255, 148, 138, 138),
                        //             ),),
                        //           ]
                                    

                        //         ),
                        //       ),
                            
                            
                            
                        //     ),
                        //   ),
                        // ),
                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(2.0),
                        //     child: Container (
                        //       // For selecting Destination
                        //       height: MediaQuery.of(context).size.width * 0.1,
                        //       width: MediaQuery.of(context).size.width * 0.7,
                        //       decoration: BoxDecoration(
                        //     // Suggested code may be subject to a license. Learn more: ~LicenseLog:2542991049.
                        //         color: Color.fromARGB(255, 188, 231, 195),
                        //         borderRadius: BorderRadius.circular(50),
                        //       ),
                        //       child: Center(
                        //         child: Text(
                        //           "Destination",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.normal,
                        //             fontSize: 20,
                        //             color: Color.fromARGB(255, 148, 138, 138),
                        //           ),),
                        //       ),
                              
                            
                            
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
              
                ],
              ),
          ),
        ),
      ),
    );
  }


  // Widget buildProfileTile() {
  //   return Positioned(
  //     top: 0,
  //     left: 0,
  //     right: 0,
  //     child: Container(
  //       width: Get.width,
  //       height: Get.width * 0.5,
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //       decoration: BoxDecoration(color: Colors.white70),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Container(
  //             width: 60,
  //             height: 60,
  //             decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 image: authController.myUser.value.image == null
  //                     ? DecorationImage(
  //                         image: AssetImage('assets/person.png'),
  //                         fit: BoxFit.fill)
  //                     : DecorationImage(
  //                         image: NetworkImage(
  //                             authController.myUser.value.image!),
  //                         fit: BoxFit.fill)),
  //           ),
  //           const SizedBox(
  //             width: 15,
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               RichText(
  //                 text: TextSpan(children: [
  //                   TextSpan(
  //                       text: 'Good Morning, ',
  //                       style:
  //                           TextStyle(color: Colors.black, fontSize: 14)),
  //                   TextSpan(
  //                       text: authController.myUser.value.name,
  //                       style: TextStyle(
  //                           color: Colors.green,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold)),
  //                 ]),
  //               ),
  //               Text(
  //                 "Where are you going?",
  //                 style: TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.black),
  //               )
  //             ],
  //           )
  //         ],
  //       ),
  //     )),
  //   );
  // }


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
    });
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


// class MyBottomSheet extends StatefulWidget {
//   const MyBottomSheet({Key? key}) : super(key: key);

//   @override
//   _MyBottomSheetState createState() => _MyBottomSheetState();
// }

// class _MyBottomSheetState extends State<MyBottomSheet> {
//   bool _isExpanded = false;

//   void _toggleExpansion() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: _isExpanded ? MediaQuery.of(context).size.height : 200, // Adjust collapsed height as needed
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.white,
//       ),
//       child: Stack(
//         children: [
//           // Location Input Field
//           GestureDetector(
//             onTap: _toggleExpansion,
//             child: Container(
//               padding: const EdgeInsets.all(16.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: "Enter Location",
//                   icon: Icon(Icons.location_on),
//                 ),
//               ),
//             ),
//           ),
//           // Google Map (conditionally displayed)
//           if (_isExpanded)
//             Expanded(
//               child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(37.7833, -122.4167), // Replace with your initial location
//                   zoom: 15.0,
//                 ),
//                 onTap: () => _toggleExpansion(), // Collapse on map tap
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
