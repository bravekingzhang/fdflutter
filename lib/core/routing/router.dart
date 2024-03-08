import 'package:fdflutter/core/utils/logger.dart';
import 'package:fdflutter/presentation/pages/login.dart';
import 'package:fdflutter/presentation/pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:routemaster/routemaster.dart';
import 'package:fdflutter/presentation/pages/todo_page.dart';
import 'package:fdflutter/presentation/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

final routes = RouteMap(
  routes: {
    '/': (_) => canUserAccessPage()
        ? const TabPage(
            child: HomePage(),
            paths: ['/todo', '/settings'],
          )
        : const Redirect('/login'),
    '/todo': (_) => const MaterialPage(child: TodoPage()),
    '/settings': (_) => const MaterialPage(child: SettingsScreen()),
    '/login': (_) => MaterialPage(child: LoginPage()),
  },
);

canUserAccessPage() {
  var isLogin =
      GetIt.instance.get<SharedPreferences>().getBool('userLogin') ?? false;
  logger.d('isLogin: $isLogin');
  return isLogin;
}
