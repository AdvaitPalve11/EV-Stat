import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Common Flutter extensions

extension ContextExtensions on BuildContext {
  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Check if dark mode is enabled
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;

  /// Get padding from media query
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// Get view insets (keyboard height, etc)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;
}

extension WidgetExtensions on Widget {
  /// Wrap with common padding
  Widget withPadding({
    double all = 0,
    double horizontal = 0,
    double vertical = 0,
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    if (all > 0) {
      return Padding(padding: EdgeInsets.all(all), child: this);
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left + horizontal,
        top + vertical,
        right + horizontal,
        bottom + vertical,
      ),
      child: this,
    );
  }

  /// Wrap with SafeArea
  Widget withSafeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }

  /// Wrap with Center
  Widget centered() => Center(child: this);

  /// Wrap with Expanded
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);
}

extension NumExtensions on num {
  /// Convert to milliseconds Duration
  Duration get ms => Duration(milliseconds: toInt());

  /// Convert to seconds Duration
  Duration get seconds => Duration(seconds: toInt());

  /// Convert to minutes Duration
  Duration get minutes => Duration(minutes: toInt());

  /// Format as currency (Indian Rupees)
  String get currencyFormat => '₹${toStringAsFixed(2)}';

  /// Format with commas
  String get numberFormat {
    return toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}

extension StringExtensions on String {
  /// Check if email is valid
  bool get isValidEmail => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  /// Check if phone number is valid (Indian format)
  bool get isValidPhone => RegExp(r'^[6-9]\d{9}$').hasMatch(this);

  /// Capitalize first letter
  String get capitalize =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  /// Check if password is strong
  bool get isStrongPassword {
    return length >= 8 &&
        contains(RegExp(r'[A-Z]')) &&
        contains(RegExp(r'[a-z]')) &&
        contains(RegExp(r'[0-9]'));
  }

  /// Mask phone number (keep last 4 digits visible)
  String get maskedPhone {
    if (length < 4) return this;
    return '${'*' * (length - 4)}${substring(length - 4)}';
  }

  /// Mask card number (keep last 4 digits visible)
  String get maskedCardNumber {
    if (length < 4) return this;
    return '${'*' * (length - 4)}${substring(length - 4)}';
  }
}

extension DateTimeExtensions on DateTime {
  /// Format as readable date (e.g., "Jan 15, 2024")
  String get readableDate {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[month - 1]} $day, $year';
  }

  /// Format as time (e.g., "2:30 PM")
  String get readableTime {
    final amPm = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$displayHour:${minute.toString().padLeft(2, '0')} $amPm';
  }

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Get time elapsed as human-readable string
  String get timeAgo {
    final duration = DateTime.now().difference(this);

    if (duration.inSeconds < 60) {
      return 'just now';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h ago';
    } else if (duration.inDays < 30) {
      return '${duration.inDays}d ago';
    } else {
      return readableDate;
    }
  }
}

extension ListExtensions<T> on List<T> {
  /// Safe access by index
  T? safeGet(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Remove nulls from list
  List<T> removeNulls() {
    return where((item) => item != null).toList();
  }

  /// Chunk list into smaller lists
  List<List<T>> chunked(int size) {
    if (size <= 0) throw ArgumentError('Size must be positive');
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
}

/// System UI utilities
class SystemUiUtils {
  /// Set system UI overlay style
  static void setSystemUIStyle({
    Brightness statusBarBrightness = Brightness.dark,
    Color? statusBarColor,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: statusBarBrightness,
        statusBarColor: statusBarColor,
      ),
    );
  }

  /// Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
