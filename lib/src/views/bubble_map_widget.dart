import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_charts/src/controllers/bubble_map_controller.dart';
import 'package:flutter_map_charts/src/tile_providers/flutter_map_zoom_buttons.dart';
import 'package:flutter_map_charts/src/tile_providers/open_street.dart';
import 'package:flutter_map_charts/src/views/base_map_widget.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class BubbleMapWidget extends BaseMapWidget {
  final BubbleMapController controller;

  const BubbleMapWidget({super.key, required this.controller})
      : super(controller: controller);

  @override
  List<Widget> buildChildren(BuildContext context) {
    // Bubble map specific children
    return [
      openStreetMapTileLayer,
      const FlutterMapZoomButtons(
        minZoom: 4,
        maxZoom: 19,
        mini: true,
        padding: 10,
        alignment: Alignment.bottomLeft,
      ),
      MarkerLayer(
        markers: controller.bubbles.map((bubble) {
          return Marker(
            point: LatLng(bubble.latitude, bubble.longitude),
            width: bubble.size,
            height: bubble.size,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.7),
              ),
            ),
          );
        }).toList(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => FlutterMap(
          mapController: controller.mapController,
          options: MapOptions(
            center: controller.center.value,
            zoom: controller.zoom.value,
          ),
          children: buildChildren(context),
        ));
  }
}
