// ignore_for_file: unnecessary_brace_in_string_interps

import '../Data/Api/api_manager.dart';

import '../Data/Model/get_activity_model.dart';

import '../Utils/string_constants.dart';

class ActivityRepository {
  final APIManager apiManager;
  ActivityRepository(this.apiManager);

  //********************** activity api call **********************//

  Future<GetActivityModel> activityAPICall({required String id}) async {
    var jsonData = await apiManager.getAPICall(
      isToken: true,
      url: '${adminUrl}get-activity/${id}',
    );
    var response = GetActivityModel.fromJson(jsonData);
    return response;
  }
}
