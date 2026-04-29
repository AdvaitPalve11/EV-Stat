# Contributing to FuelPay

Thank you for your interest in contributing to FuelPay! This guide will help you get started.

## Code of Conduct

Please review our [Code of Conduct](../CODE_OF_CONDUCT.md) before contributing. We are committed to providing a welcoming and inclusive environment.

## How to Contribute

### 1. Report Issues

Found a bug or have a feature request?

**Create an Issue:**
1. Go to [Issues](https://github.com/yourusername/EV-Stat/issues)
2. Click "New Issue"
3. Provide:
   - Clear title
   - Detailed description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Screenshots/logs if applicable

**Issue Labels:**
- `bug` - Something isn't working
- `enhancement` - Feature request
- `documentation` - Documentation improvements
- `good first issue` - Beginner-friendly tasks
- `help wanted` - Need community help

### 2. Code Contributions

#### Before You Start

- Read the [Architecture Guide](Architecture.md)
- Review the [Development Guide](Development-Guide.md)
- Check existing issues and PRs to avoid duplicates
- Ensure your environment is set up ([Getting Started](Getting-Started.md))

#### Fork & Clone

```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR-USERNAME/EV-Stat.git
cd EV-Stat

# Add upstream remote
git remote add upstream https://github.com/ORIGINAL-OWNER/EV-Stat.git
```

#### Create Feature Branch

```bash
# Update develop
git checkout develop
git pull upstream develop

# Create feature branch
git checkout -b feature/your-feature-name
```

**Branch Naming:**
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation
- `refactor/` - Code refactoring
- `test/` - Test improvements

Example:
```bash
git checkout -b feature/add-qr-scanner
git checkout -b fix/payment-validation
git checkout -b docs/architecture-update
```

#### Make Changes

1. **Follow the architecture pattern** - See [Architecture Guide](Architecture.md)
2. **Write tests** - Add unit or widget tests
3. **Format code** - Run `dart format lib/`
4. **Check lints** - Run `flutter analyze`
5. **Test locally** - Run `flutter test`

#### Commit Changes

Use clear, descriptive commit messages:

```bash
git add .
git commit -m "feat: add QR scanner for station validation"
```

**Commit Format:**
```
<type>: <subject>

<body (optional)>

<footer (optional)>
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Code style (formatting, etc.)
- `refactor` - Code refactoring
- `test` - Adding tests
- `chore` - Maintenance

**Examples:**
```
feat: add geofence validation for stations

Implement 100m radius geofence checking using Geolocator.
This ensures users are physically present at stations
before allowing payment transactions.

Closes #123
```

```
fix: resolve payment timeout issue

Increased API timeout from 15s to 30s for payment requests
to handle slow networks.
```

#### Push & Create PR

```bash
# Push your branch
git push origin feature/your-feature-name

# Create pull request on GitHub
```

#### Pull Request Guidelines

**PR Title Format:**
```
[Type] Brief description (50 chars max)
```

Examples:
- `[feat] Add QR scanner for station validation`
- `[fix] Resolve payment timeout errors`
- `[docs] Update architecture guide`

**PR Description Template:**
```markdown
## Description
Brief description of the changes.

## Type of Change
- [ ] Bug fix (non-breaking change)
- [ ] New feature (non-breaking change)
- [ ] Breaking change
- [ ] Documentation update

## Related Issues
Closes #(issue number)

## Changes Made
- Change 1
- Change 2
- Change 3

## Testing Done
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Tested on physical device
- [ ] Tested on emulator

## Screenshots (if applicable)
Add screenshots for UI changes.

## Checklist
- [ ] Code follows style guide
- [ ] No linting errors (`flutter analyze`)
- [ ] All tests pass (`flutter test`)
- [ ] Documentation updated
- [ ] Commit messages are clear
- [ ] Code is self-documenting
```

### 3. Documentation Contributions

Help improve our documentation!

**Areas:**
- README improvements
- Architecture documentation
- Setup guides
- Troubleshooting guides
- Code examples
- Wiki pages

**Submit Documentation Changes:**
Same process as code contributions, but:
- Branch: `docs/your-doc-update`
- Commit: `docs: description`
- No tests needed

### 4. Testing Contributions

Help improve test coverage!

**Unit Tests:**
```dart
test('UserRepository.getUser returns user', () async {
  // Arrange
  final mock = MockDatasource();
  final repo = UserRepository(mock);
  
  // Act
  final result = await repo.getUser('123');
  
  // Assert
  expect(result, isNotNull);
});
```

**Widget Tests:**
```dart
testWidgets('LoginPage shows error on invalid input', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Find and tap button
  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpWidget(MyApp());
  
  // Verify error shown
  expect(find.text('Invalid email'), findsOneWidget);
});
```

---

## Development Workflow

### Step-by-Step

1. **Create issue** for the feature/fix
2. **Fork repository** and create feature branch
3. **Implement changes** following architecture patterns
4. **Write tests** for new functionality
5. **Format code** - `dart format lib/`
6. **Run lints** - `flutter analyze`
7. **Test locally** - `flutter test`
8. **Push to your fork**
9. **Create pull request** with detailed description
10. **Respond to review comments**
11. **Update PR based on feedback**
12. **Get approved and merged** ✅

### Code Review Process

**What Reviewers Check:**
- ✅ Code follows architecture patterns
- ✅ Clean code principles applied
- ✅ Tests are comprehensive
- ✅ No linting errors
- ✅ Documentation is updated
- ✅ Commit messages are clear
- ✅ Performance optimizations applied

**Responding to Reviews:**
- Read feedback carefully
- Ask clarifying questions if needed
- Make requested changes
- Push updates to the same PR
- Respond to comments with ✅ when done

---

## Code Quality Standards

### Required Checks

```bash
# Format code
dart format lib/

# Analyze for issues
flutter analyze

# Run all tests
flutter test

# Check test coverage (optional)
flutter test --coverage
```

### Before Submitting PR

Ensure:
- ✅ No linting errors
- ✅ All tests pass
- ✅ Code is formatted
- ✅ No console warnings
- ✅ Architecture patterns followed

### Code Review Checklist

**Reviewers will check:**
- [ ] Code follows style guide
- [ ] Architecture patterns used correctly
- [ ] Tests are adequate
- [ ] Error handling is robust
- [ ] No performance regressions
- [ ] Documentation is clear
- [ ] Commit messages are descriptive

---

## Commit Guidelines

### Good Commit Messages

✅ **Good:**
```
feat: implement OTP login flow

Add login page with OTP input field and validation.
Integrate with Firebase Authentication.

- Create login_page.dart
- Create auth_notifier.dart
- Add OTP validation logic
- Write unit tests

Closes #456
```

❌ **Bad:**
```
fix stuff
update code
more changes
```

### Commit Best Practices

1. **Atomic commits** - Each commit should represent one logical change
2. **Descriptive messages** - Future developers should understand why
3. **Reference issues** - Use `Closes #123` to link issues
4. **Regular commits** - Don't wait until the end to commit

---

## Getting Help

### Questions?

- 📖 Read the [Development Guide](Development-Guide.md)
- 🔍 Check [Architecture Guide](Architecture.md)
- ❓ Search existing issues and discussions
- 💬 Ask in pull request comments

### Blocked?

- Check [Troubleshooting](Troubleshooting.md)
- Review related documentation
- Create an issue with details

---

## Community

### Join Our Community

- **GitHub Issues** - Bug reports and feature requests
- **Discussions** - Q&A and general discussion
- **Pull Requests** - Code review and collaboration

### Help Others

- Answer questions in issues
- Review pull requests
- Improve documentation
- Share knowledge in discussions

---

## Recognition

Contributors will be recognized:
- ✨ Listed in CONTRIBUTORS.md
- ⭐ Credited in release notes
- 🎉 Featured in project announcements

---

## Project Development

### Current Focus

See [Project Status](../PROJECT_STATUS.md) for current development phase.

### How to Choose What to Work On

1. **Good First Issues** - Look for `good first issue` label
2. **Feature Branches** - Check current phase in [Project Status](../PROJECT_STATUS.md)
3. **Help Wanted** - Issues marked with `help wanted` label
4. **Your Ideas** - Have an idea? Open an issue to discuss first!

---

## License

By contributing, you agree your code will be licensed under the project's license. See [LICENSE](../LICENSE) for details.

---

## Thank You!

We appreciate all contributions, no matter the size. Whether it's code, documentation, bug reports, or ideas, you make FuelPay better! 🙏

For detailed guidelines, check:
- [Git Workflow](../GIT_WORKFLOW.md)
- [Code of Conduct](../CODE_OF_CONDUCT.md)
- [Development Guide](Development-Guide.md)
