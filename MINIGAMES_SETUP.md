# Mini-Games Integration Guide

## Overview
The ébeere Games app includes 8 mini-games that are integrated via HTML5 and loaded in WebView. This guide explains how to set up and configure the mini-games.

## Game List

1. **Trivia WORLD** - Quiz-based trivia game
2. **Number PUZZLE** - Number puzzle challenges
3. **Trivia WORLD II** - Advanced trivia questions
4. **Memory GAMES** - Memory matching games
5. **Tic Tac Toe GAME** - Classic tic-tac-toe
6. **Maths GAMES** - Math challenges
7. **2048 GAME** - Number sliding puzzle
8. **Focus GAME** - Concentration exercises

## Current Configuration

### Game URLs

The mini-games are configured in `lib/features/mini_games/mini_games_screen.dart`:

```dart
static final List<MiniGame> games = [
  MiniGame(
    id: '1',
    name: 'Trivia WORLD',
    gameUrl: 'https://ebeere-games.github.io/minigames/trivia-world/index.html',
    // ...
  ),
  // ... more games
];
```

### Default URL Structure

Current URLs follow this pattern:
```
https://ebeere-games.github.io/minigames/{game-name}/index.html
```

## Setup Options

### Option 1: GitHub Pages Hosting (Recommended)

1. **Create a separate repository for mini-games**:
   ```bash
   # Create new repo: ebeere-games-minigames
   ```

2. **Upload your HTML5 games**:
   ```
   minigames/
   ├── trivia-world/
   │   └── index.html
   ├── number-puzzle/
   │   └── index.html
   ├── memory-game/
   │   └── index.html
   └── ...
   ```

3. **Enable GitHub Pages**:
   - Go to repository Settings
   - Navigate to Pages
   - Select main branch
   - Save
   - Your games will be available at: `https://YOUR_USERNAME.github.io/REPO_NAME/`

4. **Update URLs** in `mini_games_screen.dart` with your actual GitHub Pages URLs

### Option 2: Custom Domain Hosting

1. Host your HTML5 games on your own server
2. Update the `gameUrl` for each game:
   ```dart
   gameUrl: 'https://yourdomain.com/games/trivia-world/index.html',
   ```

### Option 3: Construct 3 HTML5 Export

If you're using Construct 3:

1. **Export your game**:
   - Open your project in Construct 3
   - Go to Menu → Project → Export project
   - Select "Web (HTML5)"
   - Choose "Single file" or "Folder" export

2. **Upload to hosting**:
   - Upload to GitHub Pages, your server, or CDN
   - Note the URL of the index.html file

3. **Update game URL**:
   ```dart
   gameUrl: 'https://your-hosting/construct-game/index.html',
   ```

## Score Synchronization

To sync game scores with the main app:

### 1. Add WebView Communication

The mini-game player uses WebView. Add JavaScript interface:

```dart
// In MiniGamePlayerScreen
import 'package:webview_flutter/webview_flutter.dart';

class MiniGamePlayerScreen extends StatefulWidget {
  // ... implementation with WebViewController
  
  // Add JavaScript channel for score communication
  controller.addJavaScriptChannel(
    'GameScore',
    onMessageReceived: (JavaScriptMessage message) {
      // Handle score from game
      final score = int.parse(message.message);
      _updateUserScore(score);
    },
  );
}
```

### 2. Update Your HTML5 Games

Add this JavaScript code in your games:

```javascript
// When game ends, send score to Flutter app
function sendScoreToApp(score) {
  if (window.GameScore) {
    window.GameScore.postMessage(score.toString());
  }
}

// Call this when game ends
sendScoreToApp(finalScore);
```

### 3. Backend API Integration

Create an API endpoint to save scores:

```dart
Future<void> _updateUserScore(int score) async {
  final response = await http.post(
    Uri.parse('${apiBaseUrl}/minigame/score'),
    headers: await ApiUtils.getHeaders(),
    body: {
      'game_id': game.id,
      'score': score.toString(),
      'user_id': userId,
    },
  );
  
  // Handle response and update coins
}
```

## Game Requirements

### Technical Specifications

Each HTML5 game should:
- ✅ Be responsive (work on mobile screens)
- ✅ Use touch controls (not just keyboard/mouse)
- ✅ Have a loading screen
- ✅ Handle pause/resume
- ✅ Send score data via JavaScript bridge
- ✅ Be optimized for mobile performance

### File Size Recommendations

- Keep each game under 10MB for fast loading
- Optimize images and audio
- Minimize JavaScript bundle size
- Use lazy loading for assets

### Browser Compatibility

Test games work in:
- Android WebView (Chrome engine)
- iOS WKWebView (Safari engine)
- Both portrait and landscape orientations

## Testing

### Local Testing

1. **Test game URLs**:
   ```bash
   # Open in browser
   open https://your-game-url/index.html
   ```

2. **Test in app**:
   ```bash
   flutter run
   # Navigate to Mini Games
   # Tap on each game
   # Verify loading and playability
   ```

### WebView Debugging

Enable debugging:

```dart
// In MiniGamePlayerScreen, add:
if (kDebugMode) {
  WebView.debuggingEnabled = true;
}
```

## Current Status

### ✅ Completed
- Mini-games screen UI implemented
- 8 game cards with colors and descriptions
- Navigation to game player screen
- WebView player framework ready

### 🔧 To Configure
- Replace placeholder URLs with actual game URLs
- Upload HTML5 games to hosting
- Implement score synchronization
- Add loading indicators
- Add error handling for failed loads
- Test on real devices

## Updating Game URLs

To update game URLs, edit `lib/features/mini_games/mini_games_screen.dart`:

```dart
static final List<MiniGame> games = [
  MiniGame(
    id: '1',
    name: 'Trivia WORLD',
    description: 'Test your knowledge',
    imageUrl: '', // Optional: Add game icon URL
    gameUrl: 'YOUR_ACTUAL_GAME_URL_HERE',
    backgroundColor: const Color(0xFFFF6B6B),
  ),
  // ... update all games
];
```

## Adding New Games

To add more games:

```dart
MiniGame(
  id: '9', // Increment ID
  name: 'NEW GAME NAME',
  description: 'Game description',
  imageUrl: '',
  gameUrl: 'https://your-game-url.com/game/index.html',
  backgroundColor: const Color(0xFFYOURCOLOR), // Choose unique color
),
```

## Troubleshooting

### Game Not Loading

1. Check URL is accessible in browser
2. Verify CORS headers on your server
3. Check WebView permissions in AndroidManifest.xml
4. Enable WebView debugging and check console

### Game Not Responsive

1. Ensure game HTML has viewport meta tag:
   ```html
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   ```
2. Test game in mobile browser first
3. Check touch event listeners in game code

### Performance Issues

1. Reduce game asset sizes
2. Enable hardware acceleration
3. Optimize JavaScript code
4. Use progressive loading for assets

## Resources

- [Construct 3 Documentation](https://www.construct.net/en/make-games/manuals/construct-3)
- [WebView Flutter Plugin](https://pub.dev/packages/webview_flutter)
- [GitHub Pages Guide](https://pages.github.com/)

---

**Status**: Structure ready - Replace placeholder URLs with actual game URLs
**Last Updated**: December 6, 2025
