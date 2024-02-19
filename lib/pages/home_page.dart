import 'package:flutter/material.dart';
import 'package:quickcal/models/calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Calendar calendar = Calendar();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date != null && date != DateTime.now()) {
      setState(() {
        calendar.setCurrentMonth(date);
        selectedDate = date;
      });
      // print('Selected Date: $date');
    }
  }

  void updateCalendarToToday() {
    setState(() {
      calendar.setCurrentMonth(DateTime.now());
      selectedDate = DateTime.now();
    });
  }

  void handleDateCardClick(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.all(0),
                  // onPrimary: Colors.black,
                  foregroundColor: Colors.black.withAlpha(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              onPressed: () => _selectDate(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    calendar.getCurrentMonthName(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    calendar.getCurrentYear().toString(),
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(164, 46, 43, 45),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        actions: [
          Stack(
            children: [
              Positioned(
                width: 22,
                height: 22,
                top: 13,
                right: 13,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 233, 91, 91),
                    // shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${DateTime.now().day}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: updateCalendarToToday,
                tooltip: 'Today',
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Search',
          ),
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('Settings'),
                ),
                const PopupMenuItem(
                  child: Text('About'),
                ),
              ];
            },
            tooltip: 'Menu',
            offset: const Offset(0, 40),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              // auto height for the calendar
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
                              // if (date == 1 || date == 15 || date == 10 || date == 18)
                              //   Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: List.generate(
                              //       3,
                              //       (index) => Container(
                              //         width: 4,
                              //         height: 4,
                              //         margin: const EdgeInsets.symmetric(horizontal: 2),
                              //         decoration: BoxDecoration(
                              //           // border: Border.all(color: Colors.black, width: 1),
                              //           color: calendar.checkIfDateIsToday(dayInfo.values.first) ? Colors.white : Colors.black,
                              //           shape: BoxShape.circle,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Schedule for ${calendar.getCurrentMonthName()} ${selectedDate.day}, ${selectedDate.year}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "3 Events",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(164, 46, 43, 45),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black.withAlpha(50),
                      elevation: 0,
                      shadowColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          // margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: const BoxDecoration(
                            color: Colors.purple,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Drop off kids at school",
                                style: TextStyle(fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough, color: Colors.black),
                              ),
                              Text("9:00 AM", style: TextStyle(color: Color.fromARGB(164, 46, 43, 45), fontSize: 12)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
