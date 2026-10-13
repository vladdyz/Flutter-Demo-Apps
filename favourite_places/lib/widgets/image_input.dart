import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  // let the parent know we picked an image so we can pass it into the Place object being constructed by the form
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File?
  _selectedImage; // initially we dont have an image so this must be nullable

  // open the camera to take an image
  void _takePicture() async {
    // using image_picker
    final imagePicker = ImagePicker();
    // right now the user has to take a new picture with the camera, but this can be refactored to also include ImageSource.gallery
    // depending on an input
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ); // this returns an x-file (no no, it just contains the image...)
    // user could always close the camera without taking a photo, causing pickedImage to be null
    if (pickedImage == null) {
      return;
    }
    // x-file not compatible with File, must be converted
    // important to tell Flutter that the state has been updated, otherwise the image won't render
    setState(() {
       _selectedImage = File(pickedImage.path);
    });
   
   // selectedImage can't be null - see check above
   widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    // by default show a take picture button, until a picture is taken and selected
    // then conditionally display the picture in the widget and allows the user to reselect it
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
    );

    if (_selectedImage != null) {
      content = GestureDetector( // allows the image to be tappable and the takepicture to be called again
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!, // null check done above
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withAlpha(120),
        ),
      ),
      alignment: Alignment.center,
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
