import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:evenlty_app/models/user_model.dart';
import 'package:evenlty_app/network/auth_service.dart';
import 'package:evenlty_app/provider/user_provider.dart';
import 'package:evenlty_app/screens/home/fav/fav_tab.dart';
import 'package:evenlty_app/screens/home/home%20tab/home_screen.dart';
import 'package:evenlty_app/screens/home/location_tab/location_tab.dart';
import 'package:evenlty_app/screens/home/setting_screen/setting_screen.dart';
import 'package:evenlty_app/screens/new_event/new_event_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayerScreen extends StatefulWidget {
  const MainLayerScreen({super.key});
  static const routeName = "/main-layer";
  @override
  State<MainLayerScreen> createState() => _MainLayerScreenState();
}

class _MainLayerScreenState extends State<MainLayerScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeScreen(), LocationTab(), FavTab(), SettingScreen()];
  @override
  void initState() {
    super.initState();
    initialUser();
  }

  initialUser() async {
    super.initState();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    UserModel user = (await AuthService.getUserInfo())!;
    Provider.of<UserProvider>(context, listen: false).setUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: tabs),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.lightbgcolor,
        ),
        child: FloatingActionButton(
          backgroundColor: Theme.of(
            context,
          ).bottomNavigationBarTheme.backgroundColor,
          onPressed: () {
            Navigator.of(context).pushNamed(NewEventTab.routeName);
          },
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: AppColors.lightbgcolor, size: 25),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        notchMargin: 5,
        clipBehavior: Clip.hardEdge,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: (value) => setState(() => currentIndex = value),
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Assets.bottomNavIcons.homeUn.image(height: 24, width: 24),
              activeIcon: Assets.bottomNavIcons.homeSelect.image(
                height: 24,
                width: 24,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Assets.bottomNavIcons.mapUn.image(height: 24, width: 24),
              activeIcon: Assets.bottomNavIcons.mapSelect.image(
                height: 24,
                width: 24,
              ),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: Assets.bottomNavIcons.favUn.image(height: 24, width: 24),
              activeIcon: Assets.bottomNavIcons.favSelect.image(
                height: 24,
                width: 24,
              ),
              label: "Favourite",
            ),
            BottomNavigationBarItem(
              icon: Assets.bottomNavIcons.profileUn.image(
                height: 24,
                width: 24,
              ),
              activeIcon: Assets.bottomNavIcons.userSelect.image(
                height: 24,
                width: 24,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
