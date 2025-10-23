import 'package:evenlty_app/common/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.label,
  });
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8,horizontal: 16),
      child: Column(spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          DropdownButtonFormField(
            padding: EdgeInsets.all(0),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              border: _getBorder(),
              enabledBorder: _getBorder(),
              errorBorder: _getBorder(),
              focusedBorder: _getBorder(),
            ),
            items: items,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.maincolor),
    );
  }
}
