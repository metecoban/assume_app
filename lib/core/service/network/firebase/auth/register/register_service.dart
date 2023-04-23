import 'package:assume/core/base/service/base_firestore.dart';
import 'package:assume/core/model/user/request/user_request.dart';
import 'package:assume/core/model/user/response/user_response.dart';
import 'package:assume/core/service/local/hive/mission_cache.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:assume/core/utils/crypto/password_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterService extends IBaseFirestore {
  static final RegisterService _instance = RegisterService._init();
  static RegisterService get instance => _instance;
  RegisterService._init() : super(path: 'users');

  Future register({required UserRequest user, required bool isGoogle}) async {
    try {
      bool isAlreadyExists = false;
      if (isGoogle) {
        isAlreadyExists =
            await super.fetchOneData(user.id!).then((value) => value.data()) !=
                null;
      } else {
        await auth.createUserWithEmailAndPassword(
            email: user.email!, password: user.password!);
        user.id = auth.currentUser!.uid;
        user.password = PasswordUtils.instance.encrypt(user.password!);
      }
      if (!isAlreadyExists) {
        await super.addData(user.toJson(), user.id);
        await _createMissionCollection(user.id ?? '');
      } else {
        final snapshot = await super.fetchOneData(user.id!);
        user = UserRequest.fromJson(snapshot.data());
      }

      await UserCacheService.instance.saveUser(user);
      return UserResponse(success: true, data: user, message: null);
    } on FirebaseAuthException catch (e) {
      return UserResponse(success: false, data: null, message: e.message);
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }

  /// THE ANONYMOUS USER CHOOSED SIGN IN THIS METHOD RUNS
  Future registerAnonymousUser({required UserRequest user}) async {
    try {
      final oldUserID = user.id!;
      await auth.currentUser!.delete(); // DELETE AUTHENTICATION
      await auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      user.id = auth.currentUser!.uid;
      user.password = PasswordUtils.instance.encrypt(user.password!);

      await super.addData(user.toJson(), user.id);
      await _createMissionCollection(user.id ?? '');

      await MissionService.instance
          .carryMissionsToAnotherAccount(oldID: oldUserID, newID: user.id!);
      user.id = oldUserID;
      await deleteUser(); //DELETE FIRESTORE
      await UserCacheService.instance.saveUser(user);
      return UserResponse(success: true, data: user, message: null);
    } on FirebaseAuthException catch (e) {
      return UserResponse(success: false, data: null, message: e.message);
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }

  Future<void> _createMissionCollection(String uuid) async {
    for (var status in MissionStatus.values) {
      await collection.doc(uuid).collection(status.name).doc().set({});
    }
  }

  deleteUser({bool deleteAuthToo = false}) async {
    try {
      String userID = UserCacheService.instance.getUserID();
      if (deleteAuthToo) {
        await auth.currentUser!.delete();
      }
      UserCacheService.instance.deleteUser();
      MissionCacheService.instance.clearMissions();
      return super.deleteData(userID);
    } on FirebaseException catch (e) {
      return UserResponse(success: false, data: null, message: e.message);
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }
}
