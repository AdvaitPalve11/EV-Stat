import 'package:flutter/material.dart';
import '../../theme/theme_extended.dart';

/// FuelPay Loading Indicator - Custom branded loader
class FuelPayLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const FuelPayLoadingIndicator({
    Key? key,
    this.size = 48,
    this.color = FuelPayTheme.neonGreen,
  }) : super(key: key);

  @override
  State<FuelPayLoadingIndicator> createState() =>
      _FuelPayLoadingIndicatorState();
}

class _FuelPayLoadingIndicatorState extends State<FuelPayLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _LoadingPainter(widget.color),
      ),
    );
  }
}

class _LoadingPainter extends CustomPainter {
  final Color color;

  _LoadingPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Draw outer circle (background)
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Draw animated arc
    final rect = Rect.fromCircle(center: center, radius: radius - 2);
    canvas.drawArc(
      rect,
      0,
      3.14,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_LoadingPainter oldDelegate) => oldDelegate.color != color;
}

/// Skeletal Loading - Placeholder loading animation
class SkeletalLoader extends StatefulWidget {
  final double height;
  final double width;
  final double borderRadius;

  const SkeletalLoader({
    Key? key,
    this.height = 16,
    this.width = double.infinity,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  State<SkeletalLoader> createState() => _SkeletalLoaderState();
}

class _SkeletalLoaderState extends State<SkeletalLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _opacity = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: FuelPayTheme.charcoalCard,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }
}

/// Empty State Widget - Show when no data available
class EmptyState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Widget? actionButton;
  final double iconSize;

  const EmptyState({
    Key? key,
    required this.title,
    required this.description,
    this.icon = Icons.inbox_outlined,
    this.actionButton,
    this.iconSize = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: FuelPayTheme.charcoalCard,
                borderRadius: BorderRadius.circular(iconSize / 2),
              ),
              child: Icon(
                icon,
                size: iconSize * 0.5,
                color: FuelPayTheme.neonGreen.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: FuelPayTheme.textSecondary,
              ),
            ),
            if (actionButton != null) ...[
              const SizedBox(height: 24),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Error State Widget - Show when error occurs
class ErrorState extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;
  final IconData icon;

  const ErrorState({
    Key? key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.icon = Icons.error_outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: FuelPayTheme.errorRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(icon, size: 40, color: FuelPayTheme.errorRed),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: FuelPayTheme.errorRed),
            ),
            const SizedBox(height: 8),
            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: FuelPayTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            // Retry Button
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

/// Divider with Text - Styled divider with centered text
class DividerWithText extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color dividerColor;

  const DividerWithText({
    Key? key,
    required this.text,
    this.textColor = FuelPayTheme.textTertiary,
    this.dividerColor = FuelPayTheme.borderLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: textColor),
          ),
        ),
        Expanded(child: Container(height: 1, color: dividerColor)),
      ],
    );
  }
}

/// Animated List Item - Reusable list item with animation
class AnimatedListItem extends StatefulWidget {
  final int index;
  final Widget child;
  final Duration duration;

  const AnimatedListItem({
    Key? key,
    required this.index,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
      child: FadeTransition(opacity: _controller, child: widget.child),
    );
  }
}

/// Shimmer Effect - Placeholder loading shimmer
class ShimmerEffect extends StatefulWidget {
  final Widget child;

  const ShimmerEffect({Key? key, required this.child}) : super(key: key);

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                FuelPayTheme.charcoalCard,
                FuelPayTheme.charcoalCard.withOpacity(0.5),
                FuelPayTheme.charcoalCard,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
