import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungscancer/providers/User_Provider.dart';
import 'package:lungscancer/widgets/custom_button.dart';
import 'package:lungscancer/widgets/custom_input.dart';

class SignUp extends ConsumerStatefulWidget {

  @override
  _SignUpFormState   createState() => _SignUpFormState();


}
class _SignUpFormState extends ConsumerState<SignUp> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController _NameController;
  late TextEditingController _PassController;
  late TextEditingController _EmailController;
  late TextEditingController _ConfirPassController;

  late FocusNode _NamefocusNode;
  late FocusNode _PassfocusNode;
  late FocusNode _EmailNofocusNode;
  late FocusNode _ConfirPassFocusNode;

  late bool isSubmitted;
  late bool isLoading;




  String? get _nameErrorText {
    final text = _NameController.value.text;

    if (!isSubmitted && !_NamefocusNode.hasFocus) {
      return null;
    }

    if (text.length < 3) {
      return 'الاسم حروفه قليلة !';
    }

    if (text.length > 15) {
      return 'عدد الاحرف كبير !';
    }

    if (text[text.length - 1] == ' ') {
      return 'لا يجب ان ينتهي الاسم ب مسافة فارغة';
    }

    /*if (!RegExp(r'^[a-zA-Z0-9_]*$').hasMatch(text)) {
      return 'يسمح باستخدام الارقام والاحرف وال _ ';
    }*/

    return null;
  }
  String? get _EmailNoErrorText {
    final text = _EmailController.value.text;

    if (!isSubmitted && !_EmailNofocusNode.hasFocus) {
      return null;
    }
    if (text.isEmpty) {
      return 'الرجاء ادخال البريد الإلكتروني';
    }
    if (text.length < 3) {
      return 'الايميل غير مكتمل';
    }

    if (text[text.length - 1] == ' ') {
      return 'الرقم لا ينتهي ب مسافة فارغة !';
    }


    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(text)) {
      return 'الرجاء ادخال بريد إلكتروني صحيح';
    }
    return null;
  }
  String? get _PassNoErrorText {
    final text = _PassController.value.text;

    if (!isSubmitted && !_PassfocusNode.hasFocus) {
      return null;
    }

    if (text.length < 3) {
      return 'كلمة المرور ضعيفة';
    }

    if (text.length > 12) {
      return 'كلمة المرور اطول من المعتاد !';
    }

    if (text[text.length - 1] == ' ') {
      return 'كلمة المرور تنتهي ب مسافة فارغة !';
    }

    return null;
  }
  String? get _ConfirmPassNoErrorText {
    final text = _ConfirPassController.value.text;

    if (!isSubmitted && !_ConfirPassFocusNode.hasFocus) {
      return null;
    }

    if (text != _PassController.text) {
      return 'كلمتي المرور غير متطابقتين';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _NameController = TextEditingController();
    _EmailController = TextEditingController();
    _PassController = TextEditingController();
    _ConfirPassController=TextEditingController();
    isSubmitted = false;
    isLoading = false;
    _NamefocusNode=FocusNode();
    _EmailNofocusNode=FocusNode();
    _PassfocusNode=FocusNode();
    _ConfirPassFocusNode=FocusNode();
    //initPlatformState();
  }




  @override
  Widget build(BuildContext context) {
    return Form(

      key: formKey,
      child: Consumer(
       builder: (context,ref,child){
         final auth = ref.read(authUserProvider);
         return  Column(

           children: [
             CustomInput(
               text: 'ألاسم بالكامل',
               errorText: _nameErrorText,
               onFocusChange: (_) => setState(() {}),
               controller: _NameController,
               focusNode: _NamefocusNode,
               onChanged: (value) => setState(() {}),
               onFieldSubmitted: (_) => _NamefocusNode.requestFocus(),
             ),
             CustomInput(
               text: 'الايميل الالكتروني',
               errorText: _EmailNoErrorText,
               onFocusChange: (_) => setState(() {}),
               controller: _EmailController,
               focusNode: _EmailNofocusNode,
               onChanged: (value) => setState(() {}),
               onFieldSubmitted: (_) => _EmailNofocusNode.requestFocus(),
             ),
             CustomInput(
               text: 'كلمة المرور',
               errorText: _PassNoErrorText,
               onFocusChange: (_) => setState(() {}),
               controller: _PassController,
               focusNode: _PassfocusNode,
               onChanged: (value) => setState(() {}),
               onFieldSubmitted: (_) => _PassfocusNode.requestFocus(),
             ),

             CustomInput(
               text: 'تأكيد كلمة المرور',
               errorText: _ConfirmPassNoErrorText,
               onFocusChange: (_) => setState(() {}),
               controller: _ConfirPassController,
               focusNode: _ConfirPassFocusNode,
               onChanged: (value) => setState(() {}),
               onFieldSubmitted: (_) => _ConfirPassFocusNode.requestFocus(),
             ),






             auth.isLoading==true?Container(color: Color.fromARGB(255, 15, 62, 129),
                 child: CircularProgressIndicator(
                   color: Colors.white,
                 ),):
             CustomButton(
               color:   Color.fromARGB(255, 15, 62, 129),
               text: "انشاء حساب جديد",
               onPressed: () async {
                 setState(() {
                   isSubmitted = true;
                 });
                 if (_nameErrorText != null ||
                     _NamefocusNode != null
                     ||_EmailNoErrorText != null ||
                     _EmailNofocusNode != null
                     ||_PassNoErrorText != null ||
                     _PassfocusNode != null
                     ||_ConfirmPassNoErrorText != null ||
                     _ConfirPassFocusNode != null) {
                   return;
                 }
                 else{
                   auth.UserRegisteration(Name: _NameController.text.toString(),Email: _EmailController.text,Password: _PassController.text);

                 }

                 setState(() {
                   isLoading = true;
                 });
                 try {
                   print("Try catch --------------------");
                   //LoginFunction(_nameController.text.toString(),_AgeController.text.toString());


                 } catch (e) {
                   setState(() {
                     isLoading = false;
                   });
                   showDialog(
                     context: context,
                     builder: (context) => AlertDialog(
                       content: Text(
                         e.toString(),
                       ),
                     ),
                   );
                 }
               },
             ),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextButton(
                 onPressed: (){
                   auth.setIsLoginState();
                   /*setState(() {
                   // widget.isSignUp=!widget.isSignUp!;
                  });*/
                 },
                 child: Text(
                   "لدي جساب بالفعل :تسجيل دخول",
                   style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,decoration: TextDecoration.underline,
                     decorationThickness: 2.0,),
                 ),
               ),
             ),
           ],
         );
       },
      ),
    );
  }

  @override
  void dispose() {
    _NameController.dispose();
    _EmailController.dispose();
    _PassController.dispose();
    _ConfirPassController.dispose();

    super.dispose();
  }
}
