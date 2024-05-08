import 'package:flutter/material.dart';
import 'package:piano_project/Utils/constant_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlRedirectScreen extends StatefulWidget {
  const UrlRedirectScreen({super.key});

  @override
  State<UrlRedirectScreen> createState() => _UrlRedirectScreenState();
}

class _UrlRedirectScreenState extends State<UrlRedirectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                //To remove the keyboard when button is pressed
                FocusManager.instance.primaryFocus?.unfocus();

                var whatsappUrl = "whatsapp://send?phone=6355327237";
                try {
                  launch(whatsappUrl);
                } catch (e) {
                  //To handle error and display error message
                  errorSnackBar(message: "Unable to open whatsapp");
                }
              },
              child: Text("whatsapp")),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();

                var telegramUrl = "https://t.me/pianoTest";
                // var telegramUrl = "https://telegram.me/6355327237";
                try {
                  launch(telegramUrl);
                } catch (e) {
                  //To handle error and display error message
                  errorSnackBar(message: "Unable to open Telegram");
                }
              },
              child: Text("Telegram")),
        ]),
      ),
    );
  }
}
