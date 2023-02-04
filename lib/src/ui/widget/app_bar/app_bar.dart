import 'package:flutter/material.dart';
import 'package:the_meal_flutter/src/src.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool? isBackButton;
  const DefaultAppBar({Key? key, this.title, this.isBackButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        leading: isBackButton == true
            ? IconButton(
                key: const Key(UIKeys.appBarBack),
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: title != null
            ? Text(
                title!,
                key: const Key(UIKeys.appBarTitle),
              )
            : null,
        centerTitle: true,
        backgroundColor: Colors.white,
      );

  @override
  Size get preferredSize => const Size(double.infinity, 40);
}
