
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:investions/Constant/ColorsCollection.dart';
import 'CommonClass.dart';

class Attachment extends StatefulWidget {
  const Attachment({Key? key}) : super(key: key);

  @override
  _AttachmentState createState() => _AttachmentState();
}

class _AttachmentState extends State<Attachment> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor:Theme.of(context).cardColor,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: <BoxShadow>[
            BoxShadow(color:Theme.of(context).cardColor.withOpacity(0.2))
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Attachment",
                    style: TextStyle(color:Theme.of(context).textTheme.headline2?.color, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  )
                ],
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final pickimage=await ImagePicker.platform.getImage(source:ImageSource.gallery);
                      final file=pickimage!.path;
                      final cropper=await ImageCropper().cropImage(
                          sourcePath: file,maxWidth: 100,maxHeight: 100,compressQuality: 80,
                          aspectRatioPresets: [
                            CropAspectRatioPreset.square,
                            CropAspectRatioPreset.ratio3x2,
                            CropAspectRatioPreset.ratio16x9]  );
                      if(cropper!=null){
                        setState(() {
                          print("bndkn "+file);
                          UploadImage=File(cropper.path);
                          print("length"+UploadImage!.lengthSync().toString());
                        });
                        Navigator.of(context).pop();
                      }
                      else{
                        print("error");
                        Navigator.of(context).pop();
                      }
                    },
                    child: Icon(
                      Icons.dashboard,
                      size: 50,
                      color: ColorsCollectionsDark.greenlightColor,
                    ),
                  ),
                  Text('Gallery',style: TextStyle(color: Theme.of(context).textTheme.headline2?.color,fontWeight: FontWeight.w700,fontSize: 16),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

