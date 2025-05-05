import 'package:hive/hive.dart';

class LocationAdapter extends TypeAdapter<LocationData> {
  @override
  final int typeId = 1;

  @override
  LocationData read(BinaryReader reader) {
    return LocationData(reader.readString());
  }

  @override
  void write(BinaryWriter writer, LocationData obj) {
    writer.writeString(obj.location);
  }
}

@HiveType(typeId: 1)
class LocationData extends HiveObject {
  @HiveField(0)
  String location;

  LocationData(this.location);
}

Future<void> storeLocation(String location) async {
  final locationBox = await Hive.openBox<LocationData>('locationBox');
  final locationData = LocationData(location);
  
  await locationBox.clear(); // Ensuring only one data is stored
  await locationBox.add(locationData);
}

Future<LocationData?> getLocation() async {
  final locationBox = await Hive.openBox<LocationData>('locationBox');
  if (locationBox.isNotEmpty) {
    return locationBox.getAt(0);
  }
  return null;
}

Future<void> clearLocation() async {
  print("Location data cleared");
  final locationBox = await Hive.openBox<LocationData>('locationBox');
  await locationBox.clear();
}