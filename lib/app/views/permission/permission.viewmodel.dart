import 'package:assume/app/routes/navigation_service.dart';
import 'package:assume/app/routes/routes.dart';
import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/service/local/notification/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

class PermissionViewModel extends BaseViewModel {
  bool _isClicked = false;
  bool get isClicked => _isClicked;
  set isClicked(bool isClicked) {
    _isClicked = !_isClicked;
    notifyListeners();
  }

  void requestNotificationPermission() async {
    var status = await Permission.notification.request();

    if (status.isGranted) {
      await NotificationService().initNotification();
      tz.initializeTimeZones();
    }
    NavigationService.instance.navigateToPageClear(path: Routes.home.name);
  }
}
