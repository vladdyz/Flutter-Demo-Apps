import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/map.dart';

// using flutter dotenv now
// const googleApiKey = String.fromEnvironment('GOOGLE_API_KEY');
final googleApiKey = dotenv.get('GOOGLE_API_KEY');

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false; // for the loading spinner
  
  void _showError(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _getCurrentLocation() async {
    Location location = new Location();

    // rest of this function code is taken from the location documentation (pub.dev/packages/location)

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // first check if the service is available
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // next check if we have appropriate permissions
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    // finally we can get the location
    _locationData = await location.getLocation();
    final latitude = _locationData.latitude;
    final longitude = _locationData.longitude;
      

    // version change: location 10.0.0 makes these values double (not double?) and thus non-nullable
    // if (latitude == null || longitude == null) {
    //   return;
    // }

    // moved into its own function because it can be called from two separate paths
    // 1. user creates a new place location when adding a new place 
    // 2. user edits a location coordinates using the map screen
    await _savePlace(latitude, longitude);
  }

  // return an image of the location's map coordinates
  String get locationImage {
    // this url only gets used if we have a picked place
    // extra safety check
    if (_pickedLocation == null) {
      return '';
    }
    final latitude = _pickedLocation!.latitude;
    final longitude = _pickedLocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$googleApiKey';
  }

  // turn coordinates into a PlaceLocation (with a human readable address) and pass it up
  // shared by both _getCurrentLocation and _selectOnMap
  Future<void> _savePlace(double latitude, double longitude) async {
    setState(() {
      _isGettingLocation = true;
    });

    try {
      // get a map snapshot and human readable address of this location via Google Maps API
      final url = Uri.parse(
        'https://geocode.googleapis.com/v4/geocode/location/$latitude,$longitude?key=$googleApiKey',
      );
      final response = await http.get(url); // returns a JSON object
      final responseData = jsonDecode(
        response.body,
      ); // a map with a nested list (with a nested map...)
      // As of GeoCoding API v4 the endpoint uses camelCase instead of snake_case
      final address = responseData['results'][0]['formattedAddress'];

      // because this function uses a lot of asynchronous calls, its possible the user navigated out of here before they resolved
      // in which case setState and context belong to a widget that no longer exists
      if (!mounted) return;
      setState(() {
        _pickedLocation = PlaceLocation(
          latitude: latitude,
          longitude: longitude,
          address: address,
        );
        _isGettingLocation = false;
      });
      widget.onSelectLocation(_pickedLocation!);
    } on http.ClientException {
      if (!mounted) return;
      // inform the user via snackbar message that the API call did not succeed
      setState(() {
        _isGettingLocation = false;
      });
      _showError('No internet connection. Check your network and try again.');
    } catch (e) {
      // logging what happened in debug mode (this really shouldn't hit)
      debugPrint('Getting location failed: $e');
      if (!mounted) return;

      // inform the user via snackbar message that the API call did not succeed
      setState(() {
        _isGettingLocation = false;
      });
      _showError('Could not get your location. Please try again.');
    }
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx) => MapScreen()));
    if (pickedLocation == null) {
      return;
    }
    await _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location Chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation == true) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withAlpha(120),
            ),
          ),
          child: previewContent, // either a text chiild or a loading spinner
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        ),
      ],
    );
  }
}
