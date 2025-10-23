// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsBottomNavIconsGen {
  const $AssetsBottomNavIconsGen();

  /// File path: assets/bottom_nav_icons/fav_select.png
  AssetGenImage get favSelect =>
      const AssetGenImage('assets/bottom_nav_icons/fav_select.png');

  /// File path: assets/bottom_nav_icons/fav_un.png
  AssetGenImage get favUn =>
      const AssetGenImage('assets/bottom_nav_icons/fav_un.png');

  /// File path: assets/bottom_nav_icons/home_select.png
  AssetGenImage get homeSelect =>
      const AssetGenImage('assets/bottom_nav_icons/home_select.png');

  /// File path: assets/bottom_nav_icons/home_un.png
  AssetGenImage get homeUn =>
      const AssetGenImage('assets/bottom_nav_icons/home_un.png');

  /// File path: assets/bottom_nav_icons/map_select.png
  AssetGenImage get mapSelect =>
      const AssetGenImage('assets/bottom_nav_icons/map_select.png');

  /// File path: assets/bottom_nav_icons/map_un.png
  AssetGenImage get mapUn =>
      const AssetGenImage('assets/bottom_nav_icons/map_un.png');

  /// File path: assets/bottom_nav_icons/profile_un.png
  AssetGenImage get profileUn =>
      const AssetGenImage('assets/bottom_nav_icons/profile_un.png');

  /// File path: assets/bottom_nav_icons/user_select.png
  AssetGenImage get userSelect =>
      const AssetGenImage('assets/bottom_nav_icons/user_select.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    favSelect,
    favUn,
    homeSelect,
    homeUn,
    mapSelect,
    mapUn,
    profileUn,
    userSelect,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/EG.png
  AssetGenImage get eg => const AssetGenImage('assets/icons/EG.png');

  /// File path: assets/icons/LR.png
  AssetGenImage get lr => const AssetGenImage('assets/icons/LR.png');

  /// File path: assets/icons/birthday.png
  AssetGenImage get birthday =>
      const AssetGenImage('assets/icons/birthday.png');

  /// File path: assets/icons/bookclub.png
  AssetGenImage get bookclub =>
      const AssetGenImage('assets/icons/bookclub.png');

  /// File path: assets/icons/eating.png
  AssetGenImage get eating => const AssetGenImage('assets/icons/eating.png');

  /// File path: assets/icons/email.png
  AssetGenImage get email => const AssetGenImage('assets/icons/email.png');

  /// File path: assets/icons/exhibiton.png
  AssetGenImage get exhibiton =>
      const AssetGenImage('assets/icons/exhibiton.png');

  /// File path: assets/icons/googleicon.png
  AssetGenImage get googleicon =>
      const AssetGenImage('assets/icons/googleicon.png');

  /// File path: assets/icons/holiday.png
  AssetGenImage get holiday => const AssetGenImage('assets/icons/holiday.png');

  /// File path: assets/icons/meeting.png
  AssetGenImage get meeting => const AssetGenImage('assets/icons/meeting.png');

  /// File path: assets/icons/nameicon.png
  AssetGenImage get nameicon =>
      const AssetGenImage('assets/icons/nameicon.png');

  /// File path: assets/icons/password.png
  AssetGenImage get password =>
      const AssetGenImage('assets/icons/password.png');

  /// File path: assets/icons/sports.png
  AssetGenImage get sports => const AssetGenImage('assets/icons/sports.png');

  /// File path: assets/icons/workshop.png
  AssetGenImage get workshop =>
      const AssetGenImage('assets/icons/workshop.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    eg,
    lr,
    birthday,
    bookclub,
    eating,
    email,
    exhibiton,
    googleicon,
    holiday,
    meeting,
    nameicon,
    password,
    sports,
    workshop,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/Logo.png');

  /// File path: assets/images/forgetpassword.png
  AssetGenImage get forgetpassword =>
      const AssetGenImage('assets/images/forgetpassword.png');

  /// File path: assets/images/route.png
  AssetGenImage get route => const AssetGenImage('assets/images/route.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo, forgetpassword, route];
}

class Assets {
  const Assets._();

  static const $AssetsBottomNavIconsGen bottomNavIcons =
      $AssetsBottomNavIconsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
