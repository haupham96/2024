import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      Container(color: Colors.red),
      Container(color: Colors.green),
      Container(color: Colors.blue),
      Container(color: Colors.deepPurple),
      Container(color: Colors.tealAccent),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _pages.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF363636),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xFF8687E7),
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index == 2) {
            return;
          }
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 24,
                color: Colors.white,
              ),
              label: "Home",
              activeIcon: Icon(
                Icons.home,
                size: 24,
                color: Color(0xFF8687E7),
              )),
          const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month, size: 24),
              label: "Calendar",
              activeIcon: Icon(
                Icons.calendar_month,
                size: 24,
                color: Color(0xFF8687E7),
              )),
          BottomNavigationBarItem(icon: Container(), label: ""),
          const BottomNavigationBarItem(
              icon: Icon(Icons.access_time_filled, size: 24),
              label: "Focus",
              activeIcon: Icon(
                Icons.access_time_filled,
                size: 24,
                color: Color(0xFF8687E7),
              )),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 24),
              label: "Profile",
              activeIcon: Icon(
                Icons.person,
                size: 24,
                color: Color(0xFF8687E7),
              ))
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            color: const Color(0xFF8687E7),
            borderRadius: BorderRadius.circular(32)),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
