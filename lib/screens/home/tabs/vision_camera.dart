import 'package:ecoclub/screens/home/tabs/analyse_image.dart';
import 'package:ecoclub/services/eco_lens_service.dart';
import 'package:ecoclub/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class VisionCamera extends StatefulWidget {
  @override
  _VisionCameraState createState() => _VisionCameraState();
}

class _VisionCameraState extends State<VisionCamera> {

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

    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height*0.65,
            width: width*0.8,
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

          CustomButton(
            width: width*0.7,
            text: "Analyze",
            onPressed: () async {
              if(_image!=null){

                String stringForApi = "";

                final inputImage = InputImage.fromFile(_image!);
                final imageLabeler = GoogleMlKit.vision.imageLabeler();
                final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
                for (ImageLabel label in labels) {
                  final String text = label.label;
                  print("TEXT");
                  print(text);
                  stringForApi = stringForApi + text.toLowerCase() + ",";

                  final int index = label.index;
                  final double confidence = label.confidence;
                }

                final jsonResponse = await EcoLensService().ecoLensApiCall(stringForApi);

                String text = "";
                String visit = "";
                String url = "";
                String label = jsonResponse["itemName"];
                if(jsonResponse["category"] == "fashion"){
                  text = "For every 1 ${jsonResponse["itemName"]} that you use, it's making has a carbon footprint of ${jsonResponse["item"]} kg";
                  visit = "Click here to visit tencel.com for more eco-friendly clothing options.";
                  url = "https://www.tencel.com/";
                }

                if(jsonResponse["category"] == "food"){
                  text = "Every 1 kg of ${jsonResponse["itemName"]} we humans consume, we leave a carbon footprint of ${jsonResponse["item"]} kg while it reaches your plate.";
                  visit = "Click here to visit mygardyn.com for more eco-friendly organic food options.";
                  url = "https://mygardyn.com/";
                }

                Navigator.push(context, MaterialPageRoute(builder: (context)=> AnalyzeImage(
                  label: label,
                  basicText: text,
                  visitText: visit,
                  url: url,
                )));
              }
            },
            color: Color(0xFF13552C),
            textColor: Color(0xFFE6EEE7),
          ),

        ],
      ),
    );
  }
}
