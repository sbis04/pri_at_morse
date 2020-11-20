import 'package:primorse/services/server_demo_service.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;

class Authentication {
  ServerDemoService _serverDemoService = ServerDemoService.getInstance();

  Future<bool> userLogin(String atSign) async {
    bool isLoginSuccessful = false;
    await _serverDemoService.onboard().then((value) async {
      await _serverDemoService
          .authenticate(
            atSign,
            cramSecret: at_demo_data.cramKeyMap[atSign],
          )
          .then((value) => isLoginSuccessful = value)
          .catchError((e) => print('Authentication error: $e'));
    }).catchError((e) => print('Onboarding error: $e'));
    return isLoginSuccessful;
  }
}
