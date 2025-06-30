import 'package:dananer/view/auth/login.dart';

import '../ navigation/navigation.dart';
import '../network/local/cache_helper.dart';

String token='';
String id='';
String adminOrUser='' ;
String phone='7826084404' ;
String telegram='Coinc3' ;
String googlePlay='' ;
String appStore='' ;
String nameApp='كوينز كاش' ;

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    token='';
    adminOrUser='' ;
    id='' ;
    if (value)
    {
      CacheHelper.removeData(key: 'role',);
      CacheHelper.removeData(key: 'id',);
      navigateTo(context, const Login(),);
    }
  });
}
