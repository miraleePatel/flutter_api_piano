import 'package:piano_project/Data/Model/check_wallet_blance_response_model.dart';

import '../Data/Api/api_manager.dart';
import '../Data/Model/contactus_response_model.dart';
import '../Data/Model/get_aboutus_model.dart';
import '../Data/Model/get_terms.dart';
import '../Data/Model/login_response_model.dart';
import '../Utils/string_constants.dart';

class ProfileRepository {
  final APIManager apiManager;
  ProfileRepository(this.apiManager);

  //********************** contact us data api call **********************//

  Future<ContactUsModel> contactusDataAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-contact-us',
    );
    var response = ContactUsModel.fromJson(jsonData);
    return response;
  }

  //********************** About us data api call **********************//

  Future<GetAboutUsModel> getAboutDataAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-about-us',
    );
    var response = GetAboutUsModel.fromJson(jsonData);
    return response;
  }

  //********************** terms & condition data api call **********************//

  Future<GetTermsConditionsModel> getTermsConditionAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-terms',
    );
    var response = GetTermsConditionsModel.fromJson(jsonData);
    return response;
  }

  //********************** edit detail api call **********************//

  Future<LoginSuccessModel> editDetailsApiCall(
    String id, {
    required String file,
    required String fullName,
    required String countryCode,
    required String phoneNo,
    required String address,
  }) async {
    var jsonData = await apiManager.patchAPICall(
      url: '${adminUrl}edit-details/$id',
      params: {
        "requestData": {"fullName": fullName, "phone_no": phoneNo, "country_code": countryCode, "address": address, "file": file}
      },
      isToken: true,
    );

    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }

  //********************** Wallet Balance data api call **********************//

  Future<CheckWalletBalanceModel> getWalletDataAPICall({required String id}) async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}check-wallet-balance/$id',
    );
    var response = CheckWalletBalanceModel.fromJson(jsonData);
    return response;
  }
}
