# FuelPay Development Guide

Best practices and guidelines for developing FuelPay features.

## Development Workflow

### 1. Before You Start

**Check the Status**
- Review [Features Overview](Features.md) to understand what's completed
- Read the relevant feature documentation
- Check [Contributing Guidelines](Contributing.md)

**Set Up Your Environment**
- Follow [Getting Started](Getting-Started.md)
- Configure IDE with Flutter extensions
- Install code formatters

### 2. Feature Development

#### Step 1: Create Feature Branch
```bash
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name
```

**Naming Convention**: `feature/`, `fix/`, `docs/`, `refactor/`

#### Step 2: Plan the Feature
1. Design data models (entities)
2. Define API contracts (if applicable)
3. Plan UI mockups
4. Identify edge cases

#### Step 3: Implement Following Clean Architecture

```
1. Create Domain Layer
   └─ entities/
   └─ repositories/ (interfaces)
   └─ usecases/

2. Create Data Layer
   └─ datasources/
   └─ models/
   └─ repositories/ (implementation)
   └─ mappers/

3. Create Presentation Layer
   └─ pages/
   └─ widgets/
   └─ providers/
   └─ notifiers/
```

#### Step 4: Write Tests
```bash
flutter test
```

#### Step 5: Code Quality
```bash
# Format code
dart format lib/

# Analyze code
flutter analyze

# Run lints
dart fix --dry-run
```

### 3. Code Review & Merge

**Before Creating PR:**
- Code passes all tests
- Code is properly formatted
- No linting issues
- Documentation is updated

**Create Pull Request**
- Title: `feat: short description`
- Description: What changed and why
- Screenshots for UI changes
- Link related issues

---

## Code Style Guide

### Naming Conventions

#### Files
```dart
// Dart files: snake_case
user_repository.dart
auth_provider.dart
login_page.dart
```

#### Classes
```dart
// Classes: PascalCase
class UserRepository {}
class LoginPage extends ConsumerWidget {}
class AuthNotifier extends StateNotifier {}
```

#### Variables & Methods
```dart
// Variables & methods: camelCase
String userName = 'John';
void processPayment() {}
Future<UserEntity> fetchUser() {}
```

#### Constants
```dart
// Constants: UPPER_SNAKE_CASE or camelCase
const String API_BASE_URL = 'https://api.example.com';
const int pageSize = 20;
```

### Class Organization

```dart
class UserRepository {
  // 1. Static constants
  static const String _endpoint = '/users';

  // 2. Private fields
  final Dio _dio;
  final UserLocalDatasource _localDatasource;

  // 3. Constructor
  UserRepository(this._dio, this._localDatasource);

  // 4. Public methods
  Future<UserEntity> getUser(String id) async {
    // Implementation
  }

  // 5. Private methods
  Future<UserModel> _fetchFromRemote(String id) async {
    // Implementation
  }
}
```

### Comments & Documentation

```dart
/// Brief description of what the class does.
/// 
/// More detailed explanation if needed. Mention:
/// - Key responsibilities
/// - Usage examples
/// - Important notes
class UserRepository {
  /// Fetches a user by ID from remote or local source.
  /// 
  /// Returns [UserEntity] if found, throws [NotFoundException] otherwise.
  /// 
  /// Example:
  /// ```dart
  /// final user = await repository.getUser('user123');
  /// ```
  Future<UserEntity> getUser(String id) async {
    // Implementation
  }
}
```

---

## Architecture Patterns

### Creating a New Feature

#### 1. Domain Layer Structure

```dart
// entities/user_entity.dart
@immutable
class UserEntity {
  final String id;
  final String email;
  
  const UserEntity({
    required this.id,
    required this.email,
  });
}

// repositories/user_repository.dart
abstract class UserRepository {
  Future<UserEntity> getUser(String id);
  Future<void> updateUser(UserEntity user);
}

// usecases/get_user_usecase.dart
class GetUserUsecase {
  final UserRepository _repository;
  
  GetUserUsecase(this._repository);
  
  Future<UserEntity> call(String id) => _repository.getUser(id);
}
```

#### 2. Data Layer Structure

```dart
// models/user_model.dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

// mappers/user_mapper.dart
class UserMapper {
  static UserEntity toEntity(UserModel model) => UserEntity(
    id: model.id,
    email: model.email,
  );

  static UserModel toModel(UserEntity entity) => UserModel(
    id: entity.id,
    email: entity.email,
  );
}

// datasources/user_remote_datasource.dart
class UserRemoteDatasource {
  final Dio _dio;
  
  UserRemoteDatasource(this._dio);
  
  Future<UserModel> getUser(String id) async {
    final response = await _dio.get('/users/$id');
    return UserModel.fromJson(response.data);
  }
}

// repositories/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource _remoteDatasource;

  UserRepositoryImpl(this._remoteDatasource);

  @override
  Future<UserEntity> getUser(String id) async {
    final model = await _remoteDatasource.getUser(id);
    return UserMapper.toEntity(model);
  }
}
```

#### 3. Presentation Layer Structure

```dart
// providers/user_provider.dart
final userUsecaseProvider = Provider((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserUsecase(repository);
});

// notifiers/user_notifier.dart
class UserNotifier extends StateNotifier<AsyncValue<UserEntity>> {
  final GetUserUsecase _getUserUsecase;

  UserNotifier(this._getUserUsecase) 
    : super(const AsyncValue.data(null));

  Future<void> getUser(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _getUserUsecase(id));
  }
}

// providers/user_notifier_provider.dart
final userNotifierProvider = 
  StateNotifierProvider<UserNotifier, AsyncValue<UserEntity>>((ref) {
    final usecase = ref.watch(userUsecaseProvider);
    return UserNotifier(usecase);
  });

// pages/user_page.dart
class UserPage extends ConsumerWidget {
  final String userId;

  const UserPage({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: userState.when(
        data: (user) => user != null 
          ? UserDetailWidget(user: user)
          : const SizedBox.shrink(),
        loading: () => const LoadingWidget(),
        error: (error, stackTrace) => ErrorWidget(
          message: error.toString(),
          onRetry: () => ref.read(userNotifierProvider.notifier)
            .getUser(userId),
        ),
      ),
    );
  }
}
```

### State Management with Riverpod

```dart
// Simple provider (computed state)
final userNameProvider = Provider((ref) {
  final user = ref.watch(userProvider);
  return user?.name ?? 'Guest';
});

// StateNotifier for complex state
final counterProvider = 
  StateNotifierProvider<CounterNotifier, int>((ref) {
    return CounterNotifier();
  });

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

// AsyncValue for async operations
final futureUserProvider = 
  FutureProvider<UserEntity>((ref) async {
    final repository = ref.watch(userRepositoryProvider);
    return repository.getUser('123');
  });
```

### Error Handling

```dart
// Custom exceptions in domain layer
class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  
  @override
  String toString() => 'ValidationException: $message';
}

// Handle errors in repositories
@override
Future<UserEntity> getUser(String id) async {
  try {
    final model = await _remoteDatasource.getUser(id);
    return UserMapper.toEntity(model);
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) {
      throw NotFoundException('User not found');
    }
    throw NetworkException('Failed to fetch user');
  } catch (e) {
    throw UnknownException('Unknown error occurred');
  }
}

// Display errors in UI
final userState = ref.watch(userProvider);

userState.whenData((user) => Text(user.name));
userState.whenError((error, stack) {
  if (error is ValidationException) {
    return Text('Invalid input: ${error.message}');
  } else if (error is NetworkException) {
    return Text('Network error. Check your connection.');
  }
  return Text('An error occurred');
});
```

---

## Testing Guide

### Unit Tests

```dart
test('GetUserUsecase returns user successfully', () async {
  // Arrange
  final mockRepository = MockUserRepository();
  final usecase = GetUserUsecase(mockRepository);
  final expectedUser = UserEntity(id: '1', email: 'test@example.com');
  
  when(mockRepository.getUser('1'))
    .thenAnswer((_) async => expectedUser);

  // Act
  final result = await usecase('1');

  // Assert
  expect(result, expectedUser);
  verify(mockRepository.getUser('1')).called(1);
});
```

### Widget Tests

```dart
testWidgets('UserPage displays user name', (tester) async {
  // Arrange
  final user = UserEntity(id: '1', email: 'test@example.com');
  
  await tester.pumpWidget(
    MaterialApp(
      home: UserDetailWidget(user: user),
    ),
  );

  // Act & Assert
  expect(find.text(user.email), findsOneWidget);
});
```

---

## Performance Tips

### Optimization Strategies

```dart
// 1. Use const constructors
const Text('Hello'); // ✅
Text('Hello');       // ❌

// 2. Implement equality for models
@immutable
class User {
  // ...
  
  @override
  bool operator ==(Object other) => // Implementation
  
  @override
  int get hashCode => // Implementation
}

// 3. Use SingleChildScrollView wisely
// ❌ Bad: Can cause performance issues
SingleChildScrollView(
  child: Column(children: largeList),
)

// ✅ Good: Use ListView for large lists
ListView(
  children: largeList,
)

// 4. Lazy load images
Image.network(
  url,
  cacheHeight: 200,
  cacheWidth: 200,
)
```

---

## Common Development Tasks

### Adding a New Dependency

```bash
flutter pub add package_name
```

### Updating All Dependencies

```bash
flutter pub upgrade
```

### Generating Code (Freezed, JSON)

```bash
# Watch for changes
flutter pub run build_runner watch

# Generate once
flutter pub run build_runner build
```

### Checking for Issues

```bash
# Analyze code
flutter analyze

# Run all tests
flutter test

# Build APK
flutter build apk --release
```

---

## Debugging Tips

### Using DevTools

```bash
flutter pub global activate devtools
devtools
```

### Debug Logging

```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

### Breakpoints

In VS Code:
1. Click line number to add breakpoint
2. Run: `flutter run`
3. Debugger pauses at breakpoint
4. Inspect variables in debug console

---

## IDE Shortcuts (VS Code)

| Action | Shortcut |
|--------|----------|
| Format Document | `Shift+Alt+F` |
| Go to Definition | `F12` |
| Find References | `Shift+Alt+F12` |
| Rename Symbol | `F2` |
| Quick Fix | `Ctrl+.` |
| Command Palette | `Ctrl+Shift+P` |

---

## Code Review Checklist

Before submitting a PR:

- [ ] Code follows style guide
- [ ] All tests pass
- [ ] No linting issues
- [ ] Architecture patterns followed
- [ ] Error handling implemented
- [ ] Documentation updated
- [ ] No console errors/warnings
- [ ] Performance optimizations applied

---

## Useful Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Riverpod Documentation](https://riverpod.dev)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

---

See [Contributing Guidelines](Contributing.md) for the complete workflow.
