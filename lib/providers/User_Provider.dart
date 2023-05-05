

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungscancer/Models/User_Model.dart';
import 'package:lungscancer/Services/Users_Http.dart';
import 'package:lungscancer/Services/api_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
final authUserProvider = ChangeNotifierProvider<UsersProvider>((ref) {
  return UsersProvider();
});
final futureAuthProviders = FutureProvider<void>((ref) async {
  final auth = ref.watch(authUserProvider);
  await auth.getUser();
});
class UsersProvider extends ChangeNotifier{
  UsersHttp_Services http_services=new UsersHttp_Services();

  bool loadingState=false;
  bool _isLoginState=false;

User SingleUser=new User();
  bool get isLoading =>loadingState;
  bool get isLoginState=>_isLoginState;
  setIsLoginState(){
    _isLoginState=!_isLoginState;
    notifyListeners();
  }
   setIsLoading(bool Loading){
     loadingState=Loading;
     notifyListeners();
  }
  bool get isAuth => SingleUser.isAuth;
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedData = prefs.getString('user');
    //print(" the loaded data is : "+loadedData!);
    if (loadedData == null) return;
    final user = userFromMap(loadedData);

    SingleUser = user!;
   //
  }

    ///User Loging operation
  Future<bool>  UserLogin(String Email,String Password) async{
    bool userLoginState =false;
    setIsLoading(true);
   var response= await http_services.UserLogin(Email, Password);
    if(response is Successed){

      final prefs = await SharedPreferences.getInstance();
      print(response.success_respones);
      SingleUser=response.success_respones as User  ;
      prefs.setString('user', userToMap(SingleUser));

      print(SingleUser);
      print("NEw Users Instance name ${SingleUser.userName}");
      userLoginState=true;

    }
    if( response is FailureRespones){
      ShowToast(response.failure_respones.toString());
    }
    //notifyListeners();
    print(userLoginState);
    setIsLoading(false);
    return userLoginState;
  }
    ///Adding new User to the table users
  Future<bool>  UserRegisteration({String ?Name, String? Email, String? Password}) async{
    bool userLoginState =false;
    setIsLoading(true);
    await http_services.UserRegisteration(UserName: Name, UserEmail: Email,UserPass: Password).then((respones) async {
      if(respones is Successed){
        final prefs = await SharedPreferences.getInstance();
        print(respones.success_respones);
        SingleUser=respones.success_respones as User  ;
        prefs.setString('user', userToMap(SingleUser));
        print(SingleUser);
        print("NEw Users Instance name ${SingleUser.userName}");
        userLoginState=true;
      }
      if( respones is FailureRespones){
        ShowToast(respones.failure_respones.toString());
        return userLoginState;
      }
    });
    setIsLoading(false);

   // notifyListeners();
    print(userLoginState);
    return userLoginState;
  }

  ///User Logout function
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    SingleUser.ClearUserData();
    prefs.remove('user');
    notifyListeners();
  }
 void ShowToast( String ToastString){
   Fluttertoast.showToast(
       msg: "${ToastString.toString()}",
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.CENTER,
       timeInSecForIosWeb: 1,
       backgroundColor: Colors.red,
       textColor: Colors.white,
       fontSize: 16.0
   );
 }

}