import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_insta/database/database-utils.dart';
import 'package:new_insta/models/my-user.dart';
import 'package:new_insta/provider/user-provider.dart';
import 'package:provider/provider.dart';

import '../../addtodatabase/Storge_Methodes.dart';
import '../../utils/utils.dart';
import '../../widget/text_field_input.dart';

class EditProfileUser extends StatefulWidget {


  @override
  State<EditProfileUser> createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {

  var usernamecontroller=TextEditingController();
  var biocontroller=TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Uint8List ? imgepicture;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0,
     ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: globalKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25,),
                      Stack(
                        children: [
                          imgepicture!=null?Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: MemoryImage(imgepicture!),
                                radius: 70,
                              ),

                            ],
                          ) : CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                userProvider.myUser!.photoUrl),
                            backgroundColor: Colors.red,
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(onPressed: (){

                              selectImage();
                            },
                              icon: Icon(Icons.add_a_photo),),
                          ),


                        ],
                      ),
                      SizedBox(height: 10,),
                      Text('Edit your profile picture'),

                      SizedBox(height: 10,),
                      Text('Edit your user name',),
                      SizedBox(height: 10,),
                      TextFieldInput(


                        textEditingController: usernamecontroller,

                        textInputType: TextInputType.text,
                        hintText: userProvider.myUser!.username, error: 'please ewnter your username',

                      )    ,
                      SizedBox(height: 10,) ,

                      Text('Edit your bio'),
                      SizedBox(height: 20,),
                      TextFieldInput(textEditingController: biocontroller,textInputType: TextInputType.text,
                        hintText: userProvider.myUser!.bio, error: 'please enter your bio',
                      )    ,
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          InkWell(onTap: () async {
                           await updateuserprofile();
                            }
                            ,
                     child: Padding(

                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         width: 120,
                         padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.blue
                          ),
                          child: Center(child: Text('Edit',style: TextStyle(fontWeight: FontWeight.bold),))),
                     )),



                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      imgepicture = im;
    });
  }

  updateuserprofile() async {
    UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
if(globalKey.currentState!.validate()){
setState(() async {
  String photo=  await StorgeMethods().uploadImageToFireStorge('profilepicture',imgepicture!, false);

  MyUser myUser=MyUser(username: usernamecontroller.text, uid: userProvider.myUser!.uid, photoUrl: photo, email: userProvider.myUser!.email, bio: biocontroller.text, followers: userProvider.myUser!.followers, following: userProvider.myUser!.following);
  DatabaseUtils.Updateuserdata(myUser);
});


}

  }
}
