import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesMap extends StatefulWidget {
  @override
  _PlacesMapState createState() => _PlacesMapState();
}

class _PlacesMapState extends State<PlacesMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(53.223240, -3.070670),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(53.223240, -3.070670),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  List<Marker> markers = []; // CLASS MEMBER, MAP OF MARKS

  void _add(LatLng tappedPoint) {
    setState(() {
      //markers = [];
      markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
      ));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(markers),
        onTap: _add,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
