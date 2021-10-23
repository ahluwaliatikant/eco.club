import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoclub/models/flash_card_model.dart';
import 'package:ecoclub/services/get_cards_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class FlashCards extends StatefulWidget {

  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  List<SwipeItem> _swipeItems = [];
  MatchEngine? _matchEngine;


  @override
  void initState() {
    // TODO: implement initState

//    for (int i = 0; i < _names.length; i++) {
//      _swipeItems.add(SwipeItem(
//          content: "HI$i",
//          likeAction: () {
//            print("Less Like");
//          },
//          nopeAction: () {
//            print("Unliked");
//          },
//          superlikeAction: () {
//            print("Liked");
//          }));
//    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xFFE6EEE7),
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: GetCards().getAllCards(),
            builder: (context, AsyncSnapshot<List<FlashCardModel>> snapshot) {

              if(snapshot.hasData){

                print(snapshot.data);

                List<FlashCardModel> myList = snapshot.data!;

                for(int i=0 ; i<myList.length ; i++){
                  _swipeItems.add(
                    SwipeItem(
                      content: myList[i],
                        likeAction: () {
                          print("Less Like");
                        },
                        nopeAction: () {
                          print("Unliked");
                        },
                        superlikeAction: () {
                          print("Liked");
                        },
                    )
                  );
                }

                _matchEngine = MatchEngine(swipeItems: _swipeItems);

                return Container(
                  child: SwipeCards(
                    matchEngine: _matchEngine!,
                    itemBuilder: (BuildContext context , int index){
                      return Container(
                        height: height*0.7,
                        width: width*0.8,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Color(0xFF41CD8C),),
                          image: DecorationImage(
                              image: AssetImage("assets/images/flash_card_bg.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop)
                          ),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.greenAccent,
//                        blurRadius: 12.0,
//                      ),
//                    ]
                        ),
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              height: 200,
                              imageUrl: "https:" + _swipeItems[index].content.image,
                              placeholder: (context, url) => CircularProgressIndicator(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                _swipeItems[index].content.content,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF13552C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onStackFinished: (){

                    },
                  ),
                );
              }

              return Center(
                child: Icon(
                  Icons.spa,
                  size: 250,
                  color: Color(0xFF13552C),
                ).shimmer(
                  primaryColor: Color(0xFF13552C),
                  secondaryColor: Color(0xFFE6EEE7),
                ),
              );

            }
          ),
        ],
      ),
    );
  }
}
