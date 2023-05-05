

import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lungscancer/Models/Image_Model.dart';
import 'package:lungscancer/Services/api_status.dart';
import 'package:lungscancer/constants.dart';

class PatientsHttp_services{


 /* String base64Encode(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes as File);
  }*/


// decode the base64 string and save it to a file
 /// Uint8List bytes = base64.decode(imageString);
  ///File file = await File('path/to/save/image.jpg').writeAsBytes(bytes);

// display the image in a Flutter widget
 /// Image.file(file)

  var dio = Dio();
  ///parsing the http url
    static String DataBase_Edit_Url(String url){
    // this function for making an url for the targeted http request web page
    url='$DATABASE_URL'+'$url';
    return url;
    }
    ///this function for adding new lost -found item to the items table
  Future<Object> SendImage(ImageModel imageModel) async {
    Dio dio = Dio();

    try{
      print("Add new Item Function********");
      // Create a FormData object
      var url = DataBase_Edit_Url('Images/AddImage');
      var URL = Uri.parse(url);
       // imageModel.filePath=jsonEncode(imageModel.filePath);
      var json2={"fileName":"example.jpg","filePath":"CJUE5HDQoaCgAAAA1JSERSAAAAMgAAADIIBgAAAC2PCAAAACBbdGV4dEFwcExlU3RhdGVdIDE1LjAuMTgwNwA3Xl17vwAAAAJ0Uk5TAP+mANcZYOIBAAAMSURBVDhPY11OWQAAACMAAABpUGhySGVzAAAATElUUEwAAP/8/f7/f5zb0b3f7+///++uzs+vj4+/366ubp6+n5+fv59/bm5uf4+Pjn5ubm9/j4+Pf29vb3+Pj45+bm5vf4+Pj39vb29/j4+Ofm5ub3+Pj49/b29vf4+Pjn5ubm9/j4+Pf29vb3+Pj45+bm5vf4+Pj39vb29/j4+Ofm5ub3+Pj49/b29vf4+Pjn5ubm9/j4+Pf29vb3+Pj45+bm5vf4+Pj39vb29/j4+Ofm5ub3+Pj49/b29vf4+Pjn5ubm9/j4+Pf29vb3+Pj45+bm5vf4+Pj39vb29/j4+Ofm5ub3+Pj49/b29vf4+Pjn5ubm9/j4+Pf29vb3+Pj45+bm5vf4+Pj39vb29/j4+Ofm5ub3+Pj49/b29vf4+Pjn5ubm9/j4+Pf29vb3+Pj45+bm5vf4","uploadDate":"2023-04-13T01:45:25.633","userId":1,"patientId":null,"patient":null,"user":null};
      String json=imageModelToMap(imageModel);
      print(imageModelToMap(imageModel));
    // print( jsonEncode(json));      //json["filePath"]=jsonEncode(json["filePath"]);
      Response response = await dio.postUri(
        URL,
        data: json,
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );

      print(response.data);
      print(response.data);
      if(response.statusCode==200){
        print(response.data);
        return Successed(success_respones: imageModel,success_code: "success");
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
    Future<Object> GetLocations() async {
    try {
      var url=DataBase_Edit_Url('locations/GetLocations');
      var URL = Uri.parse(url);
      final respones = await dio.getUri(URL);
      if(respones.statusCode ==200){
        return Successed(success_respones: jsonEncode(respones.data),success_code: "success");
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
  Future<Object> GetCategories() async {
    try {
      var url=DataBase_Edit_Url('Categories/GetAllCates');
      var URL = Uri.parse(url);
      final respones = await dio.getUri(URL);
      if(respones.statusCode==200){
        return Successed(success_respones: jsonEncode(respones.data),success_code: "success");
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
  Future<Object> GetItems() async {
    try {
      var url=DataBase_Edit_Url('items/GetItems');
      var URL = Uri.parse(url);
      final respones = await dio.getUri(URL);

      //print(respones.data);
      if(respones.statusCode==200){
         print(jsonDecode(respones.data));
        return Successed(success_respones: respones.data,success_code: "success");
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

    return true;
  }
/// updating Item status in items table
  Future<Object> UpdateItemStatus({int? itemId, int? status}) async {
    Dio dio = Dio();
    try{
      var map = Map<String, dynamic>();
      map["id"]=itemId;


      // Create a FormData object
      var url = DataBase_Edit_Url('items/UpdateItemStatus');
      var URL = Uri.parse(url);
      String json=jsonEncode(map);
      print(json);
      Response response = await dio.postUri(
        URL,
        data: FormData.fromMap(map),
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );
      if(response.data=="updated"){
        print(response.data);
        return Successed(success_respones: response.data,success_code: "success");
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
 ///removing item from Items table
  Future<Object> RemovingItem({int? itemId}) async {
    Dio dio = Dio();
    try{
      var map = Map<String, dynamic>();
      map["id"]=itemId;

      // Create a FormData object
      var url = DataBase_Edit_Url('items/DeleteItem');
      var URL = Uri.parse(url);
      String json=jsonEncode(map);
      print(json);
      Response response = await dio.postUri(
        URL,
        data: FormData.fromMap(map),
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );
      if(response.data=="removed"){
        print(response.data);
        return Successed(success_respones: response.data,success_code: "success");
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