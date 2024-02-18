import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: const Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.white,
          child: Text('Drawer'),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'QuickCal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            // fontFamily:
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Icon(Icons.menu),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: const Text('Home Page'),
    );
  }
}
