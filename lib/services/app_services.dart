import 'package:intl/intl.dart';

class AppServices {
  String getTimeDifferenceString(int timestamp) {
    final now = DateTime.now();
    final inputDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = inputDate.difference(now);

    if (difference.isNegative && difference.inDays != 0) {
      // The timestamp is in the past
      final daysAgo = -difference.inDays;
      if (daysAgo == 1) {
        return 'Yesterday ${DateFormat.Hm().format(inputDate)}';
      } else {
        return '$daysAgo days ago ${DateFormat.Hm().format(inputDate)}';
      }
    } else if (difference.inDays == 0) {
      return 'Today ${DateFormat.Hm().format(inputDate)}';
    } else if (difference.inDays == 1) {
      return 'Tomorrow ${DateFormat.Hm().format(inputDate)}';
    } else {
      return 'In the future ${DateFormat.Hm().format(inputDate)}';
    }
  }

  int countFridaysBetweenDates(DateTime startDate, DateTime endDate) {
    int fridayCount = 0;
    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      if (currentDate.weekday == DateTime.friday) {
        fridayCount++;
      }
      currentDate = currentDate.add(Duration(days: 1));
    }

    return fridayCount;
  }

  bool isDateInBetween(DateTime startDate, DateTime endDate, DateTime checkDate,
      bool includeFriday) {
    // Check if checkDate is between startDate and endDate (inclusive)
    if (checkDate.isAfter(startDate) && checkDate.isBefore(endDate) ||
        (checkDate.day == startDate.day &&
            checkDate.month == startDate.month &&
            checkDate.year == startDate.year) ||
        (checkDate.day == endDate.day &&
            checkDate.month == endDate.month &&
            checkDate.year == endDate.year)) {
      // Check if checkDate is a Friday (where 5 corresponds to Friday)
      if (includeFriday) {
        return true;
      } else {
        if (checkDate.weekday == DateTime.friday) {
          return false;
        } else {
          return true;
        }
      }
    }
    return false;
  }

  double calculateDaysDifference(DateTime startDate, DateTime endDate) {
    // Calculate the difference between the two dates
    Duration difference = endDate.difference(startDate);

    // Get the number of days as an integer
    int daysDifference = difference.inDays;

    return daysDifference.toDouble();
  }
}
