import 'package:dananer/view/admin/home.dart';
import 'package:dananer/view/auth/login.dart';
import 'package:dananer/view/user/home.dart';
import 'package:dananer/view/user/how_as.dart';
import 'package:flutter/material.dart';

import '../../core/ navigation/navigation.dart';
import '../core/navigation_bar/navigation_bar.dart';
import '../core/navigation_bar/navigation_bar_admin.dart';
import '../core/navigation_bar/navigation_bar_agents.dart';
import '../core/network/local/cache_helper.dart';
import '../core/widgets/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Widget? widget;
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      if(CacheHelper.getData(key: 'token') == null){
        token='';
        if (onBoarding != null) {
          widget = const Login();
        } else {
          widget = HowAs();
        }
      }else{
        if(CacheHelper.getData(key: 'role') == null){
          widget = const Login();
          adminOrUser='user';
        }else{
          adminOrUser = CacheHelper.getData(key: 'role');
          if (adminOrUser == 'admin') {
            widget = BottomNavBarAdmin();
          } else if (adminOrUser == 'agent') {
            widget = BottomNavBarAgents();
          }else {
            widget = BottomNavBar();
          }
        }
        token = CacheHelper.getData(key: 'token') ;
        id = CacheHelper.getData(key: 'id') ??'' ;
      }
      navigateAndFinish(context, widget);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Center(child:
                Image.asset('assets/images/logo.png',width: 300,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}