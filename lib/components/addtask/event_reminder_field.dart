import 'package:flutter/material.dart';

class EventReminderField extends StatelessWidget {
  Function changeReminderSwitch;
  bool light;
  EventReminderField({super.key, required this.changeReminderSwitch, required this.light});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.465,
          child: Container(
            // onPressed: () {
            //   Navigator.pop(context);
            // },
            // style: ElevatedButton.styleFrom(
            //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            //   backgroundColor: Colors.white,
            //   foregroundColor: Colors.white,
            //   shadowColor: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   elevation: 0,
            //   alignment: Alignment.centerLeft,
            //   side: const BorderSide(color: Color.fromARGB(50, 46, 43, 45), width: 1),
            // ),

            // container style
            // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            padding: const EdgeInsets.only(left: 20, right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color.fromARGB(50, 46, 43, 45), width: 1),
            ),
            alignment: Alignment.centerLeft,
            // elevation: 0,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All day',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  // width: 150,
                  // height: 22,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Transform.scale(
                      scale: 0.8,
                      alignment: Alignment.centerRight,
                      child: Switch(
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.grey.shade300,
                        activeColor: Colors.white,
                        activeTrackColor: Colors.black,
                        value: light,
                        onChanged: (bool value) => changeReminderSwitch(value),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
