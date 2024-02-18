import 'package:flutter/material.dart';
import 'package:quickcal/models/calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Calendar calendar = Calendar();

  @override
  void initState() {
    super.initState();
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
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'February',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              '2023',
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromARGB(164, 46, 43, 45)),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: () {},
                tooltip: 'Today',
              ),
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
              height: MediaQuery.of(context).size.width / 7 * 6,
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: calendar.totalDaysInMonth + 7 + calendar.getTotalExtraDays(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
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

                    return Card(
                      color: calendar.checkIfDateIsToday(dayInfo.values.first) ? Colors.black : Colors.black.withAlpha(10),
                      shape: RoundedRectangleBorder(
                        side: date == 10 ? const BorderSide(color: Colors.black, width: 1.5) : BorderSide.none,
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
                            if (date == 1 || date == 15 || date == 10 || date == 18)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) => Container(
                                    width: 4,
                                    height: 4,
                                    margin: const EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      color: calendar.checkIfDateIsToday(dayInfo.values.first) ? Colors.white : Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => Text("this is good"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
