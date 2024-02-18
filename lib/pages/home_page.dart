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
        backgroundColor: Colors.white.withAlpha(200),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Search',
          ),
          PopupMenuButton(
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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: calendar.totalDaysInMonth + 7 + calendar.getTotalExtraDays(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
            itemBuilder: (context, index) {
              if (index < 7) {
                return Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(calendar.getDayOfWeek(index + 1)),
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
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$date',
                          style: TextStyle(color: Colors.white),
                        ),
                        // Text(
                        //   '${date.day}',
                        //   style: TextStyle(color: Colors.white),
                        // ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
