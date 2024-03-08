import 'package:fdflutter/data/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUserCase {
  Future<bool> login(String username, String password) async {
    if (password.trim() != '123456') {
      return false;
    }
    // 随便实现下
    // step1 获取所有用户
    // step2 比对下是否有需要的用户，实际情况当然不是这么玩
    var userList = await UserRepository().fetchUserList();
    try {
      var loginUser = userList.firstWhere((element) =>
          element.username.toLowerCase() == username.toLowerCase());
      await UserRepository().saveUser(loginUser);
      GetIt.instance.get<SharedPreferences>().setBool('userLogin', true);
      return true;
    } catch (e) {
      return false;
    }
  }
}
