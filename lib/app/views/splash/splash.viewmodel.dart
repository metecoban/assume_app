import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel();

  Future<void> fetchData() async {
    // If user is logged in
    if (UserCacheService.instance.getUserID() != null) {
      MissionService.instance.updateAllMissions();
    }

    // If user is not logged in
    await Future.delayed(const Duration(seconds: 2));
  }
}
