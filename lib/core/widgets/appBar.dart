import 'package:dananer/core/%20navigation/navigation.dart';
import 'package:dananer/view/user/notifications.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            icon: const Icon(Icons.notifications,color: Colors.white,),
            onPressed: () {
              navigateTo(context, Notifications());
            },
          ),
          Image.asset('assets/images/Orange Minimalist E Wallet Logo (3).png',height: 55,width: 55,),
          Container(
            width: 50,
            height: 60,
          )
        ],
      ),
    );
  }
}

class AppbarBack extends StatelessWidget {
  const AppbarBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              navigateBack(context);
            },
          ),
          Image.asset('assets/images/Orange Minimalist E Wallet Logo (3).png',height: 55,width: 55,),
          Container(
            width: 50,
            height: 60,
          )
        ],
      ),
    );

  }
}
