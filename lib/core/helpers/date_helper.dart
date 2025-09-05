import 'package:date_field/date_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static Future<DateTime?> showAdaptiveDatePicker(
      {DateTimeFieldPickerMode? pickerMode}) async {
    final DateTime? result = await showAdaptiveDateTimePicker(
      context: Get.context!,
      cupertinoDatePickerOptions: CupertinoDatePickerOptions(
          modalTitleText: pickerMode == null || pickerMode == DateTimeFieldPickerMode.date
              ? 'Select Date'
              : 'Select Time'),
      mode: pickerMode ?? DateTimeFieldPickerMode.date,
    );

    return result;
  }


  // Add a method which accepts a nullable DateTime and returns a formatted string (i.e 11:00 AM) and null and empty empty string
  static String formatNullableDateTimeToHHmma(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('hh:mm a').format(dateTime);
  }
}
