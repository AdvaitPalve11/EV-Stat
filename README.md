# FuelPay

FuelPay is a premium Flutter fintech app for fuel payments, reward tracking, wallet management, and station-based checkout flows. The app is being built with a clean architecture approach and a modular, feature-first structure so each domain can evolve independently.

## What FuelPay Does

- Pay for fuel with UPI-backed payment flows
- Track fuel spend, reward credits, and transaction history
- Unlock tier-based rewards from Bronze to Diamond
- Validate station transactions with QR and geofence checks
- Support wallet, analytics, merchant, and fraud-prevention flows

## Current Status

FuelPay is under active development. The repository currently includes:

- Core configuration and environment handling
- Centralized routing and logging
- Premium dark theme and glassmorphic design system
- Reusable UI widgets and shared component library
- Phase-based documentation and branch workflow

## Tech Stack

- Flutter 3.x
- Dart 3.9+
- Riverpod
- GoRouter
- Dio
- Hive
- Flutter Secure Storage
- Firebase
- Razorpay Flutter
- Google Maps Flutter
- Geolocator
- Lottie
- Google Fonts

## Architecture

The project follows a clean architecture layout:

- `lib/core` for shared configuration, theme, utilities, and widgets
- `lib/features` for feature-specific modules
- `lib/main.dart` for application bootstrap

## Project Structure

```text
lib/
├── core/
│   ├── config/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
└── main.dart
```

## Key UI Systems

- Glassmorphic cards and surfaces
- Custom app bars and premium buttons
- Styled text fields and OTP input
- Loading, empty, and error states
- Gamification widgets for tiers and streaks

## Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK compatible with the Flutter installation
- Android Studio, Xcode, or VS Code depending on target platform

### Install Dependencies

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

### Run Tests

```bash
flutter test
```

## GitHub Releases

This repository includes a GitHub Actions workflow that builds Android release binaries and uploads them to GitHub Releases.

Release assets generated:

- `app-release.apk`
- `app-release.aab`
- `checksums.txt` (SHA-256 checksums)

### Publish via Tag (recommended)

```bash
git tag v1.0.0
git push origin v1.0.0
```

### Publish Manually

Go to Actions → **Flutter Release** → **Run workflow** and provide:

- `tag` (example: `v1.0.1`)
- `prerelease` true/false
- `draft` true/false

Users can download binaries from the Releases page after the workflow completes.

## Documentation

- [Project Status](PROJECT_STATUS.md)
- [Architecture Guide](docs/ARCHITECTURE.md)
- [Full Project Overview](FUELPAY_README.md)

## Contributing

Contributions should follow the feature-branch workflow used in this repository.

1. Create a feature branch from `develop`
2. Make focused commits with clear messages
3. Keep changes scoped to the current phase or fix
4. Open a pull request back into `develop`
5. Merge only after validation passes

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow.

## Security and Privacy

- Security reporting: [SECURITY.md](SECURITY.md)
- Privacy policy: [PRIVACY_POLICY.md](PRIVACY_POLICY.md)

## License

FuelPay is released under the [MIT License](LICENSE).
