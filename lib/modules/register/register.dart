import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/config/app_text_style.dart';

import '../login/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final _registerKey = GlobalKey<FormState>();
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 25),
          child: Form(
            key: _registerKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign up',
                  style: AppTextStyle.heading1Medium,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'If you already have an account',
                  style: AppTextStyle.heading3Black,
                ),
                Row(
                  children: [
                    Text(
                      'You can',
                      style: AppTextStyle.heading3Black,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          'Login here !',
                          style: AppTextStyle.heading3LightBlue,
                        ))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Email',
                    style: AppTextStyle.heading4Black,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your email address',
                        hintStyle: AppTextStyle.heading3Black,
                        border: InputBorder.none,
                        errorStyle: AppTextStyle.heading4Red),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      } else if (!isEmail(value)) {
                        return 'Vui lòng nhập đúng định dạng email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Username',
                    style: AppTextStyle.heading4Black,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your username',
                        hintStyle: AppTextStyle.heading3Black,
                        border: InputBorder.none,
                        errorStyle: AppTextStyle.heading4Red),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Vui lòng nhập username.'
                          : null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Password',
                    style: AppTextStyle.heading4Black,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your password',
                        hintStyle: AppTextStyle.heading3Black,
                        border: InputBorder.none,
                        errorStyle: AppTextStyle.heading4Red),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Vui lòng nhập password.'
                          : null;
                    },
                    controller: controller,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Confirm Password',
                    style: AppTextStyle.heading4Black,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.black,
                        ),
                        hintText: 'Confirm your password',
                        hintStyle: AppTextStyle.heading3Black,
                        border: InputBorder.none,
                        errorStyle: AppTextStyle.heading4Red),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập lại password';
                      } else if (value != controller.text) {
                        return 'Vui lòng nhập đúng mật khẩu xác thực';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 60,
                  width: size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          minimumSize: const Size(88, 36),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      onPressed: () {
                        if (_registerKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Center(
                          child: Text(
                        'Register',
                        style: AppTextStyle.heading2,
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
