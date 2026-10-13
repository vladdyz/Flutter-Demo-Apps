import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/places_provider.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:location/location.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  File? _selectedImage;
  PlaceLocation? _selectedLocation;
  final _formKey = GlobalKey<FormState>();
  String _enteredTitle = '';

  void _savePlace() {
    if (!_formKey.currentState!.validate() || _selectedImage == null || _selectedLocation == null) {
      return;
    }
    _formKey.currentState!.save();

    ref.read(placesProvider.notifier).addPlace(_enteredTitle, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a place",
          style: Theme.of(context).textTheme.headlineMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.undo),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title', style: TextStyle(color: Colors.white)),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a title.";
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                onSaved: (value) {
                  _enteredTitle = value!;
                },
              ),
              const SizedBox(height: 12),
              // just assign the image passed from image_input to a local var and use it to construct the Place obj via addPlace
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: 12),
              LocationInput(onSelectLocation: (location) {
                _selectedLocation = location;
              },),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _savePlace,
                icon: const Icon(Icons.add),
                label: const Text("Add Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
