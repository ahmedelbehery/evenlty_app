import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:evenlty_app/models/user_model.dart';
import 'package:evenlty_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).userModel;
    double width = MediaQuery.widthOf(context);
    double height = MediaQuery.heightOf(context);
    return Container(
      width: width,
      height: 0.242 * height,
      decoration: BoxDecoration(
        color: AppColors.maincolor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Assets.images.route.image(
              height: 124,
              width: 124,
              fit: BoxFit.fill,
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user?.name ?? "",
                  style: TextStyle(
                    color: AppColors.lightbgcolor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  user?.email ?? "",
                  style: TextStyle(
                    color: AppColors.lightbgcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
