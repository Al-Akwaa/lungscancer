

import 'dart:convert';
import 'dart:io';

import 'package:lungscancer/Models/UserVM_Model.dart';
import 'package:lungscancer/Models/User_Model.dart';
import 'package:lungscancer/Services/api_status.dart';
import 'package:lungscancer/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
class UsersHttp_Services {

  var dio = Dio();

  static String DataBase_Edit_Url(String url){
    // this function for making an url for the targeted http request web page
    url='$DATABASE_URL'+'$url';
    return url;

  }
  Future<Object> UserLogin(String UserEmail, String UsersPass) async {
    var ReturnResult = Map<String,dynamic>();
    ReturnResult["result"] = "Error";

    try {

      final url = DataBase_Edit_Url('User/UserLogin');
      var URL = Uri.parse(url);
      final data = {
        'userEmail': UserEmail.toString(),
        'userPassword': UsersPass.toString(),
      };
      print(data);
      final response = await dio.postUri(URL, data: data);

      if(response.data != "no one") {
        return Successed(success_respones: User.fromMap(response.data), success_code: "success");
      }

      else {
        return FailureRespones(failure_code: 100, failure_respones: "البياتات غير صحيحة،او المستخدم غير موجود");
      }

    } on DioError catch (e) {
      if (e.response != null) {
        return FailureRespones(failure_code: 103, failure_respones: "خطأ غير معروف");
      } else {
        return FailureRespones(failure_code: 101, failure_respones: "لا يوجد انترنت");
      }
    }
  }

/*
   Future<Object> UserLogin(String UserEmail, String UsersPass) async {
    //this function is the only responsible one for Login to the app
    var ReturnResult=Map<String,dynamic>();
    ReturnResult["result"]="Error";
    try {
      var map = Map<String, dynamic>();

      var url=DataBase_Edit_Url('User/UserLogin');
      var URL = Uri.parse(url);
      print("the whole url is : $URL");
      map['userEmail'] = UserEmail.toString();
      map['userPassword'] = UsersPass.toString();
      print(map);
      final respones = await dio.postUri(URL,data: map);
      if(respones.data=="exist"){
        return Successed(success_respones: userFromJson(respones.data),success_code: "success");
      }
      if(respones.data!="no one"){
        return FailureRespones(failure_code: 105, failure_respones: "البياتات غير صحيحة، مستخدم غير موجود"); //
      }
      else{
        return FailureRespones(failure_code: 100, failure_respones: "البياتات غير صحيحة"); //
      }

    } on HttpException{
      return FailureRespones(failure_respones: "لا يوجد انترنت",failure_code: 101);
    }on FormatException{
      return FailureRespones(failure_code: 102,failure_respones: " نص غير مفهوم");
    }
    catch (e) {
      print("مشكلة في السرفر$e");
      return FailureRespones(failure_code: 103, failure_respones: "خطأ غير معروف"); //
    }
  }
*/
  // register new child to the database
   Future UserRegisteration({String? UserName, String? UserEmail,String ?UserPass}) async {
    //this function is the only responsible one for Registeration to the app

    try {
      var url=DataBase_Edit_Url('User/CreateUser');
      var URL = Uri.parse(url);
     User user= new User(id: 0,userEmail:UserEmail.toString(),userName: UserName.toString(),userPassword: UserPass.toString(),userRole: "user" );
      String UserAsJson=userToMap(user);
      print(UserAsJson);
      final respones = await dio.postUri(URL,data: UserAsJson, options: Options(headers:{"Content-Type": "application/json"} ));

      print(respones.data);
      if(respones.data=="exist"){
        return FailureRespones(failure_code: 105, failure_respones: "الايميل موحود مسبقاً...استخدم إيميلاُ آخر"); //

      }
      else if(respones.data=="added"){
        print(respones.data);
        return Successed(success_respones: user,success_code: "success");
      }
      else{
        return FailureRespones(failure_code: 100, failure_respones: "البياتات غير صحيحة"); //
      }

    } on HttpException{
      return FailureRespones(failure_respones: "لا يوجد انترنت",failure_code: 101);
    }on FormatException{
      return FailureRespones(failure_code: 102,failure_respones: " نص غير مفهوم");
    }
    catch (e) {
      print("مشكلة في السرفر$e");
      return FailureRespones(failure_code: 103, failure_respones: "خطأ غير معروف"); //
    }
  }








}
