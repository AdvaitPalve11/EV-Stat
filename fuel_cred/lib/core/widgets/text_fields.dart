import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/theme_extended.dart';

/// FuelPay Text Field - Premium styled input field
class FuelPayTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final int minLines;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;
  final TextCapitalization textCapitalization;

  const FuelPayTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.minLines = 1,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.inputFormatters,
    this.isRequired = false,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<FuelPayTextField> createState() => _FuelPayTextFieldState();
}

class _FuelPayTextFieldState extends State<FuelPayTextField> {
  late FocusNode _focusNode;
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isObscured = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Text(
              widget.label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: FuelPayTheme.textPrimary,
              ),
            ),
            if (widget.isRequired)
              const Text(' *', style: TextStyle(color: FuelPayTheme.errorRed)),
          ],
        ),
        const SizedBox(height: 8),
        // Text Field
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {});
          },
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            minLines: widget.minLines,
            obscureText: _isObscured,
            obscuringCharacter: '●',
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: FuelPayTheme.textPrimary),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: FuelPayTheme.textTertiary),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: widget.prefixIcon,
                    )
                  : null,
              suffixIcon: widget.obscureText
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                        child: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: FuelPayTheme.textSecondary,
                        ),
                      ),
                    )
                  : widget.suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: widget.suffixIcon,
                    )
                  : null,
              filled: true,
              fillColor: FuelPayTheme.charcoalCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: FuelPayTheme.borderLight,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: FuelPayTheme.borderLight,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: FuelPayTheme.neonGreen,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: FuelPayTheme.errorRed,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: FuelPayTheme.errorRed,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
        // Error Text
        if (widget.errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: FuelPayTheme.errorRed),
          ),
        ],
      ],
    );
  }
}

/// OTP Input Field - Specialized for OTP entry
class OTPInputField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final TextEditingController? controller;

  const OTPInputField({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.controller,
  });

  @override
  State<OTPInputField> createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length > 1) {
      // Multiple character paste
      for (var i = 0; i < value.length && i + index < widget.length; i++) {
        _controllers[i + index].text = value[i];
      }
      if (value.length + index >= widget.length) {
        _focusNodes[widget.length - 1].requestFocus();
      }
    } else if (value.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    } else {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    }

    // Check if all fields are filled
    final otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
        (index) => Container(
          width: 50,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: FuelPayTheme.neonGreen,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: FuelPayTheme.charcoalCard,
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
                  width: 2,
                ),
              ),
              counterText: '',
              contentPadding: const EdgeInsets.all(0),
            ),
            onChanged: (value) => _onChanged(value, index),
          ),
        ),
      ),
    );
  }
}
