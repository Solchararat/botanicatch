import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  SharedPrefsService._internal();
  static SharedPrefsService? _instance;
  static SharedPrefsService get instance =>
      _instance ??= SharedPrefsService._internal();

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> cachePosition(LatLng position) async {
    await Future.wait([
      _prefs.setDouble('cached_lat', position.latitude),
      _prefs.setDouble('cached_lng', position.longitude),
    ]);
  }

  LatLng? getCachedPosition() {
    final lat = _prefs.getDouble('cached_lat');
    final lng = _prefs.getDouble('cached_lng');
    return lat != null && lng != null ? LatLng(lat, lng) : null;
  }
}
