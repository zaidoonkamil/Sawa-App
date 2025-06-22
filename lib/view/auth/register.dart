import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dananer/controllar/cubit.dart';
import 'package:dananer/controllar/states.dart';
import 'package:dananer/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/styles/themes.dart';
import '../../core/widgets/show_toast.dart';
import 'login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController locationController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
         if(state is SignUpSuccessState){
            userNameController.text='';
            emailController.text='';
            phoneController.text='';
            locationController.text='';
            passwordController.text='';
            rePasswordController.text='';
            showToastSuccess(
              text: "تم انشاء الحساب بنجاح",
              context: context,
            );
            navigateAndFinish(context, Login());
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
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  navigateBack(context);
                                },
                                child: Icon(Icons.arrow_back_ios_new_rounded,size: 26,)),
                            const Text(
                              'انشاء حساب',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 70),
                        CustomTextField(
                          controller: userNameController,
                          hintText: 'الاسم الثلاثي',
                          prefixIcon: Icons.person_outline,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل الاسم الثلاثي';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: phoneController,
                          hintText: 'رقم الهاتف',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل رقم الهاتف';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'البريد الالكتروني',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل البريد الالكتروني';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: locationController,
                          hintText: 'العنوان',
                          prefixIcon: Icons.location_on_outlined,
                          keyboardType: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اخل العنوان';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'كلمة السر',
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                          // suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اكتب كلمة السر';
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: rePasswordController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجائا اعد كتابة كلمة السر';
                            }
                          },
                          hintText: 'اعد كتابة كلمة السر',
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                          // suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.deepOrangeAccent.withOpacity(0.5),
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
                                  Expanded(child: Text('التأكيد على حفض كلمة السر جيدا لانك بنسيانها لا نتحمل مسئوليت ذلك',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 14,color: Colors.black54),)),
                                  SizedBox(width: 6,),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.deepOrangeAccent.withOpacity(0.2)
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.info_outline,color: Colors.deepOrangeAccent,size: 32,))
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        ConditionalBuilder(
                            condition: state is !SignUpLoadingState,
                            builder: (context){
                              return GestureDetector(
                                onTap: (){
                                  if (formKey.currentState!.validate()) {
                                    if(passwordController.text == rePasswordController.text){
                                      cubit.signUp(
                                        email: emailController.text.trim(),
                                        name: userNameController.text.trim(),
                                        phone: phoneController.text.trim(),
                                        location: locationController.text.trim(),
                                        password: passwordController.text.trim(),
                                        role: 'user',
                                        context: context,
                                      );
                                    }else{
                                      print(rePasswordController.text);
                                      print(passwordController.text);
                                      showToastError(
                                        text: "كلمة السر غير متطابقة",
                                        context: context,
                                      );
                                    }
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
                                    child: Text('انشاء الحساب',
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
                                navigateBack(context);
                              },
                              child: const Text(
                                'تسجيل الدخول ',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text("امتلك حساب ؟ "),
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
