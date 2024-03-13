import 'package:get_it/get_it.dart';

import 'package:fdflutter/core/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator = GetIt.instance;

initializeDependencyInjection() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => prefs);
  // Register other services and repositories as needed
}
