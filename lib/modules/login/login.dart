
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/user.dart';
import 'package:pbl6/modules/register/register.dart';

import '../../config/app_color.dart';
import '../home/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final lstUser = [
    new User(id: 1, name: 'Ho Van Nam', phoneNumber: '085827143', email: 'nam@gmail.com', password: '123'),
    new User(id: 2, name: 'Nguyen Tien Dat', phoneNumber: '433224522', email: 'dat@gmail.com', password: '123'),
    new User(id: 3, name: 'Hoang Hai', phoneNumber: '1231231', email: 'hai@gmail.com', password: '123'),
  ];

  bool checkLogin(String email, String pw){
    for(int i=0;i<=lstUser.length-1;i++){
      if(lstUser[i].email == email && lstUser[i].password == pw){
        userLogin = lstUser[i];
        return true;
      }
    }
    return false;
  }

  bool passwordVisible = false;
  bool checkBox = false;
  late User userLogin;
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlPassword = TextEditingController();

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
          child: Form(
            key: _loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40, bottom: 30),
                  child: Image.asset('assets/images/logo_pbl.png', fit: BoxFit.cover),
                ),
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
                  height: size.height/13,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DarkTheme.darkBlueIllustration,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Icon(Icons.email_outlined,color: Colors.white,),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: controlEmail,
                            style: AppTextStyle.heading3Light,
                            decoration: InputDecoration(
                                hintText: 'Enter your email address',
                                hintStyle: AppTextStyle.heading3Light,
                                border: InputBorder.none,
                                errorStyle: AppTextStyle.heading4Red
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Vui lòng nhập email';
                              }
                              else if(!isEmail(value)){
                                return 'Vui lòng nhập đúng định dạng email';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: size.height/13,
                  child: Container(
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
                          child: TextFormField(
                            controller: controlPassword,
                            style: AppTextStyle.heading3Light,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: AppTextStyle.heading3Light,
                                border: InputBorder.none,
                                errorStyle: AppTextStyle.heading4Red,
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
                            validator: (value){
                              return (value == null || value.isEmpty) ? 'Vui lòng nhập password' : null;
                            },
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
                      onPressed: (){
                        if(_loginKey.currentState!.validate()){

                          if(checkLogin(controlEmail.text, controlPassword.text)){
                            Navigator.push(context, (MaterialPageRoute(builder: (context)=> Home(user: userLogin))));
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tài khoản hoặc mật khẩu không đúng', style: AppTextStyle.heading4Light,)),
                            );
                          }
                        }
                      },
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
