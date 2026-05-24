# FuelPay Project Structure

Complete overview of the FuelPay codebase organization and file structure.

## Directory Tree

```
EV-Stat/
├── lib/
│   ├── main.dart                      # Application entry point
│   ├── core/                          # Shared configuration & utilities
│   │   ├── config/
│   │   │   ├── constants.dart         # App-wide constants
│   │   │   ├── environment.dart       # Environment variables
│   │   │   ├── logger.dart            # Logging system
│   │   │   ├── exceptions.dart        # Custom exceptions
│   │   │   └── router.dart            # Route definitions
│   │   ├── theme/
│   │   │   ├── theme.dart             # Main theme configuration
│   │   │   └── theme_extended.dart    # Theme extensions
│   │   ├── utils/
│   │   │   └── extensions.dart        # Dart extensions
│   │   ├── widgets/                   # Reusable UI components
│   │   │   ├── app_bars.dart
│   │   │   ├── buttons.dart
│   │   │   ├── cards.dart
│   │   │   ├── gamification.dart
│   │   │   ├── shared_components.dart
│   │   │   ├── text_fields.dart
│   │   │   └── widgets.dart
│   │   ├── providers/
│   │   │   └── toast_provider.dart    # Global providers
│   │   ├── network/                   # Network configuration
│   │   ├── security/                  # Security & auth utilities
│   │   └── storage/                   # Local storage setup
│   │
│   └── features/                      # Feature modules
│       ├── auth/                      # Authentication
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   ├── models/
│       │   │   ├── repositories/
│       │   │   └── mappers/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   ├── repositories/
│       │   │   └── usecases/
│       │   └── presentation/
│       │       ├── pages/
│       │       ├── widgets/
│       │       └── providers/
│       │
│       ├── stations/                 # Fuel station discovery
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── payments/                 # Payment processing
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── wallet/                   # Wallet management
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── rewards/                  # Rewards system
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── analytics/                # Analytics & tracking
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── profile/                  # User profile
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── referrals/                # Referral system
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── notifications/            # Push notifications
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       └── merchant/                 # Merchant integration
│           ├── data/
│           ├── domain/
│           └── presentation/
│
├── test/
│   └── widget_test.dart               # Example tests
│
├── android/                           # Android-specific code
│   ├── app/
│   │   ├── build.gradle.kts
│   │   └── src/
│   │       ├── debug/
│   │       ├── main/
│   │       └── profile/
│   ├── build.gradle.kts
│   └── settings.gradle.kts
│
├── ios/                               # iOS-specific code
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── Info.plist
│   │   └── Assets.xcassets/
│   └── Runner.xcodeproj/
│
├── web/                               # Web-specific code
│   ├── index.html
│   └── manifest.json
│
├── assets/                            # Static assets
│   ├── animations/                    # Lottie animations
│   ├── icons/                         # App icons
│   └── images/                        # Images
│
├── docs/                              # Project documentation
│   └── ARCHITECTURE.md
│
├── build/                             # Build output (generated)
│   └── reports/
│
├── pubspec.yaml                       # Flutter dependencies
├── analysis_options.yaml              # Lint rules
├── .env                               # Environment variables
├── .env.example                       # Environment template
│
├── README.md                          # Project overview
├── CONTRIBUTING.md                    # Contribution guidelines
├── CODE_OF_CONDUCT.md                 # Code of conduct
├── SECURITY.md                        # Security policy
├── PRIVACY_POLICY.md                  # Privacy policy
├── PROJECT_STATUS.md                  # Development status
├── QUICK_REFERENCE.md                 # Quick reference
├── GIT_WORKFLOW.md                    # Git workflow guide
├── CHANGELOG.md                       # Change history
└── LICENSE                            # License
```

## File Organization by Purpose

### Core Configuration (`lib/core/config/`)

| File | Purpose |
|------|---------|
| `constants.dart` | API base URL, timeouts, geofence radius, rewards config |
| `environment.dart` | Environment variable loading |
| `logger.dart` | Structured logging system |
| `exceptions.dart` | Custom exception classes |
| `router.dart` | GoRouter configuration and routes |

### Theme System (`lib/core/theme/`)

| File | Purpose |
|------|---------|
| `theme.dart` | Dark fintech theme with color scheme |
| `theme_extended.dart` | Theme extensions and utilities |

### Reusable Widgets (`lib/core/widgets/`)

| File | Purpose |
|------|---------|
| `app_bars.dart` | Custom app bar variations |
| `buttons.dart` | Premium button styles |
| `cards.dart` | Glassmorphic card components |
| `gamification.dart` | Reward tier and streak widgets |
| `shared_components.dart` | Loading, empty, error states |
| `text_fields.dart` | Custom text input fields |
| `widgets.dart` | Miscellaneous shared widgets |

### Feature Modules

Each feature follows the **clean architecture** pattern:

```
features/{feature_name}/
├── data/
│   ├── datasources/        # Remote API & local storage
│   ├── models/             # JSON serializable data classes
│   ├── repositories/       # Repository implementations
│   └── mappers/            # Model → Entity conversion
├── domain/
│   ├── entities/           # Pure data classes
│   ├── repositories/       # Abstract interfaces
│   └── usecases/           # Business logic
└── presentation/
    ├── pages/              # Full-screen widgets
    ├── widgets/            # Feature-specific components
    └── providers/          # Riverpod state management
```

### Platform-Specific Code

| Directory | Purpose |
|-----------|---------|
| `android/` | Android app configuration, build scripts |
| `ios/` | iOS app configuration, Swift code |
| `web/` | Web platform assets and configuration |

### Assets (`assets/`)

```
assets/
├── animations/    # Lottie JSON animations
├── icons/         # SVG/PNG icons
└── images/        # PNG/JPG images
```

## Key Files Overview

### Main Entry Point

**[lib/main.dart](../lib/main.dart)**
- Application initialization
- Theme setup
- Router configuration
- Provider setup

### Configuration Files

| File | Purpose |
|------|---------|
| `pubspec.yaml` | Flutter dependencies and metadata |
| `analysis_options.yaml` | Lint rules and code analysis settings |
| `.env` | Environment variables (API keys, URLs) |

### Documentation Files

| File | Purpose |
|------|---------|
| `README.md` | Project overview and getting started |
| `CONTRIBUTING.md` | Contribution guidelines |
| `PROJECT_STATUS.md` | Development phases and status |
| `ARCHITECTURE.md` | Detailed architecture documentation |
| `GIT_WORKFLOW.md` | Git branching strategy |

## Core Layer Deep Dive

### Config Module

```
core/config/
├── constants.dart
│   ├── API Configuration
│   ├── Reward System Constants
│   ├── Geofencing Settings
│   ├── Session Configuration
│   └── UI Constants
├── environment.dart
│   ├── Load environment variables
│   └── Environment validation
├── logger.dart
│   ├── Log levels (debug, info, warning, error)
│   └── Structured logging
├── exceptions.dart
│   ├── ValidationException
│   ├── NetworkException
│   ├── StorageException
│   └── AuthenticationException
└── router.dart
    ├── Route definitions
    ├── GoRouter configuration
    └── Named routes
```

### Theme System

```
core/theme/
├── theme.dart
│   ├── Color palette (neon green, electric blue, purple)
│   ├── Typography
│   ├── Component themes
│   └── Dark theme configuration
└── theme_extended.dart
    ├── Color getters
    ├── Spacing utilities
    └── Custom theme extensions
```

### Utilities

```
core/utils/
└── extensions.dart (30+ extensions)
    ├── String extensions
    ├── DateTime extensions
    ├── num extensions
    ├── List extensions
    └── BuildContext extensions
```

## Features Overview

### Phase 3: Authentication (Planned)
- Login with OTP
- Session management
- Secure token storage

### Phase 4: Fuel Stations (Planned)
- Station discovery
- QR validation
- Geofence checks

### Phase 5: Payment Integration (Planned)
- Razorpay integration
- Payment flows
- Transaction history

### Additional Features
- Wallet management
- Rewards tracking
- User profile
- Referral system
- Push notifications
- Analytics tracking

## Dependency Flow

```
Presentation
    ↓
Domain (Pure Business Logic)
    ↓
Data (Implementation)
    ↓
External Libraries (Dio, Hive, Firebase)
```

## Build Artifacts

```
build/
├── app/
│   ├── outputs/
│   │   ├── apk/              # Android APK files
│   │   └── bundle/           # Android app bundle
│   └── intermediates/        # Build intermediates
└── reports/
    └── problems/             # Build reports
```

## Tips for Navigation

1. **Start with** [lib/main.dart](../lib/main.dart) for app entry point
2. **Understand theme** in [lib/core/theme/](../lib/core/theme/)
3. **View shared components** in [lib/core/widgets/](../lib/core/widgets/)
4. **Study architecture** by exploring a complete feature (e.g., `features/auth/`)
5. **Check configuration** in [lib/core/config/](../lib/core/config/)

---

See [Architecture Guide](Architecture.md) for detailed layer explanations.
