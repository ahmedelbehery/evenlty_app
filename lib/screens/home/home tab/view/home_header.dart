import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/l10n/app_localizations.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:evenlty_app/models/user_model.dart';
import 'package:evenlty_app/provider/event_provider.dart';
import 'package:evenlty_app/provider/theme_provider.dart';
import 'package:evenlty_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).userModel;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          spacing: 16,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightbgcolor,
                      ),
                    ),
                    Text(
                      user?.name ?? "",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightbgcolor,
                      ),
                    ),
                    SizedBox(height: 14),
                    Row(
                      spacing: 4,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.lightbgcolor,
                          size: 20,
                        ),
                        Text(
                          "Cairo , Egypt",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightbgcolor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 33,
                  width: 33,
                  child: IconButton(
                    onPressed: () {
                      context.read<ThemeProvider>().toggleTheme();
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      context.watch<ThemeProvider>().isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      color: AppColors.lightbgcolor,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 33,
                  height: 33,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.lightbgcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(0),
                    ),
                    child: Text(
                      "EN",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(
                          context,
                        ).bottomNavigationBarTheme.backgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FilterView(),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final categories = CategoryModel.Catagories;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final currentCat = categories[index];
          final bool isSelected = eventProvider.selectedId == currentCat.id;

          return FilterChip(
            selected: isSelected,
            onSelected: (_) {
              eventProvider.selectCategory(currentCat.id);
            },
            selectedColor: Theme.of(context).focusColor,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(46),
            ),
            side: isSelected
                ? null
                : BorderSide(color: Theme.of(context).focusColor),
            backgroundColor: Theme.of(
              context,
            ).bottomNavigationBarTheme.backgroundColor,
            label: Row(
              spacing: 5,
              children: [
                Icon(
                  currentCat.icon,
                  color: isSelected
                      ? Theme.of(context).cardColor
                      : AppColors.lightbgcolor,
                ),
                Text(
                  currentCat.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Theme.of(context).cardColor
                        : AppColors.lightbgcolor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
