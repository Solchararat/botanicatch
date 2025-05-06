import 'dart:async';
import 'dart:developer';

import 'package:botanicatch/services/shared_preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late final GoogleMapController _mapController;
  static final Location _locationController = Location();
  final ValueNotifier<LatLng> _currentPosition =
      ValueNotifier(const LatLng(0, 0));
  StreamSubscription<LocationData>? _locationSubscription;
  final SharedPrefsService _prefsService = SharedPrefsService.instance;

  @override
  void initState() {
    super.initState();
    _loadCachedPosition();
    _getLocationUpdates();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _currentPosition.dispose();
    super.dispose();
  }

  void _loadCachedPosition() {
    final cached = _prefsService.getCachedPosition();
    if (cached != null) {
      _currentPosition.value = cached;
    }
  }

  Future<void> _cachePosition(LatLng position) async {
    await _prefsService.cachePosition(position);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _cameraToPosition(LatLng position) async {
    CameraPosition newCameraPosition =
        CameraPosition(target: position, zoom: 19.5);

    await _mapController
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> _getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData initialLocation;

    final List<dynamic> results = await Future.wait([
      _locationController.serviceEnabled(),
      _locationController.hasPermission(),
      _locationController.getLocation(),
    ]);

    serviceEnabled = results[0];
    permissionGranted = results[1];
    initialLocation = results[2];

    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final LatLng initialPosition =
        LatLng(initialLocation.latitude!, initialLocation.longitude!);

    _currentPosition.value = initialPosition;
    _cachePosition(initialPosition);
    _cameraToPosition(_currentPosition.value);

    _locationController.changeSettings(
      interval: 1000,
      distanceFilter: 5,
    );

    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        final LatLng newPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);

        _currentPosition.value = newPosition;
        _cachePosition(newPosition);
        _cameraToPosition(_currentPosition.value);
        log("${_currentPosition.value}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: false,
      right: false,
      bottom: false,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentPosition.value,
          zoom: 19.5,
        ),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
