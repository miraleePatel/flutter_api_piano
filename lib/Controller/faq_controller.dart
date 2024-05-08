import 'package:get/get.dart';
import '../Data/Api/api_manager.dart';
import '../Data/Model/faq_response_model.dart';
import '../Repository/faq_repository.dart';

class FaqController extends GetxController {
  
  var faqRepository = FaqRepository(APIManager());

//********************** variable declaration **********************//

  RxList<bool> selected = <bool>[].obs;
  RxList<FaqData> faqList = <FaqData>[].obs;

//********************** calling api in faq screen **********************//

  faqDataApi() async {
    faqList.clear();
    selected.clear();
    //call api
    FaqResponseModel faqDetails = await faqRepository.faqDataAPICall();
    faqList.addAll(faqDetails.data!);
    for (int i = 1; i <= faqList.length; i++) {
      selected.add(true);
    }
  }
}
