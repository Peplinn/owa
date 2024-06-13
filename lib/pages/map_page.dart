import 'dart:async';

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
                target: _pGooglePlex,
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
          buildBottomSheet(),
          buildProfileTile(),
        ],
      )
        
    );
  }


  Widget buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        //width: Get.width * 0.8,
        width: 8,
        height: 25,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        child: Center(
          child: Container(
            //width: Get.width * 0.6,
            width: 5,
            height: 4,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }


  Widget buildProfileTile() {
    return Expanded (
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // alignment: Alignment.bottomCenter,
          constraints: BoxConstraints.tightForFinite(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(color: Colors.white),
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
                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'Where are you going, ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 28)
                              ),
                        TextSpan(
                            text: 'Egbon',
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '?',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ),
                    // const TextSpan(
                    //   "Egbon",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 28,
                    //     color: Colors.green),
                    // )
                  ],
                ),
              )
            ],
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
      zoom: 13,
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
        color: Colors.black,
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
