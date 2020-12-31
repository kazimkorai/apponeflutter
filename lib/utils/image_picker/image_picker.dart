
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickImageController {
  static PickImageController get instance => PickImageController();
  ImagePicker picker = ImagePicker();
  Future<File> cropImageFromFile() async{
    // TakeImage from user's photo
    PickedFile imageFileFromLibrary = await picker
        .getImage(source: ImageSource.gallery);
    // Start crop image then take the file.
        if(imageFileFromLibrary!=null)
        {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: imageFileFromLibrary.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      return croppedFile != null ? croppedFile : null;
    }
  }

  Future<File> compressImageFile(File file, String targetPath) async {
    print(targetPath);
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 50,
      rotate: 0,
    );
    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }
}