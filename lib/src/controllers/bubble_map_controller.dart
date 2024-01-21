import 'package:flutter_map_charts/src/controllers/base_map_controller.dart';
import 'package:flutter_map_charts/src/models/bubble_model.dart';
import 'package:get/get.dart';

class BubbleMapController extends BaseMapController {
  // Use RxList for reactivity in GetX
  var bubbles = RxList<BubbleModel>();

  BubbleMapController(
      {required super.initialCenter, required super.initialZoom});

  void addBubble(BubbleModel bubble) {
    bubbles.add(bubble);
    logger.i('Bubble added: ${bubble.label}');
  }
}
