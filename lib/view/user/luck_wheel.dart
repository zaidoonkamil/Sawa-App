import 'dart:async';

import 'package:dananer/core/%20navigation/navigation.dart';
import 'package:dananer/core/navigation_bar/navigation_bar.dart';
import 'package:dananer/core/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import '../../controllar/cubit.dart';
import '../../controllar/states.dart';
import '../../core/styles/themes.dart';


class LuckWheelPage extends StatelessWidget {
  LuckWheelPage({super.key, required this.myValue});

  final int myValue;
  final List<Map<String, dynamic>> items = [
    {'key': 'try_again', 'image': 'assets/items/rocket.png'},
    {'key': 'try_again', 'image': 'assets/items/gift.png'},
    {'key': '1', 'image': 'assets/items/dollar.png'},
    {'key': 'try_again', 'image': 'assets/items/refresh.png'},
    {'key': '1', 'image': 'assets/items/medal.png'},
    {'key': '1', 'image': 'assets/items/gift-card.png'},
    {'key': 'try_again', 'image': 'assets/items/rocket.png'},
    {'key': 'try_again', 'image': 'assets/items/refresh.png'},
  ];
  static int spinCount = 0;

  final StreamController<int> selected = StreamController<int>();
  late bool animate=false;
  int? lastSelectedIndex;

  void spinWheel() {
    final random = Random();
    int selectedIndex;

    // 12=3
    if (spinCount < 2) {
      final tryAgainIndexes = items
          .asMap()
          .entries
          .where((entry) => entry.value['key'] == 'try_again')
          .map((entry) => entry.key)
          .toList();

      selectedIndex = tryAgainIndexes[random.nextInt(tryAgainIndexes.length)];
      spinCount++;
    } else {
      final rewardIndexes = items
          .asMap()
          .entries
          .where((entry) => entry.value['key'] == '1')
          .map((entry) => entry.key)
          .toList();

      selectedIndex = rewardIndexes[random.nextInt(rewardIndexes.length)];
      spinCount = 0;
    }

    lastSelectedIndex = selectedIndex;
    selected.add(selectedIndex);
    print('Selected: ${items[selectedIndex]['key']}');
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()
          ..getProfile(context: context)..fu(value: myValue),
        child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
    builder: (context,state){
    var cubit=AppCubit.get(context);
    return WillPopScope(
      onWillPop: ()async {
        navigateAndFinish(context, BottomNavBar());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                  width: double.maxFinite,
                  child: Image.asset('assets/images/Group 1171275636.png',fit: BoxFit.fill,)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 320,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange,
                        border: Border.all(
                            color: Colors.grey
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('يمكنك الدوران بأستخدام 10 جوهرة ',style: TextStyle(color: Colors.white),),
                        Icon(Icons.diamond_outlined,color: Colors.blue,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 300,
                    child: FortuneWheel(
                      selected: selected.stream,
                      animateFirst: false,
                      onAnimationStart: (){
                        animate = true;
                        cubit.refreshState();
                      },
                      onAnimationEnd: () {
                        if(items[lastSelectedIndex!]['key'] != 'try_again') {
                          cubit.myValue -=10;
                          cubit.sendSawa(amount: items[lastSelectedIndex!]['key'], context: context);
                          animate = false;
                          cubit.refreshState();
                        } else {
                          cubit.myValue -=10;
                          cubit.updateGems(gems: cubit.myValue, context: context);
                          showToastInfo(text: 'حاول مرة اخرى', context: context);
                          animate = false;
                          cubit.refreshState();
                        }
                      },
                      items: [
                        for (var item in items)
                          FortuneItem(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Image.asset(item['image'], width: 40, height: 40),
                            ),
                            style: FortuneItemStyle(
                              textStyle: TextStyle(fontSize: 16),
                              borderWidth: 3,
                              borderColor: primaryColor,
                              color: secoundColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  cubit.myValue>=10 && animate == false ? GestureDetector(
                    onTap: (){
                      spinWheel();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 6,
                            blurRadius: 5,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('جوهرة',style: TextStyle(fontSize: 18,color: Colors.white),),
                          Text(' 10',style: TextStyle(fontSize: 18,color: Colors.white),),
                          SizedBox(width: 6,),
                          Icon(Icons.diamond_outlined,color: Colors.white,)
                        ],
                      ),
                    ),
                  ):GestureDetector(
                    onTap: (){},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 6,
                            blurRadius: 5,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('جوهرة',style: TextStyle(fontSize: 18,color: Colors.black),),
                          Text(' 10',style: TextStyle(fontSize: 18,color: Colors.black),),
                          SizedBox(width: 6,),
                          Icon(Icons.diamond_outlined,color: Colors.black,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0XFF6B5ACD),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                  onPressed: () {
                    navigateAndFinish(context, BottomNavBar());
                  },
                ),
                Image.asset('assets/images/Orange Minimalist E Wallet Logo (3).png'),
                Container(
                  width: 50,
                  height: 60,
                )
              ],
            ),
          ),
            ],
          ),
        ),
      ),
    );
    },),
    );
  }
}