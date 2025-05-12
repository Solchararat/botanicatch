class PlantModel {
  final int plantId;
  final String scientificName;
  final String commonName;
  final String family;
  final String description;
  final List<String> type;
  final int confidence;
  String imageURL;

  PlantModel({
    required this.plantId,
    required this.scientificName,
    required this.commonName,
    required this.family,
    required this.description,
    required this.type,
    required this.confidence,
    required this.imageURL,
  });

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
        plantId: json['plant_id'] ?? 0,
        scientificName: json['scientific_name'] ?? '',
        commonName: json['common_name'] ?? '',
        family: json['family'] ?? '',
        description: json['description'] ?? '',
        type: List<String>.from(json['type'] ?? []),
        confidence: json['confidence'] ?? 0,
        imageURL: json["imageURL"] ?? "");
  }

  Map<String, dynamic> toJson() => {
        'plant_id': plantId,
        'scientific_name': scientificName,
        'common_name': commonName,
        'family': family,
        'description': description,
        'type': type,
        'confidence': confidence,
        'imageURL': imageURL,
      };
}
