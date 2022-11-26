import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_insta/addtodatabase/addpost.dart';
import 'package:new_insta/models/my-user.dart';
import 'package:provider/provider.dart';

import '../base.dart';
import '../login/login_screen.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widget/text_field_input.dart';
import 'Navigator.dart';
import 'RegisterViewModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseState <SignUpScreen, RegisterViewModel> implements RegisterNavigator {
  var usernamecontroller=TextEditingController();
  var biocontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Uint8List ? imgepicture;
  bool isloading=false;
  @override
  void dispose() {
    usernamecontroller.dispose();
    biocontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
  RegisterViewModel registerViewModel = RegisterViewModel();

  @override
  void initState() {
    super.initState();
    registerViewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ChangeNotifierProvider(
        create: (c)=>registerViewModel,
        child: SafeArea(child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: globalKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25,),
                 Stack(
                   children: [
                  imgepicture!=null?CircleAvatar(
                 backgroundImage: MemoryImage(imgepicture!),
              radius: 70,
        ) : CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://i.stack.imgur.com/l60Hf.png'),
                    backgroundColor: Colors.red,
                  ),

                     Positioned(
                       bottom: 0,
                       right: 0,
                       child: IconButton(onPressed: (){

selectImage();
                       },
                       icon: Icon(Icons.add_a_photo),),
                     )

                   ],
                 ),
                  SizedBox(height: 20,),
                  TextFieldInput(textEditingController: usernamecontroller,textInputType: TextInputType.text,
                    hintText: 'Enter your UserName', error: 'please enter your username',
                  )    ,
                  SizedBox(height: 20,) ,
                  TextFieldInput(textEditingController: biocontroller,textInputType: TextInputType.text,
                    hintText: 'Enter your bio', error: 'please enter your bio',
                  )    ,
                  SizedBox(height: 20,) ,

                  TextFieldInput(textEditingController: emailcontroller,textInputType: TextInputType.emailAddress,
                    hintText: 'Enter your Email', error: 'please enter your email',
                  )    ,
                  SizedBox(height: 20,) ,
                  TextFieldInput(textEditingController: passwordcontroller,textInputType: TextInputType.text,
                    hintText: 'Enter your Password',
                    isPass: true, error: 'please enter your password',
                  )    ,
                  SizedBox(height: 20,) ,
                  GestureDetector(
                    onTap: (){
singnup();
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
                      child: Center(child:isloading==false?Text('Sign up') :CircularProgressIndicator(
                        color: primaryColor,
                      )),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text('Already have an account ?  '),
                      InkWell(onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (c){
                        return LoginScreen();
                      })) ;

                      },
                          child: Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  @override


  @override
  RegisterViewModel initialviewmodel() {

    return RegisterViewModel();
  }
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      imgepicture = im;
    });
  }

  singnup()
  {
if(globalKey.currentState!.validate()){

  registerViewModel.CreateAccount(usernamecontroller.text, passwordcontroller.text, imgepicture!, emailcontroller.text, biocontroller.text, [], [],context);

}

  }

}



