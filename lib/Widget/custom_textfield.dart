// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../Utils/app_color.dart';


//txtbox
class CustomTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool? obscureText = true;
  Widget? image;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  bool readOnly;
  BoxConstraints? suffixIconConstraints;
  List<TextInputFormatter>? inputFormatters;
  String? prefixText;
  Widget? prefixIcon;

  String? Function(String?)? validator;
  void Function()? onTap;
  void Function(String)? onChanged;

  CustomTextFiled(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.image,
      this.obscureText,
      this.validator,
      this.prefixText,
      this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.readOnly = false,
      this.inputFormatters,
      this.onChanged,
      this.prefixIcon,
      this.suffixIconConstraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: TextFormField(
            onChanged: onChanged,
            onTap: onTap,
            textInputAction: TextInputAction.next,
            controller: controller,
            validator: validator,
            cursorColor: CustomColor.bgBottem,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'minion-pro-cufonfonts',
                color: CustomColor.black,
              ),
              contentPadding: EdgeInsets.only(
                top: 1.h,
                left: 4.w,
              ),
              hintTextDirection: TextDirection.ltr,
              border: InputBorder.none,
              fillColor: CustomColor.btnCont,
              filled: true,
              suffixIconConstraints: suffixIconConstraints,
              prefixText: prefixText,
              prefixIcon: SizedBox(
                height: 2,
                width: 2,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 1.w,
                    ),
                    height: 3.h,
                    width: 5.5.w,
                    child: image,
                  ),
                ),
              ),
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8.sp,
                ),
                borderSide: const BorderSide(
                  color: CustomColor.btnBorder,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8.sp,
                ),
                borderSide: const BorderSide(
                  color: CustomColor.btnBorder,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8.sp,
                ),
                borderSide: const BorderSide(
                  color: CustomColor.btnBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8.sp,
                ),
                borderSide: const BorderSide(
                  color: CustomColor.btnBorder,
                ),
              ),
            ),
            obscureText: obscureText ?? false,
            readOnly: readOnly,
          ),
        ),
      ],
    );
  }
}

//Enquiry txtbox
class CustomEnquiryTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool? show = true;

  TextInputType? keyboardType;

  String? Function(String?)? validator;
  void Function()? onTap;
  List<TextInputFormatter>? inputFormatters;

  CustomEnquiryTextFiled({
    Key? key,
    required this.controller,
    required this.hintText,
    this.show,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Stack(
            children: [
              TextFormField(
                onTap: onTap,
                inputFormatters: inputFormatters,
                textInputAction: TextInputAction.next,
                controller: controller,
                validator: validator,
                cursorColor: CustomColor.bgBottem,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontFamily: 'minion-pro-cufonfonts',
                    color: CustomColor.black,
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 1.h,
                    left: 4.w,
                  ),
                  border: InputBorder.none,
                  fillColor: CustomColor.btnCont,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                    borderSide: const BorderSide(
                      color: CustomColor.btnFaqBorder,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                    borderSide: const BorderSide(
                      color: CustomColor.btnFaqBorder,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                    borderSide: const BorderSide(
                      color: CustomColor.btnFaqBorder,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                    borderSide: const BorderSide(
                      color: CustomColor.btnFaqBorder,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: show != true ? 1.5.h : 1.5.h,
                child: Container(
                  width: 0.5.w,
                  color: CustomColor.btn,
                  padding: EdgeInsets.only(
                    bottom: 3.h,
                  ),
                ),
              ),
              Positioned(
                top: show == true ? 2.h : 1.5.h,
                right: 0.w,
                child: Container(
                  width: 0.5.w,
                  color: CustomColor.btn,
                  padding: EdgeInsets.only(
                    bottom: 3.h,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
