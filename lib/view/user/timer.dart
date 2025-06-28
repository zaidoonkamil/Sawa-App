import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dananer/controllar/cubit.dart';
import 'package:dananer/controllar/states.dart';
import 'package:dananer/core/%20navigation/navigation.dart';
import 'package:dananer/core/styles/themes.dart';
import 'package:dananer/core/widgets/appBar.dart';
import 'package:dananer/core/widgets/constant.dart';
import 'package:dananer/core/widgets/show_toast.dart';
import 'package:dananer/view/user/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getDaily(context: context, id: id)..getProfile(context: context),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFFF5F5F5),
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Appbar(),
                    SizedBox(height: 24,),
                    GestureDetector(
                      onTap: (){
                        navigateTo(context, Counter(
                          counter: cubit.profileModel!.userCounters,
                          monyOfUser: cubit.profileModel!.dolar.toString(),
                        ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 20,),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: secoundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: secoundColor.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('متجر العدادات',style: TextStyle(fontSize: 18,color: Colors.white),),
                            SizedBox(width: 6,),
                            Icon(Icons.shopping_basket,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    ConditionalBuilder(
                        condition: cubit.remainingTime != null && cubit.profileModel != null,
                        builder: (c){
                      return Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primaryColor,
                                width: 10,
                              ),
                            ),
                            child: Container(
                              width: double.maxFinite,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 10,
                                ),
                              ),
                              child: Container(
                                width: double.maxFinite,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('متبقي',style: TextStyle(color: Colors.grey),),
                                    SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(cubit.remainingTime!,style: TextStyle(color: primaryColor,fontSize: 20),),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(width: 80,height: 2,color: Colors.black,),
                                    SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text('المكافئات',style: TextStyle(color: Colors.grey),),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cubit.profileModel!.totalPoints != 0? Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blue.withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.blue
                                    )
                                ),
                                child: Row(
                                  children: [
                                   Text('سوا',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 18,color: Colors.blue),),
                                    Text(cubit.profileModel!.totalPoints.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 18,color: Colors.blue),),
                                  ],
                                ),
                              ):Container(),
                              SizedBox(width: 10,),
                              cubit.profileModel!.totalGems != 0? Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blue.withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.blue
                                    )
                                ),
                                child: Row(
                                  children: [
                                    Text('جوهرة',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 18,color: Colors.blue),),
                                    Text(cubit.profileModel!.totalGems.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 18,color: Colors.blue),),
                                  ],
                                ),
                              ):Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blue.withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.blue
                                    )
                                ),
                                child: Row(
                                  children: [
                                    Text('جوهرة',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 18,color: Colors.blue),),
                                    Text('30',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 18,color: Colors.blue),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24,),
                          cubit.canDoAction == true? GestureDetector(
                            onTap:(){
                              cubit.sumDaly( context: context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                              margin: const EdgeInsets.symmetric(horizontal: 20,),
                              width: 190,
                              decoration: BoxDecoration(
                                color: secoundColor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: secoundColor.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('جمع المكافئة',style: TextStyle(fontSize: 18,color: Colors.white),),
                                ],
                              ),
                            ),
                          ):
                          GestureDetector(
                            onTap:(){
                              showToastError(text: ' يمكنك المحاولة مجددا بعد ${cubit.remainingTime!} ', context: context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                              margin: const EdgeInsets.symmetric(horizontal: 20,),
                              width: 190,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: secoundColor.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('جمع المكافئة',style: TextStyle(fontSize: 18,color: Colors.black),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 44,),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                            margin: const EdgeInsets.symmetric(horizontal: 20,),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: secoundColor.withOpacity(0.1),
                                  spreadRadius: 4,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(child: Text('يمكنك ترقية العداد لزيادة المكافأت', textAlign: TextAlign.end, style: TextStyle(fontSize: 16,color: Colors.blue),)),
                                    SizedBox(width: 6,),
                                    Icon(Icons.info_outline,color: Colors.blue,)
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(child: Text('قم بزيارة متجر العدادات لشراء ترقيات تزيد من مكافأتك اليومية',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 14,color: Colors.grey),)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24,),
                        ],
                      );
                    },
                        fallback: (c)=>Center(child: CircularProgressIndicator())),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
