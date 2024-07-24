// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_collection_literals, use_key_in_widget_constructors, must_be_immutable, file_names, no_leading_underscores_for_local_identifiers

import 'package:addis_bus_mgt_passenger/Repositories/CustomerRepo.dart';
import 'package:addis_bus_mgt_passenger/Repositories/myUtiils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../../Repositories/Localizations.dart';
import '../../../Repositories/ScreenColors.dart';
import '../CustomWidgets/CustomeWidgets.dart';

class StationPicker extends StatefulWidget {
  final VoidCallback refereshState;
  dynamic jsonResult;
  final bool pickFirstStation;
  StationPicker({
    required this.pickFirstStation,
    required this.refereshState,
    required this.jsonResult,
  });

  @override
  State<StationPicker> createState() => _StationPickerState();
}

class _StationPickerState extends State<StationPicker> {
  List<Marker> filteredMarkers = [];

  List<Marker> allMarkers = [];

  bool onlyStationsNearMe = false;

  @override
  void initState() {
    super.initState();
    allMarkers = widget.jsonResult?["stations_list"].map<Marker>((station) {
      double latitude = double.parse(station['station_coordinate']['lat']);
      double longitude = double.parse(station['station_coordinate']['long']);
      String name = station['station_name'];

      return Marker(
        width: 50,
        height: 50,
        point: LatLng(latitude, longitude),
        child: InkWell(
          onTap: () {
            if (widget.pickFirstStation) {
              CustomerRepo.customerModel.startStation = name;
            } else {
              CustomerRepo.customerModel.endStation = name;
            }
            widget.refereshState();
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(223, 162, 174, 224),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Icon(Icons.location_on),
                Text(
                  name,
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
        ),
      );
    }).toList();

    filteredMarkers = allMarkers;
  }

  @override
  Widget build(BuildContext context) {
    final locMgrProv = Provider.of<LocalizationManager>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'), // Path to your image
              fit: BoxFit.cover, // Cover the entire app bar
            ),
          ),
        ),
        leading: Icon(
          Icons.bus_alert,
          color: Colors.white,
        ),
        title: Text(
          locMgrProv.getText('Pick Station'),
          style: TextStyle(color: MyColors.lightBlueText),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardW = constraints.maxWidth;
          double cardH = constraints.maxHeight;

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg2.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            width: cardW,
            height: cardH,
            child: Column(
              children: [
                SizedBox(height: 10),
                Builder(
                  builder: (context) {
                    if (widget.jsonResult?.isEmpty || widget.jsonResult?['stations_list'].length == 0) {
                      return Center(
                        child: Text("No Station Found!"),
                      );
                    } else {
                      return Column(
                        children: [
                          if (widget.pickFirstStation == true)
                            ListTile(
                              leading: Text(
                                "Only Near By Stations",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              trailing: Switch(
                                value: onlyStationsNearMe,
                                onChanged: (value) async {
                                  if (value == true) {
                                    try {
                                      Location location = Location();

                                      bool _serviceEnabled;
                                      PermissionStatus _permissionGranted;

                                      _serviceEnabled = await location.serviceEnabled();
                                      if (!_serviceEnabled) {
                                        _serviceEnabled = await location.requestService();
                                        if (!_serviceEnabled) {
                                          throw 'Location not Enabled';
                                        }
                                      }

                                      _permissionGranted = await location.hasPermission();
                                      if (_permissionGranted == PermissionStatus.denied) {
                                        _permissionGranted = await location.requestPermission();
                                        if (_permissionGranted != PermissionStatus.granted) {
                                          throw 'Location Permisson not Granted';
                                        }
                                      }

                                      LocationData _locationData = await location.getLocation();

                                      double deviceLat = _locationData.latitude ?? 0;
                                      double deviceLng = _locationData.longitude ?? 0;
                                      print(deviceLat.toString() + " " + deviceLng.toString());

                                      setState(() {
                                        filteredMarkers = allMarkers.where((marker) {
                                          double distanceInMeters = MyUtils.calculateDirectDistance(
                                            deviceLat,
                                            deviceLng,
                                            marker.point.latitude,
                                            marker.point.longitude,
                                          );
                                          return distanceInMeters <= 1000;
                                        }).toList();

                                        filteredMarkers.add(Marker(
                                            point: LatLng(deviceLat, deviceLng),
                                            child: CircleAvatar(
                                              child: Text("Me"),
                                            )));

                                        // Debugging: Print filtered markers
                                        print('Filtered Markers:');
                                        filteredMarkers.forEach((marker) {
                                          print(marker.point);
                                        });
                                        onlyStationsNearMe = value;
                                      });
                                    } catch (err) {
                                      MyCustomSnackBar(
                                              context: context, message: err.toString(), leadingIcon: Icons.close_rounded, leadingIconColor: Colors.white, bgColor: Colors.red)
                                          .show();
                                    }
                                  } else {
                                    setState(() {
                                      filteredMarkers = allMarkers;
                                      onlyStationsNearMe = value;
                                    });
                                  }
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ),
                          Card(
                            elevation: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                width: cardW * 0.9,
                                height: cardH * 0.7,
                                child: FlutterMap(
                                  options: MapOptions(
                                    initialCenter: LatLng(9.0192, 38.7525),
                                    initialZoom: 13,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.example.app',
                                    ),
                                    MarkerLayer(
                                      markers: filteredMarkers,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Expanded(child: SizedBox()),
                MyCustomAsyncButton(
                    btnWidth: cardW * 0.9,
                    btnText: locMgrProv.getText('return'),
                    btnOnTap: () async {
                      Navigator.pop(context);
                    }),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
