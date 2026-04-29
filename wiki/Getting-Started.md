# Getting Started with FuelPay

This guide will help you set up FuelPay development environment and run the app.

## Prerequisites

Before you begin, ensure you have:

- **Flutter SDK** (3.x or later) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (3.9 or later) - Included with Flutter
- **Git** for version control
- **Development Environment**:
  - Android Studio (for Android development)
  - Xcode (for iOS development on macOS)
  - VS Code or any preferred IDE

### Verify Installation

```bash
flutter --version
dart --version
```

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/EV-Stat.git
cd EV-Stat
```

### 2. Install Dependencies

```bash
flutter pub get
```

This will download and install all packages defined in `pubspec.yaml`.

### 3. Configure Environment Variables

Create a `.env` file in the project root:

```bash
cp .env.example .env
```

Edit `.env` with your configuration:

```env
API_BASE_URL=https://api.example.com
API_TIMEOUT=30000
ENVIRONMENT=development
LOG_LEVEL=debug
FIREBASE_PROJECT_ID=your-firebase-project
GEOFENCE_RADIUS=100
```

### 4. Set Up Firebase (Optional but Recommended)

For Firebase integration:

#### Android:
- Download `google-services.json` from Firebase Console
- Place it in `android/app/`

#### iOS:
- Download `GoogleService-Info.plist` from Firebase Console
- Add to Xcode: `ios/Runner.xcodeproj`

### 5. Run the Application

#### Development Mode (Hot Reload)

```bash
flutter run
```

#### Release Mode

```bash
flutter run --release
```

#### Specific Device/Platform

```bash
# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# List available devices
flutter devices
```

## Project Structure Overview

```
lib/
├── main.dart              # App entry point
├── core/                  # Shared configuration & utilities
│   ├── config/           # Constants, environment, logging
│   ├── theme/            # UI theme system
│   ├── widgets/          # Reusable components
│   └── utils/            # Extensions & helpers
└── features/             # Feature modules
    ├── auth/             # Authentication
    ├── stations/         # Station discovery
    ├── payments/         # Payment flows
    ├── wallet/           # Wallet management
    ├── rewards/          # Rewards system
    └── ...
```

## Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Watch mode (re-run on changes)
flutter test --watch
```

## Building for Production

### Android APK/AAB

```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

Generated builds are in `build/app/outputs/`.

## Common Commands

| Command | Purpose |
|---------|---------|
| `flutter pub get` | Install dependencies |
| `flutter run` | Run in debug mode |
| `flutter run --release` | Run in release mode |
| `flutter clean` | Clean build artifacts |
| `flutter doctor` | Diagnose Flutter setup |
| `flutter format lib/` | Format code |
| `flutter analyze` | Lint analysis |
| `flutter test` | Run tests |

## Troubleshooting

### Flutter Doctor Issues

```bash
flutter doctor
```

This command helps identify missing dependencies or configuration issues.

### Cache Issues

If you encounter strange errors, try:

```bash
flutter clean
flutter pub get
```

### Build Issues

For Android:

```bash
flutter clean
rm -rf android/.gradle
flutter pub get
flutter run
```

For iOS:

```bash
flutter clean
rm -rf ios/Pods
flutter pub get
flutter run
```

## Next Steps

- 📚 Read the [Architecture Guide](Architecture.md) to understand the codebase structure
- 🛠️ Check the [Development Guide](Development-Guide.md) for best practices
- 🔧 Review [Tech Stack](Tech-Stack.md) to understand dependencies
- 🤝 See [Contributing](Contributing.md) to start contributing

## IDE Setup Recommendations

### VS Code

Install extensions:
- Flutter
- Dart
- Awesome Flutter Snippets

### Android Studio

Built-in Flutter and Dart plugins are usually pre-installed.

### Configuration

Enable code formatting on save in your IDE settings for consistent code style.

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Riverpod State Management](https://riverpod.dev)

---

**Need Help?** Check the [Troubleshooting](Troubleshooting.md) page or review the [Architecture Guide](Architecture.md).
