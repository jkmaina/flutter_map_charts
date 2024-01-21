import 'package:latlong2/latlong.dart';

class CountryDataModel {
  String isoCode; // ISO Alpha-3 country code
  String name; // Country name
  List<LatLng> points; // The LatLng points for the country polygon
  double value; // The value that determines the color intensity for the country

  CountryDataModel({
    required this.isoCode,
    required this.name,
    required this.points,
    required this.value, // Ensure this parameter is passed when initializing
  });
}
