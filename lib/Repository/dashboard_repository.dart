// ignore_for_file: non_constant_identifier_names, unused_import
import '../Data/Api/api_manager.dart';
import '../Data/Model/contactus_response_model.dart';
import '../Utils/string_constants.dart';

class DashboardRepository {
  final APIManager apiManager;

  DashboardRepository(this.apiManager);

  //********************** contact us data api call **********************//

  Future<ContactUsModel> contactusDataAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-contact-us',
    );
    var response = ContactUsModel.fromJson(jsonData);
    return response;
  }
}
