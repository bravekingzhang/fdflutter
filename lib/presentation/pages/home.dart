import 'package:flutter/cupertino.dart';
import 'package:routemaster/routemaster.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabState = CupertinoTabPage.of(context);

    return CupertinoTabScaffold(
      controller: tabState.controller,
      tabBuilder: tabState.tabBuilder,
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Todos',
            icon: Icon(CupertinoIcons.list_bullet),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
      ),
    );
  }
}
