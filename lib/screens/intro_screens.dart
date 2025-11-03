import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:evenlty_app/provider/theme_provider.dart';
import 'package:evenlty_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboardingScreen";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  bool isEnglish = true;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/intro/1.png",
      "title": "Personalize Your Experience",
      "desc":
          "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
    },
    {
      "image": "assets/intro/2.png",
      "title": "Find Events That Inspire You",
      "desc":
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, or professional networking, we have something for everyone.",
    },
    {
      "image": "assets/intro/3.png",
      "title": "Effortless Event Planning",
      "desc":
          "Take the hassle out of organizing events with our all-in-one planning tools. Set up invites, manage RSVPs, and focus on what matters.",
    },
    {
      "image": "assets/intro/4.png",
      "title": "Connect with Friends & Share Moments",
      "desc":
          "Make every event memorable by sharing the experience with friends. Capture and share the excitement with your network.",
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (mounted) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => currentIndex = index),
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final item = pages[index];
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Image.asset("assets/intro/introbrand.png",
                          width: 159, height: 50),
                      const SizedBox(height: 20),
                      Image.asset(item["image"]!,
                          width: 357, height: 359, fit: BoxFit.fill),
                      const SizedBox(height: 20),
                      Text(
                        item["title"]!,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.maincolor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          item["desc"]!,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (index == 0) ...[
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Language",
                                    style: TextStyle(
                                        color: AppColors.maincolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        setState(() => isEnglish = !isEnglish),
                                    child: Container(
                                      width: 70,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColors.maincolor,
                                            width: 2),
                                        color: Colors.transparent,
                                      ),
                                      child: AnimatedAlign(
                                        duration:
                                            const Duration(milliseconds: 250),
                                        alignment: isEnglish
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Image.asset(
                                            isEnglish
                                                ? Assets.icons.lr.path
                                                : Assets.icons.eg.path,
                                            width: 28,
                                            height: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Theme",
                                    style: TextStyle(
                                        color: AppColors.maincolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Switch(
                                    value: themeProvider.isDarkMode,
                                    activeColor: AppColors.maincolor,
                                    onChanged: (v) =>
                                        themeProvider.toggleTheme(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 300,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.maincolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                            onPressed: () {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: const Text(
                              "Let's Start",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
            if (currentIndex != 0)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.maincolor, width: 2),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.arrow_back_ios,
                            color: AppColors.maincolor, size: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: currentIndex == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? AppColors.maincolor
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (currentIndex == pages.length - 1) {
                          await _completeOnboarding();
                        } else {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.maincolor, width: 2),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.arrow_forward_ios,
                            color: AppColors.maincolor, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
