import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urgentrishtapp/constants/color_constant.dart';

class DateOfAge {
  static void openDatePicker(BuildContext context,
      {ValueNotifier<DateTime>? timeNotifier}) {
    BottomPicker.date(
      pickerTitle: const Text(
        'Select date',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(1980),
      pickerTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
      ),
      onChange: (index) {
        //log(index);
      },
      buttonSingleColor: ColorConstants.orange,
      onSubmit: (selectedDate) {
        final ageLimitDate =
            DateTime.now().subtract(const Duration(days: 15 * 365));
        if (selectedDate.isBefore(ageLimitDate)) {
          // Date is older than 15 years
          if (timeNotifier != null) {
            timeNotifier.value = selectedDate;
          }
        } else {
          // Date is not valid
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'You must be 18 years old or older.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    ).show(context);
  }
}
