// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:owa/.env.dart';
// //import 'package:get/get.dart';
// import 'package:location/location.dart';
// import 'bus_page.dart';
// import 'dio_directions.dart';

// import 'package:owa/asset_data/bus_list.dart';
// import 'package:owa/asset_data/busstation_list.dart';

// bool firstButton = true;
// final _originInputController = TextEditingController();
// final _destinationInputController = TextEditingController();

// LatLng stationLatLng = brtStationsLatLng[_originInputController.text]!;

// List<String> _filteredStations = [];
// List<double> _filteredCoordinates = [];

// Marker _origin = Marker(markerId: MarkerId("unsetOrigin"));
// Marker _destination = Marker(markerId: MarkerId("unsetDestination"));

// LatLng? _originCoordinates = null;
// LatLng? _destinationCoordinates = null;
// Directions? _info = null;

// final Completer<GoogleMapController> _mapController =
//     Completer<GoogleMapController>();

// @override
// void dispose() {
//   _originInputController.dispose();
//   _destinationInputController.dispose();
// }

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   final Location _locationController = new Location();

//   static const _initialCameraPosition = CameraPosition(
//     target: LatLng(6.605874, 3.349149),
//     zoom: 13,
//   );


//   static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
//   static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
//   LatLng? _currentP;

//   late TextEditingController controller;

//   Map<PolylineId, Polyline> polylines = {};

//   @override
//   void initState() {
//     controller = TextEditingController();
//     super.initState();
//     getLocationUpdates().then(
//       (_) => {
//         getPolylinePoints().then((coordinates) => {
//               generatePolyLineFromPoints(coordinates),
//             }),
//       },
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           _currentP == null
//               ? const Center(
//                   child: Text("Loading..."),
//                 )
//               : GoogleMap(
//                   onMapCreated: ((GoogleMapController controller) =>
//                       _mapController.complete(controller)),
//                   initialCameraPosition: _initialCameraPosition,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                   zoomControlsEnabled: false,
                  
//                   markers: {
//                       _origin,
//                       _destination
//                     },
//                   polylines: const {
//                     }
//                   ),
//           buildFindBusTile(),
//         ],
//       ),
//       floatingActionButton: Container(
//         alignment: AlignmentDirectional.centerEnd,
//         child: FloatingActionButton(
//           shape: const CircleBorder(),
//           hoverElevation: 100,
//           hoverColor: Colors.black,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           onPressed: () => {
//             getUserCurrentLocation().then((value) {
//               _cameraToPosition(LatLng(value.latitude, value.longitude));
//             })
//           },
//           child: const Icon(Icons.my_location_rounded),
//         ),
//       ),
//     );
//   }

//   Widget buildFindBusTile() {
//     return SafeArea(
//       top: false,
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Material(
//               elevation: 50,
//               shadowColor: Colors.black,
//               color: Colors.white,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//               child: Container(
//                 constraints: BoxConstraints.tightForFinite(
//                   width: MediaQuery.of(context).size.width,
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                 decoration: const BoxDecoration(),
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.width * 0.65,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             RichText(
//                               text: const TextSpan(children: [
//                                 TextSpan(
//                                     text: 'Where are you going, ',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontStyle: FontStyle.normal,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 28)),
//                                 TextSpan(
//                                     text: 'Egbon',
//                                     style: const TextStyle(
//                                         color: Colors.green,
//                                         fontSize: 30,
//                                         fontStyle: FontStyle.normal,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.bold)),
//                                 TextSpan(
//                                     text: '?',
//                                     style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 28,
//                                         fontStyle: FontStyle.normal,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.bold)),
//                               ]),
//                             ),

//                             Center(
//                               child: TextButton.icon(
//                                 style: TextButton.styleFrom(
//                                   alignment: Alignment.centerLeft,
//                                   fixedSize: Size(
//                                       MediaQuery.of(context).size.width * 0.8,
//                                       MediaQuery.of(context).size.width * 0.11),
//                                   foregroundColor:
//                                       const Color.fromARGB(255, 148, 138, 138),
//                                   backgroundColor:
//                                       const Color.fromARGB(255, 188, 231, 195),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(24.0),
//                                   ),
//                                 ),
//                                 onPressed: () => {
//                                   firstButton = true,
//                                   setState(() {
//                                     if (_filteredStations.isEmpty) { _filteredStations = brtStationsLatLng.keys.toList();}}),
//                                   showLocationInput(context),
//                                 },
//                                 icon: Icon(
//                                   Icons.trip_origin,
//                                   color: Colors.indigo,
//                                   size:
//                                       MediaQuery.of(context).size.width * 0.05,
//                                 ),
//                                 label: Text(
//                                     textAlign: TextAlign.right,
//                                     _originInputController.text == ""
//                                         ? 'Origin'
//                                         : _originInputController.text,
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.normal,
//                                       color: _originInputController.text == ""
//                                           ? const Color.fromARGB(255, 148, 138, 138)
//                                           : Colors.indigo,
//                                     )),
//                               ),
//                             ),

//                             Center(
//                               child: TextButton.icon(
//                                 style: TextButton.styleFrom(
//                                   alignment: Alignment.centerLeft,
//                                   fixedSize: Size(
//                                       MediaQuery.of(context).size.width * 0.8,
//                                       MediaQuery.of(context).size.width * 0.11),

//                                   foregroundColor:
//                                       const Color.fromARGB(255, 148, 138, 138),
//                                   backgroundColor:
//                                       const Color.fromARGB(255, 188, 231, 195),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(24.0),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   firstButton = false;
//                                   setState(() {
//                                     if (_filteredStations.isEmpty) {
//                                       _filteredStations =
//                                           brtStationsLatLng.keys.toList();
//                                     }
//                                   });
//                                   showLocationInput(context);
//                                 },

//                                 icon: Icon(
//                                   Icons.trip_origin,
//                                   size:
//                                       MediaQuery.of(context).size.width * 0.05,
//                                   color: Colors.green,
//                                 ),
//                                 label: Text(
//                                     _destinationInputController.text == ""
//                                         ? 'Destination'
//                                         : _destinationInputController.text,
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.normal,
//                                       color: _destinationInputController.text ==
//                                               ""
//                                           ? const Color.fromARGB(255, 148, 138, 138)
//                                           : Colors.green,
//                                     )),
//                               ),
//                             ),

//                             (_originInputController.text == "" || _destinationInputController.text == "")
//                                 ? const Center()
//                                 : Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: Center(
//                                       // FIND BUS BUTTON
//                                       child: FilledButton(
//                                           onPressed: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => BusPage(
//                                                   origin: _originInputController.text,
//                                                   destination: _destinationInputController.text,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           style: FilledButton.styleFrom(
//                                             backgroundColor: Colors.green,
//                                             fixedSize: Size(
//                                                 MediaQuery.of(context).size.width * 0.5,
//                                                 MediaQuery.of(context).size.width * 0.14),
//                                           ),
//                                           child: const Text(
//                                             'Find Bus',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 24,
//                                               fontStyle: FontStyle.normal,
//                                               fontFamily: 'Poppins',///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             ),
//                                           )),
//                                     ),
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Position> getUserCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) {
//       print("error" + error.toString());
//     });

//     return await Geolocator.getCurrentPosition();
//   }

//   Future<void> getLocationUpdates() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await _locationController.serviceEnabled();
//     if (serviceEnabled) {
//       serviceEnabled = await _locationController.requestService();
//     } else {
//       return;
//     }

//     permissionGranted = await _locationController.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _locationController.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           _currentP =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         });
//       }
//     });
//   }

//   Future<List<LatLng>> getPolylinePoints() async {
//     List<LatLng> polylineCoordinates = [];
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       GOOGLE_MAPS_API_KEY,
//       PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
//       PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     return polylineCoordinates;
//   }

//   void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id,
//         color: Colors.green,
//         points: polylineCoordinates,
//         width: 8);
//     setState(() {
//       polylines[id] = polyline;
//     });
//   }

//   void showLocationInput(BuildContext context) {
//     showModalBottomSheet<dynamic>(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) =>
//           LocationInputContainer(),
//     );
//   }
// }

// Future<void> _cameraToPosition(LatLng pos) async {
//   final GoogleMapController controller = await _mapController.future;
//   CameraPosition _newCameraPosition = CameraPosition(
//     target: pos,
//     zoom: 17,
//   );
//   await controller.animateCamera(
//     CameraUpdate.newCameraPosition(_newCameraPosition),
//   );
// }

// class LocationInputContainer extends StatefulWidget {
//   @override
//   _LocationInputContainerState createState() => _LocationInputContainerState();
// }

// class _LocationInputContainerState extends State<LocationInputContainer> {
//   String _selectedLocation = "";
  

  
//   void onLocationSelected(String location) {
//     setState(() {
//       _selectedLocation = location;
//     });
//     updateTextButton(context, location);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.87,
//       padding: const EdgeInsets.all(16.0),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(8.0),
//         ),
//       ),
//       child: SafeArea(
//         top: false,
//         child: Column(
//           children: [
//             Text(
//               firstButton ? 'Select your Origin' : 'Select your Destination',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//             const SizedBox(height: 4.0),
//             const Text(
//               'Type and pick from the suggestions',
//               style: TextStyle(
//                 fontWeight: FontWeight.normal,
//                 fontSize: 15,
//               ),
//             ),
//             const Divider(height: 32.0),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         textCapitalization: TextCapitalization.words,
//                         textAlignVertical: TextAlignVertical.center,
//                         style: TextStyle(
//                           color: firstButton ? Colors.indigo : Colors.green,
//                           fontSize: 20,
//                         ),
//                         controller: firstButton
//                             ? _originInputController
//                             : _destinationInputController,
//                         decoration: InputDecoration(
//                             isDense: true,
//                             hintText: "Select Station",
//                             prefixIcon: Icon(
//                               Icons.trip_origin,
//                               size: 20,
//                               color: firstButton ? Colors.indigo : Colors.green,
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 if (firstButton) {
//                                   _originInputController.clear();
//                                   setState(() {
//                                     _filteredStations =
//                                         brtStationsLatLng.keys.toList();
//                                   });
//                                 } else {
//                                   _destinationInputController.clear();
//                                   setState(() {
//                                     _filteredStations =
//                                         brtStationsLatLng.keys.toList();
//                                   });
//                                 }
//                               },
//                               icon: const Icon(
//                                 Icons.close_rounded,
//                                 size: 20,
//                               ),
//                             )),
//                         onChanged: (String value) {
//                           setState(() {
//                             _filteredStations = value.isEmpty
//                                 ? brtStationsLatLng.keys.toList()
//                                 : brtStationsLatLng.keys
//                                     .toList()
//                                     .where((station) => station
//                                         .toLowerCase()
//                                         .contains(value.toLowerCase()))
//                                     .toList();
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             Expanded(
//               flex: 1,
//               child: ListView.builder(
//                 itemCount: _filteredStations
//                     .length,
//                 shrinkWrap: true,
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () {
//                       _onStationTap(_filteredStations[index]);
//                       if (!firstButton) {
//                         stationLatLng = brtStationsLatLng[
//                             _destinationInputController.text]!;
//                       } else {
//                         stationLatLng =
//                             brtStationsLatLng[_originInputController.text]!;
//                       }
//                       _cameraToPosition(stationLatLng);
//                     },
//                     titleAlignment: ListTileTitleAlignment.titleHeight,
//                     leading: const Icon(Icons.location_on),
//                     title: Text(
//                       _filteredStations[index],
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 18,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             Divider(height: 32.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: () => {
//                     Navigator.pop(context),
//                     firstButton
//                         ? _originInputController.clear()
//                         : _destinationInputController.clear(),
//                   },
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       fontWeight: FontWeight.normal,
//                       color: Colors.indigo,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => {
//                     onLocationSelected(_selectedLocation),
//                     _addMarker(stationLatLng)
//                   },
//                   child: Text(
//                     'Done',
//                     style: TextStyle(
//                       fontWeight: FontWeight.normal,
//                       color: Colors.indigo,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//           ],
//         ),
//       ),
//     );
//   }

//   void _onStationTap(String selectedStation) {
//     if (firstButton) {
//       _originInputController.text = selectedStation;
//     } else {
//       _destinationInputController.text = selectedStation;
//     }
//   }

//   void updateTextButton(BuildContext context, String location) {
//     final textButton = context.findAncestorWidgetOfExactType<TextButton>();
//     if (textButton != null) {
//       setState(() {
//       });
//     }
//   }

//   void _addMarker(LatLng pos) async {
//     if (firstButton) {
//       setState(() {
//         _origin = Marker(
//           markerId: const MarkerId('origin'),
//           infoWindow: const InfoWindow(title: 'Origin'),
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
//           position: pos,
//         );
//         _info = null;
//       });
//     } else {
//       setState(() {
//         _destination = Marker(
//           markerId: const MarkerId('destination'),
//           infoWindow: const InfoWindow(title: 'Destination'),
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//           position: pos,
//         );
//       });

//       final directions = await DirectionsRepository()
//           .getDirections(origin: _origin.position, destination: pos);
//       setState(() => _info = directions);
//     }
//   }
// }

// class DirectionsRepository {
//   static const String _baseUrl =
//       'https://maps.googleapis.com/maps/api/directions/json?';

//   final Dio _dio;

//   DirectionsRepository({Dio dio}) : _dio = dio ?? Dio();

//   Future<Directions> getDirections({
//     @required LatLng origin,
//     @required LatLng destination,
//   }) async {
//     final response = await _dio.get(
//       _baseUrl,
//       queryParameters: {
//         'origin': '${origin.latitude},${origin.longitude}',
//         'destination': '${destination.latitude},${destination.longitude}',
//         'key': GOOGLE_MAPS_API_KEY,
//       },
//     );

//     // Check if response is successful
//     if (response.statusCode == 200) {
//       return Directions.fromMap(response.data);
//     }
//     return null;
//   }
// }


// class Directions {
//   final LatLngBounds bounds;
//   final List<PointLatLng> polylinePoints;
//   final String totalDistance;
//   final String totalDuration;

//   const Directions({
//     @required this.bounds,
//     @required this.polylinePoints,
//     @required this.totalDistance,
//     @required this.totalDuration,
//   });

//   factory Directions.fromMap(Map<String, dynamic> map) {
//     // Check if route is not available
//     if ((map['routes'] as List).isEmpty) return null;

//     // Get route information
//     final data = Map<String, dynamic>.from(map['routes'][0]);

//     // Bounds
//     final northeast = data['bounds']['northeast'];
//     final southwest = data['bounds']['southwest'];
//     final bounds = LatLngBounds(
//       northeast: LatLng(northeast['lat'], northeast['lng']),
//       southwest: LatLng(southwest['lat'], southwest['lng']),
//     );

//     // Distance & Duration
//     String distance = '';
//     String duration = '';
//     if ((data['legs'] as List).isNotEmpty) {
//       final leg = data['legs'][0];
//       distance = leg['distance']['text'];
//       duration = leg['duration']['text'];
//     }

//     return Directions(
//       bounds: bounds,
//       polylinePoints:
//           PolylinePoints().decodePolyline(data['overview_polyline']['points']),
//       totalDistance: distance,
//       totalDuration: duration,
//     );
//   }
// }