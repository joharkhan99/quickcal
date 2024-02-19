import 'package:flutter/material.dart';

class CalendarTasksList extends StatelessWidget {
  const CalendarTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
