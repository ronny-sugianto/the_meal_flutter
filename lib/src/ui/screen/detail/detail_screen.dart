import 'package:flutter/material.dart';
import 'package:the_meal_flutter/src/src.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Meal? _data;
  bool _hasInitialize = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      setState(() {
        _data = ModalRoute.of(context)?.settings.arguments as Meal?;
        if (_data == null) {
          Navigator.pop(context);
          context.read<MessageCubit>().showSnackBar(
                isError: true,
                message: 'Tidak Dapat Menambah Item Baru!',
              );
        }
        _hasInitialize = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) => _hasInitialize
      ? BlocProvider(
          create: (context) => MealActionCubit(
            mealRepository: context.read<BaseTheMealRepository>(),
          )..getMealDetail(
              mealId: _data!.id!,
            ),
          child: Scaffold(
            key: const Key(UIKeys.detailScreen),
            appBar: DefaultAppBar(title: _data!.name),
            body: BlocBuilder<MealActionCubit, BaseState<Meal>>(
                builder: (context, state) {
              if (state is SuccessState) {
                return ListView(
                  key: const Key(UIKeys.detailListView),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(state.data!.thumbnail!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          const AspectRatio(aspectRatio: 16.0 / 9.0),
                          if (state.data!.category != null) ...[
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  state.data!.category ?? '-',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 5,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(bottom: 5),
                            margin: const EdgeInsets.only(bottom: 8),
                            child: const Text('Ingredients'),
                          ),
                          ...?state.data!.measureIngredient
                              ?.map(
                                (ingredient) => Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text(ingredient),
                                  ],
                                ),
                              )
                              .toList(),
                          if (state.data!.instruction != null) ...[
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 5,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.only(bottom: 5),
                              margin: const EdgeInsets.only(bottom: 8, top: 8),
                              child: const Text('Instruction'),
                            ),
                            Text(state.data!.instruction!),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              }

              return const DefaultLoading();
            }),
          ),
        )
      : const DefaultLoading();
}
