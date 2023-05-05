import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungscancer/Models/Image_Model.dart';
import 'package:lungscancer/providers/patient_Provider.dart';
Future<Uint8List> getImageBytes() async {
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

  /*if (pickedFile == null) {
    return  ;
  }*/

  final imageBytes = await pickedFile!.readAsBytes();
  return Uint8List.fromList(imageBytes);
}

class UploadImage extends ConsumerStatefulWidget {

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends ConsumerState<UploadImage> {
   Uint8List? _imageBytes;

  void _loadImage() async {
    final bytes = await getImageBytes();
    setState(() {
      _imageBytes = bytes;
    });
  }
  @override
  Widget build(BuildContext context) {
    final patient_Provider=ref.watch(PatientProviderInstace);
    Future<void> _SubmitUploading()async{
      if(_imageBytes ==null){
        patient_Provider.showToast("قم بتحديد صورة ....!");
      }
      else{
        Uint8List binaryValue = Uint8List.fromList(_imageBytes!);
        var  image=ImageModel(userId: 1,fileName:"_imageBytes",filePath: binaryValue,patientId: 1,uploadDate: DateTime.now() );
        await patient_Provider.UploadImage(image: image);
      }


    }

    return Scaffold(
      backgroundColor: Colors.white,
     /* appBar: AppBar(
        centerTitle: true,
        title: Text('إرفاق صورة'),
      ),*/
      body: SafeArea(
        child: Padding(
          padding: const  EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(

            children: [
              SizedBox(height: 10),

              // User name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "مرحباً,",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "أسم المستخدم",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/images/doctor1.png"),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
              ),
            Container(
              padding: EdgeInsets.all(12),
              child: Text(textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),"قم بإرفاق الصورة التي سيتم الاستفادة منها لمساعدة الدكتور في تقييم الحالة المرضية الخاصة بكم حيث سيتم ارفاق حميع النتائج في التقرير لاحقاً"),
            ),
              if (_imageBytes != null)
                Image.memory(_imageBytes!)
              else
                Text('لايوجد صورة.'),
              SizedBox(height: 20),
              Container(
                width: 200.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 15, 62, 129),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: _loadImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 15, 62, 129),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'حدد الصورة',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 200.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 15, 62, 129),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed:patient_Provider.isLoading==false? _SubmitUploading: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 15, 62, 129),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child:patient_Provider.isLoading==false? const Text(
                    'إرسال الصورة',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ):const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
