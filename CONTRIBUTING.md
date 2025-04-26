# Contributing to Botanicatch 👨‍💻

This file serves as a centralized location for collaboration guidelines and standards. Contributors should review and follow the specified guidelines to ensure a smooth collaborative process. The following guidelines illustrate variable and class naming rules as well as details about the directory structure.

## Flutter Version
Ensure that you are using a Flutter version >= Flutter 3.27.0. Preferably, it is equal to 3.27.0 since newer Flutter versions can introduce breaking changes.

## Naming Conventions 🔠

### Variable Names
- Use **camelCase** for variable names.
    - Example: `userName`, `isLoggedIn`.
- Use **"k" prefix convention** for constants.
    - Example: `kPrimaryColor`, `kGrayTextStyle`.

### Class Names
- Use **PascalCase** for class names.
    - Example: `UserProfile`, `AuthManager`.

### File Names
- Use **snake_case** for filenames within the `lib` directory.
    - Example: `user_profile.dart`, `auth_manager.dart`.

## Project Structure 📂
The `lib` directory is organized as follows:

- **`lib/screens/`**: Contains all UI screens of the app.
    - **`screens/authenticate/`**: Contains all authentication screens.
    - **`screens/home/`**: Contains all screens that an authenticated user can access.
- **`lib/models/`**: Stores data models used across the app.
- **`lib/widgets/`**: Reusable widgets to maintain DRY principles.
- **`lib/utils/`**: Helper functions and utility classes.
- **`lib/services/`**: Contains APIs and service-related logic.

<br>
