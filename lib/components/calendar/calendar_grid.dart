import 'package:flutter/material.dart';
import 'package:quickcal/data/database.dart';
import 'package:quickcal/models/calendar.dart';

class CalendarGrid extends StatelessWidget {
  final Calendar calendar;
  final DateTime selectedDate;
  final Function handleDateCardClick;
  final Database database;
  const CalendarGrid({
    super.key,
    required this.calendar,
    required this.selectedDate,
    required this.handleDateCardClick,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 7 * 6.5,
      child: GridView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: calendar.totalDaysInMonth + 7 + calendar.getTotalExtraDays(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 0, crossAxisSpacing: 0),
        itemBuilder: (context, index) {
          if (index < 7) {
            return Card(
              color: Colors.white,
              elevation: 0,
              child: Center(
                child: Text(
                  calendar.getDayOfWeek(index + 1).toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Color.fromARGB(140, 46, 43, 45),
                  ),
                ),
              ),
            );
          } else {
            Map<String, DateTime> dayInfo = calendar.getDaysInMonth()[index - 7];
            // String dayOfWeek = dayInfo.isEmpty ? '' : dayInfo.keys.first;
            int date = dayInfo.isEmpty ? 0 : dayInfo.values.first.day;

            if (date == 0 || dayInfo.isEmpty) {
              return const Card(
                color: Colors.white,
                elevation: 0,
              );
            }

            return ElevatedButton(
              onPressed: () => handleDateCardClick(dayInfo.values.first),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.white,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Card(
                color: calendar.checkIfDateIsToday(dayInfo.values.first) ? Colors.black : Colors.black.withAlpha(10),
                shape: RoundedRectangleBorder(
                  side: dayInfo.values.first == selectedDate ? const BorderSide(color: Colors.black, width: 1.5) : BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$date',
                        style: TextStyle(
                          color: calendar.checkIfDateIsToday(dayInfo.values.first) ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //
                        children: List.generate(
                          database.getTasksForDate(dayInfo.values.first).length > 4 ? 4 : database.getTasksForDate(dayInfo.values.first).length,
                          (index) {
                            return Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: database.getTasksForDate(dayInfo.values.first)[index].getColor(),
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
