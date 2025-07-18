import 'dart:async';

import 'package:dananer/controllar/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../core/network/remote/dio_helper.dart';
import '../core/widgets/constant.dart';
import '../core/widgets/show_toast.dart';
import '../model/AgentsModel.dart';
import '../model/AllNotificationModel.dart';
import '../model/CounterModel.dart';
import '../model/GetUserModel.dart';
import '../model/ProfileModel.dart';
import '../model/SubscriptionMarketModel.dart';
import '../model/WithdrawalRequestModel.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  refreshState(){
    emit(SendSawaSuccessState());
  }

  bool typeOfCash=true;
  void funTypeOfCash(){
    typeOfCash = !typeOfCash;
    emit(ValidationState());
  }

  void withdrawMoney({required BuildContext context, required String amount,required String accountNumber}) {
    emit(AddWithdrawMoneyLoadingState());
    String? method;
    if(typeOfCash == true){
      method="ماستر كارد";
    }else{
      method="زين كاش";
    }
    DioHelper.postData(
        url: '/withdrawalRequest',
        data: {
          'userId': id,
          'amount': amount,
          'method': method,
          'accountNumber': accountNumber,
        }
    ).then((value) {
      emit(AddWithdrawMoneySuccessState());
    }).catchError((error) {
      if (error is DioError) {
        final errorMessage = error.response?.data['message'] ;
        showToastError(text: errorMessage, context: context);
      } else {
        showToastError(text: 'خطأ في الاتصال بالخادم', context: context);
      }
      emit(AddWithdrawMoneyErrorState());
    });

  }

  void verifyToken({required BuildContext context}) {
    emit(VerifyTokenLoadingState());
    DioHelper.getData(
        url: '/verify-token',
        token: token
    ).then((value) {
      bool isValid = value.data['valid'];
      if (isValid) {
        emit(VerifyTokenSuccessState());
      } else {
        signOut(context);
        showToastError(text: "توكن غير صالح", context: context);
        emit(VerifyTokenErrorState());
      }
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        emit(VerifyTokenErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void deleteCounter({required BuildContext context,required String id}) {
    emit(DeleteCounterLoadingState());
    DioHelper.deleteData(
        url: '/counters/$id',
    ).then((value) {
      emit(DeleteCounterSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        emit(DeleteCounterErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void deleteCounterSell({required BuildContext context,required String idCountersSall,required String userId}) {
    emit(DeleteCounterLoadingState());
    DioHelper.deleteData(
      url: '/counters/sell/$idCountersSall',
      data: {
        'userId': userId,
      }
    ).then((value) {
      emit(DeleteCounterSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        emit(DeleteCounterErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void addCounterSell({required BuildContext context,required String userCounterId,required String price}) {
    emit(AddCounterLoadingState());
    DioHelper.postData(
      url: '/counters/sell',
      data: {
        'userId': id,
        'userCounterId': userCounterId,
        'price': price,
      }
    ).then((value) {
      emit(AddCounterSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        emit(AddCounterErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void addCounterBuy({required BuildContext context,required String saleId,required String buyerId}) {
    emit(AddCounterBuyLoadingState());
    DioHelper.postData(
      url: '/counters/buy',
      data: {
        'buyerId': id,
        'saleId': saleId,
      }
    ).then((value) {
      emit(AddCounterBuySuccessState());
    }).catchError((error) {
      if (error is DioError) {
        final errorMessage = error.response?.data['error'] ?? 'حدث خطأ غير متوقع';
        showToastError(text: errorMessage, context: context);
      } else {
        showToastError(text: 'خطأ في الاتصال بالخادم', context: context);
      }
    });

  }

  String? time;
  void timeOfDay({required BuildContext context}) {
    emit(TimeOfDayLoadingState());
    DioHelper.getData(
        url: '/timeofday',
    ).then((value) {
        time = value.data['period'];
        emit(TimeOfDaySuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        emit(TimeOfDayErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  String handleDioError(dynamic data) {
    if (data == null) {
      return "حدث خطأ غير معروف";
    } else if (data is Map && data.containsKey("error")) {
      return data["error"].toString();
    } else if (data is String) {
      return data;
    } else if (data is List) {
      return data.join(", ");
    } else {
      return data.toString();
    }
  }

  signUp({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String password,
    required String role,
    required BuildContext context,}) async {
    emit(SignUpLoadingState());
      DioHelper.postData(
        url: '/users',
        data:  {
          'name': name,
          'email': email,
          'phone': phone,
          'location': location,
          'password': password,
          'role': role,
        },
      ).then((value) {
        emit(SignUpSuccessState());
      }).catchError((error) {
        if (error is DioError) {
          print("Error Data: ${error.response?.data}");
          String errorMessage = handleDioError(error.response?.data);
          showToastError(
            text: error.response?.data['error'],
            context: context,
          );
          emit(SignUpErrorState());
        } else {
          print("Unknown Error: $error");
        }
      });

  }

  Future<void> registerDevice(String userId) async {
    final playerId = OneSignal.User.pushSubscription.id;

    if (playerId != null) {
      try {
        final response = await DioHelper.postData(
          url: "/register-device",
          data: {
            "user_id": userId,
            "player_id": playerId,
          },
        );

        if (response.statusCode == 200) {
          print("✅ تم تسجيل الجهاز بنجاح");
        } else {
          print("❌ خطأ أثناء تسجيل الجهاز: ${response.statusMessage}");
        }
      } catch (error) {
        print("❌ Error: $error");
      }
    } else {
      print("❌ لم يتم الحصول على player_id من OneSignal");
    }
  }

  String? tokenn;
  String? role;
  String? idd;
  String? phonee;
  bool? isVerified;

  signIn({required String email , required String password, required String code, required BuildContext context,}){
    emit(LoginLoadingState());
    Map<String , dynamic> data;
    if(code == '0'){
      data={
        'email': email ,
        'password': password,
      };
    }else{
      data={
        'email': email ,
        'password': password,
        'refId': code,
      };
    }
    DioHelper.postData(
      url: '/login',
      data: data,
    ).then((value) {
      tokenn=value.data['token'];
      role=value.data['user']['role'];
      idd=value.data['user']['id'].toString();
      isVerified=value.data['user']['isVerified'];
      phonee=value.data['user']['phone'].toString();
      registerDevice(idd!);
      emit(LoginSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ?? "حدث خطأ غير معروف",
          context: context,
        );
        emit(LoginErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  sendOtp({required String phone ,required BuildContext context,}){
    emit(LoginLoadingState());
    DioHelper.postData(
      url: '/send-otp',
      data: {
        'phone': phone ,
      },
    ).then((value) {
      emit(LoginSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ?? "حدث خطأ غير معروف",
          context: context,
        );
        emit(LoginErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  verifyOtp({required String phone ,required String code ,required BuildContext context,}){
    emit(VerifyOtpLoadingState());
    DioHelper.postData(
      url: '/verify-otp',
      data: {
        'phone': phone ,
        'code': code ,
      },
    ).then((value) {
      emit(VerifyOtpSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ?? "حدث خطأ غير معروف",
          context: context,
        );
        emit(VerifyOtpErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  ProfileModel? profileModel;
  void getProfile({required BuildContext context,}) {
    emit(GetProfileLoadingState());
    DioHelper.getData(
        url: '/profile',
        token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      // if (profileModel != null) {
      //   if (profileModel!.isVerified == false) {
      //     showToastError(
      //       text: "حسابك غير مفعل، الرجاء تفعيل الحساب.",
      //       context: context,
      //     );
      //     signOut(context);
      //   }
      // }

      emit(GetProfileSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        print(error.toString());
        emit(GetProfileErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  List<SubscriptionMarketModel> subscriptionMarketList = [];
  void getSubscriptionMarket({required BuildContext context,}) {
    emit(GetSubscriptionMarketLoadingState());
    DioHelper.getData(
      url: '/counters/for-sale',
      token: token,
    ).then((value) {
      subscriptionMarketList = (value.data as List)
          .map((item) => SubscriptionMarketModel.fromJson(item))
          .toList();
      emit(GetSubscriptionMarketSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        print(error.toString());
        emit(GetSubscriptionMarketErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  sendMony({required String receiverId, required String amount, required BuildContext context,}){
    emit(SendMonyLoadingState());
    DioHelper.postData(
      url: '/sendmony',
      data: {
        'senderId': id,
        'receiverId': receiverId,
        'amount': amount,
      },
    ).then((value) {
      emit(SendMonySuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ,
          context: context,
        );
        emit(SendMonyErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  sendMonyAgents({required String receiverId, required String amount, required BuildContext context,}){
    emit(SendMonyLoadingState());
    DioHelper.postData(
      url: '/sendmony-simple',
      data: {
        'senderId': id,
        'receiverId': receiverId,
        'amount': amount,
      },
    ).then((value) {
      profileModel = null;
      getProfile(context: context);
      emit(SendMonySuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ,
          context: context,
        );
        emit(SendMonyErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  List<CounterModel>? counters;
  void getCounter({required BuildContext context,}) {
    emit(GetCounterLoadingState());
    DioHelper.getData(
      url: '/counters',
      token: token,
    ).then((value) {
      counters = (value.data as List)
          .map((item) => CounterModel.fromJson(item))
          .toList();
      emit(GetCounterSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        print(error.toString());
        emit(GetCounterErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  WithdrawalRequestModel? withdrawalRequestModel;
  void getWithdrawalRequest({required BuildContext context,}) {
    emit(GetWithdrawalRequestLoadingState());
    DioHelper.getData(
      url: '/withdrawalRequest',
      token: token,
    ).then((value) {
      withdrawalRequestModel = WithdrawalRequestModel.fromJson(value.data);
      emit(GetWithdrawalRequestSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(), context: context,);
        emit(GetWithdrawalRequestErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void deleteWithdrawalRequest({required BuildContext context,required String id,}) {
    emit(DeleteWithdrawalRequestLoadingState());
    DioHelper.deleteData(
      url: '/withdrawalRequest/$id',
    ).then((value) {
      getWithdrawalRequest(context: context);
      emit(DeleteWithdrawalRequestSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(), context: context,);
        emit(DeleteWithdrawalRequestErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  List<Log> allNotification = [];
  Pagination? pagination;
  int currentPage = 1;
  bool isLastPage = false;
  AllNotificationModel? notificationModel;
  void getNotification({required String page,required String role, BuildContext? context,}) {
    emit(GetAllNotificationLoadingState());
    DioHelper.getData(
      url: '/notifications-log?role=$role&page=$page',
    ).then((value) {
      notificationModel = AllNotificationModel.fromJson(value.data);
      allNotification.addAll(notificationModel!.logs);
      pagination = notificationModel!.pagination;
      currentPage = pagination!.page;
      if (currentPage >= pagination!.totalPages) {
        isLastPage = true;
      }
      emit(GetAllNotificationSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context!,);
        print(error.toString());
        emit(GetAllNotificationErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  assignCounter({required String counterId, required BuildContext context,}){
    emit(AssignCounterLoadingState());
    DioHelper.postData(
      url: '/assign-counter',
      data: {
        'userId': id,
        'counterId': counterId,
      },
    ).then((value) {
      emit(AssignCounterSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ,
          context: context,
        );
        emit(AssignCounterErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  List<AgentsModel>? agentsModel;
  void getAgents({required BuildContext context,}) {
    emit(GetAgentsLoadingState());
    DioHelper.getData(
      url: '/roleAgents',
    ).then((value) {
      agentsModel = (value.data as List)
          .map((item) => AgentsModel.fromJson(item))
          .toList();
      emit(GetAgentsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        print(error.toString());
        emit(GetAgentsErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  int myValue=1;

  void fu({required int value}){
    myValue=value;
    print(myValue);
  }

  sendSawa({required String amount, required BuildContext context,}){
    emit(SendSawaLoadingState());
    DioHelper.postData(
      url: '/deposit-sawa',
      data: {
        'userId': id,
        'amount': amount,
      },
    ).then((value) {
      showToastSuccess(
        text: 'تم كسب $amount كوينز ',
        context: context,
      );
      updateGems(gems: myValue, context: context);
      emit(SendSawaSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ,
          context: context,
        );
        emit(SendSawaErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  sendSawaa({required String amount,required String userId, required BuildContext context,}){
    emit(SendSawaLoadingState());
    DioHelper.postData(
      url: '/deposit-sawa',
      data: {
        'userId': userId,
        'amount': amount,
      },
    ).then((value) {
      showToastSuccess(
        text: 'تم ارسال $amount كوينز ',
        context: context,
      );
      emit(SendSawaSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ,
          context: context,
        );
        emit(SendSawaErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  updateGems({required int gems, required BuildContext context,}){
    emit(UpdateGemsLoadingState());
    DioHelper.putData(
      url: '/users/$id/gems',
      data: {
        'gems': gems,
      },
    ).then((value) {
      print('===============================');
      print(gems);
      emit(UpdateGemsSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ,
          context: context,
        );
        emit(UpdateGemsErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  bool? canDoAction;
  String? remainingTime;
  void getDaily({required BuildContext context, required String id}) {
    emit(GetDailyLoadingState());
    DioHelper.getData(
      url: '/daily-action/$id',
    ).then((value) {
      canDoAction = value.data['canDoAction'];
      remainingTime = value.data['remainingTime'];
      emit(GetDailySuccessState());
      startDailyTimer(context);
    }).catchError((error) {
      if (error is DioError) {
        showToastError(
          text: error.toString(),
          context: context,);
        print(error.toString());
        emit(GetDailyErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  Timer? dailyTimer;
  void startDailyTimer(BuildContext context) {
    dailyTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      getDaily(context: context, id: id);
      emit(GetDailySuccessState());
    });
  }

  sumDaly({ required BuildContext context,}){
    emit(PostDailyLoadingState());
    DioHelper.postData(
      url: '/daily-action',
      data: {
        'user_id': id,
      },
    ).then((value) {
      showToastSuccess(
        text: 'تمت العملية بنجاح',
        context: context,
      );
      getDaily(context: context, id: id);
      emit(PostDailySuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToastError(
          text: error.response?.data["error"] ,
          context: context,
        );
        emit(PostDailyErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  assignAgents({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String password,
    required String note,
    required BuildContext context,}) async {
    emit(AssignAgentsLoadingState());
    DioHelper.postData(
      url: '/users',
      data:  {
        'name': name,
        'email': email,
        'phone': phone,
        'location': location,
        'password': password,
        'note': note,
        'role': 'agent',
      },
    ).then((value) {
      emit(AssignAgentsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print("Error Data: ${error.response?.data}");
        String errorMessage = handleDioError(error.response?.data);
        showToastError(
          text: error.response?.data['error'],
          context: context,
        );
        emit(AssignAgentsErrorState());
      } else {
        print("Unknown Error: $error");
      }
    });

  }

  deleteAgents({
    required String id,
    required BuildContext context,}) async {
    emit(DeleteAgentsLoadingState());
    DioHelper.deleteData(
      url: '/users/$id',
    ).then((value) {
      emit(DeleteAgentsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print("Error Data: ${error.response?.data}");
        String errorMessage = handleDioError(error.response?.data);
        showToastError(
          text: error.response?.data['error'],
          context: context,
        );
        emit(DeleteAgentsErrorState());
      } else {
        print("Unknown Error: $error");
      }
    });
  }

  assignCounters({
    required String points,
    required String price,
    required String type,
    required BuildContext context,}) async {
    emit(AssignCountersLoadingState());
    DioHelper.postData(
      url: '/counters',
      data:  {
        'points': points,
        'price': price,
        'type': type,
      },
    ).then((value) {

      emit(AssignCountersSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print("Error Data: ${error.response?.data}");
        String errorMessage = handleDioError(error.response?.data);
        showToastError(
          text: error.response?.data['error'],
          context: context,
        );
        emit(AssignCountersErrorState());
      } else {
        print("Unknown Error: $error");
      }
    });
  }

  void addNotification({
    required BuildContext context,
    required String title,
    required String desc,
    required String role,}) async {
    emit(AddNotificationLoadingState());
    DioHelper.postData(
      url: '/send-notification-to-role',
      data: {
        'title': title,
        'message': desc,
        'role': role,
      },
    ).then((value) {
      emit(AddNotificationSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        showToastError(text: error.message!, context: context);
      } else {
        print("❌ Unknown Error: $error");
      }
      emit(AddNotificationErrorState());
    });
  }

  void getUser({required BuildContext context,required String id}) {
    emit(GetUserLoadingState());
    DioHelper.getData(
      url: '/users/$id',
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(GetUserSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToastError(text: error.toString(),
          context: context,);
        print(error.toString());
        emit(GetUserErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


}