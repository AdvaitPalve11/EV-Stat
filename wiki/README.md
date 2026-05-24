# FuelPay Wiki

Welcome to the FuelPay Project Wiki! This comprehensive documentation covers everything you need to know about developing, using, and contributing to FuelPay.

## 📚 Quick Start

**New to FuelPay?** Start here:
1. [Home](Home.md) - Project overview
2. [Getting Started](Getting-Started.md) - Setup and installation
3. [Architecture](Architecture.md) - Understand the code structure

## 📖 Main Sections

### For Developers

- **[Getting Started](Getting-Started.md)** - Install, configure, and run FuelPay
- **[Architecture Guide](Architecture.md)** - Clean architecture patterns and layers
- **[Project Structure](Project-Structure.md)** - Directory organization and file overview
- **[Development Guide](Development-Guide.md)** - Best practices and coding standards
- **[Tech Stack](Tech-Stack.md)** - Complete dependency list and explanations

### For Contributors

- **[Contributing](Contributing.md)** - How to contribute code and documentation
- **[Troubleshooting](Troubleshooting.md)** - Solutions to common problems
- **[Features](Features.md)** - Current and planned features

## 🎯 Common Tasks

### "I want to..."

| Goal | Start Here |
|------|-----------|
| Get the app running | [Getting Started](Getting-Started.md) |
| Understand the code | [Architecture](Architecture.md) |
| Add a new feature | [Development Guide](Development-Guide.md) |
| Contribute code | [Contributing](Contributing.md) |
| Fix a bug | [Troubleshooting](Troubleshooting.md) |
| Learn the tech stack | [Tech Stack](Tech-Stack.md) |
| See what's planned | [Features](Features.md) |

## 📑 Documentation Structure

```
wiki/
├── Home.md                    # This file
├── Getting-Started.md         # Setup and installation
├── Architecture.md            # Clean architecture guide
├── Project-Structure.md       # Directory overview
├── Development-Guide.md       # Best practices
├── Tech-Stack.md              # Dependencies & technologies
├── Contributing.md            # Contribution guidelines
├── Troubleshooting.md         # Common issues & solutions
└── Features.md                # Features overview
```

## 🚀 Key Information

### Project Overview

**FuelPay** is a premium Flutter fintech application for fuel payments, rewards tracking, wallet management, and station-based checkout flows.

**Tech Stack:**
- Flutter 3.x + Dart 3.9+
- Riverpod (state management)
- GoRouter (navigation)
- Dio (networking)
- Firebase (auth, messaging, analytics)
- Razorpay (payments)

**Architecture:**
- Clean Architecture with three layers
- Feature-first modular design
- Domain → Data → Presentation separation

### Current Status

**Phase 2 Complete** ✅
- Infrastructure setup
- Theme system
- UI components

**Phase 3+ In Progress** 🔄
- Authentication
- Fuel stations
- Payment integration
- And more...

## 🔍 Quick Reference

### Development Commands

```bash
# Setup
flutter pub get

# Run
flutter run

# Test
flutter test

# Build
flutter build apk --release
flutter build ios --release

# Format & Lint
dart format lib/
flutter analyze
```

### File Organization

```
lib/
├── main.dart              # Entry point
├── core/                  # Shared utilities
│   ├── config/           # Configuration
│   ├── theme/            # Theme system
│   ├── widgets/          # Reusable components
│   └── utils/            # Utilities & extensions
└── features/             # Feature modules
    ├── auth/
    ├── stations/
    ├── payments/
    └── ...
```

### Key Concepts

- **Clean Architecture** - Three-layer pattern (Domain, Data, Presentation)
- **Riverpod** - Dependency injection and state management
- **Feature Modules** - Self-contained, reusable features
- **Immutability** - Using Freezed for data classes
- **Error Handling** - Custom exceptions and try-catch blocks

## 🎓 Learning Path

1. **Understand the Project**
   - Read [Home](Home.md)
   - Check [Features](Features.md)

2. **Set Up Environment**
   - Follow [Getting Started](Getting-Started.md)
   - Run the app successfully

3. **Learn Architecture**
   - Study [Architecture Guide](Architecture.md)
   - Explore [Project Structure](Project-Structure.md)

4. **Start Contributing**
   - Read [Development Guide](Development-Guide.md)
   - Check [Contributing](Contributing.md)
   - Follow best practices

5. **Troubleshoot Issues**
   - Reference [Troubleshooting](Troubleshooting.md)
   - Check [Tech Stack](Tech-Stack.md) for dependency issues

## 🤝 Getting Involved

### Ways to Contribute

- 🐛 **Report Bugs** - Found an issue? Let us know!
- 💡 **Suggest Features** - Have ideas? Share them!
- 📝 **Improve Docs** - Help improve documentation
- 💻 **Write Code** - Implement features or fixes
- ✅ **Review PRs** - Help review pull requests
- 🧪 **Write Tests** - Improve test coverage

See [Contributing](Contributing.md) for details.

## 📞 Support & Help

### Documentation

- 📖 [Getting Started](Getting-Started.md) - Setup guide
- 🏗️ [Architecture](Architecture.md) - Design patterns
- 🛠️ [Development Guide](Development-Guide.md) - Best practices
- 🐛 [Troubleshooting](Troubleshooting.md) - Common issues

### Community

- **GitHub Issues** - Report bugs or request features
- **Discussions** - Ask questions and share ideas
- **Pull Requests** - Contribute code and documentation

## 📚 External Resources

### Flutter & Dart

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Flutter Packages](https://pub.dev)

### State Management

- [Riverpod Documentation](https://riverpod.dev)
- [Provider Package](https://pub.dev/packages/provider)

### Architecture

- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Design Patterns](https://refactoring.guru/design-patterns)

### Tools

- [GoRouter](https://pub.dev/packages/go_router)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Firebase](https://firebase.google.com)
- [Razorpay](https://razorpay.com)

## 🔗 Important Links

- **Repository**: [EV-Stat on GitHub](https://github.com/yourusername/EV-Stat)
- **Issues**: [GitHub Issues](https://github.com/yourusername/EV-Stat/issues)
- **Pull Requests**: [GitHub PRs](https://github.com/yourusername/EV-Stat/pulls)
- **Project Status**: [PROJECT_STATUS.md](../PROJECT_STATUS.md)
- **Contributing**: [CONTRIBUTING.md](../CONTRIBUTING.md)

## 📋 Wiki Pages Overview

### [Home](Home.md)
Project overview, key highlights, and navigation.

### [Getting Started](Getting-Started.md)
Complete setup guide including prerequisites, installation, environment configuration, and running the app.

### [Architecture](Architecture.md)
Deep dive into clean architecture, layer explanations, data flow, and design patterns with code examples.

### [Project Structure](Project-Structure.md)
Complete directory tree, file organization, and module breakdown.

### [Development Guide](Development-Guide.md)
Coding standards, best practices, testing guide, and common development tasks.

### [Tech Stack](Tech-Stack.md)
Complete list of dependencies with explanations and code examples.

### [Contributing](Contributing.md)
How to report issues, submit code contributions, and follow the development workflow.

### [Troubleshooting](Troubleshooting.md)
Solutions to common problems and debugging techniques.

### [Features](Features.md)
Overview of implemented and planned features with details about each module.

## 🎯 Navigation Tips

- **Use browser back button** to return to previous page
- **Click wiki links** (in markdown format) to jump between pages
- **Use search** (if available) to find topics
- **Table of Contents** at top of each page for quick navigation

## 📝 Wiki Maintenance

This wiki is maintained by the FuelPay team and community. If you find:
- ❌ Outdated information
- 🐛 Incorrect examples
- ❓ Missing documentation
- 💡 Suggestions for improvements

Please create an issue or submit a PR!

## Last Updated

- **Date**: April 2026
- **Version**: 1.0.0
- **Status**: Complete & Actively Maintained

---

**Ready to get started?** → [Getting Started Guide](Getting-Started.md)

**Want to contribute?** → [Contributing Guide](Contributing.md)

**Need help?** → [Troubleshooting Guide](Troubleshooting.md)

**Questions?** → [GitHub Issues](https://github.com/yourusername/EV-Stat/issues)
