import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_charts/src/controllers/choropleth_map_controller.dart';
import 'package:flutter_map_charts/src/tile_providers/flutter_map_zoom_buttons.dart';
import 'package:flutter_map_charts/src/tile_providers/open_street.dart';
import 'package:flutter_map_charts/src/views/base_map_widget.dart';

class ChoroplethMapWidget extends BaseMapWidget {
  final ChoroplethMapController controller;

  const ChoroplethMapWidget({super.key, required this.controller})
      : super(controller: controller);

  @override
  List<Widget> buildChildren(BuildContext context) {
    // Choropleth map specific children
    return [
      openStreetMapTileLayer,
      const FlutterMapZoomButtons(
        minZoom: 4,
        maxZoom: 19,
        mini: true,
        padding: 10,
        alignment: Alignment.bottomLeft,
      ),
      
      PolygonLayer(
        polygons: controller.statesData.map((state) {
          return Polygon(
            points: state.points, // The LatLng points for the polygon
            color: controller.determineColorForValue(state.value).withOpacity(0.7),
            borderStrokeWidth: 0.5,
            borderColor: Colors.black,
            isFilled: true,
          );
        }).toList(),
      ),
    ];
  }
}
