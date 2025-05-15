import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserManualScreen extends StatelessWidget {
  const UserManualScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        imagePath: "assets/images/home-bg.jpg",
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    Text('User Manual',
                        style: kLargeTextStyle.copyWith(
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Getting Started',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome to BOTANICATCH, your personal plant identification and collection app. This guide will help you navigate through the app\'s features and functionalities.',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.shade900.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.amber),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Pro Tip: Use the camera button at the bottom of the screen to quickly identify plants around you!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Main Features',
                  content: Column(
                    children: [
                      _buildFeatureItem(
                        number: 1,
                        title: 'Plant Identification',
                        description:
                            'Take a photo of any plant to instantly identify its species, common name, and characteristics.',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        number: 2,
                        title: 'Personal Garden',
                        description:
                            'Save identified plants to your personal garden collection for future reference.',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        number: 3,
                        title: 'Plant Care Tips',
                        description:
                            'Access detailed care instructions for each plant in your collection.',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        number: 4,
                        title: 'Location Mapping',
                        description:
                            'Map where you\'ve found different plant species and discover nearby botanical hotspots.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Achievements',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Earn badges and achievements as you identify more plants and grow your collection:',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _buildAchievementBadge(
                              asset: 'assets/images/first-leaf-badge.svg',
                              name: 'First Leaf',
                              description: 'Discover 1 plant',
                            ),
                            _buildAchievementBadge(
                              asset: 'assets/images/leaf-collector-badge.svg',
                              name: 'Leaf Collector',
                              description: 'Discover 10 different plants',
                            ),
                            _buildAchievementBadge(
                              asset: 'assets/images/native-botanist-badge.svg',
                              name: 'Native Botanist',
                              description:
                                  'Discover 5 different native type plants',
                            ),
                            _buildAchievementBadge(
                              asset:
                                  'assets/images/plantdex-apprentice-badge.svg',
                              name: 'Master',
                              description: 'Discover 30 different plants',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Need Help?',
                  content: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'If you have any questions or need assistance, please contact our support team:',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.white70, size: 16),
                          SizedBox(width: 8),
                          Text('support@botanicatch.com',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.white70, size: 16),
                          SizedBox(width: 8),
                          Text('1-800-PLANTS',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade500.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kGreenColor100,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required int number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge({
    required String asset,
    required String name,
    required String description,
  }) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: SvgPicture.asset(
              asset,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
