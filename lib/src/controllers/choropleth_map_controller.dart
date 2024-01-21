import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_charts/src/controllers/base_map_controller.dart';
import 'package:flutter_map_charts/src/models/state_data_model.dart';
import 'package:flutter_map_charts/src/services/geojson_service.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class ChoroplethMapController extends BaseMapController {
  var statesData = RxList<StateDataModel>();
  final GeoJsonService _geoJsonService = GeoJsonService();

// Constructor
  ChoroplethMapController(
      {required super.initialCenter, required super.initialZoom});

  void setStateData(List<StateDataModel> data) {
    statesData.assignAll(data);
    logger.i('State data set');
  }

  Future<void> loadStateData() async {
    try {
      var loadedStates = await _geoJsonService.loadStatesFromGeoJson();
      setStateData(loadedStates);
      logger.i('State data loaded');
    } catch (e) {
      logger.e('Error loading state data: $e');
    }
  }

  List<Polygon> get polygons => statesData.map((state) {
        return Polygon(
          points:
              getPointsForState(state.id), // You need to implement this method
          color: determineColorForValue(state.value).withOpacity(0.7),
          borderStrokeWidth: 0.5,
          borderColor: Colors.black,
          isFilled: true,
        );
      }).toList();

  Color determineColorForValue(double value) {
    // Map value which can range from 0 to 250 to a color between light and dark blue
    double normalizedValue =
        value / 250; // Normalize value to a range of 0 to 1
    int red =
        135; // Keeping red and green at fixed values to stay within the blue spectrum
    int green = 206;
    int blue = (255 * normalizedValue)
        .clamp(100, 255)
        .toInt(); // Interpolate blue value
    logger.d('Color determined for value: $value');
    return Color.fromARGB(255, red, green, blue);
  }

  // Implement this method to return the points for a given state
  List<LatLng> getPointsForState(String stateId) {
    // Your logic to return the points (LatLng) for the given state
    // This could be a lookup in a map, fetching from a database, etc.
    logger.d('Points fetched for state: $stateId');
    return []; // Placeholder, replace with actual logic
  }
}
