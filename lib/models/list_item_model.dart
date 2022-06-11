import 'package:flutter/material.dart';

class ListItemModel {
  final String title;
  final Color color;
  final IconData icon;

  ListItemModel({
    required this.title,
    required this.color,
    required this.icon,
  });
}

List<ListItemModel> toolbarItems = [
  ListItemModel(
    title: 'Edit',
    color: Colors.pinkAccent,
    icon: Icons.edit,
  ),
  ListItemModel(
    title: 'Delete',
    color: Colors.lightBlueAccent,
    icon: Icons.delete,
  ),
  ListItemModel(
    title: 'Comment',
    color: Colors.cyan,
    icon: Icons.comment,
  ),
  ListItemModel(
    title: 'Post',
    color: Colors.deepOrangeAccent,
    icon: Icons.post_add,
  ),
  ListItemModel(
    title: 'Favorite',
    color: Colors.pink,
    icon: Icons.star,
  ),
  ListItemModel(
    title: 'Details',
    color: Colors.amber,
    icon: Icons.details,
  ),
  ListItemModel(
    title: 'Languages',
    color: Colors.pinkAccent,
    icon: Icons.translate,
  ),
  ListItemModel(
    title: 'Settings',
    color: Colors.lightBlueAccent,
    icon: Icons.settings,
  ),
  ListItemModel(
    title: 'Edit',
    color: Colors.pinkAccent,
    icon: Icons.edit,
  ),
  ListItemModel(
    title: 'Delete',
    color: Colors.lightBlueAccent,
    icon: Icons.delete,
  ),
  ListItemModel(
    title: 'Comment',
    color: Colors.cyan,
    icon: Icons.comment,
  ),
  ListItemModel(
    title: 'Post',
    color: Colors.deepOrangeAccent,
    icon: Icons.post_add,
  ),
  ListItemModel(
    title: 'Favorite',
    color: Colors.pink,
    icon: Icons.star,
  ),
  ListItemModel(
    title: 'Details',
    color: Colors.amber,
    icon: Icons.details,
  ),
  ListItemModel(
    title: 'Languages',
    color: Colors.pinkAccent,
    icon: Icons.translate,
  ),
  ListItemModel(
    title: 'Settings',
    color: Colors.lightBlueAccent,
    icon: Icons.settings,
  ),
];
