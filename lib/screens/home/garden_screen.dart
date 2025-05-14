import 'dart:typed_data';

import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/services/db/db_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/cards/plant_item.dart';
import 'package:botanicatch/widgets/profile/profile_picture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GardenScreen extends StatefulWidget {
  final ValueNotifier<Uint8List?> profileImgBytes;
  const GardenScreen({super.key, required this.profileImgBytes});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  late Stream<List<QueryDocumentSnapshot>> _plantsStream;
  UserModel? _user;
  List<QueryDocumentSnapshot> _allPlants = [];
  List<QueryDocumentSnapshot> _filteredPlants = [];
  final TextEditingController _searchController = TextEditingController();

  final double _logoHeight = 45.0;
  final double _profilePicSize = 50.0;
  final double _verticalSpacing = 16.0;
  final double _horizontalPadding = 8.0;
  final double _searchBarHeightEstimate = 50.0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _user = Provider.of<UserModel?>(context);
    if (_user != null && _user!.uid != null) {
      final databaseService = DatabaseService(uid: _user!.uid!);
      _plantsStream = databaseService.plantsStreamAscending;
    }
    super.didChangeDependencies();
  }

  void _onSearchChanged() {
    _filterPlants(_searchController.text);
  }

  void _filterPlants(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        _filteredPlants = List.from(_allPlants);
      } else {
        _filteredPlants = _allPlants.where((doc) {
          final plant = PlantModel.fromJson(doc.data() as Map<String, dynamic>);
          return plant.commonName
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              plant.scientificName
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase());
        }).toList();
      }
    });
  }

  Widget _buildItem(
      BuildContext context, int index, QueryDocumentSnapshot doc) {
    final plant = PlantModel.fromJson(doc.data() as Map<String, dynamic>);
    return PlantItem(
      plant: plant,
      plantId: plant.plantId.toString(),
      profileImgBytes: widget.profileImgBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      imagePath: "assets/images/home-bg.jpg",
      child: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: _plantsStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: kGreenColor300,
                  ));
                }

                _allPlants = snapshot.data!;

                if (_filteredPlants.isEmpty) {
                  _filteredPlants = List.from(_allPlants);
                }

                if (orientation == Orientation.landscape) {
                  return _buildLandscapeLayout(_filteredPlants);
                } else {
                  return _buildPortraitLayout(_filteredPlants);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(List<QueryDocumentSnapshot> plants) {
    return Padding(
      padding: EdgeInsets.all(_horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: _profilePicSize),
              SvgPicture.asset("assets/images/botanicatch.svg",
                  height: _logoHeight),
              ProfilePicture(
                profileImgBytes: widget.profileImgBytes,
                width: _profilePicSize,
                height: _profilePicSize,
              ),
            ],
          ),
          SizedBox(height: _verticalSpacing),
          TextSelectionTheme(
            data: const TextSelectionThemeData(
              selectionHandleColor: kGreenColor300,
              cursorColor: kGreenColor300,
            ),
            child: TextFormField(
              style: kSmallTextStyle,
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: kGreenColor300),
                hintText: "Search Plant",
                contentPadding: const EdgeInsets.all(12),
                hintStyle: kXXSmallTextStyle.copyWith(color: kGreenColor300),
                border: kGardenOutlineInputBorder,
                enabledBorder: kGardenOutlineInputBorder,
                focusedBorder: kGardenOutlineInputBorder,
                errorBorder: kGardenOutlineInputBorder,
                focusedErrorBorder: kGardenOutlineInputBorder,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: kGreenColor300),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(height: _verticalSpacing),
          Expanded(
            child: plants.isEmpty
                ? Center(
                    child: Text(
                      "No plants found",
                      style: kSmallTextStyle.copyWith(color: kGreenColor300),
                    ),
                  )
                : GridView.builder(
                    itemCount: plants.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) =>
                        _buildItem(context, index, plants[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(List<QueryDocumentSnapshot> plants) {
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
                      SvgPicture.asset(
                        "assets/images/botanicatch.svg",
                        height: _logoHeight,
                      ),
                      ProfilePicture(
                        profileImgBytes: widget.profileImgBytes,
                        width: _profilePicSize,
                        height: _profilePicSize,
                      ),
                    ],
                  ),
                  SizedBox(height: _verticalSpacing),
                  TextFormField(
                    controller: _searchController,
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
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear,
                                  color: kGreenColor300),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        plants.isEmpty
            ? SliverFillRemaining(
                child: Center(
                  child: Text(
                    "No plants found",
                    style: kSmallTextStyle.copyWith(color: kGreenColor300),
                  ),
                ),
              )
            : SliverPadding(
                padding: EdgeInsets.all(_horizontalPadding),
                sliver: SliverGrid.builder(
                  itemCount: plants.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) =>
                      _buildItem(context, index, plants[index]),
                ),
              ),
      ],
    );
  }
}
