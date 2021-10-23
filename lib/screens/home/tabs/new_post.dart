import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoclub/models/post_model.dart';
import 'package:ecoclub/services/post_service.dart';
import 'package:ecoclub/widgets/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecoclub/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ecoclub/models/user_model.dart' as userModel;

class NewPost extends StatefulWidget {

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final contentController = new TextEditingController();

  File? _image;

  _imageFromCamera() async {
    PickedFile? pickedImage = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  _imageFromGallery() async {
    PickedFile? pickedImage = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _image = File(pickedImage!.path);
    });

  }

  _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: "Capture An Image".text.make(),
                      onTap: () {
                        _imageFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_library),
                      title: "Choose From Gallery".text.make(),
                      onTap: () {
                        _imageFromGallery();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF13552C),
        title: Text(
          "New Post",
          style: GoogleFonts.poppins(
            color: Color(0xFFE6EEE7),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Image",
                    style: GoogleFonts.poppins(
                      color: Color(0xFF13552C),
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: height*0.3,
                width: width*0.9,
                decoration: BoxDecoration(
                  color: Color(0xFFE6EEE7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF13552C), width: 2),
                ),
                child: _image == null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Image Selected",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF13552C),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      width: width*0.9,
                      text: "Select Image",
                      onPressed: () {
                        _showPicker();
                      },
                      color: Color(0xFF13552C),
                      textColor: Color(0xFFE6EEE7),
                    ),
                  ],
                )
                    :
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Content",
                    style: GoogleFonts.poppins(
                      color: Color(0xFF13552C),
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  myController: contentController,
                  hint: "How did you help the environment today? :)",
                  maxLines: 7,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                width: width*0.9,
                text: "Add Post",
                onPressed: () async{
                  //TODO write function to add post

                  Map<String,dynamic> userJson = {};

                  FirebaseFirestore.instance
                      .collection('users')
                      .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((value) async{
                    print(value.docs.first.data());
                    userJson = value.docs.first.data();

                    Post post = new Post(
                        content: contentController.text,
                        createdBy: userModel.User.fromJson(userJson),
                        imageUrl: "https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1274&q=80",
                    );

                    final String docId = await PostServices().addNewPost(post);

                    await PostServices().addImageToPost(docId, _image!);

                  });
                },
                color: Color(0xFF13552C),
                textColor: Color(0xFFE6EEE7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
