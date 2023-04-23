import 'package:assume/core/base/service/base_firestore.dart';
import 'package:assume/core/model/user/request/user_request.dart';
import 'package:assume/core/model/user/response/user_response.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService extends IBaseFirestore {
  static final UserService _instance = UserService._init();
  static UserService get instance => _instance;
  UserService._init() : super(path: 'users');

  Future updateUser(UserRequest user) async {
    try {
      await super.updateData(user.toJson(), user.id!);
      return UserResponse(success: true, data: user, message: null);
    } on FirebaseException catch (e) {
      return UserResponse(success: false, data: null, message: e.message);
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }

  Future updateCategory(List<String> categories) async {
    try {
      String uuid = UserCacheService.instance.getUserID();
      await super.updateSomeData('categories', categories, uuid);
      UserRequest user = UserCacheService.instance.getUser();
      user.categories = categories;
      await UserCacheService.instance.updateUser(user);
      return UserResponse(success: true, data: user, message: null);
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }
}
