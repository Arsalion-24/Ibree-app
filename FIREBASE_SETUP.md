# Firebase Configuration Setup

## Overview
This directory contains template Firebase configuration files. You need to replace these with your actual Firebase project configuration files.

## Steps to Configure Firebase

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project" or select existing project
3. Name it: **ebeere-games** (or your preferred name)
4. Enable Google Analytics (recommended)
5. Complete project creation

### 2. Add Android App

1. In Firebase Console, click "Add app" → Android icon
2. **Android package name**: `com.ebeere.games`
3. **App nickname**: ébeere Games
4. **Debug signing certificate SHA-1**: (Get from running `./gradlew signingReport` in android folder)
5. Click "Register app"
6. **Download `google-services.json`**
7. Place it in: `android/app/google-services.json`
8. **Delete the `.template` file** after adding the real one

### 3. Add iOS App

1. In Firebase Console, click "Add app" → iOS icon
2. **iOS bundle ID**: `com.ebeere.games`
3. **App nickname**: ébeere Games
4. Click "Register app"
5. **Download `GoogleService-Info.plist`**
6. Place it in: `ios/Runner/GoogleService-Info.plist`
7. **Delete the `.template` file** after adding the real one

### 4. Enable Firebase Services

In Firebase Console, enable these services:

#### Authentication
- Go to Authentication → Sign-in method
- Enable:
  - ✅ Email/Password
  - ✅ Google
  - ✅ Apple (for iOS)
  - ✅ Phone (optional)

#### Cloud Firestore
- Go to Firestore Database
- Create database in **production mode** (or test mode for development)
- Choose region closest to your users

#### Cloud Messaging (FCM)
- Go to Cloud Messaging
- Already enabled by default
- Note the Server Key for backend

#### Analytics
- Already enabled if you chose it during project creation

#### Crashlytics (Optional)
- Go to Crashlytics
- Enable and follow setup instructions

### 5. Configure Backend

Update your backend with:
- Firebase Admin SDK credentials
- FCM Server Key for push notifications
- Configure Firestore security rules

### 6. Verify Installation

After placing the real config files:

```bash
# Android
cd android
./gradlew clean
cd ..
flutter run

# iOS
cd ios
pod install
cd ..
flutter run
```

## Configuration Files

### Android: `google-services.json`
Location: `android/app/google-services.json`

**Template provided**: `android/app/google-services.json.template`

Replace placeholders:
- `YOUR_PROJECT_NUMBER`
- `YOUR_APP_ID`
- `YOUR_HASH`
- `YOUR_CLIENT_ID`
- `YOUR_API_KEY`

### iOS: `GoogleService-Info.plist`
Location: `ios/Runner/GoogleService-Info.plist`

**Template provided**: `ios/Runner/GoogleService-Info.plist.template`

Replace placeholders:
- `YOUR_IOS_API_KEY`
- `YOUR_SENDER_ID`
- `YOUR_APP_ID`
- `YOUR_HASH`

## Security Notes

⚠️ **IMPORTANT**: 
- Never commit the actual `google-services.json` or `GoogleService-Info.plist` to public repositories
- These files are in `.gitignore` for security
- Only the `.template` files are committed for reference
- Each developer/environment should have their own config files

## Testing

After configuration:

```bash
# Test Firebase connection
flutter run --verbose

# Check logs for:
# - "Firebase initialization successful"
# - No authentication errors
```

## Troubleshooting

### Android Issues
- Ensure package name matches exactly: `com.ebeere.games`
- Check `google-services.json` is in correct location
- Run `flutter clean` and rebuild
- Check Android Studio logs

### iOS Issues
- Ensure bundle ID matches exactly: `com.ebeere.games`
- Verify `GoogleService-Info.plist` is in Xcode project
- Run `pod install` in ios folder
- Check Xcode console logs

### Common Errors

**"google-services.json not found"**
- File is not in `android/app/` directory
- File name is incorrect

**"GoogleService-Info.plist not found"**
- File is not added to Xcode project
- File is not in `ios/Runner/` directory

**"Default FirebaseApp not initialized"**
- Firebase initialization code missing in app startup
- Config file not properly loaded

## Support

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)

---

**Status**: Templates provided - Replace with actual Firebase configuration files
