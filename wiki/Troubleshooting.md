# Troubleshooting Guide

Common issues and solutions for FuelPay development.

## Getting Started Issues

### Flutter Doctor Errors

**Problem:** Flutter doctor shows errors or missing components

**Solution:**
```bash
# Run flutter doctor
flutter doctor

# Follow the suggestions for missing tools
flutter doctor --verbose
```

**Common Issues:**
- Android SDK not installed → Install Android Studio
- Xcode not installed → Install Xcode on macOS
- Dart SDK not found → Reinstall Flutter

### Dependencies Not Installed

**Problem:** `flutter pub get` fails or packages not found

**Solution:**
```bash
# Clean pub cache
flutter pub cache clean

# Remove lock file
rm pubspec.lock

# Get dependencies again
flutter pub get
```

### Environment Setup

**Problem:** `.env` file not found or variables not loading

**Solution:**
1. Create `.env` file in project root:
   ```bash
   cp .env.example .env
   ```

2. Configure with your values:
   ```env
   API_BASE_URL=https://api.example.com
   API_TIMEOUT=30000
   ENVIRONMENT=development
   ```

3. Restart the app:
   ```bash
   flutter run
   ```

---

## Build Issues

### Android Build Fails

**Problem:** `flutter build apk` fails

**Solution:**
```bash
# Clean build
flutter clean

# Remove Android build cache
rm -rf android/.gradle

# Get dependencies
flutter pub get

# Rebuild
flutter build apk --release
```

**Common Errors:**

**Error: "Unsupported class-file format"**
```bash
# Check Java version (need 11 or higher)
java -version

# Or update gradle.properties in android/
org.gradle.java.home=/path/to/jdk/11
```

### iOS Build Fails

**Problem:** `flutter build ios` fails

**Solution:**
```bash
# Clean build
flutter clean

# Remove iOS build
rm -rf ios/Pods

# Get dependencies
flutter pub get

# Rebuild
flutter build ios
```

**Common Errors:**

**Error: "Pod install" fails**
```bash
cd ios
pod repo update
pod install
cd ..
flutter run
```

**Error: "Xcode build settings"**
```bash
# Update Xcode settings
flutter clean
rm -rf ios/Podfile.lock
flutter pub get
```

---

## Runtime Issues

### App Crashes on Startup

**Problem:** App crashes immediately after launch

**Solution:**
1. Check logs:
   ```bash
   flutter logs
   ```

2. Look for error messages
3. Common causes:
   - Missing Firebase configuration
   - Invalid environment variables
   - Missing plugins

**Firebase Setup:**
- Android: Place `google-services.json` in `android/app/`
- iOS: Place `GoogleService-Info.plist` in Xcode project

### Hot Reload Not Working

**Problem:** `flutter run` hot reload fails

**Solution:**
```bash
# Exit the running app (Ctrl+C)

# Rebuild the app
flutter run

# Or force full rebuild
flutter run --no-fast-start
```

### Null Pointer Exceptions

**Problem:** NullPointerException or null safety errors

**Solution:**
1. Check provider initialization:
   ```dart
   final userProvider = Provider((ref) {
     // Ensure initialization is not null
     return ref.watch(userRepositoryProvider);
   });
   ```

2. Use null coalescing:
   ```dart
   user?.name ?? 'Guest'
   ```

3. Verify data flow from repositories

---

## Network & API Issues

### API Connection Fails

**Problem:** Dio throws connection error

**Causes & Solutions:**
```bash
# 1. Check network connectivity
ping google.com

# 2. Verify API base URL
# Check constants.dart for correct URL

# 3. Check timeout settings
# In environment or constants

# 4. Verify API endpoint exists
curl -X GET https://api.example.com/endpoint
```

**Code Check:**
```dart
// Verify in config/constants.dart
const String API_BASE_URL = 'https://api.example.com';
const int API_TIMEOUT = 30000;
```

### Authentication Token Expired

**Problem:** API returns 401 Unauthorized

**Solution:**
```dart
// Check token expiry logic in auth_repository.dart
if (isTokenExpired()) {
  await refreshToken();
}
```

**Debug:**
```bash
# Check stored token
flutter logs | grep -i token

# Verify token expiry time in secure storage
```

### Certificate/SSL Errors

**Problem:** CERTIFICATE_VERIFY_FAILED error

**Solution:**
```dart
// In development only (NOT production!)
dio.httpClientAdapter = HttpClientAdapter()
  ..onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = 
      (X509Certificate cert, String host, int port) => true;
    return client;
  };
```

**Better Solution:**
- Fix the certificate on the server
- Or add certificate pinning in production

---

## State Management Issues

### Provider Not Updating

**Problem:** Widget doesn't rebuild when state changes

**Solution:**
```dart
// Wrong approach
final provider = Provider((ref) => userState); // ❌ No update

// Correct approach
final userProvider = StateNotifierProvider((ref) => UserNotifier()); // ✅
```

**Debug:**
```dart
// Add logging
class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState.initial()) {
    print('UserNotifier created'); // Debug
  }
  
  void updateUser(User user) {
    print('Updating user: ${user.name}'); // Debug
    state = UserState.loaded(user);
  }
}
```

### Async Data Not Loading

**Problem:** FutureProvider shows loading indefinitely

**Solution:**
```dart
// Check future completes
final userProvider = FutureProvider<User>((ref) async {
  print('Fetching user...'); // Debug
  final repo = ref.watch(repositoryProvider);
  final user = await repo.getUser('123');
  print('User fetched: ${user.name}'); // Debug
  return user;
});
```

---

## Storage & Database Issues

### Hive Database Corrupted

**Problem:** Hive throws "corrupted database" error

**Solution:**
```bash
# Clear Hive cache
rm -rf ~/.local/share/EV-Stat  # Linux
rm -rf ~/Library/Application\ Support/EV-Stat  # macOS
rm -rf C:\\Users\\USERNAME\\AppData\\Local\\EV-Stat  # Windows
```

**Code Fix:**
```dart
await Hive.deleteBoxFromDisk('users');
await Hive.openBox('users');
```

### Secure Storage Not Working

**Problem:** Flutter Secure Storage returns null

**Causes:**
- iOS: App not signed
- Android: Keystore issues

**Solution for Android:**
```bash
cd android
./gradlew clean
cd ..
flutter run
```

**Solution for iOS:**
- Sign the app in Xcode
- Check provisioning profile

---

## Testing Issues

### Tests Fail to Run

**Problem:** `flutter test` fails or hangs

**Solution:**
```bash
# Clean test cache
flutter clean

# Run with verbose output
flutter test -v

# Run specific test
flutter test test/widget_test.dart
```

### Test Timeouts

**Problem:** Tests take too long and timeout

**Solution:**
```dart
test('slow operation', () async {
  // Increase timeout
}, timeout: Timeout(Duration(seconds: 10)));
```

### Mock Issues

**Problem:** Mockito mocks not working

**Solution:**
```bash
# Generate mocks
flutter pub run build_runner build

# Or watch for changes
flutter pub run build_runner watch
```

---

## UI Issues

### Widgets Not Rendering

**Problem:** Widget tree appears empty or blank

**Solution:**
1. Check Scaffold exists
2. Verify build context
3. Check for errors in build method:
   ```dart
   @override
   Widget build(BuildContext context) {
     try {
       return Container(child: Text('Hello'));
     } catch (e) {
       return Text('Error: $e');
     }
   }
   ```

### Theme Not Applied

**Problem:** Theme colors or styles not showing

**Solution:**
```dart
// Verify theme is provided
MaterialApp(
  theme: FuelPayTheme.darkTheme, // ✅
  home: MyHome(),
)

// Check if using correct color getter
Color color = Theme.of(context).primaryColor; // ✅
```

### Overflow/Layout Issues

**Problem:** RenderFlex overflow or layout errors

**Solution:**
- Use `Expanded` or `Flexible` for flexible layouts
- Check `mainAxisSize` and `mainAxisAlignment`
- Verify widget constraints

```dart
// Better
Column(
  children: [
    Expanded(
      child: ListView(...),
    ),
  ],
)

// Instead of
Column(
  children: [
    ListView(...),  // ❌ Unbounded height
  ],
)
```

---

## Performance Issues

### App Runs Slowly

**Problem:** Jank or slow UI response

**Causes & Solutions:**

1. **Large Lists:**
   ```dart
   // Bad
   ListView(
     children: List.generate(1000, (i) => HeavyWidget()),
   )
   
   // Good
   ListView.builder(
     itemCount: 1000,
     itemBuilder: (context, index) => HeavyWidget(),
   )
   ```

2. **Image Loading:**
   ```dart
   Image.network(
     url,
     cacheHeight: 200,
     cacheWidth: 200,
   )
   ```

3. **Unnecessary Rebuilds:**
   ```dart
   // Use const constructors
   const MyWidget() // ✅
   ```

### Memory Leaks

**Problem:** App memory usage increases over time

**Solution:**
- Remove listeners/subscriptions
- Dispose controllers
- Clear caches periodically

```dart
@override
void dispose() {
  _controller.dispose();
  _subscription.cancel();
  super.dispose();
}
```

---

## Platform-Specific Issues

### Android Issues

**Problem:** Android-specific error

**Debug:**
```bash
# Check Android logs
flutter logs

# Build with verbose output
flutter build apk -v

# Check Android Studio Logcat
```

### iOS Issues

**Problem:** iOS-specific error

**Debug:**
```bash
# Check iOS logs
flutter logs

# Build with verbose output
flutter build ios -v

# Check Xcode logs
```

---

## Common Error Messages

### "Unsupported class file format"
```
Solution: Update Java version to 11+
```

### "Pod install" failed
```
Solution: Run `cd ios && pod repo update && pod install && cd ..`
```

### "Unable to locate Android SDK"
```
Solution: Set ANDROID_HOME environment variable or run Flutter Doctor
```

### "Gradle build failed"
```
Solution: Run `flutter clean && flutter pub get`
```

### "Target of annotation is not supported by Freezed"
```
Solution: Check Freezed dependencies and run build_runner
```

---

## Getting Help

### Resources

1. **Check Documentation:**
   - [Getting Started](Getting-Started.md)
   - [Development Guide](Development-Guide.md)
   - [Architecture Guide](Architecture.md)

2. **Search Issues:**
   - Look for similar issues on GitHub
   - Check closed issues for solutions

3. **Community:**
   - Ask in GitHub Discussions
   - Check Flutter community forums
   - Review Stack Overflow questions

### Create an Issue

If you can't find a solution:

1. Go to GitHub Issues
2. Search for similar issues
3. If not found, create new issue with:
   - Clear title
   - Detailed description
   - Steps to reproduce
   - Error messages/logs
   - Screenshots if applicable

**Include:**
```
Flutter version: flutter --version
Dart version: dart --version
Device: device name and OS version
Error: full error message
Logs: flutter logs output
```

---

## Advanced Debugging

### Debug Logging

```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message', error, stackTrace);
```

### DevTools

```bash
# Start DevTools
flutter pub global activate devtools
devtools

# Connect to running app
flutter run
# Then visit the DevTools URL
```

### Breakpoints

Set breakpoints in VS Code:
1. Click line number
2. Run with debugging
3. Inspect variables
4. Step through code

---

## Quick Reference

| Issue | Solution |
|-------|----------|
| Build fails | `flutter clean && flutter pub get` |
| Tests fail | `flutter pub run build_runner build` |
| Hot reload fails | Restart `flutter run` |
| API errors | Check logs with `flutter logs` |
| Storage issues | Clear app cache/data |
| Theme not working | Verify theme provider in main.dart |
| Slow performance | Use ListView.builder, remove rebuilds |

---

Still stuck? Check the [Contributing](Contributing.md) page to create an issue or ask for help!
