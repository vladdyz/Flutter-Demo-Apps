import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class PlaceLocation {
  // lat/long order can be a bit confusing; using a named constructor here to be careful
  const PlaceLocation({required this.latitude, required this.longitude, required this.address});
  final double latitude;
  final double longitude;
  final String address;
  
}

class Place {
  // id is optional: pass one in when loading an existing place (e.g. from the db), otherwise a new one is generated
  Place(this.name, this.image, this.location, {String? id}) : id = id ?? uuid.v4();
  final String name;
  final String id;
  final File image;
  final PlaceLocation location;
}

