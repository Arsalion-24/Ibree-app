# Ibeere Pay - Separate Lightweight App

## Overview
Ibeere Pay is a lightweight companion app to the main ébeere Games app. It is distributed outside the app stores and focuses solely on the payout/withdrawal functionality.

## Features

### 1. Withdrawal Options
- Display available withdrawal methods
- Mobile money withdrawal
- Bank transfer options
- Minimum withdrawal amount validation

### 2. Point History
- Show user's total points balance
- Display transaction history
- Filter by date range
- Show pending/completed/rejected requests

### 3. Payout Confirmation
- Request payout interface
- Enter amount to withdraw
- Select payment method
- Confirm withdrawal request
- Track withdrawal status

## Technical Implementation

### App Structure
```
ibeere_pay/
├── lib/
│   ├── main.dart
│   ├── features/
│   │   ├── auth/
│   │   │   └── simple_login_screen.dart
│   │   ├── withdrawal/
│   │   │   ├── withdrawal_screen.dart
│   │   │   ├── withdrawal_methods_screen.dart
│   │   │   └── withdrawal_history_screen.dart
│   │   └── points/
│   │       ├── points_history_screen.dart
│   │       └── points_balance_widget.dart
│   ├── core/
│   │   ├── api/
│   │   │   └── api_service.dart
│   │   └── constants/
│   │       └── colors.dart
│   └── models/
│       ├── withdrawal_request.dart
│       └── transaction_model.dart
└── pubspec.yaml
```

### API Endpoints Required
- `GET /api/user/points` - Get user points balance
- `GET /api/user/transactions` - Get transaction history
- `POST /api/withdrawal/request` - Request withdrawal
- `GET /api/withdrawal/methods` - Get available withdrawal methods
- `GET /api/withdrawal/status/:id` - Check withdrawal status

### UI Components
1. **Login Screen** - Simple email/phone + password login
2. **Dashboard** - Shows points balance and quick actions
3. **Withdrawal Screen** - Form to request withdrawal
4. **History Screen** - List of all transactions
5. **Settings Screen** - Minimal settings (logout, language)

### Branding
- Use same ébeere Games colors (purple-teal gradient)
- Use same fonts and styling
- Simpler navigation (no bottom nav, just drawer or simple stack)

### Distribution
- APK file distributed via download link
- No Google Play Store listing
- Include update checker to notify users of new versions

## Implementation Notes
- Reuse authentication logic from main app
- Share API service code
- Minimal dependencies
- Small APK size (<10MB)
- Offline transaction caching
- Push notifications for withdrawal status updates

## Security
- Token-based authentication
- Encrypted local storage for sensitive data
- SSL pinning for API calls
- OTP verification for withdrawal requests
