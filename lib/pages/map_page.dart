import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:owa/consts.dart';
//import 'package:get/get.dart';
import 'package:location/location.dart';

bool firstButton = true; 
final _originInputController = TextEditingController();
final _destinationInputController = TextEditingController();

// final List<LatLng> directions;
// final List<AddressSuggestion> searchResultsLocation;

@override
void dispose() {
  _originInputController.dispose();
  _destinationInputController.dispose();
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(6.605874, 3.349149), // COORDINATES FOR IKEJA LAGOS
    zoom: 13,
  );

  

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  LatLng? _currentP = null;

  late TextEditingController controller;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
  }
  
  // controller.text =
  //           '${state.pickUpAddress?.city ?? ''} ${state.pickUpAddress?.street ?? ''}';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          onPressed: () => {
            //_currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
            //_cameraToPosition(_currentP!)
            getUserCurrentLocation().then((value) {
              // print("My Current Location");
              // print(value.latitude.toString() + " " + value.longitude.toString());
              _cameraToPosition(LatLng(value.latitude, value.longitude));
            })
          },
          

          
          child: const Icon(Icons.my_location_rounded),
        ),
      ), 
    );
  }

  Widget buildFindBusTile() {
    return SafeArea(
      top: false, // This ensures no interference with the UI's bottom notch
      child: Stack(
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
                                    onPressed: () => {
                                      firstButton = true,
                                      showLocationInput(context),
                                    },
                                    icon: Icon(
                                    
                                      Icons.trip_origin,
                                      color: Colors.indigo,
                                      size: MediaQuery.of(context).size.width * 0.05,
                                    ),
                                    label: Text(
                                      _originInputController.text == "" ? 'Origin' : "${_originInputController.text}",
                                    ),
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
                                    onPressed: () {
                                      firstButton = false;
                                      showLocationInput(context);
                                    },
                                    // => Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => LocationInputContainer(),
                                    //   ),
                                    // ),
                                    icon: Icon(
                                      Icons.trip_origin,
                                      size: MediaQuery.of(context).size.width * 0.05,
                                      color: Colors.green,
                                    ),
                                    label: Text(

                                      _destinationInputController.text == "" ? 'Destination' : "${_destinationInputController.text}",
                                      ),
                                  ),
                                ),
                              ),
          
                              (_originInputController.text == "" || _destinationInputController.text == "") ? Center() : Center(
                                // FIND BUS BUTTON
                                child: FilledButton(
                                  onPressed: () {}, 
                                  // style: ButtonStyle(
                                  //   backgroundColor: WidgetStatePropertyAll(Colors.green),
                                    
                                  // ),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.5, MediaQuery.of(context).size.width * 0.13
                                    ),
                                 ),
                                  child: Text('Find Bus',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Poppins',
                                    ),
                                  )
                                ),
                              ),
                              // TextFormField(
                              //   readOnly: true,
                              //   controller: controller,
                              //   decoration: InputDecoration(
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(24),
                              //       borderSide: BorderSide.none,
                              //     ),
                              //     filled: true, // Fill the background
                              //     fillColor: Color.fromARGB(255, 234, 215, 215),
                              //     //labelText: 'Destination',
                              //     hintText: 'Destination',
                              //     hintStyle: TextStyle(
                              //       fontWeight: FontWeight.normal,
                              //       fontSize: 20,
                              //       fontStyle: FontStyle.normal,
                              //       fontFamily: 'Poppins',
                              //     ),
                              //     prefixIcon: const Icon(
                              //       Icons.trip_origin,
                              //       color: Colors.green,
                              //     ),
                              //   ),
                              // ),
                              
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
      ),
    );
  }

  // Widget locationSelector() {
  //   final size = MediaQuery.sizeOf(context);
  //   final textTheme = Theme.of(context).textTheme;
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return Container(
  //         height: size.height * 0.8,
  //         padding: const EdgeInsets.all(16.0),
  //         decoration: BoxDecoration(
  //           color: colorScheme.background,
  //           borderRadius: const BorderRadius.vertical(
  //             top: Radius.circular(8.0),
  //           ),
  //         ),
  //         child:  SafeArea(
  //           child: Column(
  //             children: [
  //               Text(
  //                 'Set your destination',
  //                 style: textTheme.titleLarge!.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           )
  //         ),
          // child: SafeArea(
          //   top: false,
          //   child: Column(
          //     children: [
          //       Text(
          //         'Set your destination',
          //         style: textTheme.titleLarge!.copyWith(
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       const SizedBox(height: 4.0),
          //       Text(
          //         'Type and pick from the suggestions',
          //         style: textTheme.bodyLarge,
          //       ),
          //       Divider(height: 32.0),
          //       Row(
          //         children: [
          //           Column(
          //             children: [
          //               Container(
          //                 height: 8.0,
          //                 width: 8.0,
          //                 margin: const EdgeInsets.all(2.0),
          //                 decoration: BoxDecoration(
          //                   color: colorScheme.primary,
          //                   shape: BoxShape.circle,
          //                 ),
          //               ),
          //               Container(
          //                 height: 40.0,
          //                 width: 2.0,
          //                 decoration: BoxDecoration(
          //                   color: colorScheme.primary,
          //                 ),
          //               ),
          //               Container(
          //                 height: 8.0,
          //                 width: 8.0,
          //                 margin: const EdgeInsets.all(2.0),
          //                 decoration: BoxDecoration(color: colorScheme.primary),
          //               ),
          //             ],
          //           ),
          //           Expanded(
          //             child: Column(
          //               children: [
          //                 TextFormField(
          //                   readOnly: true,
          //                   controller: pickUpAddressController,
          //                   decoration: const InputDecoration(
          //                     isDense: true,
          //                     prefixIcon: Icon(Icons.search),
          //                   ),
          //                 ),
          //                 TextFormField(
          //                   controller: dropOffAddressController,
          //                   decoration: const InputDecoration(
          //                     isDense: true,
          //                     hintText: 'Where to?',
          //                     prefixIcon: Icon(Icons.search),
          //                   ),
          //                   onChanged: (String value) {
          //                     // TODO: DEBOUNCE

          //                     context.read<RideBookingBloc>().add(
          //                           SearchDropOffAddressEvent(query: value),
          //                         );
          //                   },
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 16.0),
          //       // List of suggestions
          //       Expanded(
          //         child: ListView.builder(
          //           itemCount: state.searchResultsForDropOff.length,
          //           shrinkWrap: true,
          //           padding: EdgeInsets.zero,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               onTap: () {
          //                 context.read<RideBookingBloc>().add(
          //                       SelectDropOffSuggestionEvent(
          //                         addressSuggestion:
          //                             state.searchResultsForDropOff[index],
          //                       ),
          //                     );
          //               },
          //               leading: const Icon(Icons.location_on),
          //               title: Text(
          //                 state.searchResultsForDropOff[index].text,
          //                 style: textTheme.bodyLarge!.copyWith(
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               subtitle: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Container(
          //                     height: 1,
          //                     margin: const EdgeInsets.only(top: 8.0),
          //                     color: colorScheme.surfaceVariant,
          //                   ),
          //                 ],
          //               ),
          //             );
          //           },
          //         ),
          //       ),

          //       // Button to confirm
          //       FilledButton(
          //         style: FilledButton.styleFrom(
          //           minimumSize: const Size.fromHeight(48.0),
          //         ),
          //         onPressed: () {
          //           context.read<RideBookingBloc>().add(
          //                 ConfirmDropOffAddressEvent(),
          //               );
          //         },
          //         child: const Text('Confirm destination'),
          //       )
          //     ],
          //   ),
          // ),
        // );
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

  Future<Position> getUserCurrentLocation() async {

    await Geolocator.requestPermission().then((value) {
    }).onError((error, stackTrace) {
      print("error"+error.toString());
    });

    return await Geolocator.getCurrentPosition();
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
          //_centerOnLocation = true;
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          //_cameraToPosition(_currentP!);
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

  void showLocationInput(BuildContext context) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) => LocationInputContainer(), // Widget for location input
    );
  }

}


class LocationInputContainer extends StatefulWidget {

  @override
  _LocationInputContainerState createState() => _LocationInputContainerState();
}

class _LocationInputContainerState extends State<LocationInputContainer> {
  String _selectedLocation = ""; // Stores user-selected location
  
  // Function to handle location selection (from Autocomplete or Done button)
  void onLocationSelected(String location) {
    setState(() {
      _selectedLocation = location;
    });
    // Update TextButton text with selected location and bold font
    updateTextButton(context, location);
    Navigator.pop(context); // Close the bottom sheet
  }


  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   firstButton ? _originInputController.dispose() : _destinationInputController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.87,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8.0),
            ),
          ),
        // ... (Container decoration and padding)
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              
              Text(
                firstButton ? 'Select your Origin' : 'Select your Destination',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Type and pick from the suggestions',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
              Divider(height: 32.0),
              Row(
                children: [
                  // Column(
                  //   children: [
                  //     // Container(
                  //     //   height: 8.0,
                  //     //   width: 8.0,
                  //     //   margin: const EdgeInsets.all(2.0),
                  //     //   decoration: BoxDecoration(
                  //     //     //color: colorScheme.primary,
                  //     //     shape: BoxShape.circle,
                  //     //   ),
                  //     // ),
                  //     // Container(
                  //     //   height: 40.0,
                  //     //   width: 2.0,
                  //     //   decoration: BoxDecoration(
                  //     //     //color: colorScheme.primary,
                  //     //   ),
                  //     // ),
                  //     // Container(
                  //     //   height: 8.0,
                  //     //   width: 8.0,
                  //     //   margin: const EdgeInsets.all(2.0),
                  //     //   decoration: BoxDecoration(//color: colorScheme.primary
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        // TextFormField(
                        //   readOnly: true,
                        //   //controller: pickUpAddressController,
                        //   decoration: const InputDecoration(
                        //     isDense: true,
                        //     prefixIcon: Icon(Icons.trip_origin,
                        //       //size: MediaQuery.of(context).size.width * 0.05,
                        //       color: Colors.indigo,
                        //     ),
                        //   ),
                        // ),
                        TextFormField(
                          //controller: dropOffAddressController,
                          controller: firstButton ? _originInputController : _destinationInputController,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: "Select Location",
                            // hintText: firstButton ? "Select Origin" : "Select Destination",
                            prefixIcon: Icon(
                              Icons.trip_origin,
                              size: 20,
                              //size: MediaQuery.of(context).size.width * 0.05,
                              // color: firstButton ? Colors.green,
                            ),

                            // suffixIcon: Icon(
                            //   Icons.cancel_rounded,
                            //   size: 20,
                            // )
                          ),
                          onChanged: (String value) {
                            // TODO: DEBOUNCE

                            // context.read<RideBookingBloc>().add(
                            //       SearchDropOffAddressEvent(query: value),
                            //     );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //SizedBox(height: 16.0),
              // List of suggestions
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: 4, //state.searchResultsForDropOff.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        // context.read<RideBookingBloc>().add(
                        //       SelectDropOffSuggestionEvent(
                        //         addressSuggestion:
                        //             state.searchResultsForDropOff[index],
                        //       ),
                        //     );
                      },
                      leading: const Icon(Icons.location_on),
                      // title: Text(
                      //   //state.searchResultsForDropOff[index].text,
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.normal,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 1,
                            margin: const EdgeInsets.only(top: 8.0),
                            //color: colorScheme.surfaceVariant,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // THESE WERE THE GEMINI GENERATED FIELDS
              // TextField(
              //   // ... (TextField configuration for location input)
              //   onChanged: (value) => setState(() => _selectedLocation = value),
              //   onSubmitted: (value) => onLocationSelected(value), // Handle selection on Done button press
              // ),
              // Autocomplete(
              //   // ... (Autocomplete configuration for suggestions)
              //   onSuggestionSelected: (suggestion) => onLocationSelected(suggestion),
              // ),
              // Button to confirm selection (optional)
              
              Divider(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => {
                      Navigator.pop(context),
                      firstButton ? _originInputController.clear() : _destinationInputController.clear(),
                      },
                    child: Text('Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.indigo,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => onLocationSelected(_selectedLocation),
                    child: Text('Done',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.indigo,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            
              // ElevatedButton(
              //   onPressed: () => onLocationSelected(_selectedLocation),
              //   child: Text('Done'),
              // ),
            ],
          ),
        ),
    );

    
  }

  void updateTextButton(BuildContext context, String location) {
    // Find the TextButton widget in your widget tree (use context or Provider)
    final textButton = context.findAncestorWidgetOfExactType<TextButton>();
    if (textButton != null) {
      // Update the button text and style
      setState(() {
        // textButton.child = Text(
        //   location,
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // );
      });
    }
  }
}
