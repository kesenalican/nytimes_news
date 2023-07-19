import 'package:flutter/material.dart';
import 'package:ny_times_news/core/constants/app_constants.dart';
import 'package:ny_times_news/view/styles/colors.dart';
import 'package:ny_times_news/view/styles/styles.dart';

class CommonAppbar extends StatefulWidget implements PreferredSizeWidget {
  final bool isHomePage;
  final String text;
  const CommonAppbar({super.key, required this.isHomePage, required this.text});

  @override
  State<CommonAppbar> createState() => _CommonAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _CommonAppbarState extends State<CommonAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(
        widget.text,
        style: kTitleStyle,
      ),
      elevation: 6,
      shadowColor: Colors.black,
      leading: widget.isHomePage
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Color(
                        MyColors.primary), // Change Custom Drawer Icon Color
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            )
          : BackButton(color: Color(MyColors.primary)),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Color(MyColors.primary),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Color(MyColors.primary),
            )),
      ],
    );
  }
}
