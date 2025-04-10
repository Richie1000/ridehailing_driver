class PredictionModel {
  final String placeId;
  final String mainText;
  final String secondaryText;
  final double? lat;
  final double? lng;

  PredictionModel({
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
    this.lat,
    this.lng,
  });

  // Factory method to create an instance from JSON
  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      placeId: json['place_id'],
      mainText: json['structured_formatting']['main_text'],
      secondaryText: json['structured_formatting']['secondary_text'] ?? '',
    );
  }
}
