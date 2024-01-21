import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_charts/src/controllers/base_map_controller.dart';

abstract class BaseMapWidget extends StatelessWidget {
  final BaseMapController controller;

  const BaseMapWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller.mapController,
      options: MapOptions(
        initialCenter: controller.center.value,
        initialZoom: controller.zoom.value,
      ),
      // Add children that are specific to bubble or choropleth map
      children: buildChildren(context),
    );
  }

  List<Widget> buildChildren(BuildContext context);
}


