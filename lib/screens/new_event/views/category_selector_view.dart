import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategorySelectorView extends StatelessWidget {
  const CategorySelectorView({
    super.key,
    required this.onChanged,
    required this.selectedCategory,
  });
  final CategoryModel selectedCategory;
  final void Function(CategoryModel) onChanged;

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = CategoryModel.Catagories.sublist(1);
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              CategoryModel currentCat = categories[index];
              bool isSelected = currentCat.id == selectedCategory.id;
              return FilterChip(
                selectedColor: AppColors.maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(46),
                ),
                side: isSelected
                    ? null
                    : BorderSide(color: AppColors.maincolor),
                showCheckmark: false,
                backgroundColor: isSelected
                    ? AppColors.maincolor
                    : Theme.of(context).scaffoldBackgroundColor,
                label: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      currentCat.icon,
                      color: isSelected
                          ? Theme.of(context).scaffoldBackgroundColor
                          : AppColors.maincolor,
                    ),
                    Text(
                      currentCat.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Theme.of(context).scaffoldBackgroundColor
                            : AppColors.maincolor,
                      ),
                    ),
                  ],
                ),
                onSelected: (value) {
                  if (value) {
                    onChanged(currentCat);
                  }
                },
                selected: isSelected,
              );
            },
            itemCount: categories.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 10);
            },
          ),
        ),
      ],
    );
  }
}
