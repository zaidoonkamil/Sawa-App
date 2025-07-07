import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dananer/core/%20navigation/navigation.dart';
import 'package:dananer/core/widgets/appBar.dart';
import 'package:dananer/view/user/send_points.dart';
import 'package:dananer/view/user/store/store.dart';
import 'package:dananer/view/user/withdraw_money.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/styles/themes.dart';
import '../../controllar/cubit.dart';
import '../../controllar/states.dart';
import 'contect_woner.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getProfile(context: context),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  AppbarBack(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            SizedBox(height: 25,),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      navigateTo(context, Store());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepOrangeAccent,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(0.2),
                                              ),
                                              child: Image.asset('assets/images/store.png',width: 40,),),
                                          SizedBox(height: 10,),
                                          Text('متجر كوينز كاش',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      navigateTo(context, WithdrawMoney());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(0.2),
                                              ),
                                            child: Image.asset('assets/images/transfer.png',width: 40,),),
                                          SizedBox(height: 10,),
                                          Text('التحويلات',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.orangeAccent,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(0.2),
                                              ),
                                            child: Image.asset('assets/images/niche-market.png',width: 40,),),
                                          SizedBox(height: 10,),
                                          Text('سوق الاشتراكات',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      navigateTo(context, ContectWoner());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.pink,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white.withOpacity(0.2),
                                            ),
                                            child: Image.asset('assets/images/customer-service.png',width: 40,),),
                                          SizedBox(height: 10,),
                                          Text('الوكلاء',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      navigateTo(context, SendPoints(
                                        sawa: cubit.profileModel!.sawa.toString(),));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white.withOpacity(0.2),
                                            ),
                                              child: Image.asset('assets/images/transfer (1).png',width: 40,)),
                                          SizedBox(height: 10,),
                                          Text('ارسال نقاط',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
