import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';

/// Avatar selector grid with colored circular backgrounds
/// Used in registration and profile edit screens
class AvatarSelectorGrid extends StatelessWidget {
  final List<String> avatarUrls;
  final String? selectedAvatar;
  final Function(String) onAvatarSelected;
  final int crossAxisCount;

  const AvatarSelectorGrid({
    required this.avatarUrls,
    this.selectedAvatar,
    required this.onAvatarSelected,
    this.crossAxisCount = 4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: avatarUrls.length,
      itemBuilder: (context, index) {
        final avatarUrl = avatarUrls[index];
        final isSelected = avatarUrl == selectedAvatar;

        return AvatarCircle(
          avatarUrl: avatarUrl,
          isSelected: isSelected,
          onTap: () => onAvatarSelected(avatarUrl),
          backgroundColor: _getAvatarBackgroundColor(index),
        );
      },
    );
  }

  Color _getAvatarBackgroundColor(int index) {
    final colors = [
      kShapeYellow,
      kShapeGreen,
      klSecondaryColor,
      kShapeLightPurple,
      klPrimaryColor,
      kActionPink,
    ];
    return colors[index % colors.length].withValues(alpha: 0.2);
  }
}

/// Individual avatar circle with colored background
class AvatarCircle extends StatelessWidget {
  final String avatarUrl;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final double size;

  const AvatarCircle({
    required this.avatarUrl,
    required this.isSelected,
    required this.onTap,
    this.backgroundColor,
    this.size = 70,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? kShapeLightPurple.withValues(alpha: 0.2),
          border: isSelected
              ? Border.all(
                  color: klPrimaryColor,
                  width: 3,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: klPrimaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(
                  avatarUrl,
                  width: size * 0.7,
                  height: size * 0.7,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      size: size * 0.5,
                      color: klPrimaryColor,
                    );
                  },
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: klPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Large selected avatar display (for profile preview)
class SelectedAvatarDisplay extends StatelessWidget {
  final String? avatarUrl;
  final double size;
  final VoidCallback? onTap;

  const SelectedAvatarDisplay({
    this.avatarUrl,
    this.size = 120,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kShapeLightPurple.withValues(alpha: 0.2),
          border: Border.all(
            color: klPrimaryColor,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: klPrimaryColor.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: avatarUrl != null
                  ? ClipOval(
                      child: Image.asset(
                        avatarUrl!,
                        width: size * 0.7,
                        height: size * 0.7,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder();
                        },
                      ),
                    )
                  : _buildPlaceholder(),
            ),
            if (onTap != null)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: klPrimaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Icon(
      Icons.person,
      size: size * 0.5,
      color: klPrimaryColor,
    );
  }
}
