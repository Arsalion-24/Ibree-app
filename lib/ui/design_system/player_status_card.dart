import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Player status card for battle screens
/// Shows avatar, name, and points with colored border
class PlayerStatusCard extends StatelessWidget {
  final String name;
  final String? profileUrl;
  final int points;
  final Color borderColor;
  final bool isCurrentUser;
  final double size;

  const PlayerStatusCard({
    required this.name,
    this.profileUrl,
    required this.points,
    this.borderColor = kPlayerBorderYellow,
    this.isCurrentUser = true,
    this.size = 80,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with colored border
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: borderColor.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: profileUrl != null
                ? Image.network(
                    profileUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
                  )
                : _buildDefaultAvatar(),
          ),
        ),
        const SizedBox(height: 8),
        // Name
        Text(
          name,
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        // Points badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: klPrimaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$points pts',
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: klPrimaryColor.withValues(alpha: 0.2),
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: klPrimaryColor,
      ),
    );
  }
}

/// Horizontal player status (for battle bottom bar)
class PlayerStatusHorizontal extends StatelessWidget {
  final String name;
  final String? profileUrl;
  final int points;
  final Color borderColor;
  final bool alignLeft;

  const PlayerStatusHorizontal({
    required this.name,
    this.profileUrl,
    required this.points,
    this.borderColor = kPlayerBorderYellow,
    this.alignLeft = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: profileUrl != null
            ? Image.network(
                profileUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
              )
            : _buildDefaultAvatar(),
      ),
    );

    final pointsBadge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: klPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$points',
        style: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: alignLeft
          ? [
              avatar,
              const SizedBox(width: 8),
              pointsBadge,
            ]
          : [
              pointsBadge,
              const SizedBox(width: 8),
              avatar,
            ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: klPrimaryColor.withValues(alpha: 0.2),
      child: const Icon(
        Icons.person,
        size: 24,
        color: klPrimaryColor,
      ),
    );
  }
}
