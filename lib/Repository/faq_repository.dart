import '../Data/Api/api_manager.dart';
import '../Data/Model/faq_response_model.dart';
import '../Utils/string_constants.dart';

class FaqRepository {
  final APIManager apiManager;

  FaqRepository(this.apiManager);

  //********************** faq data api call **********************//

  Future<FaqResponseModel> faqDataAPICall() async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-faq',
    );
    var response = FaqResponseModel.fromJson(jsonData);
    return response;
  }

}