# FuelPay - Clean Architecture Guide

## 🏗️ Architecture Overview

FuelPay follows **Clean Architecture** principles to ensure:
- Scalability
- Maintainability
- Testability
- Separation of concerns

## 📚 Layers

### 1. Presentation Layer (`presentation/`)
**Responsibility**: UI rendering and user interaction

```
presentation/
├── pages/         # Full-screen widgets (routes)
├── widgets/       # Reusable UI components
├── providers/     # Riverpod state management
└── notifiers/     # State logic (Riverpod)
```

**Key Points**:
- Pages should be thin (minimal logic)
- Widgets are stateless and composable
- Providers handle state management
- Business logic via usecase/repository calls

### 2. Domain Layer (`domain/`)
**Responsibility**: Business logic and entities

```
domain/
├── entities/      # Pure data classes (immutable)
├── repositories/  # Abstract interfaces
└── usecases/      # Business logic operations
```

**Key Points**:
- No dependencies on external frameworks
- Pure Dart code
- Models represent core business concepts
- Repositories are interfaces (contracts)

### 3. Data Layer (`data/`)
**Responsibility**: Data sources and repository implementations

```
data/
├── datasources/
│   ├── remote/    # API calls (Dio)
│   └── local/     # Local storage (Hive)
├── models/        # API/Storage data classes (JSON serializable)
├── repositories/  # Repository implementations
└── mappers/       # Convert between models and entities
```

**Key Points**:
- Implements domain repositories
- Handles network/storage operations
- Models with Freezed + JSON Serializable
- Mappers convert models ↔ entities

## 🔄 Data Flow

```
User Interaction
        ↓
   Presentation (Page/Widget)
        ↓
   Riverpod Provider/Notifier
        ↓
   Usecase (Business Logic)
        ↓
   Repository (Interface)
        ↓
   Repository Implementation
        ↓
   Datasource (Remote/Local)
        ↓
   Return Data → Map to Entity → Back to UI
```

## 🎯 Feature Structure Example

```
features/auth/
├── data/
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart
│   │   └── auth_local_datasource.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   └── auth_response_model.dart
│   ├── repositories/
│   │   └── auth_repository_impl.dart
│   └── mappers/
│       └── user_mapper.dart
│
├── domain/
│   ├── entities/
│   │   ├── user.dart
│   │   └── auth_session.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_with_otp.dart
│       ├── verify_otp.dart
│       ├── refresh_token.dart
│       └── logout.dart
│
└── presentation/
    ├── pages/
    │   ├── login_page.dart
    │   └── otp_page.dart
    ├── widgets/
    │   ├── phone_input.dart
    │   └── otp_input.dart
    ├── providers/
    │   └── auth_provider.dart
    └── notifiers/
        └── auth_notifier.dart
```

## 💾 Models vs Entities

### Entity (Domain)
```dart
// Represents business concept
class User {
  final String id;
  final String phone;
  final String name;
  final int fuelCredits;
  
  User({...});
}
```

### Model (Data)
```dart
// Represents API response structure
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String phoneNumber,
    required String fullName,
    required int credits,
  }) = _UserModel;
  
  factory UserModel.fromJson(Map<String, dynamic> json) =>
    _$UserModelFromJson(json);
}
```

### Mapper
```dart
extension UserMapper on UserModel {
  User toEntity() {
    return User(
      id: id,
      phone: phoneNumber,
      name: fullName,
      fuelCredits: credits,
    );
  }
}
```

## 🔌 Dependency Injection with Riverpod

```dart
// Repository Provider
final authRepositoryProvider = Provider((ref) {
  final remoteDatasource = AuthRemoteDatasource(
    dio: ref.watch(dioProvider),
  );
  final localDatasource = AuthLocalDatasource(
    storage: ref.watch(secureStorageProvider),
  );
  return AuthRepositoryImpl(
    remote: remoteDatasource,
    local: localDatasource,
  );
});

// Usecase Provider
final loginUsecaseProvider = Provider((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LoginWithOtpUsecase(repo);
});

// State Notifier Provider
final authNotifierProvider =
  StateNotifierProvider<AuthNotifier, AuthState>((ref) {
    final loginUsecase = ref.watch(loginUsecaseProvider);
    return AuthNotifier(loginUsecase);
  });
```

## 🧪 Testing Strategy

### Unit Tests (Domain & Data)
```dart
// Test usecases and repositories
test('login should return user when OTP is correct', () async {
  // Arrange
  final mockRepo = MockAuthRepository();
  final usecase = LoginWithOtpUsecase(mockRepo);
  
  // Act
  final result = await usecase('+91XXXXXXXXXX', '123456');
  
  // Assert
  expect(result.isRight(), true);
  expect(result.getOrNull(), isA<User>());
});
```

### Widget Tests (Presentation)
```dart
// Test UI components
testWidgets('OTP input updates state', (WidgetTester tester) async {
  await tester.pumpWidget(MyTestApp());
  
  await tester.enterText(find.byType(TextField), '123456');
  await tester.pumpAndSettle();
  
  expect(find.text('123456'), findsOneWidget);
});
```

### Integration Tests
```dart
// Test full flows
testWidgets('login flow works end-to-end', (WidgetTester tester) async {
  // Start app
  // Enter phone
  // Submit OTP
  // Verify home screen shown
});
```

## ❌ Error Handling

```dart
// Result type for error handling
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T data;
  Success(this.data);
}

final class Failure<T> extends Result<T> {
  final AppException exception;
  Failure(this.exception);
}

// Usage in repository
Future<Result<User>> loginWithOtp(String phone, String otp) async {
  try {
    final response = await remoteDatasource.loginWithOtp(phone, otp);
    return Success(response.toEntity());
  } on NetworkException catch (e) {
    return Failure(NetworkException(...));
  }
}
```

## 🔐 Security Best Practices

1. **Never store sensitive data unencrypted**
   - Use `flutter_secure_storage` for tokens
   - Never log tokens or passwords

2. **Validate input at all layers**
   - Presentation: UI validation
   - Domain: Business logic validation
   - Data: API response validation

3. **Handle exceptions properly**
   - Catch specific exceptions
   - Don't expose internal details
   - Log for auditing

4. **API Security**
   - Sign requests (HMAC)
   - Verify webhook signatures
   - Use HTTPS only
   - Implement API versioning

## 🚀 Performance Optimization

1. **Caching Strategy**
   - Local cache (Hive) for frequently accessed data
   - Redis cache on backend
   - Invalidation on updates

2. **Lazy Loading**
   - Paginate list results
   - Load data on demand
   - Implement debouncing

3. **State Management**
   - Use `.select()` for rebuilds
   - Keep state minimal
   - Avoid redundant computations

## 📊 Folder Structure Rules

- **One feature per folder**
- **Maximum 3 levels deep** (with exceptions)
- **Each layer has clear responsibility**
- **No cross-layer imports** (except down)
  - Presentation → Domain/Data ✅
  - Data → Domain ✅
  - Domain → Data ❌

## 🔗 Allowed Imports

```
Presentation can import from:
- presentation/
- domain/
- core/

Data can import from:
- data/
- domain/
- core/

Domain can import from:
- domain/
- core/

Core can import from:
- core/ only
```

## 📋 Checklist for New Feature

- [ ] Create domain layer (entities, repositories, usecases)
- [ ] Create data layer (models, datasources, mappers)
- [ ] Create presentation layer (pages, widgets, providers)
- [ ] Write unit tests for domain
- [ ] Write unit tests for data
- [ ] Write widget tests for UI
- [ ] Update routing
- [ ] Add to navigation
- [ ] Documentation

---

**Remember**: Clean architecture is about separation of concerns, making testing easier, and keeping the codebase maintainable as it grows.
