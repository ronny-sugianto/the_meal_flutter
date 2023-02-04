import 'package:flutter/material.dart';
import 'package:the_meal_flutter/src/src.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        key: const Key(UIKeys.homeScreen),
        providers: [
          BlocProvider(
            create: (context) => CategoryCubit(
              mealRepository: context.read<BaseTheMealRepository>(),
            )..getCategoryList(),
          ),
          BlocProvider(
            create: (context) => MealDataCubit(
              mealRepository: context.read<BaseTheMealRepository>(),
            )..getMealList(),
          ),
        ],
        child: Scaffold(
          appBar: const DefaultAppBar(
            title: 'The Meal',
            isBackButton: false,
          ),
          backgroundColor: Colors.white,
          body: BlocBuilder<CategoryCubit, BaseState<List<String>>>(
              builder: (context, categoryState) {
            return RefreshIndicator(
              onRefresh: () async => _reinitializeData(context),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                children: [
                  if (categoryState is LoadedState) ...[
                    _buildCategoryWidget(context, data: categoryState.data!),
                  ],
                  const SizedBox(height: 20),
                  _buildMealWidget(),
                ],
              ),
            );
          }),
        ),
      );

  void _reinitializeData(BuildContext context) => context
    ..read<CategoryCubit>().getCategoryList()
    ..read<MealDataCubit>().getMealList();

  Widget _buildCategoryWidget(
    BuildContext context, {
    required List<String> data,
  }) =>
      DropdownButtonFormField(
        key: const Key(UIKeys.categoryDropdown),
        decoration: const InputDecoration(
          labelText: 'Category',
          hintText: 'Select an category',
          prefixIcon: Icon(Icons.list),
        ),
        items: data
            .map((category) => DropdownMenuItem(
                  value: category.toLowerCase(),
                  child: Semantics(
                    label: UIKeys.categoryItem(category),
                    child: Text(category),
                  ),
                ))
            .toList(),
        onChanged: (value) => context.read<MealDataCubit>().getMealList(
              category: value,
            ),
      );

  Widget _buildMealWidget() =>
      BlocBuilder<MealDataCubit, BaseState<List<Meal>>>(
          builder: (context, mealState) {
        if (mealState is ErrorState) {
          return const Center(
            key: Key(UIKeys.mealListError),
            child: Text(
              'Error While Fetch Data\n'
              'Please Pull To Refresh.',
              textAlign: TextAlign.center,
            ),
          );
        }

        if (mealState is EmptyState) {
          return const Center(
            key: Key(UIKeys.mealListEmpty),
            child: Text(
              'No Data\n'
              'Please Select Another Category.',
              textAlign: TextAlign.center,
            ),
          );
        }

        if (mealState is LoadedState) {
          return GridView.builder(
            key: const Key(UIKeys.mealList),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: mealState.data!.length,
            itemBuilder: (context, index) => MealItemCard(
              index: index,
              meal: mealState.data![index],
            ),
          );
        }

        return const Center(
          key: Key(UIKeys.mealListLoading),
          child: CircularProgressIndicator(),
        );
      });
}
