import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:favourite_places/models/place.dart';

// create the database (or edit existing one) in the dbPath directory
Future<Database> _getDatabase() async {
  // store the data in a local SQL database
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      // only runs once, when the database is not found and initially created
      // image is the path to the file
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  List<Place> build() => []; // no dummy list of places (yet!)

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query(
      'user_places',
    ); // returns a Future yielding a list of maps (of rows in the db)
    final places = data
        .map(
          (row) => Place(
            row['title'] as String,
            File(row['image'] as String),
            PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
            id: row['id'] as String,
          ),
        )
        .toList(); // map is lazy, toList actually builds the places

    state = places;
  }

  void addPlace(String name, File image, PlaceLocation location) async {
    // images are stored in temporary locations and can be deleted by the OS
    // the goal is to save this on the device so the app persistently tracks the favourited locations
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); // returns a future
    final filename = path.basename(image.path);
    final copiedImage = await image.copy(
      '${appDir.path}/$filename',
    ); // returns a future, yields updated file

    final newPlace = Place(name, copiedImage, location);

    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.name,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

    state = [...state, newPlace];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>((
  ref,
) {
  return PlacesNotifier();
});
