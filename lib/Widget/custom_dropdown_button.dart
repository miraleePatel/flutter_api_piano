// ignore_for_file: must_be_immutable, unused_import
import 'package:flutter/material.dart';
import 'package:piano_project/Utils/string_constants.dart';
import 'package:sizer/sizer.dart';
import '../Utils/app_color.dart';
import 'custom_widget.dart';

class CustomDropDownButton extends StatefulWidget {
  String? value;
  List<DropdownMenuItem<String>>? items;
  Function(String?)? onChanged;
  CustomDropDownButton({Key? key, this.value, this.items, this.onChanged})
      : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  bool? obscureText = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Padding(
        padding: EdgeInsets.only(left: 3.w, right: 3.w),
        child: Stack(
          children: [
            DropdownButtonFormField(
              value: widget.value,
              hint: CustomWidgets.text(
                'Piano Type',
                fontSize: 12.sp,
                color: CustomColor.black,
              ),
              isExpanded: true,
              dropdownColor: CustomColor.btnFaq,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
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
              onChanged: widget.onChanged,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please choose the value from Dropdown";
                } else {
                  return null;
                }
              },
              items: widget.items,
            ),
            Positioned(
              top: obscureText != true ? 1.5.h : 1.5.h,
              child: Container(
                width: 0.5.w,
                color: CustomColor.btn,
                padding: EdgeInsets.only(
                  bottom: 3.h,
                ),
              ),
            ),
            Positioned(
              top: obscureText == true ? 2.h : 1.5.h,
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
    );
  }
}
