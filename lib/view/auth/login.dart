import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dananer/controllar/cubit.dart';
import 'package:dananer/controllar/states.dart';
import 'package:dananer/view/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../core/navigation_bar/navigation_bar.dart';
import '../../core/navigation_bar/navigation_bar_admin.dart';
import '../../core/navigation_bar/navigation_bar_agents.dart';
import '../../core/network/local/cache_helper.dart';
import '../../core/widgets/constant.dart';
import 'loginCode.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            CacheHelper.saveData(
              key: 'token',
              value: AppCubit.get(context).tokenn,
            ).then((value) {
              CacheHelper.saveData(
                key: 'id',
                value: AppCubit.get(context).idd,
              ).then((value) {
                CacheHelper.saveData(
                  key: 'role',
                  value: AppCubit.get(context).role,
                ).then((value) {
                  token = AppCubit.get(context).tokenn.toString();
                  id = AppCubit.get(context).idd.toString();
                  adminOrUser = AppCubit.get(context).role.toString();
                  // if(AppCubit.get(context).isVerified ==false){
                  //   navigateTo(context, LoginCode(phone: AppCubit.get(context).phonee.toString(),));
                  // }else{
                  //
                  // }
                  if (adminOrUser == 'admin') {
                    navigateAndFinish(context, BottomNavBarAdmin());
                  }else if (adminOrUser == 'agent') {
                    navigateAndFinish(context, BottomNavBarAgents());
                  } else {
                    navigateAndFinish(context, BottomNavBar());
                  }
                });
              });
            });
          }
        },
          builder: (context,state){
          var cubit=AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFFF5F5F5),
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 140,),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 100,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          nameApp,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'متعة خاصة بك لا تنتهي',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 70),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'البريد الالكتروني',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل البريد الالكتروني';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'كلمة السر',
                          prefixIcon: Icons.lock,
                          obscureText: true,
                          suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اكتب كلمة السر';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: codeController,
                          hintText: 'كود الاحالة (اختياري)',
                          prefixIcon: Icons.code,
                          keyboardType: TextInputType.phone,
                        ),
                        // const SizedBox(height: 8),
                        // GestureDetector(
                        //   onTap: (){
                        //     navigateTo(context, LoginCode());
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         'تسجيل الدخول عن طريق كود الاحالة',
                        //         style: TextStyle(
                        //           color: primaryColor,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 60),
                        ConditionalBuilder(
                            condition: state is !LoginLoadingState,
                            builder: (context){
                              return GestureDetector(
                                onTap: (){
                                  if (formKey.currentState!.validate()) {
                                    if(codeController.text.trim().isEmpty){
                                      codeController.text='0';
                                    }
                                    cubit.signIn(
                                        email : emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      code: codeController.text.trim(),
                                      context: context
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                      borderRadius:  BorderRadius.circular(12),
                                      color: primaryColor
                                  ),
                                  child: Center(
                                    child: Text('تسجيل الدخول',
                                      style: TextStyle(color: Colors.white,fontSize: 18 ),),
                                  ),
                                ),
                              );
                            },
                          fallback: (c)=> CircularProgressIndicator(color: primaryColor,),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, Register());
                              },
                              child: const Text(
                                'انشاء حساب ',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text("لا تمتلك حساب ؟ "),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          },
          ),
    );
  }
}
