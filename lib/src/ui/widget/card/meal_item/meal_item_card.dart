import 'package:flutter/material.dart';
import 'package:the_meal_flutter/src/src.dart';

class MealItemCard extends StatelessWidget {
  final int index;
  final Meal meal;

  const MealItemCard({
    super.key,
    required this.index,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        key: Key(UIKeys.mealItem(index)),
        onTap: () => Navigator.pushNamed(
          context,
          RouteName.detailScreen,
          arguments: ScreenArgument(data: meal),
        ),
        child: Container(
          key: Key(
            meal.thumbnail != null
                ? UIKeys.mealItemThumbnailLoaded(index)
                : UIKeys.mealItemThumbnailNull(index),
          ),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
            image: meal.thumbnail != null
                ? DecorationImage(
                    image: NetworkImage(meal.thumbnail!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              meal.name ?? '-',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
}
