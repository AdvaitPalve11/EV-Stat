# Quick Prompt for Cline + Ollama (Qwen2.5 Coder 14B 16k)

Use this prompt when starting work on FuelPay with Cline + Ollama.

---

## System Prompt

```
You are an expert Flutter/Dart developer working on FuelPay, a premium fintech 
mobile app for fuel payments, rewards tracking, and wallet management.

ARCHITECTURE: Clean Architecture with 3 layers
- Domain: Pure business logic, entities, abstract repositories, usecases
- Data: Datasources (Dio, Hive), models (Freezed), repository implementations
- Presentation: Pages, widgets, Riverpod providers/notifiers

KEY TECH: Flutter 3.x, Dart 3.9+, Riverpod, GoRouter, Dio, Firebase, Razorpay

CRITICAL RULES:
✅ DO: Keep domain pure, immutable models, error handling, unit tests
❌ DON'T: Domain imports UI/data, mutable state, skip tests, God classes

NAMING: snake_case files, PascalCase classes, camelCase methods/variables

PROJECT STATUS:
- ✅ Phase 1-2: Setup, theme, UI components (DONE)
- 🔄 Phase 3: Authentication (IN PROGRESS)
- 📋 Phase 4-8: Stations, payments, rewards, etc. (PLANNED)

When implementing features:
1. Create domain layer first (entities, interfaces, usecases)
2. Implement data layer (datasources, models, mappers)
3. Build presentation (pages, widgets, providers)
4. Write tests for business logic
5. Format: dart format lib/ && flutter analyze
6. Commit: feat/fix/docs: clear message

PATTERNS:
- Providers inject dependencies
- StateNotifier manages complex state
- AsyncValue handles loading/error/data
- Try-catch maps to custom exceptions
- Use const constructors everywhere

Config constants: API_BASE_URL, TIMEOUT=30s, GEOFENCE=100m, REWARD=₹200=1credit

Refer to .instructions.md, ENHANCEMENT_ROADMAP.md, and wiki/ for details.
```

---

## Usage Instructions for Cline

### Starting a New Feature

**Prompt Template:**
```
I'm implementing [Feature Name] for FuelPay. Here's what I need:

1. Create the domain layer:
   - entities/[name]_entity.dart
   - repositories/[name]_repository.dart (interface)
   - usecases/[action]_usecase.dart

2. Implement data layer:
   - datasources/[name]_remote_datasource.dart (Dio)
   - models/[name]_model.dart (Freezed)
   - mappers/[name]_mapper.dart
   - repositories/[name]_repository_impl.dart

3. Build presentation:
   - pages/[name]_page.dart
   - widgets/[name]_widget.dart
   - providers/[name]_provider.dart

Follow clean architecture patterns. Include:
- Proper error handling with custom exceptions
- Unit tests for business logic
- Immutable models with @freezed
- Documentation comments

Reference: wiki/Architecture.md and existing features for patterns.
```

### Asking for Code Review

**Prompt:**
```
Review this code for FuelPay architecture compliance:

1. Does it follow clean architecture (domain/data/presentation)?
2. Are error cases handled properly?
3. Are models immutable (Freezed)?
4. Are tests adequate?
5. Any performance issues?
6. Linting compliance?

Here's the code:
[paste code]
```

### Fixing Issues

**Prompt:**
```
I'm getting this error: [error message]

Context: Working on [feature], in [file].
The error occurs when [describe scenario].

Expected: [what should happen]
Actual: [what happens]

How should I fix this following FuelPay's architecture patterns?
Reference: wiki/Troubleshooting.md
```

### Writing Tests

**Prompt:**
```
Write unit tests for this usecase:

[paste usecase code]

Requirements:
- Test success case
- Test error cases
- Use mockito for dependencies
- Follow AAA pattern (Arrange, Act, Assert)
```

---

## Common Feature Templates

### Authentication Feature
```
feature/auth/
├── data/
│   ├── datasources/auth_remote_datasource.dart
│   ├── models/user_model.dart
│   ├── repositories/auth_repository_impl.dart
│   └── mappers/user_mapper.dart
├── domain/
│   ├── entities/user_entity.dart
│   ├── repositories/auth_repository.dart
│   └── usecases/login_usecase.dart
└── presentation/
    ├── pages/login_page.dart
    ├── widgets/otp_input.dart
    └── providers/auth_provider.dart
```

### Payment Feature
```
feature/payments/
├── data/
│   ├── datasources/payment_remote_datasource.dart
│   ├── models/payment_model.dart
│   ├── repositories/payment_repository_impl.dart
└── domain/
├── entities/payment_entity.dart
├── repositories/payment_repository.dart
└── usecases/process_payment_usecase.dart
└── presentation/
    ├── pages/payment_page.dart
    ├── widgets/payment_form.dart
    └── providers/payment_provider.dart
```

---

## Key Files Reference

```
lib/core/config/
├── constants.dart      → API_BASE_URL, timeouts, geofence
├── environment.dart    → .env loading
├── logger.dart         → Logging setup
├── exceptions.dart     → Custom exceptions
└── router.dart         → GoRouter config

lib/core/theme/
├── theme.dart          → Dark fintech theme
└── theme_extended.dart → Utilities

lib/core/widgets/
├── buttons, cards, app_bars, text_fields
├── shared_components.dart → Loading, error, empty states
└── gamification.dart   → Tier, streak widgets
```

---

## Testing Example

```dart
test('LoginUsecase.call returns user on valid credentials', () async {
  // Arrange
  final mockRepo = MockAuthRepository();
  final usecase = LoginUsecase(mockRepo);
  final expectedUser = UserEntity(id: '123', email: 'test@example.com');
  
  when(mockRepo.login('test@example.com', 'password'))
    .thenAnswer((_) async => expectedUser);

  // Act
  final result = await usecase('test@example.com', 'password');

  // Assert
  expect(result, expectedUser);
  verify(mockRepo.login('test@example.com', 'password')).called(1);
});

testWidgets('LoginPage shows error on invalid input', (tester) async {
  await tester.pumpWidget(MyApp());
  
  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpWidget(MyApp());
  
  expect(find.text('Invalid email'), findsOneWidget);
});
```

---

## Commands Cheat Sheet

```bash
# Core
flutter pub get
flutter run
flutter run --release

# Testing
flutter test
flutter test --coverage

# Code Quality
dart format lib/
flutter analyze
dart fix --dry-run
dart fix --apply

# Code Generation
flutter pub run build_runner watch
flutter pub run build_runner build

# Building
flutter build apk --release
flutter build ios --release
```

---

## Context Optimization for 16k Window

When your context is limited:

1. **Describe only current task** - Don't paste whole files
2. **Reference wiki** - "See wiki/Architecture.md for patterns"
3. **Ask focused questions** - Not broad design questions
4. **Provide code snippets** - Just the relevant parts
5. **Be specific** - "Add error handling for DioException"

Example:
```
✅ GOOD (concise, focused):
"Add error handling to this datasource method. Map DioException 
to NetworkException. Reference: wiki/Architecture.md #error-handling"

❌ BAD (too broad):
"How should I handle errors in my app? Here's my entire codebase..."
```

---

## Quality Checklist

Before committing:
```
✅ Code follows architecture patterns
✅ No linting errors (flutter analyze)
✅ All tests pass (flutter test)
✅ Code formatted (dart format lib/)
✅ Error handling implemented
✅ Immutable models (Freezed)
✅ Documentation updated
✅ Commit message clear (feat/fix/docs:)
```

---

## Phase 3 Focus (Current)

**Goal**: Complete authentication system

**Tasks**:
1. Implement LoginUsecase, GetUserUsecase, LogoutUsecase
2. Create Firebase Auth datasource
3. Build login/signup UI with Riverpod
4. Add session persistence with Hive
5. Implement token refresh logic
6. Add unit & widget tests
7. Update wiki with examples

---

## Troubleshooting Prompts

### "Code doesn't compile"
```
Error: [paste error]
File: [file]
Dart version: [dart --version]

Based on FuelPay architecture, what's the issue?
```

### "Performance is slow"
```
Issue: [describe slow part]
Profile result: [paste DevTools info]

How to optimize for FuelPay's patterns?
```

### "Tests failing"
```
Test: [paste test]
Error: [paste error]

Debug: Should I change the test or the code?
```

---

## Documentation Template

When asking for feature docs:
```
Create wiki page for [Feature Name]:

1. Overview (what it does)
2. Architecture (domain/data/presentation)
3. File structure
4. Code examples
5. Testing approach
6. Related features
```

---

## Key Stats

- **Phases**: 8 total (Phase 3-8 remaining)
- **Estimated Time**: 4-5 months to MVP
- **Core Dependencies**: 20+ packages
- **Current Code**: ~500 LOC (core + theme)
- **Target Coverage**: 70%+ test coverage

---

## Remember

> "Every feature starts with domain, then data, then presentation. 
> Keep it clean, immutable, and tested."

---

**Start with**: `.instructions.md` at project root  
**Reference**: `wiki/` directory for detailed guidance  
**Roadmap**: `ENHANCEMENT_ROADMAP.md` for phases
