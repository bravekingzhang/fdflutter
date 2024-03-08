import 'dart:async';

import 'package:fdflutter/core/utils/logger.dart';
import 'package:fdflutter/data/repositories/user_repository.dart';
import 'package:fdflutter/domain/entities/user_entity.dart';
import 'package:fdflutter/domain/usecases/login_usercase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    AsyncNotifierProvider.autoDispose<UserProvider, User>(UserProvider.new);

class UserProvider extends AutoDisposeAsyncNotifier<User> {
  @override
  Future<User> build() async {
    var user = await UserRepository().localUser();
    logger.d('user: $user');
    if (user != null) {
      return user;
    } else {
      throw Exception('no user');
    }
  }

  Future<void> login(String username, String password) async {
    var result = await LoginUserCase().login(username.trim(), password.trim());
    logger.d('login result: $result');
    if (result) {
      var user = await UserRepository().localUser();
      state = AsyncData(user!);
    }
  }
}
