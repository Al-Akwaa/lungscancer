import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungscancer/Core/app_route.dart';
import 'package:lungscancer/providers/User_Provider.dart';
import 'package:lungscancer/widgets/custom_button.dart';
import 'package:lungscancer/widgets/custom_input.dart';
import 'package:lungscancer/providers/User_Provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  bool? isSignUp;

  LoginForm({this.isSignUp});

  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends ConsumerState<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController _PassController;
  late TextEditingController _EmailController;

  late FocusNode _PassfocusNode;
  late FocusNode _EmailNofocusNode;

  late bool isSubmitted;
  late bool isLoading;

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

  @override
  void initState() {
    super.initState();
    _EmailController = TextEditingController();
    _PassController = TextEditingController();
    isSubmitted = false;
    isLoading = false;
    _EmailNofocusNode = FocusNode();
    _PassfocusNode = FocusNode();
    //initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Consumer(
        builder: (context, ref, child) {
          final auth = ref.watch(authUserProvider);
          Future<void> SubmitLogin() async {
            bool LoginState = await auth.UserLogin(
                _EmailController.text.toString(),
                _PassController.text.toString());
            if (LoginState) {
              Navigator.pushNamed(context, AppRoute.home);
            }
          }

          return Column(
            children: [
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
              auth.isLoading
                  ? TextButton(
                      style: TextButton.styleFrom(
                        primary: Color.fromARGB(255, 15, 62, 129),
                      ),
                      onPressed: () {},
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : CustomButton(
                      color: Color.fromARGB(255, 15, 62, 129),
                      text: widget.isSignUp == true
                          ? "انشاء حساب جديد"
                          : "تسجيل دخول",
                      onPressed: () async {
                        try {
                          if (_EmailController.text != "" &&
                              _PassController.text != "") {
                            await SubmitLogin();
                          }
                        } catch (e) {
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
                  onPressed: () {
                    auth.setIsLoginState();
                  },
                  child: Text(
                    'ليس لدي حساب ?حساي جديد',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2.0,
                    ),
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
    _EmailController.dispose();
    _PassController.dispose();

    super.dispose();
  }
}
