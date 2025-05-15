import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Privacy Policy',
                      style:
                          kLargeTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Introduction',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'At BOTANICATCH, we take your privacy seriously. This Privacy Policy explains how we collect, use, and protect your personal information when you use our app.',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Last Updated: May 15, 2025',
                        style: TextStyle(
                          color: kGreenColor100,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade900.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.green.shade700,
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'By using BOTANICATCH, you agree to the collection and use of information in accordance with this policy.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Information We Collect',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoItem(
                        icon: Icons.person_outline,
                        title: 'Personal Information',
                        description:
                            'When you create an account, we collect your name, email address, and profile picture.',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoItem(
                        icon: Icons.data_usage_outlined,
                        title: 'Usage Data',
                        description:
                            'We collect information on how you interact with the app, including plants you identify, collections you create, and features you use.',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoItem(
                        icon: Icons.location_on_outlined,
                        title: 'Location Data',
                        description:
                            'With your permission, we collect location data to enhance plant identification and mapping features. You can disable this in settings.',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoItem(
                        icon: Icons.devices_outlined,
                        title: 'Device Information',
                        description:
                            'We collect information about your device, including model, operating system, and unique device identifiers.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'How We Use Your Information',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'We use your information to:',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      _buildBulletPoint(
                          'Provide and improve our plant identification services'),
                      _buildBulletPoint(
                          'Personalize your experience within the app'),
                      _buildBulletPoint(
                          'Send notifications about new features or plants in your area'),
                      _buildBulletPoint(
                          'Analyze usage patterns to enhance app functionality'),
                      _buildBulletPoint(
                          'Ensure the security of your account and data'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Data Sharing and Disclosure',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'We do not sell your personal information to third parties. We may share data with:',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      _buildBulletPoint(
                          'Service providers who help us operate the app'),
                      _buildBulletPoint(
                          'Research partners for botanical studies (anonymized data only)'),
                      _buildBulletPoint(
                          'Legal authorities when required by law'),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade800.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.amber.shade700,
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Important: You can request deletion of your data at any time through the app settings.',
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
                  title: 'Contact Us',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'If you have any questions about this Privacy Policy, please contact us:',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'privacy@botanicatch.com',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
      width: double.infinity,
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

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.green,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Text(
            description,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
