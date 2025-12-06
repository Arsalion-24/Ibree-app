# ébeere Games

A comprehensive quiz and mini-games mobile application built with Flutter.

## Overview

ébeere Games is an interactive gaming platform that combines quiz competitions, mini-games, and social features. Users can earn Kauris (in-app currency), compete in battles, and enjoy various game modes.

## Features

### Core Features
- **Quiz System**: Multiple quiz categories with different difficulty levels
- **Battle Mode**: 1v1 and group battle competitions
- **Mini Games**: Integration with HTML5 mini-games
  - Trivia World
  - Number Puzzle
  - Memory Games
  - Tic Tac Toe
  - Math Games
  - 2048
  - Focus Game
  - And more...

### User Features
- User authentication (Email, Google, Apple Sign-in)
- Profile customization with avatars
- Badges and achievements system
- Leaderboards (Daily, Monthly, All-time)
- Social features (Follow/Followers)
- Referral and rewards system
- Push notifications

### Payment & Rewards
- **Kauris**: In-app currency system
- Moneroo payment integration for mobile money
- In-app purchases
- Reward scratch cards
- Coin history tracking

### Additional Features
- Multi-language support (French, English, Spanish, Yoruba)
- Dark/Light theme support
- Settings and preferences
- Statistics and analytics
- Bookmark questions
- Review quiz answers

## Tech Stack

- **Framework**: Flutter 3.10.0+
- **State Management**: flutter_bloc
- **Backend**: Firebase (Auth, Firestore, Messaging)
- **Payment**: In-app Purchase, Moneroo Integration
- **Ads**: Google Mobile Ads, Unity Ads, IronSource
- **UI**: Material Design 3

## Getting Started

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Dart SDK
- Android Studio / Xcode
- Firebase project setup

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Arsalion-24/Ibree-app.git
cd Ibree-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
- Add `google-services.json` for Android in `android/app/`
- Add `GoogleService-Info.plist` for iOS in `ios/Runner/`

4. Run the app:
```bash
flutter run
```

## Build for Release

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── app/              # App initialization
├── commons/          # Common widgets and screens
├── core/             # Core utilities, constants, themes
├── features/         # Feature modules
│   ├── auth/
│   ├── quiz/
│   ├── battle_room/
│   ├── mini_games/
│   ├── moneroo_payment/
│   └── ...
├── ui/               # UI screens and widgets
└── utils/            # Utility functions
```

## Configuration

### Moneroo Payment
Update the Moneroo API keys in:
```dart
lib/features/moneroo_payment/moneroo_payment_service.dart
```

### App Configuration
Update the app configuration in:
- `pubspec.yaml` - Dependencies and assets
- `android/app/build.gradle` - Android specific config
- `ios/Runner/Info.plist` - iOS specific config

## Phase 1 Implementation Status

- [x] App branding updated to ébeere Games
- [x] Color scheme (purple-teal gradient)
- [x] Core UI updates
- [x] Moneroo payment integration (structure)
- [x] Mini-games integration (structure)
- [x] Android/iOS build configuration
- [ ] Store publication (pending client credentials)
- [ ] Moneroo API keys configuration
- [ ] HTML5 games integration (pending game URLs)

## Companion App: Ibeere Pay

A separate lightweight app for withdrawal and payout management. See `IBEERE_PAY_SPECS.md` for details.

## License

Proprietary - All rights reserved

## Support

For support and inquiries, contact the ébeere Games team.

## Version History

- **v2.3.7** - Elite Quiz base version
- **v1.0.0** - ébeere Games Phase 1 (Current)
  - Rebranding to ébeere Games
  - New UI/UX implementation
  - Moneroo payment integration
  - Mini-games support
  - Bug fixes and improvements
