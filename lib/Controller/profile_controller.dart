import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Data/Model/check_wallet_blance_response_model.dart';
import 'package:piano_project/Data/Model/login_response_model.dart';
import 'package:piano_project/Repository/profile_repository.dart';
import '../Data/Api/api_manager.dart';
import '../Data/Model/contactus_response_model.dart';
import '../Data/Model/get_aboutus_model.dart';
import '../Data/Model/get_terms.dart';
import '../Routes/routes.dart';
import '../Utils/constant_widgets.dart';
import '../Utils/string_constants.dart';
import 'authetication_controller.dart';

class ProfileController extends GetxController {
  var profileRepository = ProfileRepository(APIManager());

  AuthController authController = Get.put(
    AuthController(),
  );

  //********************** variable declaration **********************

  GlobalKey<FormState> editKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phController = TextEditingController(text: "");
  TextEditingController passController = TextEditingController();
  TextEditingController addController = TextEditingController();

  RxString flag = 'ae'.obs;
  RxString numberLenght = '9'.obs;
  RxString contryCode = '+971'.obs;

  Rx<ContactUsModel> contactUsDetails = ContactUsModel().obs;
  Rx<GetAboutUsModel> aboutUsDetails = GetAboutUsModel().obs;
  Rx<GetTermsConditionsModel> termsConData = GetTermsConditionsModel().obs;
  Rx<CheckWalletBalanceModel> walletBalanceData = CheckWalletBalanceModel().obs;
//********************** calling api in editUserDetails screen **********************//

  editUserDetails(String id,
      {required String file,
      required String fullName,
      required String countryCode,
      required String phoneNo,
      required String address,
      String? screenName}) async {
    //call api
    authController.loginDetails.value =
        await profileRepository.editDetailsApiCall(id, file: file, fullName: fullName, countryCode: countryCode, phoneNo: phoneNo, address: address);

    // success message & navigation

    if (authController.loginDetails.value.status == 1) {
      successSnackBar(message: authController.loginDetails.value.message);
      GetStorage().write(userData, authController.loginDetails.value.toJson());
      if (screenName == "editprofile") {
        Get.offAllNamed(Routes.DASHBOARD_SCREEN);
      } else {
        Get.back(closeOverlays: true);
      }
    } else {
      errorSnackBar(message: authController.loginDetails.value.message);
    }
  }

  //********************** calling api in contact us screen **********************//

  contactUsDataApi() async {
    contactUsDetails.value = await profileRepository.contactusDataAPICall();
  }

  //********************** calling api in about us screen **********************//

  aboutUsDataApi() async {
    aboutUsDetails.value = await profileRepository.getAboutDataAPICall();
  }

  //********************** calling api of terms & condition **********************//

  termsConditionApi() async {
    termsConData.value = await profileRepository.getTermsConditionAPICall();
  }
  //********************** calling api of terms & condition **********************//

  walletBalanceApi() async {
    walletBalanceData.value = await profileRepository.getWalletDataAPICall(
        id: LoginSuccessModel.fromJson(
      GetStorage().read(
        userData,
      ),
    ).data!.sId.toString());
  }
}
