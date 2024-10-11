import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class Mapswithmarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrentLocationScreen(),
    );
  }
}

class CurrentLocationScreen extends StatefulWidget {
  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  GoogleMapController? _controller;
  Location _location = Location();
  final Set<Marker> _markers = {};

  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // Default to San Francisco
    zoom: 14,
  );

  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var currentLocation = await _location.getLocation();
    setState(() {
      _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });

    if (_controller != null && _currentPosition != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLng(_currentPosition!),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    // _location.onLocationChanged.listen((locationData) {
    //   if (locationData != null && _controller != null) {
    //     _controller!.animateCamera(
    //       CameraUpdate.newLatLng(
    //         LatLng(locationData.latitude!, locationData.longitude!),
    //       ),
    //     );
    //   }
    // });
  }

  void _setMarkerAndMoveCamera(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });

    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLngZoom(position, 14.0),
      );
    }
  }

  void handleMarker() {
    FocusScope.of(context).unfocus();
    final _lat = double.parse(latController.text);
    final _long = double.parse(longController.text);
    final latlng = LatLng(_lat, _long);
    _setMarkerAndMoveCamera(latlng);
  }

  void handleClearMarker() {
    setState(() {
      _markers.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(child:
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
            // onTap: (LatLng tappedPosition) {
            //   _setMarkerAndMoveCamera(tappedPosition);
            // },
          )),
          Padding(
            padding: EdgeInsets.all(10) ,
            child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: latController,
                decoration: InputDecoration(
                    label: Text('latitude')
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: longController,
                decoration: InputDecoration(
                    label: Text('longitude')
                ),
              ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10) ,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: handleMarker, child: Text('Mark')
                    ),
                    )
                ),
                Expanded(
                    child:  Padding(
                        padding: EdgeInsets.all(10) ,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: handleClearMarker, child: Text('Clear')
                        )
                    )
                ),
               ],
             )
            ],
          ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
