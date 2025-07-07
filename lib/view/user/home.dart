import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dananer/controllar/cubit.dart';
import 'package:dananer/controllar/states.dart';
import 'package:dananer/core/%20navigation/navigation.dart';
import 'package:dananer/core/styles/themes.dart';
import 'package:dananer/view/user/luck_wheel.dart';
import 'package:dananer/view/user/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/appBar.dart';
import 'counter.dart';
import 'my_subscriptions.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getProfile(context: context)
        ..verifyToken(context: context)
        ..timeOfDay(context: context),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
          builder: (context,state){
          var cubit=AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFFF5F5F5),
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: ConditionalBuilder(
                    condition: cubit.profileModel != null,
                    builder: (c){
                      return Column(
                        children: [
                          Appbar(),
                          const SizedBox(height: 24,),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                cubit.time == 'night'? Center(child: Image.asset('assets/images/Rectangle 42035.png')):
                                Center(child: Image.asset('assets/images/Rectangle 42039.png')),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset('assets/images/noto-v1_full-moon.png'),
                                          const SizedBox(width: 10,),
                                          cubit.time == 'night'? Text('مساء الخير',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),):
                                          Text('صباح الخير',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      Text(cubit.profileModel!.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                                      Text('! ابدأ يومك بجمع المكافئات',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24,),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 230,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 95, 6, 173),
                                  const Color.fromARGB(255, 117, 94, 248),
                                  const Color.fromARGB(255, 95, 6, 173),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
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
                            child: Column(
                              children: [
                                SizedBox(height: 15,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.wallet,color: Colors.white,),
                                      Text('رصيد الحساب',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset('assets/images/carbon_currency (1).png',scale: 0.8,),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              //Text('د.ع ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                              Text(cubit.profileModel!.dolar.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Text('الدينار',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image.asset('assets/images/logo.png',width: 60,height: 60,),
                                          SizedBox(height: 10,),
                                          Text(cubit.profileModel!.sawa.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                          SizedBox(height: 10,),
                                          Text('كوينز',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image.asset('assets/images/material-symbols_diamond-outline (1).png',scale: 0.8,),
                                          SizedBox(height: 10,),
                                          Text(cubit.profileModel!.jewel.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                          SizedBox(height: 10,),
                                          Text('الجواهر',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          navigateTo(context, LuckWheelPage(myValue: cubit.profileModel!.jewel,));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
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
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red.withOpacity(0.2),
                                                  ),
                                                  child: Image.asset('assets/images/confetti.png',width: 40,)),
                                              SizedBox(height: 10,),
                                              Text('التسلية',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: 15,),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          navigateTo(context, MySubscriptions(userCounters: cubit.profileModel!.userCounters,));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
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
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.yellowAccent.withOpacity(0.2),
                                                  ),
                                                  child: Image.asset('assets/images/f7_timer-fill.png',scale: 0.7,)),
                                              SizedBox(height: 10,),
                                              Text('اشتراكاتي',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          navigateTo(context, Counter(
                                            counter: cubit.profileModel!.userCounters,
                                            monyOfUser: cubit.profileModel!.sawa.toString(),
                                          ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
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
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.purple.withOpacity(0.2),
                                                  ),
                                                  child: Image.asset('assets/images/ic_round-timer.png',scale: 0.7,)),
                                              SizedBox(height: 10,),
                                              Text('العدادات',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          navigateTo(context, Shop());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
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
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primaryColor.withOpacity(0.2),
                                                  ),
                                                child: Image.asset('assets/images/store.png',width: 40,),),
                                              SizedBox(height: 10,),
                                              Text('المتجر',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15,),
                              ],
                            ),
                          ),
                          SizedBox(height: 24,),
                        ],
                      );
                    },
                    fallback: (c)=> Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.4,
                        ),
                        Center(child: CircularProgressIndicator()),
                      ],
                    )),
              ),
            ),
          );
          },
      ),
    );
  }
}
