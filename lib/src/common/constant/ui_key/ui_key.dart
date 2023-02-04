class UIKeys {
  static const appBarBack = '__appBarBack__';
  static const appBarTitle = '__appBarTitle__';
  static const singleLoading = '__singleLoading__';

  // Home Screen
  static const homeScreen = '__homeScreen__';
  static const categoryDropdown = '__categoryDropdown__';
  static const mealList = '__mealList__';
  static const mealListLoading = '__mealListLoading__';
  static const mealListEmpty = '__mealListEmpty__';
  static const mealListError = '__mealListError__';

  // Detail Screen
  static const detailScreen = '__detailScreen__';
  static const detailListView = '__detailListView__';

  // Category
  static categoryItem(String value) => '__categoryItem${value}__';

  // MealItemCard
  static mealItem(int index) => '__mealItem${index}__';
  static mealItemThumbnailLoaded(int index) =>
      '__mealItem${index}_thumbnailLoaded__';
  static mealItemThumbnailNull(int index) =>
      '__mealItem${index}_thumbnailNull__';
}
