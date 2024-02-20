import 'package:flutter/material.dart';
import 'package:quickcal/components/addtask/event_color_modal.dart';

class EventColorField extends StatefulWidget {
  const EventColorField({super.key});

  @override
  State<EventColorField> createState() => _EventColorFieldState();
}

class _EventColorFieldState extends State<EventColorField> {
  void selectColorModal() {
    showDialog(
      context: context,
      builder: (context) {
        return EventColorDialogBox(
            // controller: _controller,
            // onSave: saveNewTask,
            // onCancel: () => Navigator.of(context).pop(),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.465,
          child: ElevatedButton(
            onPressed: selectColorModal,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              alignment: Alignment.centerLeft,
              side: const BorderSide(color: Color.fromARGB(50, 46, 43, 45), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Event color',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
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
