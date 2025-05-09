import 'dart:typed_data';

import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/cards/plant_item.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  late final ValueNotifier<Uint8List?> _profileImgBytes;
  late List<Map<String, String>> _plants;
  final double _logoHeight = 45.0;
  final double _profilePicSize = 50.0;
  final double _verticalSpacing = 16.0;
  final double _horizontalPadding = 8.0;
  final double _searchBarHeightEstimate = 50.0;

  @override
  void initState() {
    super.initState();
    _profileImgBytes = ValueNotifier<Uint8List?>(null);
    _plants = _fetchPlants();
  }

  @override
  void dispose() {
    _profileImgBytes.dispose();
    super.dispose();
  }

  // TODO: Implement mock function to populate gridview builder
  // TODO: Implement list of mock objects (plants)
  final List<Map<String, String>> _list = [
    {
      "plant_id": "1",
      "common_name": "Aloe Vera",
      "scientific_name": "Aloe barbadensis miller",
      "description":
          "Aloe Vera is a popular succulent known for its soothing and healing properties. It is a hardy plant that brings a refreshing aesthetic to any indoor or outdoor setting, while also offering medicinal benefits for skin care and overall wellness.",
      "type": "succulent",
    },
    {
      "plant_id": "2",
      "common_name": "Snake Plant",
      "scientific_name": "Sansevieria trifasciata",
      "description":
          "The Snake Plant, or Mother-in-Law's Tongue, is a resilient and low-maintenance indoor plant. Its striking upright leaves add a modern touch to decor, and it's known for its air-purifying qualities, making it a practical and stylish choice.",
      "type": "houseplant",
    },
    {
      "plant_id": "3",
      "common_name": "Rose",
      "scientific_name": "Rosa spp.",
      "description":
          "Roses are classic flowering shrubs admired for their beautiful blooms and fragrant flowers. Available in a wide variety of colors and forms, they are a popular choice for gardens and bouquets, symbolizing love and beauty.",
      "type": "shrub",
    },
    {
      "plant_id": "4",
      "common_name": "Orchid",
      "scientific_name": "Orchidaceae",
      "description":
          "Orchids are elegant and diverse flowering plants known for their intricate and often exotic blooms. They are prized for their beauty and are popular as ornamental houseplants, adding a touch of sophistication to any space.",
      "type": "houseplant",
    },
    {
      "plant_id": "5",
      "common_name": "Sunflower",
      "scientific_name": "Helianthus annuus",
      "description":
          "Sunflowers are tall and vibrant annual plants with large, daisy-like flower heads. Known for their heliotropism (following the sun), they bring cheerfulness to gardens and are also cultivated for their edible seeds and oil.",
      "type": "annual",
    },
    {
      "plant_id": "12",
      "common_name": "Fiddle Leaf Fig",
      "scientific_name": "Ficus lyrata",
      "description":
          "A popular statement houseplant with large, violin-shaped leaves.",
      "type": "houseplant",
    },
    {
      "plant_id": "105",
      "common_name": "Lavender",
      "scientific_name": "Lavandula angustifolia",
      "description":
          "A fragrant herb known for its calming properties and purple flowers.",
      "type": "herb",
    },
  ];

  // mock function to fetch items
  List<Map<String, String>> _fetchPlants() {
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      imagePath: "assets/images/home-bg.jpg",
      child: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              return _buildLandscapeLayout();
            } else {
              return _buildPortraitLayout();
            }
          },
        ),
      ),
    );
  }

  _buildPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 45),
              Image.asset(
                "assets/images/logo-small.png",
                height: 45,
                fit: BoxFit.contain,
              ),
              ProfilePicture(
                profileImgBytes: _profileImgBytes,
                width: 50,
                height: 50,
              )
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: kGreenColor300,
              ),
              hintText: "Search Plant",
              contentPadding: const EdgeInsets.all(12),
              hintStyle: kXXSmallTextStyle.copyWith(color: kGreenColor300),
              border: kGardenOutlineInputBorder,
              enabledBorder: kGardenOutlineInputBorder,
              focusedBorder: kGardenOutlineInputBorder,
              errorBorder: kGardenOutlineInputBorder,
              focusedErrorBorder: kGardenOutlineInputBorder,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildGrid(2)),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    final double appBarContentHeight = _logoHeight +
        _verticalSpacing +
        _searchBarHeightEstimate +
        _verticalSpacing;

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: false,
          floating: false,
          snap: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          expandedHeight: appBarContentHeight,
          toolbarHeight: 0.1,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: _profilePicSize),
                      Image.asset(
                        "assets/images/logo-small.png",
                        height: _logoHeight,
                        fit: BoxFit.contain,
                      ),
                      ProfilePicture(
                        profileImgBytes: _profileImgBytes,
                        width: _profilePicSize,
                        height: _profilePicSize,
                      )
                    ],
                  ),
                  SizedBox(height: _verticalSpacing),
                  // Search Field
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.search, color: kGreenColor300),
                      hintText: "Search Plant",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle:
                          kXXSmallTextStyle.copyWith(color: kGreenColor300),
                      border: kGardenOutlineInputBorder,
                      enabledBorder: kGardenOutlineInputBorder,
                      focusedBorder: kGardenOutlineInputBorder,
                      errorBorder: kGardenOutlineInputBorder,
                      focusedErrorBorder: kGardenOutlineInputBorder,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(_horizontalPadding),
          sliver: _buildSliverGrid(3),
        ),
      ],
    );
  }

  _buildGrid(int numColumns) {
    return GridView.builder(
        itemCount: _plants.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: numColumns,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) => _buildItem(index));
  }

  Widget _buildItem(int index) {
    final plantData = _plants[index];
    final plantId = plantData["plant_id"]?.padLeft(3, "0") ?? "000";
    final commonName = plantData["common_name"] ?? "Unknown";
    final scientificName = plantData["scientific_name"];
    final description = plantData["description"];
    final type = plantData["type"];

    return PlantItem(
      plantId: plantId,
      commonName: commonName,
      scientificName: scientificName,
      description: description,
      type: type,
      profileImgBytes: _profileImgBytes,
    );
  }

  Widget _buildSliverGrid(int numColumns) {
    return SliverGrid.builder(
        itemCount: _plants.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numColumns,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => _buildItem(index));
  }
}
