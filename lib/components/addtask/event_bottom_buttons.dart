import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final Function onSave;
  final Function onCancel;
  const BottomButtons({super.key, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            // 50% of screen width
            width: MediaQuery.of(context).size.width * 0.47,
            child: ElevatedButton(
              onPressed: () => onCancel(),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  backgroundColor: Colors.grey.shade300,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.47,
            child: ElevatedButton(
              onPressed: () => onSave(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
