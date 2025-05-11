class PlantModel {
  final String scientificName;
  final String commonName;
  final String family;
  final String description;
  final List<String> type;
  final int confidence;

  PlantModel({
    required this.scientificName,
    required this.commonName,
    required this.family,
    required this.description,
    required this.type,
    required this.confidence,
  });

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      scientificName: json['scientific_name'] ?? '',
      commonName: json['common_name'] ?? '',
      family: json['family'] ?? '',
      description: json['description'] ?? '',
      type: List<String>.from(json['type'] ?? []),
      confidence: json['confidence'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'scientific_name': scientificName,
        'common_name': commonName,
        'family': family,
        'description': description,
        'type': type,
        'confidence': confidence,
      };
}
