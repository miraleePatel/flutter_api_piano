// ignore_for_file: unused_import, implementation_imports, unnecessary_import, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:piano_project/Controller/booking_controller.dart';
import 'package:piano_project/Controller/payment_controller.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../Data/Model/login_response_model.dart';
import '../../../../Data/Model/time_available_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_color.dart';
import '../../../../Utils/constant_widgets.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

String paymentUrl = "";
String bookingId = "";

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentController paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
    paymentUrl = Get.arguments[0];
    bookingId = Get.arguments[1];
  }

  @override
  void dispose() {
    super.dispose();
    print("url--------->$paymentUrl");
    paymentUrl = "";
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        paymentController.paytabsPaymentResponse(bookingId: bookingId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: CustomWidgets.text(
            'Payment',
            color: CustomColor.black,
            fontWeight: FontWeight.w800,
            fontSize: 15.sp,
          ),
          centerTitle: true,
          backgroundColor: CustomColor.btnAbout,
          automaticallyImplyLeading: false,
        ),
        body: Obx(() {return isInternetAvailable.value == true ? InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(paymentUrl)),
          initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
              loadWithOverviewMode: true,
            ),
            ios: IOSInAppWebViewOptions(
              allowsInlineMediaPlayback: true,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            // Inject JavaScript code after the WebView is created
            injectJavaScript(controller);
          },
          onLoadStart: (controller, url) {
            // Show the circular progress indicator when the page starts loading

            var urlData = Uri.parse(url.toString());
            print("Payment URL:---------> $paymentUrl");
            print("url onPageStarted --------->$urlData");
            showProgressIndicator();
          },
          onLoadStop: (controller, url) {
            // Hide the circular progress indicator when the page finishes loading
            var urlData = Uri.parse(url.toString());
            print("url onPageFinished--------->$urlData");

            if (urlData.toString().contains('result')) {
              print("url--------->$paymentUrl");
              print("url onPageFinished--------->$urlData");
              Timer(
                const Duration(
                  seconds: 4,
                ),
                () {
                  print("url--------->$paymentUrl");
                  paymentController.paytabsPaymentResponse(bookingId: bookingId);
                },
              );
            } else {
              print("Payment not successful!");
            }

            dismissProgressIndicator();
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            // Check if the URL contains "cancel_button"

            return NavigationActionPolicy.ALLOW;
          },
        )    : CustomWidgets.NoInertnet(top: 230);})
      ),
    );
  }

  void injectJavaScript(InAppWebViewController controller) async {
    // The JavaScript code to handle the cancel button click
    String jsCode = '''
      document.querySelector('a.cancelButton').addEventListener('click', function(event) {
        event.preventDefault(); // Prevent the default link behavior
        window.flutter_inappwebview.callHandler('cancelButtonClicked');
      });
    ''';

    // Execute the JavaScript code
    await controller.evaluateJavascript(source: jsCode);
  }
}
