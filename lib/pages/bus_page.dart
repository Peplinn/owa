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
import 'package:intl/intl.dart';

class BusPage extends StatefulWidget {
  final String origin;
  final String destination;

  const BusPage({Key? key, required this.origin, required this.destination})
      : super(key: key);

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  List<Bus> _buses = []; // Empty list to store bus data
  List<String> directions = ["Southbound", "Northbound"];
  List<String> statuses = ["Active", "Inactive"];
  Random random = Random();
  DateTime currentTime = DateTime.now();


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
      _buses = [
        Bus(
            name: "Bus 123",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 456",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 23",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 235",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 6346",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 28",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 72",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 28",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 86",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 62",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 48",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 29",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 542",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 82",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 72",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
        Bus(
            name: "Bus 63",
            arrivalTime: currentTime.add(Duration(minutes: random.nextInt(60))),
            direction: directions[random.nextInt(directions.length)],
            status: statuses[random.nextInt(statuses.length)]),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Buses"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _buses.length,
        separatorBuilder: (context, index) => const Divider(
          indent: 20,
          endIndent: 20,
        ),
        itemBuilder: (context, index) {
          final bus = _buses[index];
          return ListTile(
              onTap: () {},
              title: Text(bus.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              // subtitle: Text("Arriving at: ${bus.arrivalTime}"),
              subtitle: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Direction: ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "${bus.direction}\n",
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "Arriving at: ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "${DateFormat('Hm').format(bus.arrivalTime)}\n",
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "Status: ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "${bus.status}",
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold)),
                ]),
              ));
        },
      ),
    );
  }
}

class Bus {
  final String name;
  final DateTime arrivalTime;
  final String direction;
  final String status;

  Bus(
      {required this.name,
      required this.arrivalTime,
      required this.direction,
      required this.status});
}
