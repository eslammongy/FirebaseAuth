import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/helper/location_helper.dart';
import 'package:flutter_maps/presentaion/widget/mydrawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  FloatingSearchBarController searchBarController = FloatingSearchBarController();

  static Position? currentPosition;

  Future getCurrentPosition() async {
    currentPosition = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  static final CameraPosition _userCameraPosition = CameraPosition(
      bearing: 50,
      target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
      tilt: 59.440717697143555,
      zoom: 10.5);

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
        currentPosition != null
            ? buildMapsView()
            : Center(
          child: CircularProgressIndicator(
            color: AppColor.iconsColor,
          ),
        ),
          buildMaterialSearchBar()
      ],),
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
      drawer: MainDrawer(),
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
    controller.animateCamera(CameraUpdate.newCameraPosition(_userCameraPosition));
  }

  Widget buildMaterialSearchBar(){
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'find place...',
      controller: searchBarController,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 50),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      height: 60,
      margins: const EdgeInsets.symmetric(horizontal: 15 , vertical: 60),
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      onFocusChanged: (_){},
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
