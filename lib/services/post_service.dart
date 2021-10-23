import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoclub/models/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class PostServices {
  Future<String> addNewPost(Post post) async {
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    try {
      final res = await posts.add(post.toJson());
      print(res.id);
      return res.id;
    } catch (e) {
      print(e);
    }

    return "NO_ID";

  }

  Future addImageToPost(String id, File file) async {
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref().child("images/posts/$id").putFile(file);
    final String url = await snapshot.ref.getDownloadURL();

    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    try {
      return posts
          .doc(id)
          .update({"imageUrl": url})
          .then((value) => print("POST UPDATED"))
          .catchError((error) => print("Failed to update user: $error"));
    } catch (e) {
      print(e);
    }
  }
}
