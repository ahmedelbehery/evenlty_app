import 'package:evenlty_app/common/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.borderColor,
    this.hintColor,
    this.label,
    this.maxLines = 1,
    this.controller,
    this.isPassword = false,
  });
  final String? hintText, label;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? hintColor;
  final int? maxLines;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isPassword = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        TextFormField(
          obscureText: isPassword,
          controller: widget.controller,
          validator: widget.validator,
          maxLines: widget.maxLines,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).hoverColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: widget.hintColor ?? Theme.of(context).hoverColor,
            ),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: widget.prefixIcon,
                  ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.remove_red_eye,
                    ),
                  )
                : null,
            border: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
            enabledBorder: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
            errorBorder: _getBorder(AppColors.loginbuttoncolor),
            focusedBorder: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
          ),
        ),
      ],
    );
  }

  _getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }
}
