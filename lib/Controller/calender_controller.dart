// ignore_for_file: non_constant_identifier_names
import 'package:get/get.dart';

class TableCalenderController extends GetxController {
//********************** variable declaration **********************//

  RxString previous_mon = ''.obs;
  RxString next_mon = ''.obs;
  RxString currentDate = ''.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
}
