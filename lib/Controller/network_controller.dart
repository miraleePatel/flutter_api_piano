import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:piano_project/Utils/constant_widgets.dart';

import '../Utils/string_constants.dart';

class NetworkController extends GetxController{

//********************** variable declaration **********************//
  
  RxInt connectionStatus = 0.obs;
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? streamSubscription;

//********************** onit method **********************//

  @override
  void onInit() async {
    super.onInit();
    try {
      ConnectivityResult connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        isInternetAvailable.value = true;
      } else {
        isInternetAvailable.value = false;
      }
    } on PlatformException catch (e) {
      errorSnackBar(message:  e.message);
    }
    streamSubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }
//********************** onclose method **********************//

  @override
  void onClose() {
    streamSubscription!.cancel();
    super.onClose();
  }

//********************** update connection status **********************//

  updateConnectionStatus(ConnectivityResult resultData) async {
    switch (resultData) {
      case ConnectivityResult.none:
        isInternetAvailable.value = false;
        await showSyncDialog();
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        isInternetAvailable.value = true;
        await showSyncDialog();
        break;
      default:
        errorSnackBar(message: 'Network Error, Try after sometime!');
        break;
    }
  }
  showSyncDialog() async {
    if (isInternetAvailable.value == true) {
      log('🟢 Internet is available');
    } else {
      log('🔴 Internet is not available');
    }
  }
}