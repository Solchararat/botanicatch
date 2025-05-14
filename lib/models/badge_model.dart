class BadgeModel {
  final String id;
  final String name;
  final String description;
  final String assetPath;
  final String unlockedAssetPath;
  final bool isUnlocked;

  BadgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.assetPath,
    required this.unlockedAssetPath,
    this.isUnlocked = false,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      assetPath: json['asset_path'] ?? '',
      unlockedAssetPath: json['unlocked_asset_path'] ?? '',
      isUnlocked: json['is_unlocked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'asset_path': assetPath,
        'unlocked_asset_path': unlockedAssetPath,
        'is_unlocked': isUnlocked,
      };

  BadgeModel copyWith({
    String? id,
    String? name,
    String? description,
    String? assetPath,
    String? unlockedAssetPath,
    bool? isUnlocked,
  }) {
    return BadgeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      assetPath: assetPath ?? this.assetPath,
      unlockedAssetPath: unlockedAssetPath ?? this.unlockedAssetPath,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
