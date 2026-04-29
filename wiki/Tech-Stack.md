# FuelPay Tech Stack & Dependencies

Complete list of technologies, frameworks, and packages used in FuelPay.

## Core Framework

| Technology | Version | Purpose |
|-----------|---------|---------|
| **Flutter** | 3.x | UI framework for cross-platform mobile development |
| **Dart** | 3.9+ | Programming language |

## State Management

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter_riverpod** | ^2.1.3 | State management and dependency injection |
| **provider** | ^6.0.5 | State management (legacy, co-exists with Riverpod) |

## Navigation & Routing

| Package | Version | Purpose |
|---------|---------|---------|
| **go_router** | ^17.2.2 | Navigation and routing |

## Networking

| Package | Version | Purpose |
|---------|---------|---------|
| **dio** | ^5.x | HTTP client for API requests |
| **retry** | ^3.x | Automatic retry logic for failed requests |

## Local Storage

| Package | Version | Purpose |
|---------|---------|---------|
| **hive** | ^2.x | NoSQL database for local storage |
| **hive_flutter** | ^1.x | Hive integration with Flutter |
| **flutter_secure_storage** | ^9.x | Secure storage for sensitive data (tokens, passwords) |

## Firebase Integration

| Package | Version | Purpose |
|---------|---------|---------|
| **firebase_core** | ^x.x | Firebase core library |
| **firebase_auth** | ^x.x | Firebase Authentication |
| **firebase_messaging** | ^x.x | Firebase Cloud Messaging for push notifications |
| **firebase_analytics** | ^x.x | Firebase Analytics |
| **cloud_firestore** | ^x.x | Firestore database (optional) |

## Payment Integration

| Package | Version | Purpose |
|---------|---------|---------|
| **razorpay_flutter** | ^1.3.x | Razorpay payment gateway integration |

## Location & Maps

| Package | Version | Purpose |
|---------|---------|---------|
| **geolocator** | ^x.x | Device location services |
| **google_maps_flutter** | ^x.x | Google Maps integration |

## UI & Design

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter_lints** | ^6.0.0 | Linting rules for code quality |
| **google_fonts** | ^x.x | Google Fonts typography |

## Utilities

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter_dotenv** | ^6.0.1 | Environment variable management |
| **logger** | ^2.7.0 | Structured logging |
| **fluttertoast** | ^8.0.9 | Toast notifications |

## Development Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter_test** | sdk | Built-in testing framework |
| **flutter_lints** | ^6.0.0 | Linting and code analysis |
| **build_runner** | ^x.x | Code generation (for Freezed, JSON) |
| **freezed_annotation** | ^x.x | Code generation for immutable models |
| **json_serializable** | ^x.x | JSON serialization code generation |

---

## Dependency Tree

```
Application Layer
├── main.dart
└── Presentation (UI, Widgets, Providers)
    │
    ├── State Management
    │   └── flutter_riverpod ^2.1.3
    │
    ├── Navigation
    │   └── go_router ^17.2.2
    │
    └── UI Components
        ├── google_fonts ^x.x
        └── flutter_lints ^6.0.0

Domain Layer
├── Entities (Pure Dart)
├── Repositories (Interfaces)
└── Usecases

Data Layer
├── Networking
│   ├── dio ^5.x
│   └── retry ^3.x
│
├── Local Storage
│   ├── hive ^2.x
│   ├── hive_flutter ^1.x
│   └── flutter_secure_storage ^9.x
│
├── Firebase
│   ├── firebase_core
│   ├── firebase_auth
│   ├── firebase_messaging
│   └── firebase_analytics
│
├── External Services
│   ├── razorpay_flutter ^1.3.x
│   ├── geolocator ^x.x
│   └── google_maps_flutter ^x.x
│
└── Models (Code Generation)
    ├── freezed_annotation ^x.x
    └── json_serializable ^x.x

Configuration & Utilities
├── flutter_dotenv ^6.0.1
├── logger ^2.7.0
└── fluttertoast ^8.0.9
```

---

## Package Details

### State Management: Riverpod

**Why Riverpod?**
- ✅ Provider-based state management
- ✅ Built-in dependency injection
- ✅ Supports both sync and async operations
- ✅ Excellent for testing
- ✅ Minimal boilerplate

```dart
// Simple provider
final counterProvider = StateProvider<int>((ref) => 0);

// Family modifier for parameters
final userProvider = FutureProvider.family<User, String>((ref, id) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getUser(id);
});

// StateNotifier for complex state
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
```

### Networking: Dio

**Why Dio?**
- ✅ Powerful HTTP client
- ✅ Interceptors for auth headers
- ✅ Request/response logging
- ✅ Automatic timeout handling
- ✅ File upload/download support

```dart
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  connectTimeout: Duration(seconds: 30),
  receiveTimeout: Duration(seconds: 30),
));

// Interceptors for auth
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  },
));
```

### Storage: Hive + Secure Storage

**Why Hive?**
- ✅ Lightning-fast NoSQL database
- ✅ Type-safe operations
- ✅ No external dependencies
- ✅ Excellent for caching

**Why Flutter Secure Storage?**
- ✅ Secure storage for sensitive data
- ✅ Platform-native encryption
- ✅ Android Keystore + iOS Keychain integration

```dart
// Hive for general data
final userBox = await Hive.openBox('users');
userBox.put('currentUser', userModel);

// Secure Storage for tokens
final secureStorage = FlutterSecureStorage();
await secureStorage.write(key: 'auth_token', value: token);
```

### Firebase

**Why Firebase?**
- ✅ Authentication system
- ✅ Cloud messaging for push notifications
- ✅ Analytics tracking
- ✅ Firestore for real-time database (optional)
- ✅ Cloud Storage for files

```dart
// Firebase Auth
final user = await FirebaseAuth.instance
  .signInWithEmailAndPassword(email: email, password: password);

// Firebase Messaging
FirebaseMessaging.instance.getToken().then((token) {
  // Save token for push notifications
});

// Firebase Analytics
FirebaseAnalytics.instance.logEvent(
  name: 'purchase',
  parameters: {'amount': 100},
);
```

### Payment: Razorpay

**Why Razorpay?**
- ✅ Supports multiple payment methods
- ✅ UPI integration
- ✅ Robust error handling
- ✅ Easy reconciliation
- ✅ Fraud protection

```dart
final _razorpay = Razorpay();

_razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
_razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

_razorpay.open({
  'key': 'YOUR_RAZORPAY_KEY',
  'amount': 50000, // in paise (₹500)
  'name': 'FuelPay',
  'description': 'Fuel Payment',
  'prefill': {
    'contact': phoneNumber,
    'email': email,
  },
});
```

### Location: Geolocator & Google Maps

**Geolocator:**
- ✅ Device location services
- ✅ Background location tracking
- ✅ Geofencing support
- ✅ Permission handling

**Google Maps:**
- ✅ Interactive map display
- ✅ Markers and polylines
- ✅ Direction calculation
- ✅ Place search

```dart
// Get current location
final position = await Geolocator.getCurrentPosition();

// Distance between two points
double distance = Geolocator.distanceBetween(
  lat1, lon1, lat2, lon2,
);

// Geofence check (100m radius)
bool inGeofence = distance <= 100;
```

---

## Version Management

### Checking Versions

```bash
# Flutter and Dart versions
flutter --version

# Package versions
flutter pub outdated
```

### Upgrading Dependencies

```bash
# Upgrade specific package
flutter pub upgrade package_name

# Upgrade all packages
flutter pub upgrade

# Update pubspec.yaml manually for major versions
```

---

## Platform-Specific Dependencies

### Android

- Gradle (Build system)
- Google Play Services (Location, Maps)
- AndroidX compatibility

### iOS

- CocoaPods (Package manager)
- iOS 11.0+ support
- Swift 5.0+

---

## Build & Release Tools

| Tool | Purpose |
|------|---------|
| **Android Studio** | Android development and emulation |
| **Xcode** | iOS development and emulation |
| **Android Gradle** | Android build system |
| **Flutter Build Tools** | Compilation and optimization |

---

## Environment Variables (.env)

Example `.env` file:

```env
API_BASE_URL=https://api.fuelpay.com
API_TIMEOUT=30000
ENVIRONMENT=development
LOG_LEVEL=debug
FIREBASE_PROJECT_ID=fuelpay-project
RAZORPAY_KEY=YOUR_RAZORPAY_KEY
GOOGLE_MAPS_API_KEY=YOUR_MAPS_KEY
GEOFENCE_RADIUS=100
```

---

## Performance & Optimization

### Image Optimization
- Use appropriate image formats (WebP for modern devices)
- Cache images efficiently
- Resize images to device dimensions

### Code Optimization
- Tree shaking for release builds
- Code splitting for features
- Lazy loading of modules

### Build Optimization
```bash
# Release build with optimization
flutter build apk --release -v

# AOT compilation
flutter build apk --release --target-platform android-arm64
```

---

## Security Considerations

### Sensitive Data
- Store tokens in **Flutter Secure Storage**
- Never commit `.env` files
- Use HTTPS only for API calls

### Authentication
- Firebase Authentication for user management
- JWT tokens with expiry
- Refresh token rotation

### API Security
- Certificate pinning
- Request signing
- Rate limiting

---

## Testing Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito:  # Mocking framework
  build_runner:  # Code generation
```

---

## Useful Resources

- [Pub.dev](https://pub.dev) - Official Dart package repository
- [Flutter Packages](https://flutter.dev/packages)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Riverpod Docs](https://riverpod.dev)
- [GoRouter Guide](https://pub.dev/packages/go_router)

---

## Migration Path

As FuelPay evolves, the tech stack may include:

- 📋 **GraphQL** for efficient API queries
- 📋 **SQLite** for offline data sync
- 📋 **Realm** as alternative to Hive
- 📋 **GetIt** for service locator pattern
- 📋 **Sentry** for error tracking

---

For setup instructions, see [Getting Started](Getting-Started.md).
For architectural patterns using these dependencies, see [Architecture Guide](Architecture.md).
