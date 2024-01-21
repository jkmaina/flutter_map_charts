import 'package:flutter/material.dart';
import 'package:flutter_map_charts/flutter_map_charts.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Map Charts Example',
      home: MapsExamplePage(),
    );
  }
}

class MapsExamplePage extends StatelessWidget {
  const MapsExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Example'),
      ),
      body: ListView(
        children: const [
          BubbleMapExample(),
          SizedBox(height: 20),
          ChoroplethMapExample(),
        ],
      ),
    );
  }
}

class BubbleMapExample extends StatelessWidget {
  const BubbleMapExample({super.key});

  @override
  Widget build(BuildContext context) {
    final bubbleMapController = Get.put(BubbleMapController(
      initialCenter: const LatLng(39.8283, -98.5795), // Center of the US
      initialZoom: 4.0,
    ));

    // Add some sample bubbles
    bubbleMapController.addBubble(BubbleModel(
        latitude: 40.7128, longitude: -74.0060, size: 30)); // New York
    bubbleMapController.addBubble(BubbleModel(
        latitude: 34.0522, longitude: -118.2437, size: 20)); // Los Angeles

    return Obx(() => SizedBox(
          height: 300,
          child: bubbleMapController.bubbles.isNotEmpty
              ? BubbleMapWidget(controller: bubbleMapController)
              : const Center(child: CircularProgressIndicator()),
        ));
  }
}

class ChoroplethMapExample extends StatelessWidget {
  const ChoroplethMapExample({super.key});

  @override
  Widget build(BuildContext context) {
    final choroplethMapController = Get.put(ChoroplethMapController(
      initialCenter: const LatLng(39.8283, -98.5795), // Center of the US
      initialZoom: 5.0,
    ));

    // Load state data asynchronously
    return FutureBuilder(
      future: choroplethMapController.loadStateData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Check for errors and handle the loaded state
          return SizedBox(
            height: 300,
            child: ChoroplethMapWidget(controller: choroplethMapController),
          );
        } else {
          // Data is still loading
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
