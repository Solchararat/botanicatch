import "package:botanicatch/utils/constants.dart";
import "package:botanicatch/widgets/profile/profile_banner.dart";
import "package:botanicatch/widgets/profile/profile_picture.dart";
import "package:flutter/material.dart";

class EditProfileModal extends StatefulWidget {
  const EditProfileModal({super.key});

  @override
  State<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  late final TextEditingController _name;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: kGreenColor400,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 320),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Profile",
                        style: kSmallTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Make changes to your profile information.",
                        style: kXXSmallTextStyle.copyWith(
                            color: Colors.grey[300], fontSize: 12),
                        softWrap: true,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Name",
                style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextSelectionTheme(
                data: const TextSelectionThemeData(
                    selectionHandleColor: kGreenColor300),
                child: TextField(
                  controller: _name,
                  cursorColor: kGreenColor400,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: kProfileOutlineInputBorder,
                    enabledBorder: kProfileOutlineInputBorder,
                    focusedBorder: kProfileOutlineInputBorder,
                    errorBorder: kProfileOutlineInputBorder,
                    focusedErrorBorder: kProfileOutlineInputBorder,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Banner Image",
                style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ProfileBanner(
                isEditable: true,
              ),
              const SizedBox(height: 16),
              Text(
                "Profile Picture",
                style: kXXSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ProfilePicture(
                isEditable: true,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style:
                            kXXSmallTextStyle.copyWith(color: kGreenColor100),
                      )),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kGreenColor100),
                    child: Text(
                      "Save Changes",
                      style: kXXSmallTextStyle.copyWith(
                          color: kGreenColor500, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
