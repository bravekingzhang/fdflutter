import 'package:fdflutter/presentation/pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:fdflutter/presentation/pages/todo_page.dart';
import 'package:fdflutter/presentation/pages/home.dart';

final routes = RouteMap(
  routes: {
    '/': (_) => CupertinoTabPage(
          child: HomePage(),
          paths: ['/todo', '/settings'],
        ),
    '/todo': (_) => const MaterialPage(child: TodoPage()),
    // '/feed/profile/:id': (_) => MaterialPage(child: ProfilePage()),
    '/settings': (_) => const MaterialPage(child: SettingsScreen()),
  },
);
