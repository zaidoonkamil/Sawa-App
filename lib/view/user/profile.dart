import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/styles/themes.dart';
import '../../../core/widgets/constant.dart';
import '../../../core/widgets/show_toast.dart';
import '../../controllar/cubit.dart';
import '../../controllar/states.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
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
                            icon: const Icon(Icons.notifications,color: Colors.white,),
                            onPressed: () {},
                          ),
                          Image.asset('assets/images/Orange Minimalist E Wallet Logo (3).png'),
                          Container(
                            width: 50,
                            height: 60,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 64,),
                    ConditionalBuilder(
                        condition:  cubit.profileModel != null,
                        builder: (context){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset('assets/images/Group 1171275632 (1).png'),
                                SizedBox(height: 12,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      cubit.profileModel!.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 4,),
                                    Text(
                                      cubit.profileModel!.phone,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                        fallback: (c)=>Center(child: CircularProgressIndicator(color: primaryColor,))
                    ),
                    SizedBox(height: 70,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Icon(Icons.arrow_back_ios_new_rounded),
                          //         Row(
                          //           children: [
                          //             Text(
                          //               'من نحن',
                          //               style: TextStyle(
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.grey,
                          //               ),
                          //             ),
                          //             SizedBox(width: 4,),
                          //             Image.asset('assets/images/info-circle.png'),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(height: 6,),
                          //     Container(width: double.maxFinite,height: 2,color: Colors.black12,),
                          //     SizedBox(height: 14,),
                          //   ],
                          // ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // try {
                                  final phoneNumber = phone.trim();
                                  print(phoneNumber);
                                  final url =
                                      'https://wa.me/+964$phoneNumber?text=';
                                  await launch(
                                    url,
                                    enableJavaScript: true,
                                  ).catchError((e) {
                                    showToastError(context: context,text:  e.toString());
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset('assets/images/Group 1171275617.png'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'الاتصال المباشر بالدعم',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(width: 4,),
                                        Image.asset('assets/images/Vector (1).png'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6,),
                              Container(width: double.maxFinite,height: 2,color: Colors.black12,),
                              SizedBox(height: 14,),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // try {
                                  final phoneNumber = phone.trim();
                                  print(phoneNumber);
                                  final url =
                                      'https://t.me/$telegram';
                                  await launch(
                                    url,
                                    enableJavaScript: true,
                                    // forceWebView: true,
                                  ).catchError((e) {
                                    showToastError(context: context,text:  e.toString());
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Image.asset('assets/images/Group 1171275618.png'),
                                        // SizedBox(width: 4,),
                                        Image.asset('assets/images/Group 1171275618c.png'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'الاتصال المباشر بالدعم',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(width: 4,),
                                        Image.asset('assets/images/Vector (1).png'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6,),
                              Container(width: double.maxFinite,height: 2,color: Colors.black12,),
                              SizedBox(height: 14,),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Icon(Icons.arrow_back_ios_new_rounded),
                          //         Row(
                          //           children: [
                          //             Text(
                          //               'تقييم التطبيق',
                          //               style: TextStyle(
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.grey,
                          //               ),
                          //             ),
                          //             SizedBox(width: 4,),
                          //             Image.asset('assets/images/solar_star-line-duotone.png'),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(height: 6,),
                          //     Container(width: double.maxFinite,height: 2,color: Colors.black12,),
                          //     SizedBox(height: 14,),
                          //   ],
                          // ),
                          // Column(
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Icon(Icons.arrow_back_ios_new_rounded),
                          //         Row(
                          //           children: [
                          //             Text(
                          //               'مشاركة التطبيق',
                          //               style: TextStyle(
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.grey,
                          //               ),
                          //             ),
                          //             SizedBox(width: 4,),
                          //             Image.asset('assets/images/octicon_share-16.png'),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(height: 6,),
                          //     Container(width: double.maxFinite,height: 2,color: Colors.black12,),
                          //     SizedBox(height: 14,),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 70,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text("هل حقا ترغب في تسجيل الخروج ؟",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("إلغاء",style: TextStyle(color: primaryColor),),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          signOut(context);
                                        },
                                        child: Text("نعم",style: TextStyle(color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 41,
                            width: double.maxFinite,
                            color: primaryColor.withOpacity(0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/stash_signout.png'),
                                Text(
                                  'تسجيل الخروج',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: 20,height: 10,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text("هل حقا ترغب في حذف الحساب ؟",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("إلغاء",style: TextStyle(color: primaryColor),),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showToastInfo(
                                              text: 'تم ارسال طلبك وسوف يتم الرد عليك قريبا',
                                              context: context);
                                        },
                                        child: Text("نعم",style: TextStyle(color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 41,
                            width: double.maxFinite,
                            color: primaryColor.withOpacity(0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/fluent_delete-16-regular.png'),
                                Text(
                                  'حذف الحساب',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: 20,height: 10,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
