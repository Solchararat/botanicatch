import 'package:botanicatch/screens/home/privacy_policy_screen.dart';
import 'package:botanicatch/screens/home/user_manual_screen.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  final Function(int) onNavigate;
  const SettingsScreen({super.key, required this.onNavigate});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ValueNotifier<bool> _locationEnabled = ValueNotifier(false);
  final ValueNotifier<bool> _cameraEnabled = ValueNotifier(false);
  final ValueNotifier<bool> _socialSyncEnabled = ValueNotifier(false);
  static final AuthService _auth = AuthService.instance;

  @override
  void dispose() {
    _locationEnabled.dispose();
    _cameraEnabled.dispose();
    _socialSyncEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        imagePath: "assets/images/home-bg.jpg",
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => widget.onNavigate(0),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Documentation',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(color: Colors.white38),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.insert_drive_file_outlined,
                      color: kGreenColor100,
                    ),
                    title: const Text(
                      'User Manual',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserManualScreen()));
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.privacy_tip_outlined,
                      color: kGreenColor100,
                    ),
                    title: const Text(
                      'Privacy Policy',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PrivacyPolicyScreen()));
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Functions',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.white38),
                ValueListenableBuilder<bool>(
                  valueListenable: _locationEnabled,
                  builder: (_, enabled, __) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SwitchListTile(
                      activeColor: kGreenColor200,
                      title: const Text(
                        'Enable Location',
                        style: TextStyle(color: Colors.white),
                      ),
                      secondary: const Icon(
                        Icons.location_on_outlined,
                        color: kGreenColor100,
                      ),
                      value: enabled,
                      onChanged: (v) => _locationEnabled.value = v,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<bool>(
                  valueListenable: _cameraEnabled,
                  builder: (_, enabled, __) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SwitchListTile(
                      activeColor: kGreenColor200,
                      title: const Text(
                        'Enable Camera',
                        style: TextStyle(color: Colors.white),
                      ),
                      secondary: const Icon(
                        Icons.camera_alt_outlined,
                        color: kGreenColor100,
                      ),
                      value: enabled,
                      onChanged: (v) => _cameraEnabled.value = v,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<bool>(
                  valueListenable: _socialSyncEnabled,
                  builder: (_, enabled, __) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SwitchListTile(
                      activeColor: kGreenColor200,
                      title: const Text(
                        'Sync Social Media',
                        style: TextStyle(color: Colors.white),
                      ),
                      secondary: const Icon(
                        Icons.share_outlined,
                        color: kGreenColor100,
                      ),
                      value: enabled,
                      onChanged: (v) => _socialSyncEnabled.value = v,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white54),
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Log Out',
                      style: kXXSmallTextStyle,
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
