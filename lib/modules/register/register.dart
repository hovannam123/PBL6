
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
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 25),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign up', style: AppTextStyle.heading1Medium,),
                SizedBox(height: 30,),
                Text('If you already have an account',style: AppTextStyle.heading3Light,),
                Row(
                  children: [
                    Text('You can', style: AppTextStyle.heading3Light,),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                        },
                        child: Text('Login here !', style: AppTextStyle.heading3Purple,))
                  ],
                ),
                SizedBox(height: 40,),
                Padding(padding: EdgeInsets.only(bottom: 4), child: Text('Email', style: AppTextStyle.heading4Light,),),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width:1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.white,),
                        hintText: 'Enter your email address',
                        hintStyle: AppTextStyle.heading3Light,
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(padding: EdgeInsets.only(bottom: 4), child: Text('Username', style: AppTextStyle.heading4Light,),),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width:1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline, color: Colors.white,),
                        hintText: 'Enter your username',
                        hintStyle: AppTextStyle.heading3Light,
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(padding: EdgeInsets.only(bottom: 4), child: Text('Password', style: AppTextStyle.heading4Light,),),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width:1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.white,),
                        hintText: 'Enter your password',
                        hintStyle: AppTextStyle.heading3Light,
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(padding: EdgeInsets.only(bottom: 4), child: Text('Confirm Password', style: AppTextStyle.heading4Light,),),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width:1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.white,),
                        hintText: 'Confirm your password',
                        hintStyle: AppTextStyle.heading3Light,
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 60,),
                Container(
                  height: 60,
                  width: size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: DarkTheme.purple,
                          minimumSize: const Size(88, 36),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))
                          )
                      ),
                      onPressed: (){},
                      child: const Center(
                          child: Text('Register', style: AppTextStyle.heading2,)
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
