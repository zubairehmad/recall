class DateFormatter {
  DateFormatter._();

  static final _monthPrefix = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static String formatDate(DateTime dateTime) {
    final monthPrefix = _monthPrefix[dateTime.month - 1];
    final day = dateTime.day;
    final year = dateTime.year;
    final hour = (dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12)
        .toString()
        .padLeft(2, '0');
    final min = dateTime.minute.toString().padLeft(2, '0');
    final amPmSuff = dateTime.hour >= 12 ? 'PM' : 'AM';

    return "$monthPrefix $day, $year, $hour:$min $amPmSuff";
  }
}
