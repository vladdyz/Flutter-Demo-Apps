import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    // wrap the container in an inkwell widget to make the items inside it tappable
    // can also use GestureDetector for this, but Inkwell also provides visual feedback on tap
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16), // rounded corners for the container items
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withAlpha(135),
              category.color.withAlpha(230),
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        // Text theme will be defined by Google Fonts, so it cant be null
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
