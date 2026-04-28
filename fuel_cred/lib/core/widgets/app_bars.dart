import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/theme_extended.dart';

/// FuelPay Custom AppBar - Premium glassmorphic app bar
class FuelPayAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onLeadingPressed;
  final bool isTransparent;
  final double elevation;
  final double blurAmount;
  final Color backgroundColor;
  final Color textColor;
  final PreferredSizeWidget? bottom;

  const FuelPayAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.onLeadingPressed,
    this.isTransparent = false,
    this.elevation = 0,
    this.blurAmount = 10,
    this.backgroundColor = FuelPayTheme.charcoalCard,
    this.textColor = FuelPayTheme.textPrimary,
    this.bottom,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          decoration: BoxDecoration(
            color: isTransparent
                ? backgroundColor.withOpacity(0.7)
                : backgroundColor,
            border: Border(
              bottom: BorderSide(
                color: FuelPayTheme.borderLight.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            boxShadow: isTransparent ? FuelPayTheme.glassmorphicShadow : [],
          ),
          child: Column(
            children: [
              AppBar(
                title: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: textColor),
                ),
                leading:
                    leading ??
                    (Navigator.of(context).canPop()
                        ? IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new),
                            color: textColor,
                            onPressed:
                                onLeadingPressed ??
                                () => Navigator.pop(context),
                          )
                        : null),
                actions: actions,
                elevation: elevation,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                surfaceTintColor: Colors.transparent,
              ),
              if (bottom != null) bottom!,
            ],
          ),
        ),
      ),
    );
  }
}

/// Minimal Glassmorphic AppBar - Simple header for premium feel
class MinimalGlassAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? subtitle;
  final List<Widget>? actions;

  const MinimalGlassAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: FuelPayTheme.charcoalCard.withOpacity(0.7),
            border: Border(
              bottom: BorderSide(
                color: FuelPayTheme.borderLight.withOpacity(0.3),
                width: 0.5,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        subtitle!,
                      ],
                    ],
                  ),
                ),
                if (actions != null) ...[
                  const SizedBox(width: 16),
                  Row(children: actions!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Search AppBar - AppBar with integrated search
class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ValueChanged<String> onSearchChanged;
  final String hintText;
  final VoidCallback? onClear;

  const SearchAppBar({
    super.key,
    required this.onSearchChanged,
    this.hintText = 'Search...',
    this.onClear,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: FuelPayTheme.charcoalCard.withOpacity(0.8),
            border: Border(
              bottom: BorderSide(
                color: FuelPayTheme.borderLight.withOpacity(0.3),
                width: 0.5,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: FuelPayTheme.textPrimary),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: FuelPayTheme.textTertiary),
              prefixIcon: const Icon(
                Icons.search,
                color: FuelPayTheme.neonGreen,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: FuelPayTheme.textSecondary,
                      ),
                      onPressed: () {
                        _controller.clear();
                        widget.onClear?.call();
                        widget.onSearchChanged('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: FuelPayTheme.borderLight,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: FuelPayTheme.borderLight,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: FuelPayTheme.neonGreen,
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: FuelPayTheme.darkSurface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onChanged: widget.onSearchChanged,
          ),
        ),
      ),
    );
  }
}
