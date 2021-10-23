import 'dart:io';

import 'package:ecoclub/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: posts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length > 0) {
              return ListView.separated(
                itemBuilder: (context, index) {

                  return PostCard(
                    content: snapshot.data!.docs[index]["content"],
                    displayName: snapshot.data!.docs[index]["createdBy"]["name"],
                    imageUrl: snapshot.data!.docs[index]["imageUrl"],
                    profilePic: snapshot.data!.docs[index]["createdBy"]["profilePicUrl"],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 2,
                    color: Color(0xFF13552C),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
            else {
              return Center(
                child: Text(
                  "No data."
                ),
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
//      child: ListView.separated(
//          itemCount: 10,
//          itemBuilder: (context, index) {
//            return PostCard();
//          },
//          separatorBuilder: (context , index){
//            return Divider(
//              thickness: 2,
//              color: Color(0xFF13552C),
//            );
//          },
//      ),
    );
  }
}

class PostCard extends StatelessWidget {

  String displayName;
  String content;
  String imageUrl;
  String profilePic;

  PostCard({
    required this.content,
    required this.displayName,
    required this.imageUrl,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: profilePic,
//                imageUrl:
//                    'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80',
                imageBuilder: (context, imageProvider) => Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                displayName,
                style: GoogleFonts.montserrat(
                  color: Color(0xFF13552C),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            content,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl:
                  imageUrl,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
