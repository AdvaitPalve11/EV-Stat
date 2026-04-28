# FuelPay - Premium Fuel Payment & Rewards Ecosystem

## 🚀 Project Overview

FuelPay is a production-grade Flutter fintech application that revolutionizes fuel payment and rewards. Users can:

- **Pay** for fuel through seamless UPI integration (Razorpay)
- **Track** fuel expenses with intelligent analytics
- **Earn** FuelCredits through smart reward tiers
- **Unlock** exclusive rewards and discounts
- **Access** vehicle intelligence and optimization

## 🎯 Core Positioning

This is **NOT** a generic payment app. FuelPay is a **fuel-specific rewards and vehicle intelligence platform** with:

- Geofence-based reward validation
- Station-generated QR for legitimate transactions
- Smart reward tier system (Bronze → Diamond)
- Fraud prevention mechanisms
- Scalable architecture for 100k+ concurrent users

## 📊 Value Proposition

**Pay + Track + Earn**

## 🏗️ Project Architecture

### Frontend (Flutter)
- **Framework**: Flutter 3.x with Dart 3.9+
- **State Management**: Riverpod
- **Routing**: GoRouter
- **Networking**: Dio
- **Serialization**: Freezed + JSON Serializable
- **Local Storage**: Hive + Flutter Secure Storage
- **UI**: Material 3 + Custom glassmorphic design

### Backend (Node.js)
- **Runtime**: Node.js
- **Language**: TypeScript
- **Framework**: Express.js
- **Database**: PostgreSQL
- **ORM**: Prisma
- **Cache**: Redis
- **Job Queue**: BullMQ

### Deployment
- **Containers**: Docker + Docker Compose
- **Cloud**: AWS-ready
- **Scaling**: Horizontal scaling ready

## 📁 Project Structure

```
lib/
├── core/              # Shared code
│   ├── config/       # Configuration (constants, env, router, exceptions)
│   ├── theme/        # UI Theme (colors, typography)
│   ├── network/      # Dio HTTP client
│   ├── security/     # Encryption, JWT handling
│   ├── storage/      # Local storage abstractions
│   ├── utils/        # Extensions, utilities
│   └── widgets/      # Shared UI components
│
├── features/         # Feature-based modules
│   ├── auth/         # Authentication (OTP, JWT, sessions)
│   ├── stations/     # Fuel stations management
│   ├── payments/     # Razorpay integration
│   ├── wallet/       # Wallet & ledger system
│   ├── rewards/      # Reward engine & tiers
│   ├── analytics/    # User analytics
│   ├── profile/      # User profile management
│   ├── referrals/    # Referral system
│   ├── notifications/# Firebase notifications
│   └── merchant/     # Merchant dashboard
│
└── main.dart         # App entry point
```

## 🎮 Core Features

### 1. Authentication
- Phone-based OTP login
- JWT with refresh token rotation
- Secure token storage
- Device session management
- Device fingerprinting

### 2. Fuel Stations
- Nearby stations discovery
- Station QR generation & validation
- Real-time fuel price listings
- Geolocation-based filtering

### 3. Payments
- Razorpay UPI integration
- Payment flow orchestration
- Webhook verification
- Transaction lifecycle management
- Fraud detection

### 4. Rewards Engine
- **Tier System**:
  - Bronze: 0-99 credits (1x multiplier)
  - Silver: 100-499 credits (1.25x)
  - Gold: 500-1499 credits (1.5x)
  - Platinum: 1500-4999 credits (2x)
  - Diamond: 5000+ credits (3x)
  
- **Reward Types**:
  - Streak rewards
  - Referral rewards
  - Promo rewards
  - Milestone rewards
  - Seasonal campaigns
  - Lucky drops

### 5. Wallet System
- Ledger-based architecture
- Credit tracking & history
- Redemption logs
- Expiry management

### 6. Analytics
- Monthly fuel spend tracking
- Cost-per-km calculations
- Expense trends & insights
- Historical analytics

### 7. Referral System
- Unique referral codes
- Shareable invite links
- Fraud detection (self-referral, device duplication)

### 8. Merchant Dashboard
- QR generation
- Payment verification
- Customer analytics
- Campaign management

## 🔒 Security Features

- JWT authentication with expiry
- Refresh token rotation
- Secure token storage (Flutter Secure Storage)
- API request signing
- Webhook signature verification
- SQL injection prevention
- XSS prevention
- CSRF protection
- Input validation
- SSL pinning
- Role-based access control
- Audit logging
- Encryption at rest & in transit

## 🛡️ Fraud Prevention

- Duplicate payment detection
- Reward farming prevention
- Geofence validation (100m radius)
- QR replay prevention
- Webhook replay prevention
- Payment tampering detection
- Device duplication detection
- Self-referral prevention

## 📈 Scalability Design

Architecture built for **100k+ concurrent users**:

- Load balancing
- Horizontal scaling
- Redis caching
- API gateway pattern
- Background job queues (BullMQ)
- Distributed event processing
- Retry mechanisms with exponential backoff
- Circuit breaker patterns
- Idempotent webhook processing

## 🎨 UI Theme

**Premium Dark Fintech Design**:
- Background: Pure Black (#000000)
- Cards: Charcoal (#1A1A1A)
- Accent: Neon Green (#00FF41)
- Secondary: Electric Blue (#0066FF)

**Design Elements**:
- Glassmorphism
- Gradient overlays
- Animated components
- Smooth transitions
- Microinteractions
- Premium typography

## 📱 App Screens

1. Splash
2. Login / OTP
3. Home Dashboard
4. Nearby Stations
5. Station Details
6. QR Scanner
7. Payment Page
8. Payment Status
9. Wallet
10. Rewards
11. Tier Progress
12. Offers
13. Analytics
14. Profile
15. Referrals
16. Transactions
17. Merchant Dashboard

## 🚀 Development Phases

### Phase 1: Project Setup + Architecture ✅
- Folder structure
- Dependencies
- Configuration
- Theme system basics
- Router setup
- Core utilities

### Phase 2: Theme System
- Complete theme implementation
- Dark theme finalization
- Component theming
- Animation definitions

### Phase 3: Authentication
- OTP login flow
- JWT handling
- Refresh token rotation
- Device fingerprinting
- Session management

### Phase 4: Fuel Stations
- Station listing
- Nearby stations
- Station details
- QR code generation
- Station geolocation

### Phase 5: Payment Integration
- Razorpay setup
- Payment flow
- Payment callbacks
- Status tracking

### Phase 6: Rewards Engine
- Tier calculations
- Reward mechanics
- Streak tracking
- Reward redemption

### Phase 7: Wallet Ledger
- Ledger implementation
- Transaction tracking
- Balance management
- Expiry handling

### Phase 8: Analytics
- User analytics
- Expense tracking
- Trend analysis
- Reports generation

### Phase 9: Merchant Dashboard
- Merchant features
- QR generation
- Analytics dashboard

### Phase 10: Fleet Mode
- Fleet accounts
- Employee tracking
- Spending controls

### Phase 11: Fraud Prevention
- Detection systems
- Prevention mechanisms
- Logging & auditing

### Phase 12: Testing
- Unit tests
- Widget tests
- Integration tests
- E2E tests

### Phase 13: Deployment
- Build optimization
- Release preparation
- Deployment guides

## 🛠️ Tech Stack Summary

| Layer | Technology |
|-------|-----------|
| **Frontend** | Flutter / Dart |
| **State Mgmt** | Riverpod |
| **Routing** | GoRouter |
| **HTTP** | Dio |
| **Models** | Freezed |
| **Storage** | Hive / Flutter Secure Storage |
| **Payments** | Razorpay |
| **Maps** | Google Maps Flutter |
| **QR** | QR Code Scanner / QR Flutter |
| **Backend** | Node.js / TypeScript |
| **API** | Express.js |
| **Database** | PostgreSQL |
| **Cache** | Redis |
| **Queue** | BullMQ |
| **Cloud** | AWS |
| **Container** | Docker |

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.x
- Dart 3.9+
- Node.js 18+
- PostgreSQL 15+
- Docker & Docker Compose

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/fuelpay.git
   cd fuelpay/frontend
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. **Generate code**
   ```bash
   flutter pub run build_runner build
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📚 Documentation

- [Architecture Guide](./docs/ARCHITECTURE.md)
- [API Documentation](./docs/API.md)
- [Database Schema](./docs/DATABASE.md)
- [Deployment Guide](./docs/DEPLOYMENT.md)
- [Testing Guide](./docs/TESTING.md)
- [Security Guidelines](./docs/SECURITY.md)

## 📝 Development Workflow

1. Create feature branch: `git checkout -b feature/feature-name`
2. Follow clean architecture principles
3. Write tests first (TDD)
4. Create meaningful commits
5. Push and create PR
6. Code review
7. Merge to main

## 🤝 Contributing

Please follow the [contribution guidelines](./CONTRIBUTING.md).

## 📄 License

Proprietary - All rights reserved

## 👥 Team

Built with ❤️ by the FuelPay team

---

**Status**: Phase 1 - Project Setup ✅ | Next: Phase 2 - Theme System
