class Calendar {
  late DateTime _currentMonth;
  late int totalDaysInMonth;

  Calendar() {
    _currentMonth = DateTime.now();
    totalDaysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
  }

  List<Map<String, DateTime>> getDaysInMonth({DateTime? month}) {
    month ??= _currentMonth; // If month is null, use _currentMonth
    List<Map<String, DateTime>> daysInMonth = [];
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int startingDayOfWeek = firstDayOfMonth.weekday;

    // Add empty days to the list
    for (int i = 1; i < startingDayOfWeek; i++) {
      daysInMonth.add({});
    }

    final int daysCount = DateTime(month.year, month.month + 1, 0).day;
    for (int day = 1; day <= daysCount; day++) {
      DateTime date = DateTime(month.year, month.month, day);
      String dayOfWeek = getDayOfWeek(date.weekday);

      daysInMonth.add({
        dayOfWeek: date,
      });
    }

    // print(daysInMonth);

    return daysInMonth;
  }

  String getDayOfWeek(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  int getTotalExtraDays() {
    return getDaysInMonth().where((day) => day.isEmpty).length;
  }

  bool checkIfDateIsToday(DateTime date) {
    DateTime now = DateTime.now();
    return now.day == date.day && now.month == date.month && now.year == date.year;
  }
}
