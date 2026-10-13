import 'package:favourite_places/providers/places_provider.dart';
import 'package:favourite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

import 'package:favourite_places/screens/add_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    Widget content = Center(
      child: Text(
        "No place added yet...",
        style: Theme.of(context).textTheme.bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
    );

    if (places.isNotEmpty) {
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) => ListTile(
          // background image wants an image provider, NOT an image widget
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(
            places[index].name,
            style: Theme.of(context).textTheme.titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          subtitle: Text(
            places[index].location.address,
            style: Theme.of(context).textTheme.bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PlaceDetails(place: places[index]),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My places",
          style: Theme.of(context).textTheme.headlineMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: Padding(padding: EdgeInsets.all(16), child: content),
    );
  }
}
