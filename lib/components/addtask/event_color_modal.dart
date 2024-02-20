import 'package:flutter/material.dart';

class EventColorDialogBox extends StatelessWidget {
  EventColorDialogBox({super.key});

  final List<Color> colors = [
    Colors.blueAccent,
    Colors.red,
    Colors.purple.shade300,
    Colors.blue.shade200,
    Colors.green.shade600,
    Colors.pink.shade200,
    Colors.teal.shade400,
    Colors.amber.shade600,
    Colors.brown.shade300,
    Colors.indigo.shade400,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.cyan,
    Colors.lime,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(0),
      insetPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              backgroundColor: Colors.black.withOpacity(0.1),
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(6),
        margin: EdgeInsets.only(bottom: 20),
        height: MediaQuery.of(context).size.height * 0.2,
        // full screen width
        // width: MediaQuery.of(context).size.width * 0.9,
        width: double.maxFinite,
        child: GridView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: colors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () {
                // Add the functionality you want when the button is pressed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors[index],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
                padding: const EdgeInsets.all(0),
              ),
              child: Center(
                child: index == 0
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
