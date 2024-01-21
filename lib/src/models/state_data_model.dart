import 'package:latlong2/latlong.dart';

class StateDataModel {
  String id; // Could be a state code or identifier
  double value; // The value that determines the color intensity for the state
  String label; // Optional label for the state
  List<LatLng> points; // The LatLng points for the polygon

  StateDataModel({
    required this.id,
    required this.value,
    this.label = '',
    required this.points,
  });
}
