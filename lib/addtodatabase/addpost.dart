import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_insta/database/database-utils.dart';
import 'package:new_insta/models/my_post.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/user-provider.dart';
import '../utils/utils.dart';
import 'Storge_Methodes.dart';

class addPost extends StatefulWidget {
  const addPost({Key? key}) : super(key: key);

  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
  void postImage(String uid, String username,   String  profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      var uuid = Uuid();
      String photo=  await StorgeMethods().uploadImageToFireStorge('post',_file!, false);


      post pos=post(description: _descriptionController.text, uid: uid, username: username, likes:[], postId:uuid.v1() , datePublished: DateTime.now().toUtc(), postUrl: photo, profImage: profImage);
      DatabaseUtils.Createpost(pos);
     setState(() {
       isLoading=false;
     });
     clearImage();
    }catch(e){
      print('${e.toString()}');
    }
  }
  void clearImage() {
    setState(() {
      _file = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    printphotourl();
   return _file == null
        ? Scaffold(
        body:    Center(
      child: IconButton(
          icon: const Icon(
            Icons.upload,color: Colors.white,
          ),
          onPressed: () => _selectImage(context),
      ),
    ),
        )
        : Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        title: const Text(
          'Post to',
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: () => postImage(
              userProvider.myUser!.uid,
              userProvider.myUser!.username ,
             userProvider.myUser!.photoUrl,
            ),
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      // POST FORM
      body: Column(
        children: <Widget>[
        isLoading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 25,

                backgroundImage: NetworkImage(
                 '${userProvider.myUser?.photoUrl}'
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Write a caption...",
                      hintStyle: TextStyle(color: Colors.white,fontSize: 15),
                      border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                          image: MemoryImage(_file!),
                        )),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }


  printphotourl(){
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    print(userProvider.myUser?.photoUrl);
  }
}
