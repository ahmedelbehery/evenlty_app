import 'package:evenlty_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  int id;
  String title;
  IconData icon;
  String? designPath;
  CategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    this.designPath,
  });
  // ignore: non_constant_identifier_names
  static List<CategoryModel> get Catagories => [
    CategoryModel(id: 1, title: "All", icon: Icons.explore),
    CategoryModel(
      id: 2,
      title: "Sport",
      icon: Icons.pedal_bike,
      designPath: Assets.icons.sports.path,
    ),
    CategoryModel(
      id: 3,
      title: "Birthday",
      icon: Icons.cake,
      designPath: Assets.icons.birthday.path,
    ),
    CategoryModel(
      id: 4,
      title: "Meeting",
      icon: Icons.meeting_room,
      designPath: Assets.icons.meeting.path,
    ),
    CategoryModel(
      id: 5,
      title: "Workshop",
      icon: Icons.handyman,
      designPath: Assets.icons.workshop.path,
    ),
    CategoryModel(
      id: 6,
      title: "Eating",
      icon: Icons.dining,
      designPath: Assets.icons.eating.path,
    ),
    CategoryModel(
      id: 7,
      title: "Holiday",
      icon: Icons.airplane_ticket,
      designPath: Assets.icons.holiday.path,
    ),
    CategoryModel(
      id: 8,
      title: "Exhibition",
      icon: Icons.museum,
      designPath: Assets.icons.exhibiton.path,
    ),
    CategoryModel(
      id: 9,
      title: "Book Club",
      icon: Icons.book_outlined,
      designPath: Assets.icons.bookclub.path,
    ),
  ];
}
