import 'package:flutter/material.dart';
import 'package:mercave/app/shared/components/store/category_grid_list/category_grid_list.widget.ui.dart';

class CategoryGridListWidget extends StatelessWidget {
  final List<dynamic> categories;
  final List<dynamic> stores;
  final int numberColums;
  final double ratio;
  final Function onCategoryTapped;

  const CategoryGridListWidget({
    required this.categories,
    required this.stores,
    required this.numberColums,
    required this.ratio,
    required this.onCategoryTapped
  });

  @override
  Widget build(BuildContext context) {
    return CategoryGridListWidgetUI(
      context: context,
      categories: categories,
      stores:stores,
      numberColums: numberColums,
      ratio: ratio,
      onCategoryTapped: onCategoryTapped,
    ).build();
  }
}
