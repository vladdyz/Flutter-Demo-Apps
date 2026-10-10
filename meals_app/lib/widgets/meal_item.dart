import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  // capitalizes the first letter of the enum for affordability & complexity
  // ex: simple -> Simple
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  // displays the meals in card format
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      clipBehavior: Clip
          .hardEdge, // to keep the rounded corners defined above in the stack
      // any content that goes outside these boundaries is cut off
      elevation: 2, // drop shadow on the card
      // a meal should be tappable
      child: InkWell(
        onTap: () => {onSelectMeal(context, meal)},
        // positions multiple widgets on top of each other
        child: Stack(
          // in order from background to foreground
          children: [
            // smoothly fades in the meal image instead of suddenly popping it in
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover, // image is never distorted, only cuts off if doesnt fit
              height: 200,
              width: double.infinity,
            ),
            // positioned widget takes a child and allows us to set params
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // transparent bg color to make sure meal metadata is readable atop the image
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 44.0,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // duration icon and meal duration
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(icon: Icons.work, label: complexityText),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
