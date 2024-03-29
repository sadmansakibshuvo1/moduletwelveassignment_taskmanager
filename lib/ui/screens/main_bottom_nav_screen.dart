import 'package:flutter/material.dart';
import 'package:moduletwelveassignment_taskmanager/ui/screens/progress_task_screen.dart';
import '../../style/style.dart';
import 'cancel_task_screen.dart';
import 'complete_task_screen.dart';
import 'new_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> screens = const [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompleteTaskScreen(),
    CancelTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PrimaryColor.color,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "New Task",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_sharp),
            label: "Progress",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close_rounded),
            label: "Cancelled",
          ),
        ],
      ),
    );
  }
}