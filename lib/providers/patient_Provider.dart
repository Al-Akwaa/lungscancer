


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungscancer/Models/Image_Model.dart';
import 'package:lungscancer/Models/User_Model.dart';
import 'package:lungscancer/Services/Patient_Http.dart';
import 'package:lungscancer/Services/api_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
final PatientProviderInstace = ChangeNotifierProvider<PatientProvider>((ref) {
  return PatientProvider();
});
/*final futureAuthProviders = FutureProvider<void>((ref) async {
  final auth = ref.watch(authUserProvider);
  await auth.getUser();
});*/
class PatientProvider extends ChangeNotifier{
  bool loadingState=false;
  User SingleUser=new User();
  final PatientsHttp_services  _patientsHttp_services=new PatientsHttp_services();
  bool get isLoading =>loadingState;
  setIsLoading(bool Loading){
    loadingState=Loading;
    notifyListeners();
  }
  Future<bool> UploadImage({ImageModel? image}) async {
    setIsLoading(true);
    await _patientsHttp_services.SendImage(image!).then((value){
       if(value is Successed){
         print("Uploading provider image successed");
         setIsLoading(false);
       }else{
         print("Uploading provider image Failed");
         setIsLoading(false);
       }
     });

    return isLoading;
  }

  ///User Loging operation
/*
  Future<bool>  UserLogin(String Email,String Password) async{
    bool userLoginState =false;
    //setIsLoading(true);
    await UsersHttp_Services.UserLogin(Email, Password).then((respones) async {

      //userLoginState= respones["result"]=="Error" || respones["result"]== "no user"?false:true;
      if(respones is Successed){
        final prefs = await SharedPreferences.getInstance();

        print(respones.success_respones);
        SingleUser=respones.success_respones as Users  ;
        prefs.setString('user', usersToMap(SingleUser));

        print(SingleUser);
        print("NEw Users Instance name ${SingleUser.userName}");
        userLoginState=true;

      }
       if( respones is FailureRespones){
        Fluttertoast.showToast(
            msg: "${respones.failure_respones.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return userLoginState;
      }
    });
    notifyListeners();
    print(userLoginState);
    //setIsLoading(false);
    return userLoginState;
  }
*/
  //  UsersHttp_Services http_services=new UsersHttp_Services();
  ///Adding new User to the table users
/*
  Future<bool>  UserRegisteration({String ?Name, String? Phone, String? Email, String? Password}) async{
    bool userLoginState =false;
    //setIsLoading(true);
    await http_services.UserRegisteration(UserName: Name, UserEmail: Email,UserPass: Password,UserPhone: Phone).then((respones) async {
      if(respones is Successed){
        final prefs = await SharedPreferences.getInstance();
        print(respones.success_respones);
        SingleUser=respones.success_respones as Users  ;
        prefs.setString('user', usersToMap(SingleUser));
        print(SingleUser);
        print("NEw Users Instance name ${SingleUser.userName}");
        userLoginState=true;
      }
      if( respones is FailureRespones){
        Fluttertoast.showToast(
            msg: "${respones.failure_respones.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return userLoginState;
      }
    });
    notifyListeners();
    print(userLoginState);
    //setIsLoading(false);
    return userLoginState;
  }
*/

  ///User Logout function
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    SingleUser.ClearUserData();
    prefs.remove('user');
    notifyListeners();
  }
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }



}