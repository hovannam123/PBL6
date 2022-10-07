
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/modules/register/register.dart';

import '../../config/app_color.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool passwordVisible = false;
  bool checkBox = false;
  @override
  void initState() {
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox( child: Image.asset('assets/images/img.png')),
                const Text('Sign in', style: AppTextStyle.heading1Medium,),
                const SizedBox(height: 10,),
                const Text("If you don't have an account.", style: AppTextStyle.heading3Light),
                Row(
                  children: [
                    const Text('You can', style: AppTextStyle.heading3Light),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        },
                        child: const Text('Register here !', style: AppTextStyle.heading3Purple,)),
                  ],
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: size.height/15,
                  child: Container(
                    height: size.height/15,
                    decoration: BoxDecoration(
                      color: DarkTheme.darkBlueIllustration,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Icon(Icons.email_outlined,color: Colors.white,),
                        ),
                        Expanded(
                          child: TextField(
                            style: AppTextStyle.heading3Light,
                            decoration: InputDecoration(
                                hintText: 'Enter your email address',
                                hintStyle: AppTextStyle.heading3Light,
                                border: InputBorder.none
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: size.height/15,
                  child: Container(
                    height: size.height/15,
                    decoration: BoxDecoration(
                      color: DarkTheme.darkBlueIllustration,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children:  [
                        const Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Icon(Icons.lock_outline_rounded,color: Colors.white,),
                        ),
                        Expanded(
                          child: TextField(
                            style: AppTextStyle.heading3Light,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: AppTextStyle.heading3Light,
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      passwordVisible
                                          ? passwordVisible = false
                                          : passwordVisible = true;
                                    });
                                  },
                                ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: checkBox,
                          checkColor: Colors.black,
                          fillColor:  MaterialStateProperty.resolveWith((states) => Colors.white),
                          onChanged: (bool? newValue){
                            setState((){
                              checkBox = newValue!;
                            });
                          },
                        ),
                        const Text('Remember me', style: AppTextStyle.heading4Light,)
                      ],
                    ),
                    TextButton(onPressed: (){},
                        child: const Text('Forget password?', style: AppTextStyle.heading4Light,))
                  ],
                ),
                SizedBox(height: 30,),
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
                          child: Text('Login', style: AppTextStyle.heading2,)
                      )),
                ),
                SizedBox(height: 20,),
                const Align(
                  alignment: Alignment.center,
                  child: Text('or continue with',style: AppTextStyle.heading3Light, ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: size.width/2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(heroTag: null, onPressed: (){}, child: Image.asset('assets/images/logo_fb.png'),backgroundColor: DarkTheme.darkBackground),
                        FloatingActionButton(heroTag: null, onPressed: (){}, child: Image.asset('assets/images/logo_apple.png'),backgroundColor: DarkTheme.darkBackground),
                        FloatingActionButton(heroTag: null, onPressed: (){}, child: Image.asset('assets/images/logo_google.png'),backgroundColor: DarkTheme.darkBackground)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
