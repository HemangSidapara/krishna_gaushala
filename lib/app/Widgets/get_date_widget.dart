import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetDateOrTime {
  ///GetNonSuffixDate
  String getNonSuffixDate(String? date) {
    const Map<int, String> weekdayName = {
      1: "Mon",
      2: "Tue",
      3: "Wed",
      4: "Thu",
      5: "Fri",
      6: "Sat",
      7: "Sun",
    };
    const Map<int, String> monthName = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sept",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };
    // String dayOfWeek = weekdayName[DateTime.parse(date!).weekday]!;
    String formatDay = date?.split('-')[0] ?? '';
    String formatMonth = monthName[int.parse(date?.split('-')[1] ?? '0')] ?? '';
    String formatYear = date?.split('-')[2].split(' ')[0].toString().replaceRange(0, date.split('-')[2].split(' ')[0].length - 2, '') ?? '';
    String formatDate = '$formatMonth $formatDay, \'$formatYear';
    return formatDate;
  }

  ///GetDate
  String getDate(String? date, {bool isDaySuffixCapitalize = false}) {
    const Map<int, String> weekdayName = {
      1: "Mon",
      2: "Tue",
      3: "Wed",
      4: "Thu",
      5: "Fri",
      6: "Sat",
      7: "Sun",
    };
    const Map<int, String> monthName = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sept",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };
    String dayOfWeek = weekdayName[DateTime.parse(date!).weekday]!;

    String daySuffix;
    if (DateTime.parse(date).day >= 11 && DateTime.parse(date).day <= 13) {
      daySuffix = isDaySuffixCapitalize ? 'Th' : 'th';
    } else {
      switch (DateTime.parse(date).day % 10) {
        case 1:
          daySuffix = isDaySuffixCapitalize ? 'St' : 'st';
          break;
        case 2:
          daySuffix = isDaySuffixCapitalize ? 'Nd' : 'nd';
          break;
        case 3:
          daySuffix = isDaySuffixCapitalize ? 'Rd' : 'rd';
          break;
        default:
          daySuffix = isDaySuffixCapitalize ? 'Th' : 'th';
      }
    }
    String formatDate = '${DateTime.parse(date).day}$daySuffix ${monthName[DateTime.parse(date).month]} ${DateTime.parse(date).year}';
    return '$dayOfWeek, $formatDate';
  }

  ///GetTime
  String getTime(String time) {
    String timeInHours = TimeOfDay.fromDateTime(DateTime.parse(time)).hourOfPeriod.hours.inHours < 10 ? '0${TimeOfDay.fromDateTime(DateTime.parse(time)).hourOfPeriod.hours.inHours}' : TimeOfDay.fromDateTime(DateTime.parse(time)).hourOfPeriod.hours.inHours.toString();
    String timeInMinutes = TimeOfDay.fromDateTime(DateTime.parse(time)).minute < 10 ? '0${TimeOfDay.fromDateTime(DateTime.parse(time)).minute}' : TimeOfDay.fromDateTime(DateTime.parse(time)).minute.toString();
    String periodOfTime = TimeOfDay.fromDateTime(DateTime.parse(time)).period.name.toUpperCase();

    return '$timeInHours:$timeInMinutes $periodOfTime';
  }
}
