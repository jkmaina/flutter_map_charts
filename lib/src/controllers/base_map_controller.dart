import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

abstract class BaseMapController extends GetxController {
  MapController mapController;
  Rx<LatLng> center;
  RxDouble zoom;
  Logger logger;

  BaseMapController(
      {required LatLng initialCenter, required double initialZoom})
      : mapController = MapController(),
        center = Rx<LatLng>(initialCenter),
        zoom = RxDouble(initialZoom),
        logger = Logger(
          level: Level.warning,
          printer: PrettyPrinter(),
        ) {
    //initialize logger
    _setupLogging();
  }

  // Common functionality to be shared by all map controllers
  void _setupLogging() {
    // Change log level to info in debug mode
    assert(() {
      logger = Logger(
        level: Level.info,
      );
      return true;
    }());
  }
}
