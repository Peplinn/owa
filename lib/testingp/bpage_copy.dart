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

class BusPage extends StatefulWidget {
  final String origin;
  final String destination;

  const BusPage({Key? key, required this.origin, required this.destination})
      : super(key: key);

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  Map<String, LatLng> _buses = {}; // Empty list to store bus data

  @override
  void initState() {
    super.initState();
    _fetchBusData(widget.origin, widget.destination); // Fetch data on init
  }

  // Function to fetch bus data (replace with your actual data fetching logic)
  Future<void> _fetchBusData(String origin, String destination) async {
    // Simulate API call with some delay
    await Future.delayed(const Duration(seconds: 2));

    // Replace this with your actual API call and data parsing logic
    setState(() {
      _buses = {
        _buses(busName: "Bus 123", arrivalTime: "10:15 AM"),
        Bus(busName: "Bus 456", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 23", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 235", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 6346", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 28", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 72", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 28", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 86", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 62", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 48", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 29", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 542", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 82", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 72", arrivalTime: "10:30 AM"),
        Bus(busName: "Bus 63", arrivalTime: "10:30 AM"),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Buses"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListView.separated(
            itemCount: _buses.length,
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              final bus = _buses[index];
              return ListTile(
                title: Text(bus.busName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                subtitle: Text("Arriving at: ${bus.arrivalTime}"),
                // onTap: () {
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CountdownPage(bus: selectedBus),
                //     // Assuming you have a CountdownPage widget and selectedBus variable
                //   ),
                // );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// class Bus {
//   final String busName;
//   final String arrivalTime;
//   //final latLng busLocation

//   Bus({required this.busName, required this.arrivalTime});
// }
