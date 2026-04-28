import 'package:flutter/material.dart';
import '../../theme/theme_extended.dart';

/// FuelPay Button - Premium button with multiple variants
class FuelPayButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final FuelPayButtonVariant variant;
  final Size size;
  final Widget? icon;
  final bool isLoading;
  final bool isEnabled;
  final EdgeInsets? padding;

  const FuelPayButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.variant = FuelPayButtonVariant.primary,
    this.size = FuelPayButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.padding,
  }) : super(key: key);

  @override
  State<FuelPayButton> createState() => _FuelPayButtonState();
}

class _FuelPayButtonState extends State<FuelPayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isEnabled ? _onTapDown : null,
      onTapUp: widget.isEnabled ? _onTapUp : null,
      onTapCancel: _controller.reverse,
      onTap: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: _buildButton(),
      ),
    );
  }

  Widget _buildButton() {
    final theme = Theme.of(context);

    switch (widget.variant) {
      case FuelPayButtonVariant.primary:
        return _buildPrimaryButton(theme);
      case FuelPayButtonVariant.secondary:
        return _buildSecondaryButton(theme);
      case FuelPayButtonVariant.outline:
        return _buildOutlineButton(theme);
      case FuelPayButtonVariant.ghost:
        return _buildGhostButton(theme);
      case FuelPayButtonVariant.danger:
        return _buildDangerButton(theme);
    }
  }

  Widget _buildPrimaryButton(ThemeData theme) {
    return Container(
      padding: widget.padding ?? _getPadding(widget.size),
      decoration: BoxDecoration(
        gradient: FuelPayTheme.neonGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: widget.isEnabled ? FuelPayTheme.neonShadow : [],
      ),
      child: Center(
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FuelPayTheme.blackBackground,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: FuelPayTheme.blackBackground,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSecondaryButton(ThemeData theme) {
    return Container(
      padding: widget.padding ?? _getPadding(widget.size),
      decoration: BoxDecoration(
        color: FuelPayTheme.charcoalCard,
        border: Border.all(color: FuelPayTheme.electricBlue, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FuelPayTheme.electricBlue,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: FuelPayTheme.electricBlue,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildOutlineButton(ThemeData theme) {
    return Container(
      padding: widget.padding ?? _getPadding(widget.size),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isEnabled
              ? FuelPayTheme.neonGreen
              : FuelPayTheme.textTertiary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FuelPayTheme.neonGreen,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: widget.isEnabled
                          ? FuelPayTheme.neonGreen
                          : FuelPayTheme.textTertiary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildGhostButton(ThemeData theme) {
    return Container(
      padding: widget.padding ?? _getPadding(widget.size),
      child: Center(
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FuelPayTheme.neonGreen,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: FuelPayTheme.neonGreen,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDangerButton(ThemeData theme) {
    return Container(
      padding: widget.padding ?? _getPadding(widget.size),
      decoration: BoxDecoration(
        color: FuelPayTheme.errorRed,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: FuelPayTheme.errorRed.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  EdgeInsets _getPadding(Size size) {
    return switch (size) {
      FuelPayButtonSize.small => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      FuelPayButtonSize.medium => const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 14,
      ),
      FuelPayButtonSize.large => const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 18,
      ),
    };
  }
}

enum FuelPayButtonVariant { primary, secondary, outline, ghost, danger }

class FuelPayButtonSize {
  static const Size small = Size(0, 32);
  static const Size medium = Size(0, 48);
  static const Size large = Size(0, 56);
}
