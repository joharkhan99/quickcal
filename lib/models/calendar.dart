class Calendar {
  late DateTime _currentMonth;
  late int totalDaysInMonth;

  Calendar() {
    _currentMonth = DateTime.now();
    totalDaysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
  }

  // set current month
  void setCurrentMonth(DateTime month) {
    _currentMonth = month;
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

  String getCurrentMonthName() {
    switch (_currentMonth.month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  int getCurrentYear() {
    return _currentMonth.year;
  }
}
