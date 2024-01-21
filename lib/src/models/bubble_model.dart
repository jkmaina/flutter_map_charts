class BubbleModel {
  double latitude;
  double longitude;
  double size; // Determines the size of the bubble
  String label; // Optional label for the bubble

  BubbleModel({
    required this.latitude,
    required this.longitude,
    required this.size,
    this.label = '',
  });
}
