// ignore_for_file: unused_local_variable

import 'package:piano_project/Data/Model/current_user_model.dart';

import '../Data/Api/api_manager.dart';
import '../Data/Api/post_api_manager.dart';
import '../Data/Model/login_response_model.dart';
import '../Data/Model/logout_model.dart';
import '../Data/Model/otp_model.dart';
import '../Data/Model/send_mail_model.dart';
import '../Utils/string_constants.dart';

class AuthenticationRepository {
  final APIManager apiManager;
  final PostAPIManager postAPIManager;

  AuthenticationRepository(this.apiManager, this.postAPIManager);

  //********************** current user api call **********************//

  Future<CurrentUserModel> currentUserApiCall({
    required String email,
  }) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${userUrl}check-user-register',
      params: {
        "email": email,
      },
    );

    var response = CurrentUserModel.fromJson(jsonData);
    return response;
  }

  //********************** login api call **********************//

  Future<LoginSuccessModel> loginApiCall({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    var jsonData = await apiManager.postAPICall(
      url: '${userUrl}log-in',
      params: {
        "email": email,
        "password": password,
        "fcmToken": fcmToken,
      },
    );

    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }

  //********************** signUp api call **********************//

  Future<LoginSuccessModel> registerApiCall(
      {required String fullName,
      required String email,
      required String countryCode,
      required String phoneNo,
      required String password,
      required String file,
      required String fcmToken,
      required String role}) async {
    var jsonData = await apiManager.postAPICall(url: '${userUrl}register', params: {
      'file': file,
      "fullName": fullName,
      "email": email,
      "country_code": countryCode,
      "phone_no": phoneNo,
      "password": password,
      "fcmToken": fcmToken,
      "role": role
    });
    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }
//********************** social register api call **********************//

  Future<LoginSuccessModel> socialRegisterApiCall(
      {required String fullName,
      required String email,
      required String phoneNo,
      required String password,
      required String file,
      required String countryCode,
      required String socialMedia,
      required String fcmToken,
      required String role}) async {
    var jsonData = await postAPIManager.postAPICall(url: '${userUrl}register', params: {
      'file': file,
      "country_code": countryCode,
      "fullName": fullName,
      "email": email,
      "phone_no": phoneNo,
      "password": password,
      "social_media": socialMedia,
      "fcmToken": fcmToken,
      "role": role
    });
    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }

  //********************** social login api call **********************//

  Future<LoginSuccessModel> socialLoginApiCall(Map<String, dynamic> params) async {
    var jsonData = await apiManager.postAPICall(url: '${userUrl}social-log-in', isToken: false, params: params
        // params: {"fullName": fullName, "email": email, "phone_no": phoneNo, "social_media": socialMedia, "fcmToken": fcmToken},
        );
    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }

  Future<LoginSuccessModel> loginUserApiCall({required String email, bool isLoaderShow = false}) async {
    var jsonData = await postAPIManager.postAPICall(
      url: '${userUrl}check-user-login',
      isLoaderShow: isLoaderShow,
      params: {
        "email": email,
      },
    );

    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }

//********************** logout api call **********************//

  Future<LogoutModel> logoutAPICall() async {
    var jsonData = await apiManager.getAPICall(
      url: '${userUrl}log-out',
    );
    var response = LogoutModel.fromJson(jsonData);
    return response;
  }

//********************** forgot password api call **********************//

  Future<SendMailModel> sendMailAPICall({required String email}) async {
    var jsonData = await apiManager.postAPICall(url: '${userUrl}send-mail', params: {"email": email});
    var response = SendMailModel.fromJson(jsonData);
    return response;
  }
//********************** send OTP api call **********************//

  Future<OtpModel> sendOTPAPICall({required String email}) async {
    var jsonData = await apiManager.postAPICall(url: '${userUrl}send-otp-mail', params: {"email": email});
    var response = OtpModel.fromJson(jsonData);
    return response;
  }
//********************** Verify OTP api call **********************//

  Future<LoginSuccessModel> verifyOTPAPICall({required String otp}) async {
    var jsonData = await apiManager.postAPICall(url: '${userUrl}verify-otp', params: {"otp": otp});
    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }
}
