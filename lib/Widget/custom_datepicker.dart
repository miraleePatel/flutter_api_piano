// ignore_for_file: unrelated_type_equality_checks, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:piano_project/Controller/calender_controller.dart';
import 'package:piano_project/Widget/custom_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Utils/app_color.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  TableCalenderController tableCalenderController = Get.put(TableCalenderController());

  var years;
  @override
  void initState() {
    super.initState();
    tableCalenderController.selectedDate.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: CustomColor.cld1,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CustomColor.cldBorder,
        ),
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(
          2050,
          3,
          14,
        ),
        focusedDay: tableCalenderController.selectedDate.value,
        headerVisible: true,

        /// *********** select single date ****************

        selectedDayPredicate: (currentSelectedDate) {
          return isSameDay(tableCalenderController.selectedDate.value, currentSelectedDate);
        },

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            tableCalenderController.selectedDate.value = selectedDay;
            tableCalenderController.selectedDate.value = focusedDay;
          });
        },
        onPageChanged: (focusedDay) {
          //  tableCalenderController.selectedDate.value = focusedDay;
        },

        /// *********** Header ****************

        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextFormatter: (date, locale) {
            final month = DateFormat.MMM(locale).format(date);
            years = DateFormat.y(locale).format(date);
            tableCalenderController.next_mon.value = DateFormat.MMM().format(
              DateTime(
                0,
                date.month + 1,
              ),
            );
            tableCalenderController.previous_mon.value = DateFormat.MMM().format(
              DateTime(
                0,
                date.month - 1,
              ),
            );

            return '$years\n${month.toUpperCase()}';
          },
          titleTextStyle: TextStyle(
            color: CustomColor.btn,
            fontSize: 13.sp,
            fontWeight: FontWeight.w800,
            fontFamily: 'minion-pro-cufonfonts',
          ),
          formatButtonShowsNext: true,
          leftChevronIcon: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                size: 10.sp,
                weight: 20,
                color: CustomColor.black,
              ),
              Obx(() => Text(
                    tableCalenderController.previous_mon.toString().toUpperCase(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: CustomColor.black,
                      fontFamily: 'minion-pro-cufonfonts',
                    ),
                  ))
            ],
          ),
          rightChevronIcon: Row(
            children: [
              Obx(
                () => Text(
                  tableCalenderController.next_mon.toString().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'minion-pro-cufonfonts',
                    color: CustomColor.black,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 10.sp,
                weight: 20,
                color: CustomColor.black,
              ),
            ],
          ),
          headerPadding: const EdgeInsets.only(
            bottom: 15,
            top: 15,
          ),
        ),

        /// ************ Day ***************

        daysOfWeekHeight: 2.h,
        daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: CustomColor.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'minion-pro-cufonfonts',
            ),
            weekendStyle: TextStyle(
              color: CustomColor.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'minion-pro-cufonfonts',
            )),

        /// ************ Calendar decoration ***************

        rowHeight: 5.5.h,
        calendarBuilders: CalendarBuilders(
          // --------------- Header decoration ---------------

          headerTitleBuilder: (context, day) {
            var m = DateFormat.MMM().format(
              day,
            );
            tableCalenderController.next_mon.value = DateFormat.MMM().format(
              DateTime(
                0,
                day.month + 1,
              ),
            );
            tableCalenderController.previous_mon.value = DateFormat.MMM().format(
              DateTime(
                0,
                day.month - 1,
              ),
            );
            return Container(
              margin: EdgeInsets.only(
                bottom: 2.5.h,
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    day.year.toString(),
                    style: TextStyle(
                      fontFamily: 'minion-pro-cufonfonts',
                      color: CustomColor.black,
                      fontSize: 11.sp,
                    ),
                  ),
                  Text(
                    m.toString(),
                    style: TextStyle(
                        fontFamily: 'minion-pro-cufonfonts',
                        color: CustomColor.btn,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5.w),
                  ),
                ],
              ),
            );
          },

          // --------------- Selected Date decoration ---------------

          selectedBuilder: (context, date, events) => Container(
            margin: EdgeInsets.all(
              3.sp,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: CustomColor.cld,
              border: Border.all(
                color: CustomColor.btnSelectDateBorder,
              ),
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            child: CustomWidgets.text(
              date.day.toString(),
              color: CustomColor.btn,
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
            ),
          ),

          // -------------- Current Date decoration --------------

          todayBuilder: (context, date, events) => Container(
            margin: EdgeInsets.all(
              4.5.sp,
            ),
            alignment: Alignment.center,
            child: CustomWidgets.text(
              date.day.toString(),
              color: CustomColor.textDate,
              fontSize: 12.sp,
            ),
          ),
        ),

        /// ************ Calendar Style ************

        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: TextStyle(color: CustomColor.textDate, fontFamily: 'minion-pro-cufonfonts', fontSize: 12.sp),

          defaultTextStyle: TextStyle(color: CustomColor.textDate, fontFamily: 'minion-pro-cufonfonts', fontSize: 12.sp),

          // ---------------- table decoration ----------------

          tablePadding: EdgeInsets.only(
            left: 3.w,
            right: 2.w,
          ),
          markerMargin: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
          ),
          canMarkersOverflow: true,
        ),
      ),
    );
  }
}
