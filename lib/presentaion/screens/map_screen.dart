import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/helper/location_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static Position? currentPosition;

  Future getCurrentPosition() async {
    await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  static final CameraPosition _userCameraPosition = CameraPosition(
      bearing: 195,
      target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
      tilt: 59.440717697143555,
      zoom: 19.15);

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition != null
          ? buildMapsView()
          : Center(
              child: CircularProgressIndicator(
                color: AppColor.iconsColor,
              ),
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: AppColor.shapesColor,
          borderRadius: const BorderRadius.all(Radius.circular(80)),
        ),
        child: FloatingActionButton(
          onPressed: _goToTheCurrentLocation,
          child: const Icon(Icons.place),
          backgroundColor: AppColor.iconsColor,
        ),
      ),
    );
  }

  Widget buildMapsView() {
    return GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition: _userCameraPosition,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> _goToTheCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_userCameraPosition));
  }
}
