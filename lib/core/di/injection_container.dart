import 'package:get_it/get_it.dart';

import 'package:fdflutter/core/api/api_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiService());
  // Register other services and repositories as needed
}
