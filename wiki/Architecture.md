# FuelPay Architecture Guide

FuelPay follows **Clean Architecture** principles to ensure scalability, maintainability, testability, and clear separation of concerns.

## Architecture Overview

The application is organized into three main layers:

```
┌─────────────────────────────────────────────┐
│         PRESENTATION LAYER                   │
│  (UI, Pages, Widgets, Providers)             │
└─────────────────────────────────────────────┘
                     ↑
                     │
┌─────────────────────────────────────────────┐
│          DOMAIN LAYER                        │
│  (Entities, Repositories, Usecases)          │
└─────────────────────────────────────────────┘
                     ↑
                     │
┌─────────────────────────────────────────────┐
│          DATA LAYER                          │
│  (Datasources, Models, Mappers)              │
└─────────────────────────────────────────────┘
```

## Layer Details

### 1. Presentation Layer (`presentation/`)

**Responsibility**: Handle UI rendering and user interaction.

**Structure**:
```
presentation/
├── pages/           # Full-screen widgets (routes)
├── widgets/         # Reusable UI components
├── providers/       # Riverpod state providers
└── notifiers/       # State logic (Riverpod NotifierProviders)
```

**Key Principles**:
- Pages should be **thin** with minimal business logic
- Widgets should be **stateless** and composable
- All state management delegated to Riverpod providers
- Providers call usecases or repositories for business logic

**Example**:
```dart
// pages/login_page.dart
class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onChanged: (value) => authNotifier.setEmail(value),
          ),
          ElevatedButton(
            onPressed: () => authNotifier.login(),
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
```

### 2. Domain Layer (`domain/`)

**Responsibility**: Contain business logic and core entities.

**Structure**:
```
domain/
├── entities/        # Pure data classes (immutable)
├── repositories/    # Abstract interfaces
└── usecases/        # Business logic operations
```

**Key Principles**:
- **No external framework dependencies** (pure Dart)
- Entities are **immutable** and represent core business concepts
- Repositories are **interfaces** (abstract classes) defining contracts
- Usecases encapsulate **single business operations**

**Example**:
```dart
// entities/user_entity.dart
class UserEntity {
  final String id;
  final String email;
  final String name;
  
  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
  });
}

// repositories/auth_repository.dart
abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
}

// usecases/login_usecase.dart
class LoginUsecase {
  final AuthRepository _repository;
  
  LoginUsecase(this._repository);
  
  Future<UserEntity> call(String email, String password) {
    return _repository.login(email, password);
  }
}
```

### 3. Data Layer (`data/`)

**Responsibility**: Implement data fetching and storage operations.

**Structure**:
```
data/
├── datasources/
│   ├── remote/      # API calls via Dio
│   └── local/       # Local storage via Hive
├── models/          # API/Storage data classes (JSON serializable)
├── repositories/    # Repository implementations
└── mappers/         # Convert between models ↔ entities
```

**Key Principles**:
- Implements **domain repositories**
- Handles **network and storage** operations
- Models are **JSON serializable** (use Freezed + JSON Serializable)
- Mappers **convert models to entities** and vice versa

**Example**:
```dart
// models/user_model.dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

// mappers/user_mapper.dart
class UserMapper {
  static UserEntity toEntity(UserModel model) => UserEntity(
    id: model.id,
    email: model.email,
    name: model.name,
  );

  static UserModel toModel(UserEntity entity) => UserModel(
    id: entity.id,
    email: entity.email,
    name: entity.name,
  );
}

// repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;

  AuthRepositoryImpl(this._remoteDatasource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final model = await _remoteDatasource.login(email, password);
    return UserMapper.toEntity(model);
  }
}
```

## Data Flow

Complete flow from user interaction to response:

```
1. User Interaction (tap button)
     ↓
2. Presentation Layer (Widget calls provider action)
     ↓
3. Riverpod Provider/Notifier (updates state)
     ↓
4. Usecase (executes business logic)
     ↓
5. Repository Interface (calls abstract method)
     ↓
6. Repository Implementation (delegates to datasource)
     ↓
7. Remote/Local Datasource (API call or DB query)
     ↓
8. Response returned as Model
     ↓
9. Mapper converts Model → Entity
     ↓
10. UI rebuilds with new state
```

## Feature Module Structure

Each feature (Auth, Stations, Payments, etc.) follows this pattern:

```
features/auth/
├── data/
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart
│   │   └── auth_local_datasource.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   └── login_request_model.dart
│   ├── repositories/
│   │   └── auth_repository_impl.dart
│   └── mappers/
│       └── user_mapper.dart
├── domain/
│   ├── entities/
│   │   └── user_entity.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_usecase.dart
│       └── logout_usecase.dart
└── presentation/
    ├── pages/
    │   ├── login_page.dart
    │   └── signup_page.dart
    ├── widgets/
    │   └── login_form.dart
    └── providers/
        └── auth_provider.dart
```

## State Management with Riverpod

FuelPay uses Riverpod for state management:

```dart
// Create a provider for a usecase
final loginUsecaseProvider = Provider((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUsecase(repository);
});

// Create a notifier for complex state
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUsecase _loginUsecase;

  AuthNotifier(this._loginUsecase) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _loginUsecase(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

// Provider that returns the notifier
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final usecase = ref.watch(loginUsecaseProvider);
  return AuthNotifier(usecase);
});
```

## Core Shared Layer

The `lib/core` directory contains shared utilities used across all features:

```
core/
├── config/
│   ├── constants.dart     # App-wide constants
│   ├── environment.dart   # Environment variables
│   ├── logger.dart        # Structured logging
│   ├── exceptions.dart    # Custom exception types
│   └── router.dart        # Route configuration
├── theme/
│   ├── theme.dart         # Dark fintech theme
│   └── theme_extended.dart # Extended theme utilities
├── widgets/
│   ├── app_bars.dart
│   ├── cards.dart
│   ├── buttons.dart
│   └── shared_components.dart
└── utils/
    └── extensions.dart    # 30+ useful extensions
```

## Best Practices

### 1. Keep Layers Separate
- Domain layer should never import from presentation or data
- Presentation should use domain through repositories/usecases
- Data implements domain interfaces

### 2. Use Immutable Models
- Entities and models should be immutable
- Use `@immutable` annotation or `@freezed` for code generation

### 3. Error Handling
- Define custom exceptions in domain layer
- Handle errors at presentation layer with user feedback
- Log all errors for debugging

### 4. Dependency Injection
- Use Riverpod providers to manage dependencies
- Keep dependency graphs organized and testable

### 5. Single Responsibility
- Each class should have one reason to change
- Usecases should handle one business operation
- Widgets should focus on UI rendering

## Advantages of This Architecture

✅ **Testability** - Each layer can be tested independently  
✅ **Maintainability** - Clear separation makes changes easier  
✅ **Scalability** - New features follow the same pattern  
✅ **Reusability** - Domain logic is framework-independent  
✅ **Flexibility** - Easy to swap datasources or state management  

## Example: Complete Authentication Flow

```dart
// 1. DOMAIN - Business Logic
class LoginUsecase {
  final AuthRepository _repository;
  
  LoginUsecase(this._repository);
  
  Future<UserEntity> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw ValidationException('Email and password required');
    }
    return _repository.login(email, password);
  }
}

// 2. DATA - Implementation
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;
  
  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final model = await _datasource.login(email, password);
      return UserMapper.toEntity(model);
    } catch (e) {
      throw LoginFailureException('Login failed');
    }
  }
}

// 3. PRESENTATION - UI
class AuthNotifier extends StateNotifier<AsyncValue<UserEntity>> {
  final LoginUsecase _loginUsecase;
  
  AuthNotifier(this._loginUsecase) : super(const AsyncValue.data(null));
  
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loginUsecase(email, password));
  }
}

// 4. UI RENDERING
class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    return authState.when(
      data: (user) => user != null ? HomePage() : LoginForm(),
      loading: () => LoadingWidget(),
      error: (err, _) => ErrorWidget(message: err.toString()),
    );
  }
}
```

---

## Additional Resources

- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)
- [Riverpod Documentation](https://riverpod.dev)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)

For more details, check the main [Architecture Documentation](../docs/ARCHITECTURE.md).
