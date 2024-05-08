// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unused_import, unnecessary_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../Utils/app_color.dart';
import '../Utils/constant_widgets.dart';
import '../Utils/string_constants.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidgets {
  ///******************************************* Text Widget *******************************************///

  static Text text(
    String content, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    int? maxLine,
    double? letterSpacing = 0.0,
    TextAlign? textAlign,
    double? height = 1.7,
    TextOverflow? overflow,
    TextDecoration? decoration,
    bool? softWrap,
  }) {
    return Text(
      content,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      softWrap: softWrap,
      style: TextStyle(
        letterSpacing: letterSpacing,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: 'minion-pro-cufonfonts',
      ),
    );
  }

  ///******************************************* Image Widget *******************************************///

  // custom image
  static customImage({required String image, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: '$imageUrl${image}',
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }

  //no image
  static NoImage({double? scale}) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: CustomColor.btnCon,
          border: Border.all(
            color: CustomColor.btn,
          ),
        ),
        child: Image.asset(
          noImage,
          fit: BoxFit.contain,
          scale: scale,
        ));
  }

  //no internet connection image
  static NoInertnet({double top = 0.0, double bottom = 0.0}) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: bottom),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 20.h,
            child: Image.asset(
              noInternet,
              scale: 9,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  ///******************************************* Tab Widget *******************************************///

  static CustomTab({
    Widget? child,
    Color? color,
  }) {
    return Tab(
      icon: Container(
        margin: EdgeInsets.only(
          top: 1.5.h,
        ),
        color: color,
        height: 2.5.h,
        width: 10.w,
        child: child,
      ),
    );
  }

  ///******************************************* Icon Widget *******************************************///

  static customIcon({
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: 1.w,
        ),
        width: 7.5.w,
        height: 4.5.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              menuBackIcon,
            ),
          ),
        ),
      ),
    );
  }

  ///******************************************* LoginContainer Widget *******************************************///

  static LoginContainer({
    required void Function() onPressed,
    Widget? image,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 7.h,
        width: 13.1.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.sp,
          ),
          border: Border.all(
            color: color,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 4.h,
            width: 9.w,
            child: image,
          ),
        ),
      ),
    );
  }

  ///******************************************* CustomContainer Widget *******************************************///

  static customContainer({double? height, double? top, Widget? child, Color? color, required double margintop, BorderRadiusGeometry? borderRadius}) {
    return Padding(
      padding: EdgeInsets.only(
        top: margintop,
      ),
      child: Stack(
        children: [
          Container(
            height: height,
            width: 90.w,
            decoration: BoxDecoration(
                color: color ?? CustomColor.btnFaq,
                borderRadius: borderRadius ?? BorderRadius.circular(5.sp),
                border: Border.all(
                  color: CustomColor.btnFaqBorder,
                )),
            child: child,
          ),
          Positioned(
              left: 0.2.w,
              top: top,
              bottom: top,
              child: Container(
                width: 0.4.w,
                color: CustomColor.btn,
              )),
          Positioned(
              right: 0.2.w,
              top: top,
              bottom: top,
              child: Container(
                width: 0.4.w,
                color: CustomColor.btn,
              )),
        ],
      ),
    );
  }

  ///******************************************* App Bar *******************************************///

  static CustAppbar({
    required String title,
  }) {
    stutesbar();
    return Padding(
      padding: EdgeInsets.only(
        top: 1.h,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back(result: true, closeOverlays: true);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: CustomColor.btn,
              size: SizerUtil.deviceType == DeviceType.mobile ? 20 : 30,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 3.3.h,
              child: Center(
                child: CustomWidgets.text(title,
                    fontWeight: FontWeight.w800, fontSize: SizerUtil.deviceType == DeviceType.mobile ? 15.sp : 12.sp, maxLine: 1),
              ),
            ),
          ),
          const SizedBox(
            width: 48,
          ),
        ],
      ),
    );
  }

  ///******************************************* Custom RichText Widget *******************************************///

  Padding buildRichText({
    String? text1,
    String? text2,
    TextOverflow? overflow,
    int? maxLines,
    double? fontSize,
    double? fontSize1,
    Color? color1,
    Color? color2,
    FontWeight? fontWeight1,
    FontWeight? fontWeight2,
  }) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
            style: const TextStyle(
              height: 1.4,
              color: CustomColor.black,
            ),
            text: "",
            children: [
              TextSpan(
                  text: "$text1",
                  style: TextStyle(
                    overflow: overflow,
                    color: color1 ?? CustomColor.btn,
                    fontSize: fontSize1 ?? 12.sp,
                    fontWeight: fontWeight1 ?? FontWeight.w800,
                    fontFamily: 'minion-pro-cufonfonts',
                  )),
              TextSpan(
                  style: TextStyle(
                      fontWeight: fontWeight2 ?? FontWeight.normal,
                      overflow: overflow,
                      fontFamily: 'minion-pro-cufonfonts',
                      color: color2,
                      fontSize: fontSize),
                  text: "$text2"),
            ]),
        maxLines: maxLines,
      ),
    );
  }

  ///******************************************* FAQ Icon Widget *******************************************///

  static customFaq({
    required bool isSelected,
    required String image,
    required String Text,
    required String des,
    Function()? onTap,
  }) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColor.btnFaq,
            border: Border.all(
              color: CustomColor.btnFaqBorder,
            ),
            borderRadius: BorderRadius.circular(
              6.sp,
            ),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                SizedBox(
                  height: 2.w,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 2.w),
                    SizedBox(
                      height: 6.h,
                      width: 6.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          6.sp,
                        ),
                        child: CustomWidgets.customImage(
                          image: image,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.5.w,
                    ),
                    Expanded(
                      child: CustomWidgets.text(
                        Text,
                        softWrap: true,
                        fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.5.sp : 8.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 1.8.h,
                      width: 1.8.h,
                      child: isSelected
                          ? Image.asset(
                              dropdown,
                            )
                          : Image.asset(
                              uparrow,
                            ),
                    ),
                    SizedBox(width: 5.w),
                  ],
                ),
                SizedBox(
                  height: 2.w,
                ),
                Visibility(
                    visible: isSelected == false ? true : false,
                    child: Container(
                      width: 63.w,
                      margin: EdgeInsets.only(
                        left: SizerUtil.deviceType == DeviceType.mobile ? 10.w : 20,
                      ),
                      child: CustomWidgets.text(des, fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 8.sp),
                    )),
                Visibility(
                    visible: isSelected == false ? true : false,
                    child: SizedBox(
                      height: 4.w,
                    ))
              ],
            ),
          ),
        ),
        Positioned(
          top: isSelected == true ? 2.h : 3.h,
          bottom: isSelected == true ? 2.h : 3.h,
          child: Container(
            width: 0.5.w,
            color: CustomColor.btn,
            padding: EdgeInsets.only(
              top: 2.h,
            ),
          ),
        ),
        Positioned(
          top: isSelected == true ? 2.h : 3.h,
          right: 0.w,
          bottom: isSelected == true ? 2.h : 3.h,
          child: Container(
            width: 0.5.w,
            color: CustomColor.btn,
            padding: EdgeInsets.only(
              top: 2.h,
            ),
          ),
        )
      ],
    );
  }
}
