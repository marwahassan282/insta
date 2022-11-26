import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_insta/models/my-user.dart';
import 'package:provider/provider.dart';

import '../addtodatabase/addpost.dart';
import '../base.dart';
import '../signup/SignUp_screen.dart';
import '../utils/colors.dart';
import '../widget/text_field_input.dart';
import 'Login-View-Model.dart';
import 'LoginNavigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState <LoginScreen, LoginViewModel> implements LoginNavigator {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  bool isloading = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  LoginViewModel registerViewModel=LoginViewModel();
  @override
  void initState() {

    super.initState();
    registerViewModel.navigator= this;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ChangeNotifierProvider(
        create: (c)=>LoginViewModel(),
        child: SafeArea(child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(height: 25,),
                SvgPicture.asset('assets/ic_instagram.svg',
                  height: 64, color: primaryColor,),
                SizedBox(height: 20,),
                TextFieldInput(textEditingController: emailcontroller,
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Enter your Email', error: 'please enter your email',
                ),
                SizedBox(height: 20,),
                TextFieldInput(textEditingController: passwordcontroller,
                  textInputType: TextInputType.text,
                  hintText: 'Enter your Password',
                  isPass: true, error: 'please enter your password',
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
login();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: blueColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: isloading ? CircularProgressIndicator(
                      color: primaryColor,) : Text('Login')),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Don\'t have an account?    '),
                    InkWell(onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) {
                        return SignUpScreen();
                      }));
                    },
                        child: Text('Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold),)),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  @override


  @override
  LoginViewModel initialviewmodel() {

    return  LoginViewModel();
  }

  login(){
if(globalKey.currentState!.validate())
    registerViewModel.login(emailcontroller.text, passwordcontroller.text,context);

  }

}
