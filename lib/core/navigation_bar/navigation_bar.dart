import 'package:dananer/view/user/home.dart';
import 'package:dananer/view/user/profile.dart';
import 'package:flutter/material.dart';

import '../../view/user/timer.dart';
import '../styles/themes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 2;
  List<Widget> screens =
  [
    Profile(),
    TimerScreen(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(70),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, -3)
              ),
            ],
          ),
          child: BottomNavigationBar(
            selectedItemColor: primaryColor,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                label: "الحساب",
                icon:  currentIndex==0?Image.asset('assets/images/fluent_person-16-filled (1).png'):
                Image.asset('assets/images/fluent_person-16-regular (1).png'),
              ),
              BottomNavigationBarItem(
                label: "العداد",
                icon:  currentIndex==1?Image.asset('assets/images/material-symbols_timer-rounded.png'):
                Image.asset('assets/images/ic_outline-timer.png'),
              ),
              BottomNavigationBarItem(
                label: "الرئيسية",
                icon:  currentIndex==2?Image.asset('assets/images/si_home-fill.png'):
                Image.asset('assets/images/si_home-line.png'),
              ),
            ],
            onTap: (val) {
              setState(() {
                currentIndex = val;
              });
            },
          ),
        )
        ,
      ),
    );
  }
}