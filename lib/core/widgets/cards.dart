import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/theme_extended.dart';

/// FuelPay Glassmorphic Card - Premium transparent card with blur effect
class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final double blurAmount;
  final double opacity;
  final VoidCallback? onTap;
  final Color borderColor;
  final List<BoxShadow>? shadows;
  final LinearGradient? gradient;

  const GlassmorphicCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.blurAmount = 10,
    this.opacity = 0.1,
    this.onTap,
    this.borderColor = FuelPayTheme.borderLight,
    this.shadows,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      FuelPayTheme.charcoalCard.withValues(alpha: opacity + 0.05),
                      FuelPayTheme.darkSurface.withValues(alpha: opacity),
                    ],
                  ),
              border: Border.all(
                color: borderColor.withValues(alpha: 0.5),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: shadows ?? FuelPayTheme.glassmorphicShadow,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// FuelPay Premium Card - Solid card variant
class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final List<BoxShadow>? shadows;
  final LinearGradient? gradient;

  const PremiumCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.onTap,
    this.backgroundColor = FuelPayTheme.charcoalCard,
    this.borderColor = FuelPayTheme.borderLight,
    this.shadows,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          color: gradient == null ? backgroundColor : null,
          border: Border.all(color: borderColor, width: 0.5),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: shadows ?? FuelPayTheme.glassmorphicShadow,
        ),
        child: child,
      ),
    );
  }
}

/// FuelPay Animated Card - Card with entrance animation
class AnimatedFuelPayCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Duration duration;
  final Curve curve;
  final EdgeInsets? margin;

  const AnimatedFuelPayCard({
    super.key,
    required this.child,
    this.padding,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOut,
    this.margin,
  });

  @override
  State<AnimatedFuelPayCard> createState() => _AnimatedFuelPayCardState();
}

class _AnimatedFuelPayCardState extends State<AnimatedFuelPayCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _offset = Tween<Offset>(
      begin: const Offset(0, 20),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: FadeTransition(
        opacity: _opacity,
        child: Container(
          margin: widget.margin,
          child: PremiumCard(padding: widget.padding, child: widget.child),
        ),
      ),
    );
  }
}
