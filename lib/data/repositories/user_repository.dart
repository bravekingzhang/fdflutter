import 'package:fdflutter/data/datasources/local_datasource.dart';
import 'package:fdflutter/data/datasources/remote_datasource.dart';
import 'package:fdflutter/domain/entities/user_entity.dart';
import 'package:get_it/get_it.dart';

class UserRepository {
  Future<List<User>> fetchUserList() async {
    var datas =
        await RemoteDataSource(GetIt.instance.get()).fetchData('/users');
    datas = datas as List;
    return datas.map((e) => User.fromJson(e)).toList();
  }

  // find user by id
  Future<User> fetchUserById(int id) async {
    var datas =
        await RemoteDataSource(GetIt.instance.get()).fetchData('/users/$id');
    return User.fromJson(datas);
  }

  // save login user
  Future<void> saveUser(User user) async {
    await LocalDataSource().save(LocalDataSource.keyUser, user);
  }

  // load local user
  Future<User?> localUser() async {
    var user = await LocalDataSource()
        .get(LocalDataSource.keyUser, defaultValue: null);
    return user;
  }
}
