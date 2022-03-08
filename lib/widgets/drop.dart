import 'package:flutter/material.dart';
import 'dropmodel.dart';

class MenuItems {
  static const List<MenuItem> Items = [
    itemDelete,
    itemEdit,
  ];

  static const itemEdit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const itemDelete =
      MenuItem(text: 'Delete', icon: Icons.delete_forever);
}
