import 'dart:developer' as dev;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ecoclub/services/payment_db_service.dart';
import 'package:ecoclub/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_retriever/sms_retriever.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:ecoclub/screens/home/tabs/payment_detail.dart';

class SmsDetect extends StatefulWidget {
  @override
  _SmsDetectState createState() => _SmsDetectState();
}

class _SmsDetectState extends State<SmsDetect> {

  CollectionReference payments = FirebaseFirestore.instance.collection('payments');

  getCode(String sms) {
    if (sms != null) {
      final intRegex = RegExp(r'\d+', multiLine: true);
      final code = intRegex.allMatches(sms).first.group(0);
      return code;
    }
    return "NO SMS";
  }

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void initState() {
    // TODO: implement initState

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience

        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text(
                    "Notifications",
                ),
                content: Text(
                  "Would you like to allow Eco.Club to send notifications",
                ),
                actions: [
                  ElevatedButton(
                      onPressed: (){
                        AwesomeNotifications().requestPermissionToSendNotifications();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Yes",
                      )
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "No",
                      )
                  ),
                ],
              );
            }
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
              stream: payments.where("uuid" , isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context , AsyncSnapshot snapshot){
                if(snapshot.hasData){

                  if(snapshot.data.docs.length == 0){
                    return Center(
                      child: Text(
                        "No Data",
                      ),
                    );
                  }

                  print(snapshot.data.docs);
                  return ListView.separated(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context , index){
                        return GestureDetector(
                          onTap: (){

                            double x = 0.05*snapshot.data.docs[index]["amount"];
                            String myString = "Your donation of 5% of your txn amount = ₹$x would help offset your carbon footprint for ${((300*x)/900).toInt()} days (as per international average data).\n\n Did you know? \"It takes about 1,025 trees to offset the average American’s emissions\"";

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentDetails(data: myString,)));
                          },
                          child: ListTile(
                            title: Text(
                              "Amount: ₹${snapshot.data.docs[index]["amount"]}",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF13552C),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "Txn ID: ${getRandomString(10)}",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30,
                              color: Color(0xFF13552C),
                            ),
                          ),
                        );
                      },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 1,
                        color: Color(0xFF13552C),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          ),
//          ElevatedButton(
//              onPressed: () async{
//                print("HELLO INSIDE ON");
//                String appSig = await SmsRetriever.getAppSignature();
//                print(appSig);
//                String smsCode = await SmsRetriever.startListening();
//                print("GOT SMS");
//                print(smsCode);
//                print("AMOUNT");
//                print(getCode(smsCode));
//                dev.log(smsCode);
//
//                final res = await AwesomeNotifications().createNotification(
//                    content: NotificationContent(
//                        id: 11,
//                        channelKey: 'basic_channel',
//                        title: 'Simple Notification',
//                          body: 'AMOUNT PAID = ${getCode(smsCode)}',
//                    )
//                );
//
//                print(res);
//                SmsRetriever.stopListening();
//                dev.log("STOPPED");
//
//                await PaymentDbService().addPaymentToDb(int.parse(getCode(smsCode)));
//
//              },
//              child: Text(
//                "Listen"
//              ),
//          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: CustomButton(
              text: "Read Messages",
              onPressed: () async{
                print("HELLO INSIDE ON");
                String appSig = await SmsRetriever.getAppSignature();
                print(appSig);
                String smsCode = await SmsRetriever.startListening();
                print("GOT SMS");
                print(smsCode);
                print("AMOUNT");
                print(getCode(smsCode));
                dev.log(smsCode);

                final res = await AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: 11,
                      channelKey: 'basic_channel',
                      title: 'Eco.Pe',
                      body: 'You made a transaction of ₹${getCode(smsCode)}. Consider donating now. :)',
                    )
                );

                print(res);
                SmsRetriever.stopListening();
                dev.log("STOPPED");

                await PaymentDbService().addPaymentToDb(int.parse(getCode(smsCode)));
              },
              textColor: Color(0xFFE6EEE7),
              width: width*0.9,
              color: Color(0xFF13552C),
            ),
          ),
        ],
      ),
    );
  }
}
