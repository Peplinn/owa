The Old Container for the Current Location:

Container(
                          
                          height: MediaQuery.of(context).size.width * 0.125,
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.centerLeft,
                          //margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 188, 231, 195),
                              borderRadius: BorderRadius.circular(50.0)),
                          
                          child: TextButton(
                            child: Text('Current Locations',
                                style: TextStyle(color: Color.fromARGB(255, 148, 138, 138), fontSize: 24),
                                textAlign: TextAlign.left),
                            onPressed: () {},
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




// boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey,
                  //     offset: Offset(0.0, 0.0), //(x,y)
                  //     blurRadius: 10.0,
                  //   ),
                  //]


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