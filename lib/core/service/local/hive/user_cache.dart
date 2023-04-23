import 'package:assume/core/base/service/base_cache_manager.dart';
import 'package:assume/core/model/user/request/user_request.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserCacheService extends IBaseCacheManager<UserRequest> {
  static final UserCacheService _instance = UserCacheService._init();
  static UserCacheService get instance => _instance;
  UserCacheService._init() : super('user');

  Future<void> openUserBox() async {
    Hive.registerAdapter(UserRequestAdapter());
    await super.openBox();
  }

  Future<void> saveUser(UserRequest user) async {
    user.password = null; // Do not save password
    await super.saveItemWithKey('user', user);
  }

   Future<void> updateUser(UserRequest user) async {
    user.password = null; // Do not save password
    await super.saveItemWithKey('user', user);
  }

  getUser() {
    return super.getItem('user');
  }

  getUserID() {
    return (super.getItem('user') ?? UserRequest()).id;
  }

  getCategories() {
    return (super.getItem('user') ?? UserRequest()).categories;
  }

  deleteUser() {
    return super.deleteItem('user');
  }
}
