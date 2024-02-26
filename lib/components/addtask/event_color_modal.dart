import 'package:flutter/material.dart';

class EventColorDialogBox extends StatelessWidget {
  int colorIndex;
  Function handleColorSelection;
  int colorsLength;
  List<Color> colors;
  EventColorDialogBox({super.key, required this.colorIndex, required this.handleColorSelection, required this.colorsLength, required this.colors});

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(bottom: 20),
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.maxFinite,
        child: GridView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: colorsLength,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () => handleColorSelection(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors[index],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
                padding: const EdgeInsets.all(0),
              ),
              child: Center(
                child: colorIndex == index
                    ? const Icon(
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
