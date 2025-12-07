import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/utils/extensions.dart';
<<<<<<< HEAD
=======
import 'package:ebeere/ui/design_system/decorated_background.dart';
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)

class MiniGame {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String gameUrl;
  final Color backgroundColor;

  const MiniGame({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.gameUrl,
    required this.backgroundColor,
  });
}

class MiniGamesScreen extends StatelessWidget {
  const MiniGamesScreen({super.key});

  static Route<dynamic> route() {
    return CupertinoPageRoute(builder: (_) => const MiniGamesScreen());
  }

  static final List<MiniGame> games = [
    MiniGame(
      id: '1',
      name: 'Trivia WORLD',
      description: 'Test your knowledge',
      imageUrl: '',
      gameUrl: 'https://ebeere-games.github.io/minigames/trivia-world/index.html',
      backgroundColor: const Color(0xFFFF6B6B),
    ),
    MiniGame(
      id: '2',
      name: 'Number PUZZLE',
      description: 'Solve number puzzles',
      imageUrl: '',
      gameUrl: 'https://ebeere-games.github.io/minigames/number-puzzle/index.html',
      backgroundColor: const Color(0xFF4ECDC4),
    ),
    MiniGame(
      id: '3',
      name: 'Trivia WORLD II',
      description: 'More trivia fun',
      imageUrl: '',
      gameUrl: 'https://ebeere-games.github.io/minigames/trivia-world-2/index.html',
      backgroundColor: const Color(0xFF95E1D3),
    ),
    MiniGame(
      id: '4',
      name: 'Memory GAMES',
      description: 'Train your memory',
      imageUrl: '',
      gameUrl: 'https://ebeere-games.github.io/minigames/memory-game/index.html',
      backgroundColor: const Color(0xFFFFD93D),
    ),
    MiniGame(
      id: '5',
      name: 'Tic Tac Toe GAME',
      description: 'Classic tic tac toe',
      imageUrl: '',
      gameUrl: 'https://ebeere-games.github.io/minigames/tic-tac-toe/index.html',
      backgroundColor: const Color(0xFF6BCB77),
    ),
    MiniGame(
      id: '6',
      name: 'Maths GAMES',
      description: 'Improve math skills',
      imageUrl: '',
      gameUrl: 'https://ebeere-games.github.io/minigames/math-game/index.html',
      backgroundColor: const Color(0xFFFF6B9D),
    ),
    MiniGame(
      id: '7',
      name: '2048 GAME',
      description: 'Reach 2048!',
      imageUrl: '',
      gameUrl: 'https://ebeere-games.github.io/minigames/2048/index.html',
      backgroundColor: const Color(0xFFFFA07A),
    ),
    MiniGame(
      id: '8',
      name: 'Focus GAME',
      description: 'Sharpen your focus',
      imageUrl: '',
      gameUrl: 'https://ebeere-games.github.io/minigames/focus-game/index.html',
      backgroundColor: const Color(0xFF98D8C8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mini Games',
          style: TextStyle(
            color: context.colorScheme.onTertiary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.colorScheme.onTertiary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
<<<<<<< HEAD
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              klPrimaryColor,
              klSecondaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
=======
      body: DecoratedBackground(
        shapesCount: 22,
        shapesSeed: 111,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                klPrimaryColor.withOpacity(0.3),
                klSecondaryColor.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return _MiniGameCard(game: game);
              },
            ),
          ),
        ),
<<<<<<< HEAD
=======
        ),
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
      ),
    );
  }
}

class _MiniGameCard extends StatelessWidget {
  const _MiniGameCard({required this.game});

  final MiniGame game;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => MiniGamePlayerScreen(game: game),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: game.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videogame_asset_rounded,
              size: 64,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                game.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                game.description,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniGamePlayerScreen extends StatelessWidget {
  const MiniGamePlayerScreen({super.key, required this.game});

  final MiniGame game;

  static Route<dynamic> route(MiniGame game) {
    return CupertinoPageRoute(
      builder: (_) => MiniGamePlayerScreen(game: game),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          game.name,
          style: TextStyle(
            color: context.colorScheme.onTertiary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.colorScheme.onTertiary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: context.colorScheme.onTertiary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Game Integration Coming Soon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onTertiary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'HTML5 game will be loaded here',
              style: TextStyle(
                fontSize: 14,
                color: context.colorScheme.onTertiary.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Game URL: ${game.gameUrl}',
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.onTertiary.withValues(alpha: 0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
