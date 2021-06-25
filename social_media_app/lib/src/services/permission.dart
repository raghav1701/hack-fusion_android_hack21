import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  final Permission permission;

  PermissionHandler(this.permission);

  /// Verify if permission is granted or not, if not then request for same.
  Future<bool> verifyAndRequest() async {
    bool status = await permission.isGranted && await permission.isDenied;
    if (!status) {
      var value = await permission.request();
      if (value == PermissionStatus.granted || value == PermissionStatus.limited) {
        status = true;
      }
    }
    return status;
  }
}