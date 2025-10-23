import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
                      "Welcome Back ✨",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightbgcolor,
                      ),
                    ),
                    Text(
                      "Ahmed Elbehery",
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
                    onPressed: () {},
                    padding: EdgeInsets.all(0),
                    style: IconButton.styleFrom(padding: EdgeInsets.all(0)),
                    icon: Icon(
                      Icons.brightness_5_outlined,
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
            filterView(),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class filterView extends StatefulWidget {
  const filterView({
    super.key,
  });

  @override
  State<filterView> createState() => _filterViewState();
}

// ignore: camel_case_types
class _filterViewState extends State<filterView> {
  int selectedId=CategoryModel.Catagories.first.id;
  
  @override
  Widget build(BuildContext context) {
    List categories=CategoryModel.Catagories;
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          CategoryModel currentCat=categories[index];
          bool isSelected=selectedId==currentCat.id;
          return Theme(
            data: Theme.of(context).copyWith(cardColor: Colors.transparent),
            child: FilterChip(
              selectedColor: Theme.of(context).focusColor,
              labelStyle: TextStyle(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(46),
              ),
              side: isSelected
                  ? null
                  : BorderSide(color: Theme.of(context).focusColor),
              showCheckmark: false,
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
              onSelected: (value) {
                setState(() {
                  selectedId=currentCat.id;
                });
              },
              selected: isSelected,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10);
        },
      ),
    );
  }
}
